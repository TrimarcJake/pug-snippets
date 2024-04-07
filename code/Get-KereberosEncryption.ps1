$ADAdminName = 'BTPC02$'
$filter = @"
    *[EventData
        [Data
            [@Name='TargetUserName']
            and
            (Data='$ADAdminName')
        ]
    ]
    [System
        [(EventID=4768 or EventID=4769)]
    ]
"@
Get-WinEvent -FilterXPath $filter -LogName Security

$ADAdminName = 'BTPC02$'
$filter = @"
    *[EventData
        [Data
            [@Name='TargetUserName']
            and
            (Data='$ADAdminName')
        ]
        [Data
            [@Name='EncryptionType']
            and
            (Data=0x12)
        ]
    ]
    [System
        [(EventID=4768 or EventID=4769)]
    ]
"@
Get-WinEvent -FilterXPath $filter -LogName Security
