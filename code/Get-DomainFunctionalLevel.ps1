$Forest = Get-ADForest
$Domains = $Forest.Domains
$Domains | ForEach-Object {
    Get-ADDomain -Server $_ | Select-Object Name, DomainMode
}