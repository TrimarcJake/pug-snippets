$Forest = Get-ADForest
$Domains = $Forest.Domains
$DNs = @()
$PrincipalInfo = @()

$Domains | ForEach-Object {
    $DomainSid = (Get-ADDomain -Server $_).DomainSID.Value
    
    $KrbtgtSid = $DomainSid + "-502"
    $DNs += (Get-ADUser -Server $_ -Identity $KrbtgtSid).distinguishedName

    $BASid = 'S-1-5-32-544'
    $DASid = $DomainSid + '-512'
    $EASid = $DomainSid + '-519'
    $SASid = $DomainSid + '-518'
    foreach ($sid in @($BASid, $DASid, $EASid, $SASid)) {
        try {
            $DNs += (Get-ADGroupMember -Server $_ -Identity $sid -Recursive).distinguishedName
            $DNs += (Get-ADGroup -Server $_ -Identity $sid).Members
        } catch {}
    }

    $DNs = $DNs | Sort-Object -Unique
    
    foreach ($dn in $DNs) {
        $Domain = $_
        try {
            $PrincipalInfo += Get-ADUser -Server $Domain -Identity $dn -Properties PasswordLastSet | Select-Object {$Domain}, Name, objectClass, PasswordLastSet
        } catch {}
        try {
            $PrincipalInfo += Get-ADComputer -Server $Domain -Identity $dn -Properties PasswordLastSet | Select-Object {$Domain}, Name, objectClass, PasswordLastSet
        } catch {}
        try {
            $PrincipalInfo += Get-ADServiceAccount -Server $Domain -Identity $dn -Properties PasswordLastSet | Select-Object {$Domain}, Name, objectClass, PasswordLastSet
        } catch {}
    }
}

$PrincipalInfo = $PrincipalInfo | Sort-Object -Property PasswordLastSet
$PrincipalInfo | Format-Table -AutoSize