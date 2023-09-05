$UserName = "adm-loc"

Add-Type -AssemblyName 'System.Web'

$Description = 'LAPS Client Admin'
$Password = [System.Web.Security.Membership]::GeneratePassword(24, 0) | ConvertTo-SecureString -AsPlainText -Force

try{
    New-LocalUser -Name $UserName -Description $Description -Password $Password -ErrorAction Stop
}
catch{
    Write-Host "User already exists."
}
try{
    Add-LocalGroupMember -SID 'S-1-5-32-544' -Member $UserName
}catch{
    Write-Host "User is already an admin."
}
