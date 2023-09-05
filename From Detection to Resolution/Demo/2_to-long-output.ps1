# I will give you a 4000 character long output aka Hardware Hash ;)
try{
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null
    Install-Script Get-WindowsAutoPilotInfo -Force | Out-Null

    $HWHash = (Get-WindowsAutoPilotInfo.ps1).'Hardware Hash'

    Write-Output $HWHash
}
catch{
    Write-Error $_
}