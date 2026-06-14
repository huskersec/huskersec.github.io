---
title: "Recognizing pool overflows in WinPrivEscLab"
# rename to YYYY-MM-DD-slug.md and move to _posts/ to publish
categories: [Notes, Study Notes]
tags: [reverse-engineering, windows, kernel, pool-overflow, privilege-escalation]
---

A walk through one of the WinPrivEscLab bug classes — what the planted
vulnerability looks like in source, and how to spot the same construct in
disassembly. Source is pulled straight from the lab repo at build time, so the
line ranges below always match the lab version this site is pinned to.

## The vulnerable allocation

Here's the relevant slice of the driver source, pulled live from the gallery:

{% gallery_snippet file="src/pool_overflow.c" lang="c" lines="1-20" %}

The bug is the missing bound check before the copy — attacker-controlled length
flows into the pool write.

## What it looks like disassembled

The same routine, Intel syntax:

{% gallery_snippet file="disasm/pool_overflow.asm" lang="nasm" lines="1-15" %}

The tell: the length comes from the IOCTL input buffer and reaches the copy with
no comparison against the allocation size in between.

## Takeaways

- Pull the snippet, don't paste it — when the lab driver changes, bump the
  pinned `ref` in the deploy workflow and every note re-syncs on rebuild.
- For a PoC writeup, pin to the **tag** you developed the exploit against, so
  the offsets in your prose match the code shown.

> Replace the file paths and line ranges above with the real ones from your
> WinPrivEscLab repo. If a path is wrong, the build fails loudly rather than
> rendering a wrong snippet.
{: .prompt-tip }
