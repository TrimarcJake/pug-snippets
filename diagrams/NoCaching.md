``` mermaid
---
title: Before
---
sequenceDiagram
  actor AD Admin
  participant User Workstation
  actor Attacker
  AD Admin ->> User Workstation: Login
  User Workstation -->> AD Admin: Logoff (Credentials left in memory)
  Attacker ->> User Workstation: Elite hacking! (phishing)
  User Workstation ->> Attacker: Collect AD Admin credentials for later use
```
