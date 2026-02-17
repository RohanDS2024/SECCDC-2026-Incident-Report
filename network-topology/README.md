# SECCDC 2026: Wild West Parks Inc. (WWPI) Network Topology

## 1. Scenario Context
[cite_start]Wild West Parks Inc. (WWPI) is an interstellar entertainment empire that requires professional security engineering to safeguard its digital frontier[cite: 299, 301]. [cite_start]This engagement simulates a team of security professionals managing a fictional business network while defending against active Red Team exploitation[cite: 19, 20, 28].

## 2. Alpha Network Infrastructure
The environment consists of eight primary scored servers with diverse operating systems and complex inter-service dependencies.

| Hostname | IP Address | OS Platform | Scored Services |
| :--- | :--- | :--- | :--- |
| **frontier** | 10.250.60.10 | Windows | [cite_start]DNS (53), RDP (3389) [cite: 157, 168] |
| **drifter** | 10.250.60.11 | Linux | [cite_start]SSH (22) [cite: 174] |
| **mustang** | 10.250.60.12 | Windows | [cite_start]RDP (3389), WinRM (5985) [cite: 168, 178] |
| **praire** | 10.250.60.13 | Linux | [cite_start]SSH (22), IMAPS (993) [cite: 174, 181] |
| **cactus** | 10.250.60.14 | Linux | [cite_start]SSH (22) [cite: 174] |
| **governor** | 10.250.60.15 | Linux | [cite_start]SSH (22) [cite: 174] |
| **sunset** | 10.250.60.250 | Windows | [cite_start]RDP (3389), SMB (445), WinRM (5985) [cite: 168, 170, 178] |
| **sunrise** | **10.250.60.252** | **Windows Server Core** | [cite_start]**RDP (3389), WinRM (5985)** [cite: 168, 178] |



## 3. Core Asset Analysis: `sunrise`
My primary operational focus during the engagement was the hardening and maintenance of the `sunrise` host.
* **Headless Architecture**: Utilized a Windows Server Core installation to significantly reduce the attack surface by removing the Graphical User Interface (GUI).
* [cite_start]**Remote Management**: The system is scored based on the continuous availability of Remote Desktop Protocol (RDP) and Windows Remote Management (WinRM)[cite: 106, 168, 178].
* [cite_start]**Privileged Accounts**: Access is managed through Scored Administrative users (e.g., `alexisj`) and designated normal users[cite: 259, 291, 293].
* [cite_start]**Mandatory Telemetry**: The host must run a Black Team Agent (BTA) Windows Service (`bta.exe`) with full SYSTEM privileges to facilitate environment health monitoring[cite: 202, 203].

## 4. Operational Requirements & Connectivity
* **Service Dependencies**: Active Directory and web service functionality across the network rely on proper DNS resolution from the `frontier` host.
* [cite_start]**Egress Whitelisting**: For the Black Team Agent (BTA) to communicate successfully, outbound network access is required for `10.250.250.11` (Port 443) and `169.254.169.254` (Port 80)[cite: 205].
* [cite_start]**Administrative Access**: Initial environment access is achieved via Apache Guacamole, connecting to specific Jump machines within the `10.250.250.0/24` range[cite: 228, 236, 253].
* [cite_start]**Traffic Integrity**: All countermeasures must allow whitelisted binaries and IP addresses listed in the operational requirements to ensure accurate service scoring[cite: 207].
