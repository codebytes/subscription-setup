# Ensure you are logged in to Azure
if [ -z "$(az account show)" ]; then
    echo "You are not logged in. Please run 'az login' or 'az login --use-device-code' first."
    exit 1
fi

# Get the list of all providers
providers=$(az provider list --query "[?registrationState!='Registered'].namespace" -o tsv)

# Loop through each provider and enable it
for provider in $providers; do
  echo "Enabling provider: $provider"
  az provider register --namespace $provider
done

echo "All providers have been enabled."