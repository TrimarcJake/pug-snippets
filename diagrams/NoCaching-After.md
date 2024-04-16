``` mermaid
---
title: After
---
%%{
  init: {
    'theme': 'forest'
  }
}%%
sequenceDiagram
  actor AD Admin
  participant User Workstation
  actor Attacker
  AD Admin ->> User Workstation: Login
  User Workstation -->> AD Admin: Logoff
  note left of User Workstation: No credentials cached anywhere
  Attacker ->> User Workstation: Elite hacking! (phishing)
  User Workstation ->> Attacker: No credentials to steal... BEC, here we come!
```