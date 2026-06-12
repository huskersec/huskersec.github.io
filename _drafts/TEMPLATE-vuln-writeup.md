---
title: "CVE-YYYY-NNNNN: <one-line summary> in <product>"
# date is set automatically when you publish (move to _posts and rename to
# YYYY-MM-DD-slug.md). Uncomment and set explicitly if you want:
# date: 2026-01-01 12:00:00 -0400
categories: [Vulnerability Research]   # see CATEGORY list below
tags: [cve, <product>, <bug-class>]    # see TAG vocabulary below; 3–6 per post
# pin: false
# image:                               # optional hero image
#   path: /assets/img/posts/<slug>/cover.png
#   alt: ...
---

<!-- ============================================================
     TAXONOMY REFERENCE — house style (delete this block before publishing,
     or leave it; HTML comments don't render). Keep tags lowercase and
     hyphenated. Aim for ONE primary category and 3–6 tags per post.

     CATEGORIES (broad post type; [Parent, Child] = sub-category):
       Vulnerability Research      root-cause analysis, CVE writeups, bug hunting
       Exploit Development         bug -> working exploit  (often a child of VR:
                                   [Vulnerability Research, Exploit Development])
       Offensive Security          tradecraft, red team, technique deep-dives
       Malware Analysis            reversing samples, unpacking, behavioral
       Tooling                     utilities you build or write up
       Notes                       short posts, paper roundups, CTF, misc
       Meta                        site housekeeping

     TAGS (flat keywords; pick from these, extend sparingly):
       tools:       ghidra, ida-pro, windbg, gdb, binary-ninja, frida,
                    burp-suite, pwndbg, radare2, qemu, wireshark, volatility
       bug classes: heap-overflow, stack-overflow, use-after-free,
                    type-confusion, race-condition, integer-overflow,
                    oob-read, oob-write, uninitialized-memory, logic-bug,
                    deserialization
       techniques:  rop, heap-grooming, fuzzing, reverse-engineering,
                    privilege-escalation, code-injection, dll-hijacking,
                    shellcode
       targets:     windows, linux, macos, kernel, browser, android,
                    firmware, web
       general:     cve, 0day, n-day, poc, malware-analysis, red-team,
                    ctf, disclosure

     Rule of thumb: don't invent a tag you'll only ever use once.
     ============================================================ -->


## Summary

One paragraph: what the bug is, where it lives, and why it matters. State the
affected versions and the impact (RCE / LPE / info-leak / DoS) up front.

| | |
|---|---|
| **Product** | name + affected versions |
| **CVE** | CVE-YYYY-NNNNN |
| **Class** | e.g. heap buffer overflow (CWE-122) |
| **Impact** | e.g. remote code execution |
| **Reported** | YYYY-MM-DD |
| **Fixed** | YYYY-MM-DD (version x.y.z) |

## Background

Context a reader needs: what the component does, the relevant architecture,
the trust boundary being crossed.

## Root cause

The actual defect. Show the vulnerable code and walk through *why* it's wrong.

<!-- ------------------------------------------------------------
     SYNTAX HIGHLIGHTING — fence tags (Rouge / Chirpy). Put the tag right
     after the opening fence (three backticks) of a code block:

       c          C                cpp        C++
       csharp     C#  (or c#)      python     Python
       powershell PowerShell       bash       shell / sh / zsh
       nasm       x86 asm (Intel)  armasm     ARM asm
       rust  go  java  ruby  javascript  sql  yaml  json  html  diff

     NOTE: no GAS/AT&T-syntax asm lexer exists. `nasm` is Intel-syntax only —
     dump disassembly with Intel syntax (objdump -M intel / gdb
     `set disassembly-flavor intel`) for clean highlighting.

     For plain terminal output / PoC runs, leave the fence bare (no tag),
     or use `console` if you want prompt styling.
     ------------------------------------------------------------ -->

```c
// vulnerable snippet — annotate the exact problem
size_t n = read_u32(input);     // attacker-controlled
memcpy(dst, src, n);            // no bound check against sizeof(dst)
```

Explain the path from input to the defect. Diagrams help if state is complex.

<!-- Example: Intel-syntax disassembly of the same spot -->

```nasm
mov     eax, [rdi]        ; eax = attacker-controlled length
call    memcpy            ; dst, src, eax  — no bound check
```

## Reaching the bug

The input path / preconditions. How does attacker data get here? What
constraints does it have to satisfy?

## Impact / exploitation

What an attacker gains. Keep this proportionate and responsible: demonstrate
impact without shipping a turnkey weapon. A crashing PoC or a controlled
primitive is usually the right level for a public writeup.

```console
$ ./poc target
[*] triggering...
[+] crash at 0x4141414141414141
```

## Timeline

- **YYYY-MM-DD** — reported to vendor
- **YYYY-MM-DD** — vendor acknowledged
- **YYYY-MM-DD** — patch released
- **YYYY-MM-DD** — public disclosure

## Takeaways

What the broader lesson is — the pattern other code might share, the mitigation
that would have helped, what you'd look for next.

## References

- Vendor advisory: <link>
- Patch / commit: <link>
