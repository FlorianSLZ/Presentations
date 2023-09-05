$UserName = "adm-loc"

if(Get-LocalUser | where-Object Name -eq $UserName){
    Write-Host "User does already exist"
    Exit 0
}else{
    Write-Host "User does not exist"
    Exit 1
}