v
$DomainControllers = $Domains | ForEach-Object {
    Get-ADDomainController -Filter * -Server $_
}
$DomainControllers | Group-Object OperatingSystem | Sort-Object Name