# Encryption Info: https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/decrypting-the-selection-of-supported-kerberos-encryption-types/ba-p/1628797
# XPath: https://powershell.org/2019/08/a-better-way-to-search-events/

foreach ($ADAdminName in $ForestADAs.sAMAccountName) {
    $filter = @"
        *[EventData
            [Data[@Name='TargetUserName']='$ADAdminName']
            [Data[@Name='TicketEncryptionType']!='0x12']
            [Data[@Name='TicketEncryptionType']!='0x11']
        ]
        [System
            [(EventID=4768 or EventID=4769)]
        ]
"@
    Write-Host "Checking for DES/RC4 Kerberos logons for $ADAdminName`: " -NoNewline
    try {
        Get-WinEvent -FilterXPath $filter -LogName Security -ErrorAction Stop |
            Select-Object -Last 1 |
            Out-Null
        Write-Host "Recent weakly encrypted Kerberos logon found for $ADAdminName" -ForegroundColor Red
    } catch {
        Write-Host "No weakly encrypted Kerberos logons found for $ADAdminName"
    }
    Write-Host
}
