# Source: https://powershellmagazine.com/2013/07/15/pstip-how-to-enable-event-logs-using-windows-powershell/

Get-WinEvent -ListLog Microsoft-Windows-Authentication*/ProtectedUser* | Select-Object LogName, IsEnabled

$LogNames = (Get-WinEvent -ListLog Microsoft-Windows-Authentication*/ProtectedUser*).LogName

foreach ($LogName in $LogNames) {
    $Log = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $LogName
    $Log.IsEnabled = $true
    $Log.SaveChanges()
}

Get-WinEvent -ListLog Microsoft-Windows-Authentication*/ProtectedUser* | Select-Object LogName, IsEnabled

