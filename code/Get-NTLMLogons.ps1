foreach ($ADAdminName in $ForestADAs.sAMAccountName) {
    $filter = @"
        *[EventData
            [Data
                [@Name='AuthenticationPackageName']
                and
                (Data='NTLM' or Data='Negotiate')
            ]
            [Data[@Name='TargetUserName']='$ADAdminName']
        ]
        [System
            [(EventID=4624 or EventID=4625)]
        ]
"@
    Write-Host "Checking Security log for NTLM logons from $ADAdminName`: " -NoNewline
    try {
        Get-WinEvent -FilterXPath $filter -LogName Security -ErrorAction Stop |
            Select-Object -Last 1 |
            Out-Null
        Write-Host "Recent NTLM logon found for $ADAdminName" -ForegroundColor Red
    } catch {
        Write-Host "No NTLM logons found for $ADAdminName"
    }
    Write-Host
}