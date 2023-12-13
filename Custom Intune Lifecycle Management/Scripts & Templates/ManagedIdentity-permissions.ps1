################################################################################
#   Graph permission
################################################################################

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Application.Read.All","AppRoleAssignment.ReadWrite.All","RoleManagement.ReadWrite.Directory"


# You will be prompted for the Name of you Managed Identity
$MdId_Name = Read-Host "Name of your Managed Identity"
$MdId_ID = (Get-MgServicePrincipal -Filter "displayName eq '$MdId_Name'").id

# Adding Microsoft Graph permissions
$graphApp = Get-MgServicePrincipal -Filter "AppId eq '00000003-0000-0000-c000-000000000000'"

# Add the required Graph scopes
$graphScopes = @(
  "DeviceManagementManagedDevices.Read.All"
  "DeviceManagementServiceConfig.ReadWrite.All"
  "Sites.Selected"
  "BrowserSiteLists.Read.All"
)
ForEach($scope in $graphScopes){
  $appRole = $graphApp.AppRoles | Where-Object {$_.Value -eq $scope}

  if ($null -eq $appRole) { Write-Warning "Unable to find App Role for scope $scope"; continue; }

  # Check if permissions isn't already assigned
  $assignedAppRole = Get-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $MdId_ID | Where-Object { $_.AppRoleId -eq $appRole.Id -and $_.ResourceDisplayName -eq "Microsoft Graph" }

  if ($null -eq $assignedAppRole) {
    New-MgServicePrincipalAppRoleAssignment -PrincipalId $MdId_ID -ServicePrincipalId $MdId_ID -ResourceId $graphApp.Id -AppRoleId $appRole.Id
  }else{
    write-host "Scope $scope already assigned"
  }
}

<#

# Removing all Graph scopes
$MdId_permissions = Get-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $MdId_ID
ForEach($Assignment in $MdId_permissions){
  Remove-MgServicePrincipalAppRoleAssignment -AppRoleAssignmentId $Assignment.Id -ServicePrincipalId $MdId_ID
}


#>

################################################################################
#   SharePoint permission
################################################################################

# Add the correct 'Application (client) ID' and 'displayName' for the Managed Identity
$MdId_ID = Read-Host "Your Managed Identity Application (client) ID"
$MdId_Name = Read-Host "Your Managed Identity name"

# You will be prompted for the Name of you Managed Identity
$MdId_Name = Read-Host "Name of your Managed Identity"
$MdId_ID = (Get-MgServicePrincipal -Filter "displayName eq '$MdId_Name'").id

$application = @{
    id = $MdId_ID
    displayName = $MdId_Name
}

# Add the correct role to grant the Managed Identity (read or write)
$appRole = "read"

# Add the correct SharePoint Online tenant URL and site name
$spoTenant = Read-Host "Your SharePoint main URL (ex. tenant.sharepoint.com)"
$spoSite  = Read-Host "Your SharePoint site name (ex. Portal)"

# No need to change anything below
$spoSiteId = $spoTenant + ":/sites/" + $spoSite + ":"

Import-Module Microsoft.Graph.Sites
Connect-MgGraph -Scope Sites.FullControl.All

New-MgSitePermission -SiteId $spoSiteId -Roles $appRole -GrantedToIdentities @{ Application = $application }

<#
# Removing all permissions
Remove-MgSitePermission -SiteId $spoSiteId -PermissionId $(get-MgSitePermission -SiteId $spoSiteId).id

#>
