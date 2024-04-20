foreach ($admin in $ForestInfo) {
    try {
        Get-ADUser -Server $admin.Domain-Identity $admin.distinguishedName -ErrorAction SilentlyContinue
    } catch {}
    # Set-ADUser -Server $admin.Domain-Identity $admin.distinguishedName -AccountNotDelegated $true
}