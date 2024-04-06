``` mermaid
---
title: Before
---
sequenceDiagram
  actor AD Admin Dave
  participant Web Server
  participant SQL Server
  participant Domain Controller
  AD Admin Dave ->> Web Server: May I have confidential data?
  Web Server ->> SQL Server: May I have Dave's confidential data? (Dave said it's okay.)
  SQL Server ->> Domain Controller: Is the Web Server allowed to impersonate Dave?
  Domain Controller ->> SQL Server: Yes!
  SQL Server ->> Web Server: Certainly, friend. Here you go.
  Web Server ->> AD Admin Dave: Here you go!
```

``` mermaid
---
title: After
---
sequenceDiagram
  actor AD Admin Dave
  participant Web Server
  participant SQL Server
  participant Domain Controller
  AD Admin Dave ->> Web Server: May I have confidential data?
  Web Server ->> SQL Server: May I have Dave's confidential data? (Dave said it's okay.)
  SQL Server ->> Domain Controller: Is the Web Server allowed to impersonate Dave?
  Domain Controller ->> SQL Server: No! Dave is a Protected User and cannot be impersonated!
  SQL Server ->> Web Server: Despite what Dave said, you are not allowed to impersonate him.
  Web Server ->> AD Admin Dave: I'm sorry, Dave. I'm afraid I can't do that.
```