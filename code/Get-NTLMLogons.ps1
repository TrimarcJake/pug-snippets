foreach ($ADAdminName in $ForestInfo.sAMAccountName) {
    $filter = @"
        *[EventData
            [Data
                [@Name='AuthenticationPackageName']
                and
                (Data='NTLM' or Data='Negotiate')
            ]
            [Data
                [@Name='TargetUserName']
                and
                (Data='$ADAdminName')
            ]
        ]
        [System
            [(EventID=4624 or EventID=4625)]
        ]
"@
    Get-WinEvent -FilterXPath $filter -LogName Security | Select-Object -Last 1
}