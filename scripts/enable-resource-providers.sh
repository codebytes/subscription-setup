# Get the list of all providers
#providers=$(az provider list --query "[].namespace" -o tsv)
providers=$(az provider list --query "[?registrationState!='Registered'].namespace" -o tsv)
#echo "$providers"

# Loop through each provider and enable it
for provider in $providers; do
  echo "Enabling provider: $provider"
  az provider register --namespace $provider
done

echo "All providers have been enabled."