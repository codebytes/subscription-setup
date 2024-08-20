# Print a message indicating the start of the installation process
Write-Output "Starting the installation of the Az module from the PowerShell Gallery..."

# Install the Az module from the PowerShell Gallery
Install-Module -Name Az -Repository PSGallery -Force

# Print a message indicating the completion of the installation process
Write-Output "Az module installation completed successfully."
