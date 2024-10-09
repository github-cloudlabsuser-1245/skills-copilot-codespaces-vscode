# Login to Azure
Connect-AzAccount

# Define parameters
$resourceGroupName = "example-resources"
$location = "eastus"
$storageAccountName = "examplestorageacct"
$skuName = "Standard_LRS"
$accessTier = "Hot"

# Create Resource Group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create Storage Account
New-AzStorageAccount -ResourceGroupName $resourceGroupName `
                     -Name $storageAccountName `
                     -Location $location `
                     -SkuName $skuName `
                     -Kind StorageV2 `
                     -AccessTier $accessTier