#!/bin/bash

# Ensure you are logged in to Azure
if [ -z "$(az account show)" ]; then
    echo "You are not logged in. Please run 'az login' or 'az login --use-device-code' first."
    exit 1
fi

# Get the list of all resource groups in the subscription
resource_groups=$(az group list --query "[].name" -o tsv)

# Loop through each resource group and delete it
for rg in $resource_groups; do
  echo "Deleting resource group: $rg"
  az group delete --name $rg --no-wait --yes 
done
echo "All resource groups have been scheduled for deletion."

# Purge deleted Cognitive Services
deleted_cognitive_services=$(az cognitiveservices account list-deleted --query "[].id" -o tsv)
for cs in $deleted_cognitive_services; do
  echo "Purging deleted Cognitive Service: $cs"
  array=($(echo $cs | tr "/" "\n"))
  loc=${array[5]}
  rg=${array[7]}
  nm=${array[9]}
  az cognitiveservices account purge --name $nm --resource-group $rg --location $loc
done
echo "All deleted Cognitive Services have been purged."

# Purge deleted Key Vaults
deleted_keyvaults=$(az keyvault list-deleted --query "[].name" -o tsv)
for kv in $deleted_keyvaults; do
  echo "Purging deleted Key Vault: $kv"
  az keyvault purge --name $kv
done
echo "All deleted Key Vaults have been purged."


# Purge deleted App Configurations
deleted_app_configs=$(az appconfig list-deleted --query "[].id" -o tsv)
for ac in $deleted_app_configs; do
  echo "Purging deleted App Configuration: $ac"
  az appconfig purge --id $ac
done
echo "All App Configurations have been deleted."

# # Delete all App Registrations
# app_registrations=$(az ad app list --query "[].appId" -o tsv)
# for app in $app_registrations; do
#   echo "Deleting App Registration: $app"
#   az ad app delete --id $app
# done
# echo "All App Registrations have been deleted."
