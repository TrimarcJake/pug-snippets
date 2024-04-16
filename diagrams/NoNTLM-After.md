``` mermaid
---
title: After
---
%%{
  init: {
    'theme': 'forest'
  }
}%%
flowchart LR
  ADAPC[AD Admin\nWorkstation] -- Connect via Name/FQDN\n(uses Kerberos) --> AttackerPC[Attacker-controller\nPC running SMB Services]
  AttackerPC -- Good luck! --> DC[Domain Controller]
```