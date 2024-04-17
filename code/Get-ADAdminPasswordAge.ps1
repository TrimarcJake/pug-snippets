$Forest = Get-ADForest
$Domains = $Forest.Domains
$DNs = @()
$ForestInfo = @()

$ForestInfo = $Domains | ForEach-Object {
    $Domain = $_
    $DomainSid = (Get-ADDomain -Server $Domain).DomainSID.Value
    $KrbtgtSid = $DomainSid + "-502"
    $AdaSids = @(
        'S-1-5-32-544',
        "$DomainSid-512",
        "$DomainSid-519",
        "$DomainSid-518"
    )

    $DNs = foreach ($sid in $AdaSids) {
        $GetDNSplat = @{
            Server = $_
            Identity = $sid
        }
        try {
            (Get-ADGroupMember @GetDNSplat -Recursive).distinguishedName
            (Get-ADGroup @GetDNSplat).Members
        } catch {}
    }
    $DNs += (Get-ADUser -Server $Domain -Identity $KrbtgtSid).distinguishedName
    $DNs = $DNs | Sort-Object -Unique
    
    $DomainInfo = foreach ($dn in $DNs) {
        $GetInfoSplat = @{
            Server = $Domain
            Identity = $dn
            Properties = '*'
        }
    
        $SelectProperties = @(
            @{name='Domain';expression={$Domain}},
            'Name',
            @{name ='pwdLastSet';expression={[datetime]::FromFileTime($_.pwdLastSet)}}
        )

        try {
            Get-ADObject @GetInfoSplat | Select-Object $SelectProperties
        } catch {}
    }

    $DomainInfo | Sort-Object -Property pwdLastSet
}

$ForestInfo

# Source: https://techhues.wordpress.com/2017/03/13/efficiently-converting-pwdlastset-to-datetime-and-exporting-it-to-csv-in-a-single-line/
