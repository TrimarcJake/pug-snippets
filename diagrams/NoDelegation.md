``` mermaid
---
title: Before
---
sequenceDiagram
  actor AD Admin Dave
  AD Admin Dave ->> Web Server: May I have confidential data?
  create participant SQL Server
  Web Server ->> SQL Server: May I have AD Admin's confidential data? (Dave said it's okay.)
  SQL Server ->> Web Server: Certainly, friend. Here you go.
  Web Server ->> AD Admin Dave: Here you go!
```

``` mermaid
---
title: After
---
sequenceDiagram
  actor AD Admin Dave
  AD Admin Dave ->> Web Server: May I have confidential data?
  create participant SQL Server
  Web Server ->> SQL Server: May I have AD Admin's confidential data? (Dave said it's okay.)
  SQL Server ->> Web Server: LIAR! Protected Users can't be delegated!
  Web Server ->> AD Admin Dave: I'm sorry, Dave. I'm afaird I can't do that.
```