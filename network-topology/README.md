# SECCDC 2026: Wild West Parks Inc. (WWPI) Network Topology

## 1. Scenario Context
Wild West Parks Inc. (WWPI) is an interstellar entertainment empire that requires professional security engineering to safeguard its digital frontier. This engagement simulates a team of security professionals managing a fictional business network while defending against active Red Team exploitation.

## 2. Alpha Network Infrastructure
The environment consists of eight primary scored servers with diverse operating systems and complex inter-service dependencies.

| Hostname | IP Address | OS Platform | Scored Services |
| :--- | :--- | :--- | :--- |
| **frontier** | 10.250.60.10 | Windows | DNS (53), RDP (3389) |
| **drifter** | 10.250.60.11 | Linux | SSH (22) |
| **mustang** | 10.250.60.12 | Windows | RDP (3389), WinRM (5985) |
| **praire** | 10.250.60.13 | Linux | SSH (22), IMAPS (993) |
| **cactus** | 10.250.60.14 | Linux | SSH (22) |
| **governor** | 10.250.60.15 | Linux | SSH (22) |
| **sunset** | 10.250.60.250 | Windows | RDP (3389), SMB (445), WinRM (5985) |
| **sunrise** | **10.250.60.252** | **Windows Core** | **RDP (3389), WinRM (5985)** |

## 3. Core Asset Analysis: sunrise
The `sunrise` host was the primary target of my defense strategy.
* **Architecture:** Minimalist Server Core installation (no GUI) to reduce attack surface.
* **Telemetry:** Required to host the Black Team Agent (BTA) at `C:\Program Files\BTA\bta.exe`.
