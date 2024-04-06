$ADAdminName = 'jhda'
Get-WinEvent -FilterXPath "*[EventData[Data[@Name='AuthenticationPackageName'] and (Data='NTLM'
or Data='Negotiate')][Data[@Name='TargetUserName'] and (Data='jhda'')]][System[(EventID=4624 or EventID=4625)]]" -LogName Security