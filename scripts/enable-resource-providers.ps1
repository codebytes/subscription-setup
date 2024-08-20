# Get the list of all providers
$providers = Get-AzResourceProvider `
    | Where-Object { $_.RegistrationState -ne 'Registered' } 
    | Select-Object -ExpandProperty ProviderNamespace

# Loop through each provider and enable it
foreach ($provider in $providers) {
    Write-Output "Enabling provider: $provider"
    Register-AzResourceProvider -ProviderNamespace $provider
}

Write-Output "All providers have been enabled."
