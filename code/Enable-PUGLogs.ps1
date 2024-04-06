Get-WinEvent -ListLog Microsoft-Windows-Authentication*/ProtectedUser* | Select-Object LogName, IsEnabled

foreach ($LogName in (Get-WinEvent -ListLog Microsoft-Windows-Authentication*/ProtectedUser*).LogName) {
    $Log = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $LogName
    $Log.IsEnabled=$false
    $Log.SaveChanges()
}

Get-WinEvent -ListLog Microsoft-Windows-Authentication*/ProtectedUser* | Select-Object LogName, IsEnabled