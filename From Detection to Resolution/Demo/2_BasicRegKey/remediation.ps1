$Path = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Setup"
$Key = "DisableRoamingSignaturesTemporaryToggle" 
$KeyFormat = "dword"
$Value = "1"

Try {
    New-Item $Path -Force | New-ItemProperty -Name $Key -Value $Value -PropertyType $KeyFormat -Force | Out-Null
    Exit 0
}
Catch {
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    Exit 1 
}