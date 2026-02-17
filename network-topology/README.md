# SECCDC 2026: Wild West Parks Inc. (WWPI) Network Topology

## 1. Scenario Context
Wild West Parks Inc. (WWPI) is an interstellar entertainment empire that requires professional security engineering to safeguard its digital frontier. This engagement simulates a team of security professionals managing a fictional business network while defending against active Red Team exploitation.

## 2. Alpha Network Infrastructure
The environment consists of eight primary scored servers with diverse operating systems and complex inter-service dependencies.

| Hostname | IP Address | OS Platform | Scored Services Status |
| :--- | :--- | :--- | :--- |
| **frontier** | 10.250.60.10 | Windows |  DNS (53) <br>  RDP (3389)  |
| **drifter** | 10.250.60.11 | Linux |  SSH (22) |
| **mustang** | 10.250.60.12 | Windows |  RDP (3389) <br>  WinRM (5985) |
| **praire** | 10.250.60.13 | Linux |  SSH (22) <br>  IMAPS (993) |
| **cactus** | 10.250.60.14 | Linux |  SSH (22) |
| **governor** | 10.250.60.15 | Linux |  SSH (22) |
| **sunset** | 10.250.60.250 | Windows |  RDP (3389) <br>  WinRM (5985) <br>  SMB (445) - DOWN |
| **sunrise** | **10.250.60.252** | **Windows Core** |  **RDP (3389)** <br>  **WinRM (5985)** |

## 3. Core Asset Analysis: `sunrise` (10.250.60.252)
My primary operational focus during the engagement was the hardening and maintenance of the `sunrise` host.

* **Headless Architecture**: Utilized a Windows Server Core installation to significantly reduce the attack surface by removing the Graphical User Interface (GUI).
* **Remote Management**: The system is scored based on the continuous availability of Remote Desktop Protocol (RDP) and Windows Remote Management (WinRM).
* **Black Team Agent (BTA)**: A mandatory telemetry agent (`bta.exe`) was maintained at `C:\Program Files\BTA\` to capture competitor actions for the Gold Team.
* **Privileged Account Audit**: The account `alexisj` was identified as the primary administrative user for system management.

## 4. Operational Requirements & Connectivity
* **Infrastructure Access**: Blue Team access was provided via Apache Guacamole through designated "Jump" machines in the `10.250.250.X` range.
* **Service Dependencies**: Proper DNS resolution from the `frontier` host was a critical dependency for Active Directory and web service functionality.
* **Mandatory Egress**: The BTA requires unobstructed outbound network access to `10.250.250.11:443` and `169.254.169.254:80`.
* **Incident Response Rule**: Removal of malware artifacts or technical information from the environment (e.g., uploading to VirusTotal) is strictly prohibited.
