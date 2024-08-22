# Ensure you are logged in to Azure
az login

# Get the list of all resource groups in the subscription
$resourceGroups = az group list --query "[].name" -o tsv

# Loop through each resource group and delete it
foreach ($rg in $resourceGroups) {
    Write-Output "Deleting resource group: $rg"
    az group delete --name $rg --yes --no-wait
}
Write-Output "All resource groups have been scheduled for deletion."

# Purge deleted Cognitive Services
$deletedCognitiveServices = az cognitiveservices account list-deleted --query "[].id" -o tsv
foreach ($cs in $deletedCognitiveServices) {
    Write-Output "Purging deleted Cognitive Service: $cs"
    az cognitiveservices account purge --ids $cs
}
Write-Output "All deleted Cognitive Services have been purged."

# Purge deleted Key Vaults
$deletedKeyVaults = az keyvault list-deleted --query "[].id" -o tsv
foreach ($kv in $deletedKeyVaults) {
    Write-Output "Purging deleted Key Vault: $kv"
    az keyvault purge --ids $kv
}
Write-Output "All deleted Key Vaults have been purged."

# Purge deleted App Configurations
$deletedAppConfigs = az appconfig list-deleted --query "[].id" -o tsv
foreach ($ac in $deletedAppConfigs) {
    Write-Output "Purging deleted App Configuration: $ac"
    az appconfig purge --ids $ac
}
Write-Output "All deleted App Configurations have been purged."

# Delete all App Registrations
$appRegistrations = az ad app list --query "[].appId" -o tsv
foreach ($app in $appRegistrations) {
    Write-Output "Deleting App Registration: $app"
    az ad app delete --id $app
}
Write-Output "All App Registrations have been deleted."

# Delete all Service Principals
$servicePrincipals = az ad sp list --query "[].appId" -o tsv
foreach ($sp in $servicePrincipals) {
    Write-Output "Deleting Service Principal: $sp"
    az ad sp delete --id $sp
}
Write-Output "All Service Principals have been deleted."