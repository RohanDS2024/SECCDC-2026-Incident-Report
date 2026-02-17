Post-Incident Reflection: Persistence Hunting

Observation: During the final phase, the Red Team maintained persistent access via an obfuscated Registry Key (HKCU\Software\Microsoft\Windows\CurrentVersion\Run).

Gaps Identified: My initial response focused heavily on the Network Layer (L3/L4) rather than the Host Layer (L7/Registry).

Remediation Plan: Since the engagement, I have integrated the Sysinternals Suite (Autoruns/Procmon) into my standard hardening workflow to identify and neutralize similar non-process-based persistence.
