# Hi I'm a dummy PS1
$website = "scloud.work"
$location = "CH"

try{
    if(Test-Connection $website){
        Write-Output "Website aviable: $website"
        exit 0
    }else{
        Write-Output "Can't rech $website"
        exit 1
    }
}
catch{Write-Error $_}