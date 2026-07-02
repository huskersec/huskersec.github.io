---
title: "WinDbg kernel debugging, ghidriff, and HEVD — working notes"
categories: [Notes]
tags: [windbg, ghidra, kernel, reverse-engineering, windows]
---

Working notes from kernel-debugging setup and driver analysis: getting KDNET up
against a VM target, breaking into LSASS from the kernel debugger, patch-diffing
drivers with ghidriff, and driving the HackSys Extremely Vulnerable Driver (HEVD).
A notebook / quick reference, not a tutorial.

## KDNET kernel debugging setup

> ESXi `vmxnet` adapters don't play well with KDNET — swap the target's NIC to
> `e1000`/`e1000e` (a second NIC dedicated to the debug transport works well).
{: .prompt-warning }

Configure the target (debuggee) for network kernel debugging:

```console
bcdedit /debug on
bcdedit /dbgsettings net hostip:<YOUR_DEBUGGER_IP> port:50000 nodhcp
bcdedit /set "{dbgsettings}" busparams <output from kdnet for adapter>
bcdedit /set testsigning on
```

Check whether a supported adapter is present (also prints the `busparams` value
used above):

```console
kdnet.exe
```

## Debugging LSASS from the kernel debugger

LSASS runs as PPL, which blocks a user-mode debugger *attach* — but from the
kernel debugger you can switch into its process context and inspect it. Get the
`EPROCESS`, do an invasive context switch, then load user-mode symbols:

```console
!process 0 0 lsass.exe
.process /i /p <EPROCESS address>
g

.reload /user
lm
```

## Patch-diffing with ghidriff

ghidriff decompiles two binaries in Ghidra and diffs the output — handy for
locating what a patch changed. One snag: when `remove_code_sig` returns an empty
string, `normalize_ghidra_decomp` expects a list, so empty decomp needs coercing
to `[]`. Local patch to `ghidra_diff_engine.py`:

```diff
@@ -1618,7 +1618,13 @@
             self.normalize_ghidra_decomp(new_code)
 
             old_code_no_sig = self.remove_code_sig(ematch_1['code'])
+            if (old_code_no_sig == ""):
+                old_code_no_sig = []
+
             new_code_no_sig = self.remove_code_sig(ematch_2['code'])
+            if (new_code_no_sig == ""):
+                new_code_no_sig = []

             self.normalize_ghidra_decomp(old_code_no_sig)
             self.normalize_ghidra_decomp(new_code_no_sig)
```

Diffing pre-fix vs post-fix CLFS driver builds:

```console
ghidriff.exe .\apr25_vuln_clfs.sys .\may25_patched_clfs.sys
```

## HEVD

Load and start the driver:

```console
sc create HEVD type= kernel binPath= "<path_to_driver>"
sc start HEVD
```

Decode an IOCTL code in WinDbg:

```console
!ioctldecode 0x222003
```

### Getting HEVD's `DbgPrintEx` output to show

`DbgPrintEx(component, level, "message")` output is filtered per-component. `arg1`
(the component id) maps to a `DPFLTR_*_ID` in `dpfilter.h`; to see the messages you
set the matching `nt!Kd_<COMPONENT>_Mask` to all-bits. `arg2` is the log level.

Example: Ghidra shows the call as `DbgPrintEx(0x4d, 3, "message")`. `0x4d` = 77,
which is the IHVDRIVER component — so set its mask:

```console
ed nt!Kd_IHVDRIVER_Mask 0xFFFFFFFF
dd nt!Kd_IHVDRIVER_Mask
```

With the mask set, HEVD's `DbgPrintEx` messages show up in WinDbg.

### Bugcheck / reset helpers

```console
!analyze -v        ; triage the bugcheck
.reboot            ; reboot the target
.reload            ; reload symbols (e.g. after a snapshot revert)
```

## Takeaways

- **`kdnet.exe` first** — it both confirms adapter support and hands you the
  `busparams` value; on ESXi, get off `vmxnet` before fighting the transport.
- **LSASS is reachable from kernel context** — `.process /i /p` + `.reload /user`
  sidesteps the PPL attach block.
- **`DbgPrintEx` is silent until you raise the component mask** — decode `arg1`
  against `dpfilter.h`, set `Kd_<COMPONENT>_Mask`.

## References

- Component id → `DPFLTR_*_ID` mapping: [`dpfilter.h`](https://github.com/tpn/winsdk-10/blob/master/Include/10.0.16299.0/shared/dpfilter.h)
- [HackSys Extremely Vulnerable Driver (HEVD)](https://github.com/hacksysteam/HackSysExtremeVulnerableDriver)
- [ghidriff](https://github.com/clearbluejar/ghidriff)
