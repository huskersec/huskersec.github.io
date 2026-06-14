---
title: "<topic> — study notes"
# date set when you publish (move to _posts, rename YYYY-MM-DD-slug.md)
categories: [Notes, Study Notes]   # or just [Notes] for lighter posts
tags: [reverse-engineering, <tool>, <topic>]   # 3–6, lowercase, hyphenated
# pin: false
---

<!-- ============================================================
     STUDY NOTE — for learning / exploration with no specific disclosure.
     For formal, disclosure-bound findings use TEMPLATE-vuln-writeup.md instead.
     Category guide: [Notes] for short/informal, [Notes, Study Notes] for
     substantial deep-dives. See the vuln template for the full tag vocabulary.
     (This block is an HTML comment — it never renders. Delete or keep.)
     ============================================================ -->

## What I was looking at

One or two lines: the topic, why you dug into it, what triggered the study
(a CTF, a paper, a sample, a question like "how do you spot X in decompiled
output?").

## Setup / context

Tools, target, versions — whatever a reader needs to follow along.

- **Tools:** e.g. ghidra, windbg
- **Target:** e.g. a sample binary / toy program / real package
- **Goal:** what you were trying to understand

## Notes

The body. This is a notebook, not a polished tutorial — capture the actual
reasoning. Show the pattern you're learning to recognize.

<!-- PULL SOURCE FROM THE GALLERY (WinPrivEscLab), don't paste it, so notes
     stay in sync with the pinned lab version. Build-time include:

       {% gallery_snippet file="src/pool_overflow.c" lang="c" lines="42-58" %}

     file  = path within the gallery repo (under _gallery/)
     lang  = fence language (c, nasm, csharp, ...)
     lines = "START-END" (1-indexed, inclusive); omit for whole file;
             "42" single line; "42-" / "-58" open-ended.
     A bad path or range FAILS the build instead of rendering wrong code. -->

```c
// source-level version of the construct
if (len > 0) memcpy(dst, src, len);   // looks fine in source...
```

```nasm
; ...and what it looks like in disassembly (Intel syntax)
mov     ecx, [rsi]        ; len, attacker-influenced
test    ecx, ecx
jle     skip
call    memcpy            ; the cue you're training your eye to catch
skip:
```

Call out the **tell** explicitly: what in the disassembly/decompiler output
made the pattern recognizable, and what would have hidden it.

## Takeaways

The distilled lesson — the heuristic you'll carry forward. What you'd grep /
script / look for next time to find this faster.

## Open questions / next

- Things you didn't resolve, threads to pull later.

## References

- Paper / talk / repo / writeup that prompted or informed this: <link>
