Incident Analysis: C2 Beaconing Detection
Observation: During SECCDC 2026, an internal Windows host was identified communicating with a suspicious external IP at a fixed 60-second interval.

Detection Methodology (Wireshark):

Used the filter ip.addr == [Attacker_IP] && tcp.flags.push == 1 to isolate outgoing payloads.

Analyzed the "Time" column to identify the "heartbeat" pattern consistent with C2 frameworks like Sliver or Cobalt Strike.

Response Action:

Implemented an emergency outbound firewall rule to block traffic to the destination IP.

Flagged the source PID for host-based analysis in Process Explorer.
