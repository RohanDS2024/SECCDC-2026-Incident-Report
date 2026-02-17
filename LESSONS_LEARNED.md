Post-Engagement Retrospective: Windows Server Core Defense
Technical Focus: sunrise (10.250.60.252)

Critical Infrastructure Risks:

Credential Spraying: The use of a universal credential (Trying-Our-Best1) for the administrative user alexisj across the environment was a primary vector for Red Team lateral movement.

Headless Environments: Managing a Windows Server Core machine without a GUI requires high proficiency in PowerShell and SConfig.

Key Takeaways:

Firewall Precision: In Server Core, misconfiguring a firewall rule can permanently lock out administrative access via RDP/WinRM, requiring a "revert" action from the Black Team.

Service Dependency Awareness: Understanding that DNS (hosted on Frontier) is a dependency for all Windows authentication ensures faster troubleshooting when RDP connections fail.

Whitelisting over Blacklisting: Whitelisting the scoring agent (BTA) IPs is more effective than trying to block every individual Red Team IP.
