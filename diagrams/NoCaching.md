``` mermaid
---
title: Before
---
sequenceDiagram
  actor AD Admin
  participant User Workstation
  actor Attacker
  AD Admin ->> User Workstation: Login
  User Workstation -->> AD Admin: Logoff
  note left of User Workstation: Credentials left on User Workstation
  Attacker ->> User Workstation: Elite hacking! (phishing)
  User Workstation ->> Attacker: Collect AD Admin credentials for later use
```
