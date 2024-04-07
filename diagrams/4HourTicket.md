``` mermaid
---
title: Before
---
sequenceDiagram
  actor AD Admin
  participant Workstation
  actor Attacker
  AD Admin ->> Workstation: Log on to vCenter Remote Console
  AD Admin --> Workstation: Close Console Session without Logging Off
  note left of Workstation: Admin Session remains open.
  Attacker ->> Workstation: Compromise Admin Session
  note right of Workstation: 7 Days Pass
  Workstation ->> Attacker: Prompt for Password
  note right of Workstation: Session Unusable
```

``` mermaid
---
title: After
---
sequenceDiagram
  actor AD Admin
  participant Workstation
  actor Attacker
  AD Admin ->> Workstation: Log on to vCenter Remote Console
  AD Admin --> Workstation: Close Console Session without Logging Off
  note left of Workstation: Admin Session remains open.
  Attacker ->> Workstation: Compromise Admin Session
  note right of Workstation: 4 Hours Pass
  Workstation ->> Attacker: Prompt for Password
  note right of Workstation: Session Unusable
```