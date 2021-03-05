
## Remember to run pre-reqs for token

## UPDATE VARIABLES BELOW

## Create RG Variables
$vnetRG = ""
$vnetName = ""
$snetName = ""
$vnetRGLocation = ""
$apiVersion = "2020-07-01"
$vnetCIDR = ""
$subnetCIDR = ""

## HEADERS
$headers = @{}
$headers.Add("Authorization","$($Token.token_type) "+ " " + "$($Token.access_token)")
$createVirtualNetworkApiUri = "https://management.azure.com/subscriptions/"+$subscriptionId+"/resourcegroups/"+$vnetRG+"/providers/Microsoft.Network/virtualNetworks/"+$vnetName+"?api-version="+$apiVersion
$body = @{
    properties = @{
        addressSpace =@{ 
            addressPrefixes = @(
                $vnetCIDR
            )
        }
    subnets = @(
        @{
            name = $snetName
            properties = @{
            addressPrefix = $snetCIDR
            }
        }
    )
    }
    location = $vnetRGLocation
}

## Create vnet with API
$createVnet = Invoke-RestMethod -Method Put -Uri $createVirtualNetworkApiUri -Headers $headers -ContentType "application/json" -Body ($body | ConvertTo-Json -Depth 5)