$Forest = Get-ADForest
$ForestGC = $(Get-ADDomainController -Discover -Service GlobalCatalog -ForceDiscover | Select-Object -ExpandProperty Hostname) + ":3268"
$Domains = $Forest.Domains
$AdaMemberDNs = @()
$AdaMemberNamesAndPasswords = @()

$Domains | ForEach-Object {
    $DomainSid = (Get-ADDomain -Server $_).DomainSID.Value
    $KrbtgtSid = $DomainSid + "-502"
    $BASid = 'S-1-5-32-544'
    $DASid = $DomainSid + '-512'
    $EASid = $DomainSid + '-519'
    $SASid = $DomainSid + '-518'
    # $ADAGroupSids = @($BASid, $DASid, $EASid, $SASid)
    $Krbtgt = Get-ADUser -Server $_ -Identity $KrbtgtSid -Properties PasswordLastSet

    foreach ($sid in @($BASid, $DASid, $EASid, $SASid)) {
        try {
            $ADAMemberDNs += (Get-ADGroupMember -Server $_ -Identity $sid -Recursive).distinguishedName
            $ADAMemberDNs += (Get-ADGroup -Server $_ -Identity $sid).Members
        } catch {}
    }

    $ADAMemberDNs = $ADAMemberDNs | Sort-Object -Unique
    
    foreach ($dn in $ADAMemberDNs) {
        $Domain = $_
        try {
            $ADAMemberNamesAndPasswords += Get-ADUser -Server $Domain -Identity $dn -Properties PasswordLastSet | Select-Object {$Domain}, Name, objectClass, PasswordLastSet
        } catch {}
        try {
            $ADAMemberNamesAndPasswords += Get-ADComputer -Server $Domain -Identity $dn -Properties PasswordLastSet | Select-Object {$Domain}, Name, objectClass, PasswordLastSet
        } catch {}
        try {
            $ADAMemberNamesAndPasswords += Get-ADServiceAccount -Server $Domain -Identity $dn -Properties PasswordLastSet | Select-Object {$Domain}, Name, objectClass, PasswordLastSet
        } catch {}
    }
}

$AdaMemberNamesAndPasswords = $AdaMemberNamesAndPasswords | Sort-Object -Property Name
$AdaMemberNamesAndPasswords