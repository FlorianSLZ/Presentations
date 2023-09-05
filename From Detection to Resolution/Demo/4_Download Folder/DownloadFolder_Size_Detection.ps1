$Size_Limit = "10000000000"
# 10000000000 (Bytes) is 10GB

$Folder_Path = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$Folder_Size = (Get-ChildItem -LiteralPath $Folder_Path -File -Force -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum

Function Format_Size
	{
		param(
		$size	
		)	
		
		$suffix = "B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
		$index = 0
		while ($size -gt 1kb) 
		{
			$size = $size / 1kb
			$index++
		} 

		"{0:N2} {1}" -f $size, $suffix[$index]
	}
	
$RecycleBin_FormatedSize = Format_Size	$Folder_Size

If($Folder_Size -ge $Size_Limit)
	{
		write-output "Size: $RecycleBin_FormatedSize"			
		EXIT 1				
	}
Else
	{
		write-output "Size: $RecycleBin_FormatedSize"			
		EXIT 0			
	}	
