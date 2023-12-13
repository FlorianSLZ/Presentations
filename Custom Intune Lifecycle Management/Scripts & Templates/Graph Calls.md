# Get all SP sites
https://graph.microsoft.com/v1.0/sites/scloudwork.sharepoint.com

# Get all Lists of SP site
https://graph.microsoft.com/v1.0/sites/scloudwork.sharepoint.com:/sites/Doku:/lists/

# Get all list items
https://graph.microsoft.com/v1.0/sites/scloudwork.sharepoint.com:/sites/Doku:/lists/xxxxxxxxx-xxxx-42d8-926c-14ab28747bf9/items

# select specific fields




?$select=id,&$expand=fields($select=Title,SN,OS,User,Status,Grouptag)