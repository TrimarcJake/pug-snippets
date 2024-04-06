``` mermaid
---
title: Before
---
sequenceDiagram
  AD Admin ->> Web Server: May I have confidential data?
  create participant SQL Server
  Web Server ->> SQL Server: May I have AD Admin's confidential data? (She said it's okay.)
  SQL Server ->> Web Server: Certainly, friend. Here you go.

```

``` mermaid
---
title: After
---
sequenceDiagram
  AD Admin ->> Web Server: May I have confidential data?
  create participant SQL Server
  Web Server ->> SQL Server: May I have AD Admin's confidential data? (She said it's okay.)
  SQL Server ->> Web Server: LIAR! Protected Users can't be delegated!

```