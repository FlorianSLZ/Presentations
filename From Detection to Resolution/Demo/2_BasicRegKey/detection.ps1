$Path = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Setup"
$Key = "DisableRoamingSignaturesTemporaryToggle" 
$Value = "1"

Try {
    If (Test-Path $Path) {
        $RegResult = Get-ItemProperty $Path -Name $Key -ErrorAction Stop | Select-Object -ExpandProperty $Key

        If ($RegResult -eq $Value) {
            Write-Output "Match. Expected $($Value) and got $($RegResult)"
            Exit 0 
        }
        else {
            If ($RegResult::IsNullOrEmpty) {
                $RegResult = "<<null>>"
            }
            Write-Output "No Match. Expected $($Value) but got $($RegResult)"
            Exit 1
        }
    }
    else {
        Write-Output "No Match. Expected $($Path) not found"
        Exit 1
    }
}
Catch {
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    Exit 1
}
