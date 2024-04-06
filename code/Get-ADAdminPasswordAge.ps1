$Forest = Get-ADForest
$Domains = $Forest.Domains
$DomainLength = 0
$DNs = @()
$NameLength = 0
$PrincipalInfo = @()

$Domains | ForEach-Object {
    $Domain = $_
    $DomainSid = (Get-ADDomain -Server $Domain).DomainSID.Value
    
    $KrbtgtSid = $DomainSid + "-502"
    $DNs += (Get-ADUser -Server $Domain -Identity $KrbtgtSid).distinguishedName

    $BASid = 'S-1-5-32-544'
    $DASid = $DomainSid + '-512'
    $EASid = $DomainSid + '-519'
    $SASid = $DomainSid + '-518'
    foreach ($sid in @($BASid, $DASid, $EASid, $SASid)) {
        try {
            $DNs += (Get-ADGroupMember -Server $Domain -Identity $sid -Recursive).distinguishedName
            $DNs += (Get-ADGroup -Server $Domain -Identity $sid).Members
        } catch {}
    }

    $DNs = $DNs | Sort-Object -Unique
    
    foreach ($dn in $DNs) {
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

$DomainLength = -4 - ($PrincipalInfo | Measure-Object -Maximum -Property '$Domain').Maximum.length
$NameLength = -8 - ($PrincipalInfo | Measure-Object -Maximum -Property Name).Maximum.length
$PasswordLastSetLength = -12 - ($PrincipalInfo | Measure-Object -Maximum -Property PasswordLastSet).Maximum.length

$PrincipalInfo = $PrincipalInfo | Sort-Object -Property PasswordLastSet
$PrincipalInfo | ForEach-Object { "{0,$DomainLength}{1,$NameLength}{2,$PasswordLastSetLength}" -f $_.'$Domain',$_.Name,$_.PasswordLastSet }
