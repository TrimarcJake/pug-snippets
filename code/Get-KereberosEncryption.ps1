# Encryption Info: https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/decrypting-the-selection-of-supported-kerberos-encryption-types/ba-p/1628797
# XPath: https://powershell.org/2019/08/a-better-way-to-search-events/

$ADAdminName = 'BTPC02$'
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
Get-WinEvent -FilterXPath $filter -LogName Security
