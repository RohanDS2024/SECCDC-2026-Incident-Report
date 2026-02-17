# SECCDC 2026: Wild West Parks Inc. (WWPI) Network Topology

## 1. Scenario & Mission Profile
[cite_start]Wild West Parks Inc. (WWPI) is an interstellar entertainment empire that requires a professional security engineering team to safeguard its digital gates[cite: 299, 302]. [cite_start]The mission is to integrate, manage, and protect this fictional small business while maintaining standard business functionality under active Red Team engagement[cite: 18, 19, 28].

## 2. Alpha Network Infrastructure
[cite_start]The environment consists of eight primary scored systems, each identically configured at the start of the competition to serve critical business functions[cite: 22, 243, 247].

| Hostname | IP Address | Platform | Critical Scored Services |
| :--- | :--- | :--- | :--- |
| **frontier** | 10.250.60.10 | Windows | [cite_start]DNS (53), RDP (3389) [cite: 157, 168, 246] |
| **drifter** | 10.250.60.11 | Linux | [cite_start]SSH (22) [cite: 174, 246] |
| **mustang** | 10.250.60.12 | Windows | [cite_start]RDP (3389), WinRM (5985) [cite: 168, 178, 246] |
| **praire** | 10.250.60.13 | Linux | [cite_start]SSH (22), IMAPS (993) [cite: 174, 181, 246] |
| **cactus** | 10.250.60.14 | Linux | [cite_start]SSH (22) [cite: 174, 246] |
| **governor** | 10.250.60.15 | Linux | [cite_start]SSH (22) [cite: 174, 246] |
| **sunrise** | 10.250.60.250 | Windows | [cite_start]RDP (3389), WinRM (5985) [cite: 168, 178, 246] |
| **sunset** | **10.250.60.252** | **Windows Core** | [cite_start]**RDP (3389), WinRM (5985)** [cite: 168, 178, 246] |

## 3. Host Focus: `sunrise` (10.250.60.252)
The `sunrise` host was the primary target of my defense strategy during the SECCDC 2026 engagement.

* **Attack Surface Reduction**: The host utilized a Windows Server Core installation, which lacks a traditional GUI to minimize exploitable binaries and overhead.
* [cite_start]**Remote Management Consistency**: The system was monitored via Remote Desktop Protocol (RDP) and Windows Remote Management (WinRM), simulating a remote employee workflow[cite: 168, 178, 179].
* [cite_start]**Black Team Agent (BTA)**: A mandatory telemetry agent (`bta.exe`) was maintained at `C:\Program Files\BTA\` to capture competitor actions for the Gold Team[cite: 188, 195].
* [cite_start]**Privileged Account Audit**: The account `alexisj` was identified as the primary administrative user for system management[cite: 259, 261, 293].

## 4. Connectivity & Operational Constraints
* [cite_start]**Infrastructure Access**: Blue Team access was provided via Apache Guacamole through designated "Jump" machines in the `10.250.250.X` range[cite: 228, 236, 239].
* **Service Dependencies**: Proper DNS resolution from the `frontier` host was a critical dependency for Active Directory and web service functionality.
* [cite_start]**Mandatory Egress**: The BTA requires unobstructed outbound network access to `10.250.250.11:443` and `169.254.169.254:80`[cite: 205].
* [cite_start]**Communication Policy**: During the engagement, students are prohibited from accessing personal email, social media, or using any screen recording software[cite: 89, 90].
* [cite_start]**Incident Response Rule**: Removal of malware artifacts or technical information from the environment (e.g., uploading to VirusTotal) is strictly prohibited[cite: 87, 88].
