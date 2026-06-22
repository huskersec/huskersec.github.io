---
title: Projects
icon: fas fa-code
order: 3
---

Tools and code I've published — separate from the writeup posts. If you're here
for the code rather than the prose, this is the page.

<!--
  Add a card per project, most significant / most recent first.
  Keep descriptions to a line or two and lead with what it does.
  Link to the repo; link to a writeup post if one exists.
-->

## Tooling

### IronNet
Semi-automated, human-in-the-loop system for proactive remediation of
network-level lateral-movement attack paths in Active Directory. Delivers a full
capability chain — observed host port state → GPO policy intent → OU-inheritance
root-cause analysis → targeted AD remediation with verified port closure — tested
against a Windows Server 2025 AD lab. Planned extension toward agentic, LLM-driven
decision-making for continuous autonomous network hardening (M.S. practicum).
**Stack:** Python control plane · C# scanning agent · BloodHound / Splunk integration
**Links:** [repo](https://github.com/huskersec/IronNet) · [paper](/publications/)

---

### BugMuseum
Windows bug-class study corpus: each specimen built across optimization and
mitigation levels (`/Od`, `/O2`, `/O2 /GS`) with source, multi-level MSVC
disassembly, and angr/pypcode decompilation laid side-by-side to build cross-layer
bug recognition. Doubles as the known-answer validation corpus for the
agent-driven VR system.
**Stack:** C
**Links:** [repo](https://github.com/huskersec/BugMuseum)

---

### WinPrivEscLab
Documented catalog of Windows privilege-escalation primitives with working demos:
object-manager / registry / NTFS symlink TOCTOU, token impersonation and privilege
manipulation, named-pipe / RPC / ALPC abuse, and the Potato and PrintNightmare
lineages — mapping the EoP attack surface to SYSTEM.
**Stack:** C / C++
**Links:** [repo](https://github.com/huskersec/WinPrivEscLab)

---

### SharpArsenal
Windows offensive techniques: token theft/impersonation, multiple process-injection
variants (remote-thread, reflective DLL, spawn-and-inject), and SYSTEM escalation —
demonstrating hands-on Windows process/thread, token, and memory internals.
**Stack:** C#
**Links:** [repo](https://github.com/huskersec/SharpArsenal)

---

## Contributions

<!-- Notable PRs / patches to other projects, if any.
     - **project** — what you contributed. [PR](#) -->

_None listed yet._
