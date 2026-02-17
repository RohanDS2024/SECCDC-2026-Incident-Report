Post-Incident Reflection: Host-Based Remediation
The Gap: While perimeter defenses (Firewall) were successful, host-based persistence remained active during the engagement.

Research & Remediation Strategy:

Persistence Hunting: I have since mastered the use of Autoruns (Sysinternals) to identify malware hiding in HKCU\Software\Microsoft\Windows\CurrentVersion\Run and scheduled tasks.

Advanced Process Analysis: For future engagements, I will use Process Explorer to verify executable signatures. If a process like svchost.exe lacks a Verified Signer (Microsoft Corporation), it is flagged as high-risk malware injection.

Service Integrity: I now audit the binPath in the registry (HKLM\SYSTEM\CurrentControlSet\Services) to ensure Red Teamers haven't redirected legitimate services to malicious binaries.
