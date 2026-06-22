---
title: Publications & CVEs
icon: fas fa-shield-halved
order: 2
---

A running index of vulnerabilities I've discovered, advisories I've published,
and other research output. Each entry links to the full writeup where one exists.

> Coordinated disclosure: details for a given issue are published only after a
> patch is available or the disclosure window has elapsed.
{: .prompt-info }

## CVEs & advisories

<!--
  Add a row per finding, newest first. Link the CVE id to its writeup post once
  published (e.g. [CVE-2026-12345](/posts/cve-2026-12345-uaf-in-libfoo/)).
  Keep "Class" terse — match your tag vocabulary (use-after-free, heap-overflow, …).
-->

CVEs I discovered and disclosed (credited in NVD):

| CVE / ID | Product | Class | Impact | Disclosed | Writeup |
|---|---|---|---|---|---|
| CVE-2019-12176 | HTC VIVEPORT Desktop | insecure service permissions | LPE | 2019-05-24 | [link](/posts/htc-viveport-privesc/) |
| CVE-2019-12177 | HTC VIVEPORT Desktop | DLL hijacking | LPE | 2019-05-24 | [link](/posts/htc-viveport-privesc/) |

## Vulnerability analysis

Independent root-cause / reverse-engineering writeups of vulnerabilities
discovered by others — **not my discoveries**; credit to the original finders is
given in each post.

| CVE / ID | Product | Class | My contribution | Writeup |
|---|---|---|---|---|
| CVE-2026-41089 | Microsoft Windows (netlogon.dll / AD DC) | stack-overflow (DoS) | independent root-cause + patch-diff analysis | [link](/posts/CVE-2026-41089-netlogon-analysis/) |

## Papers

<!-- - **Paper title** — Venue / publisher, YYYY. [pdf](#) -->

- **Iron Net: Proactive Remediation of Network-Level Lateral Movement Attack Paths in Windows Active Directory Environments** — CS6727, Georgia Institute of Technology, 2026. [pdf](/assets/files/ironnet.pdf) · [code](https://github.com/huskersec/IronNet)

## Bug bounties / acknowledgements

<!-- Vendor hall-of-fame credits, hackerone/bugcrowd handles, etc.
     - Vendor — short description, YYYY -->

_None yet._
