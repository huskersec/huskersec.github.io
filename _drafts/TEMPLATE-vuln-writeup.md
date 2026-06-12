---
title: "CVE-YYYY-NNNNN: <one-line summary> in <product>"
# date is set automatically when you publish (move to _posts and rename to
# YYYY-MM-DD-slug.md). Uncomment and set explicitly if you want:
# date: 2026-01-01 12:00:00 -0400
categories: [Vulnerability Research]   # or [Offensive Security] / [Tooling]
tags: [cve, <product>, <bug-class>]    # e.g. [cve, libfoo, heap-overflow]
# pin: false
# image:                               # optional hero image
#   path: /assets/img/posts/<slug>/cover.png
#   alt: ...
---

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

```c
// vulnerable snippet — annotate the exact problem
size_t n = read_u32(input);     // attacker-controlled
memcpy(dst, src, n);            // no bound check against sizeof(dst)
```

Explain the path from input to the defect. Diagrams help if state is complex.

## Reaching the bug

The input path / preconditions. How does attacker data get here? What
constraints does it have to satisfy?

## Impact / exploitation

What an attacker gains. Keep this proportionate and responsible: demonstrate
impact without shipping a turnkey weapon. A crashing PoC or a controlled
primitive is usually the right level for a public writeup.

```
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
