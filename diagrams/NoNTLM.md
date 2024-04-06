``` mermaid
---
title: Before
---
flowchart LR
  ADAPC[AD Admin\nWorkstation] -- Connect via IP\n(uses NTLM) --> AttackerPC[Attacker-controller\nPC running SMB Services]
  AttackerPC -- Sends NTLM Hash --> DC[Domain Controller]
```

``` mermaid
---
title: After
---
flowchart LR
  ADAPC[AD Admin\nWorkstation] -- Connect via Name/FQDN\n(uses Kerberos) --> AttackerPC[Attacker-controller\nPC running SMB Services]
  AttackerPC -- Good luck! --> DC[Domain Controller]
```