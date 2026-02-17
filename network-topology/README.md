Alpha Network Topology: Wild West Parks Inc.
Scope: 8-Server Enterprise Infrastructure

Hostname	IP Address	OS	Critical Scored Services
frontier	10.250.60.10	Windows Server	DNS (53), RDP (3389)
drifter	10.250.60.11	Linux	SSH (22)
mustang	10.250.60.12	Windows Server	RDP (3389), WinRM (5985)
praire	10.250.60.13	Linux	SSH (22), IMAPS (993)
cactus	10.250.60.14	Linux	SSH (22)
governor	10.250.60.15	Linux	SSH (22)
sunset	10.250.60.250	Windows Server	RDP (3389), SMB (445), WinRM (5985)
sunrise	10.250.60.252	Windows Server Core	RDP (3389), WinRM (5985)
Target Focus: sunrise

Architecture: Minimalist Server Core installation (no GUI) to reduce attack surface.

Management: Entirely command-line and remote-based via RDP and PowerShell/WinRM.

Telemetry: Required to host the Black Team Agent (BTA) at C:\Program Files\BTA\bta.exe.
