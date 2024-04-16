``` mermaid
---
title: Before
---
%%{
  init: {
    'theme': 'forest'
  }
}%%
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