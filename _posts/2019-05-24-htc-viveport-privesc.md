---
title: "Privilege Escalation via HTC VIVEPORT Desktop"
date: 2019-05-24 17:24:43 -0400
categories: [Vulnerability Research]
tags: [cve, privilege-escalation, dll-hijacking, windows, disclosure, htc]
img_path: /assets/img/htc-viveport-privesc/
---

> Originally published on [Medium](https://medium.com/@huskersec/privilege-escalation-via-htc-viveport-desktop-c93471ff87c8)
> on 2019-05-24. Republished here as part of consolidating my writing onto this site.
{: .prompt-info }

On the hunt for privilege escalation paths, I decided to take a look at my own
gaming computer to see if any of the software I've installed over the years would
provide for a nice, simple path to SYSTEM.
[This](https://twitter.com/enigma0x3/status/1108595493800546304) Tweet from Matt
Nelson intrigued my curiosity to look at my own gaming system. Also, thanks to
@FuzzySec for his popular Windows privilege escalation
[guide](https://www.fuzzysecurity.com/tutorials/16.html). I'll first preface this
and say that these issues were in no way hard to find. It merely just took someone
with a little curiosity to look in the right place.

To summarize, I was able to identify insecure service permissions (CVE-2019-12176)
and a DLL hijacking opportunity (CVE-2019-12177) due to insecure directory
permissions affecting the VIVEPORT Desktop software installation. We'll go ahead
and begin with the first issue, insecure service permissions. Using the
Sysinternals Suite AccessChk tool, I was able to use the following commands to
identify two services with the `SERVICE_CHANGE_CONFIG` permission:

![AccessChk permissions result for HTC Account Service](01-accesschk-htc-account-service.png)
_AccessChk permissions result for HTC Account Service_

![AccessChk permissions result for ViveportDesktopService](02-accesschk-viveport-desktop-service.png)
_AccessChk permissions result for ViveportDesktopService_

Quick note, I already knew these two services were installed and that's why I
specified the exact service names in the above commands. However, you could always
tell AccessChk to search across all services by specifying a `*` instead of the
specific service.

Moving on, Microsoft describes the `SERVICE_CHANGE_CONFIG` permission in the
following screenshot and
[here](https://docs.microsoft.com/en-us/windows/desktop/services/service-security-and-access-rights):

![SERVICE_CHANGE_CONFIG description](03-service-change-config-description.png)
_SERVICE_CHANGE_CONFIG description_

As we can see, we've identified some serious issues in the way that these two
services are configured, especially considering Microsoft states that the
permission "should be granted to only administrators." Essentially, the output
from AccessChk has told us that "Authenticated Users" have the ability to "change
the executable file that the system runs." Since many services are configured to
execute as Local System, if the vulnerable service is reconfigured to execute a
command or execute a malicious executable, the command or executable will be ran
in the context of Local System, resulting in successful privilege escalation.

To test out our newly-found privesc path, I ensured I was logged on as a regular
user and then executed the commands in the following screenshots:

![Reconfiguring the HTC Account Service to add a new user, admin1](04-reconfig-htc-add-admin1.png)
_Reconfiguring the HTC Account Service to add a new user, admin1_

![Reconfiguring the HTC Account Service to add the admin1 user to the Administrators group](05-reconfig-htc-admin1-to-administrators.png)
_Reconfiguring the HTC Account Service to add the admin1 user to the Administrators group_

![Reconfiguring the ViveportDesktopService to add a new user, admin2](06-reconfig-viveport-add-admin2.png)
_Reconfiguring the ViveportDesktopService to add a new user, admin2_

![Reconfiguring the ViveportDesktopService to add the admin2 user to the Administrators group](07-reconfig-viveport-admin2-to-administrators.png)
_Reconfiguring the ViveportDesktopService to add the admin2 user to the Administrators group_

Above, both the HTC Account Service and ViveportDesktopService were successfully
reconfigured to add new users to the system and to the Administrators group, thus,
elevating our privileges from a regular user to that of an administrator.

Next, we'll take a look at the DLL hijack due to insecure directory permissions
identified while looking into the VIVEPORT Desktop installation. First, I'd like
to thank Matt Nelson for
[this](https://posts.specterops.io/razer-synapse-3-elevation-of-privilege-6d2802bd0585)
post, in which he details a privilege escalation in Razer Synapse software. His
post got me thinking and kind of guided me down a path to look at images that are
loaded by VIVEPORT services when they're started and from where. Somewhat
following his process and methodology, I used the Sysinternals Suite tool, Process
Monitor, to determine images that are loaded by the ViveportDesktopService when
the service is started. In the following screenshot, we can see the
`vita_update_requester_api64.dll` is loaded when the service is started:

![Load Image operation by ViveportDesktopService.exe](08-load-image-viveport-service.png)
_Load Image operation by ViveportDesktopService.exe_

Checking access to the folder where the above DLL is loaded from, it was
determined that users have FullControl over the folder:

![Identifying all users have FullControl over the folder where the DLL is loaded from](09-fullcontrol-dll-folder.png)
_Identifying all users have FullControl over the folder where the DLL is loaded from_

Leveraging these permissions, MSFvenom was used to quickly generate a DLL that,
once loaded, would execute a reverse shell back to my attacker host:

![Generating a malicious reverse shell DLL with MSFvenom](10-msfvenom-generate-dll.png)
_Generating a malicious reverse shell DLL with MSFvenom_

With a perfect, malicious payload ready to go, the DLL was copied to the directory
where the legitimate DLL, `vita_update_requester_api64.dll`, is loaded from:

![Malicious DLL copy and execute](11-malicious-dll-copy-execute.png)
_Malicious DLL copy and execute_

Once the service was started, the reverse shell was received on the attacker
system and privileges were verified by running the `whoami` command:

![Successful reverse shell and verification of privileges](12-reverse-shell-whoami.png)
_Successful reverse shell and verification of privileges_

By taking advantage of the vulnerabilities described above, escalation of
privileges from a regular user to that of an administrator or SYSTEM was able to
take place.

To close this out, I just wanted to quickly say that these issues were disclosed
to HTC once identified and that HTC worked quickly to fix both vulnerabilities. As
of the release of this post, the VIVEPORT Desktop software has been updated to
remediate both issues. Thanks for reading and happy hacking!

## References

- <https://twitter.com/enigma0x3/status/1108595493800546304>
- <https://www.fuzzysecurity.com/tutorials/16.html>
- <https://docs.microsoft.com/en-us/windows/desktop/services/service-security-and-access-rights>
- <https://posts.specterops.io/razer-synapse-3-elevation-of-privilege-6d2802bd0585>
