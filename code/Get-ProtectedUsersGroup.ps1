$Forest = Get-ADForest
$Domains = $Forest.Domains
$Domains | ForEach-Object {
    $PugExists = $false
    $DomainSid = Get-ADDomain -Server $_ | Select-Object DomainSID
    $PugSid = "$($DomainSid.DomainSID)-525"
    try {
        Get-ADGroup -Server $_ -Identity $PugSid| Out-Null
        $PugExists = $true
    } catch {}

    if ($PugExists) {
        Write-Output "Protected Users group exists in $_"
    } else {
        Write-Output "Protected Users group does not exist in $_"
    }
}