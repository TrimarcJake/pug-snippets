``` mermaid
---
title: Before
---
flowchart LR
  ADAPC[AD Admin\nWorkstation] -- Connect via IP\n(uses NTLM) --> AttackerPC[Attacker-controller\nPC]
  AttackerPC -- Sends NTLM Hash --> DC[Domain Controller]
```

``` mermaid
---
title: After
---
flowchart LR
  ADAPC[AD Admin\nWorkstation] -- Connect via Name/FQDN\n(uses Kerberos) --> AttackerPC[Attacker-controller\nPC]
  AttackerPC -- Good luck! --> DC[Domain Controller]
```