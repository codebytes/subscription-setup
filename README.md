# Subscription Setup

This repository contains scripts to help setup new Azure subscriptions quickly.
This includes a devcontainer with `az`, `azd`, `jq`, and `powershell` installed.

## Scripts

| Language   | Script Name | Description |
|------------|-------------|-------------|
| Bash       | [Enable Resource Providers](./scripts/enable-resource-providers.sh) | This script enables the required resource providers for the subscription. |
| PowerShell | [Install Az Module](./scripts/install-az-module.ps1) | This script installs the Az module from the PowerShell Gallery. |
| PowerShell | [Enable Resource Providers](./scripts/enable-resource-providers.ps1) | This script enables the required resource providers for the subscription. |
| Bash       | [Delete All Resources](./scripts/delete-all-resources.sh) | This script deletes all resource groups, app registrations, and service principals. |
| PowerShell | [Delete All Resources](./scripts/delete-all-resources.ps1) | This script deletes all resource groups, app registrations, and service principals. |