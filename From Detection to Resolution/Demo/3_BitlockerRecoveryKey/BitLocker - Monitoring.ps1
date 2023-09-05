Try 
{
	$BitLockerInfo = Get-Bitlockervolume
	if($BitLockerInfo.EncryptionPercentage -eq '100')
	{
			$Result = (Get-BitLockerVolume -MountPoint C).KeyProtector
			$Recoverykey = $result.recoverypassword	
			Write-Output "Bitlocker recovery key `n$Recoverykey"
		Exit 0
	}else{
		Write-Output "No key aviable"
		Exit 1
	}
}
catch
{
	Write-Error $_
}

