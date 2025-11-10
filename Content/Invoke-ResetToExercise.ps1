param(
    [int]$exerciseNumber,
    [string]$solutionsPath = "C:\Labs\Content\solutions",
    [string]$labPath = "$env:USERPROFILE\terraform-labs",
    [string]$tenantId = $null,
    [string]$subscriptionId = $null,
    [string]$username = $null,
    [securestring]$password = $null
)

Write-Output "Resetting to Exercise $exerciseNumber..."

if(Test-Path $labPath) {
  $stateFilePath = Join-Path $labPath "terraform.tfstate"
  if(Test-Path $stateFilePath) {
    Write-Output "Existing state file found. Running Terraform Destroy to clean up resources..."
    terraform -chdir="$labPath" destroy -auto-approve
  }
  Write-Output "Existing lab folder found. Deleting lab folder..."
  Remove-Item -Recurse -Force $labPath | Out-String | Write-Verbose
}

Write-Output "Creating lab folder..."
New-Item -ItemType Directory -Path $labPath -Force | Out-String | Write-Verbose

Write-Output "Copying exercise files to lab folder..."
$exercisePath = Join-Path $solutionsPath "exercise$($exerciseNumber.ToString("00"))"
Copy-Item -Force -Recurse "$exercisePath\*" $labPath | Out-String | Write-Verbose

Write-Output "Logging into Azure CLI and Setting Subscription Env Var..."
if($tenantId -ne $null -and $username -ne $null -and $password -ne $null) {
  Write-Output "Using provided credentials to login..."
  az login -t $tenantId -u $username -p $(ConvertFrom-SecureString -SecureString $password -AsPlainText)
} else {
  Write-Output "No credentials provided. Assuming you are already connected to Azure CLI..."
}

if($subscriptionId -eq $null) {
  Write-Output "No subscription provided. Using default subscription..."
  $subscriptionId = az account show --query id -o tsv
} else {
  az account set --subscription $subscriptionId
}

$env:ARM_SUBSCRIPTION_ID = $subscriptionId

Write-Output "Initializing and Applying Terraform..."

$remoteStateModulePath = Join-Path $labPath "storage_account"
if(Test-Path $remoteStateModulePath) {
  Write-Output "Remote state module found. Initializing and applying remote state module..."
  terraform -chdir="$remoteStateModulePath" init
  terraform -chdir="$remoteStateModulePath" apply -auto-approve

  $outputs = $(terraform -chdir="$remoteStateModulePath" output -json storage_account_details) | ConvertFrom-Json
  Write-Output "Remote state module outputs:"
  Write-Output "Resource Group Name: $($outputs.resource_group_name)"
  Write-Output "Storage Account Name: $($outputs.storage_account_name)"

  Write-Output "Waiting for storage account permissions to propagate..."
  Start-Sleep -Seconds 60
  
  terraform -chdir="$labPath" init `
  -backend-config="resource_group_name=$($outputs.resource_group_name)" `
  -backend-config="storage_account_name=$($outputs.storage_account_name)" `
  -backend-config="container_name=tfstate" `
  -backend-config="key=terraform.tfstate" `
  -backend-config="use_azuread_auth=true"
} else {
  terraform -chdir="$labPath" init
}

terraform -chdir="$labPath" apply -auto-approve

Write-Output "You are now reset to Exercise $exerciseNumber"
