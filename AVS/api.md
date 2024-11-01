Login into Azure  

```powershell
$tenantId = Read-host "Please enter your tenant id"
Connect-AzAccount -Tenant $tenantId
```

Set your subscription ID

```powershell
$subscriptionId = Read-host "Please enter your subscription id"
Set-AzContext -Subscription $subscriptionId 
```

Get a token for the API

```powershell
$token = (Get-AzAccessToken).token
```

[Reference for AVS](https://learn.microsoft.com/en-us/rest/api/avs/)

## [List Private Clouds](https://learn.microsoft.com/en-us/rest/api/avs/private-clouds/list?view=rest-avs-2023-09-01&tabs=HTTP)


### Example

#### List Private Clouds

GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds?api-version=2023-09-01

So let's build this programmatically now

```powershell
# $subscriptionId = Read-host "Please enter your subscription id" - IF NOT Using list_sub_login.ps1 first
$subscriptionId = (Get-AzContext).Subscription.Id
$resourceGroupName = Read-host "Please enter your resource group name"
$uri = "https://management.azure.com/subscriptions/" + $subscriptionId + "/resourceGroups/" + $resourceGroupName + "/providers/Microsoft.AVS/privateClouds?api-version=2023-09-01"

$headers = @{   
'Authorization' = "Bearer $token"
}

$result = Invoke-WebRequest -Method GET -Uri $uri -Headers $headers
$content = $result.Content
```

Lets Extract the JSON from the result

```powershell
($content | ConvertFrom-Json).value
```

An example below
```powershell
(($content | ConvertFrom-Json).value).properties
```

```powershell
availability           : @{secondaryZone=3; strategy=DualZone; zone=1}
circuit                : @{expressRouteID=/subscriptions/3f8c427f-8912-41f9-9690-c81ab88bda59/resourceGroups/tnt186-cust-p01-germanywestcentral/providers/Microsoft.Network/expressRouteCircuits/tnt186-cust-p01-germanyw 
                         estcentral-er; expressRoutePrivatePeeringID=/subscriptions/3f8c427f-8912-41f9-9690-c81ab88bda59/resourceGroups/tnt186-cust-p01-germanywestcentral/providers/Microsoft.Network/expressRouteCircui 
                         ts/tnt186-cust-p01-germanywestcentral-er/peerings/AzurePrivatePeering; primarySubnet=192.168.52.232/30; secondarySubnet=192.168.52.236/30}
encryption             : @{status=Disabled}
endpoints              : @{hcxCloudManager=https://hcx.560926be3e064c648.germanywestcentral.avs.azure.com/; hcxCloudManagerIp=192.168.52.9; nsxtManager=https://nsx.560926be3e064c648.germanywestcentral.avs.azure.com/;  
                         nsxtManagerIp=192.168.52.3; vcenterIp=192.168.52.2; vcsa=https://vc.560926be3e064c648.germanywestcentral.avs.azure.com/}
externalCloudLinks     : {}
identitySources        : {}
internet               : Disabled
managementCluster      : @{clusterId=1; clusterSize=6; displayName=Cluster-1; hosts=System.Object[]; provisioningState=Succeeded; vsanDatastoreName=vsanDatastore}
managementNetwork      : 192.168.52.0/26
networkBlock           : 192.168.52.0/22
nsxPublicIpQuotaRaised : Disabled
provisioningNetwork    : 192.168.54.0/25
provisioningState      : Succeeded
secondaryCircuit       : @{expressRouteID=/subscriptions/06f677fc-7d25-4ac5-b705-42afe8be8e27/resourceGroups/tnt186-cust-p02-germanywestcentral/providers/Microsoft.Network/expressRouteCircuits/tnt186-cust-p02-germanyw 
                         estcentral-er; expressRoutePrivatePeeringID=/subscriptions/06f677fc-7d25-4ac5-b705-42afe8be8e27/resourceGroups/tnt186-cust-p02-germanywestcentral/providers/Microsoft.Network/expressRouteCircui 
                         ts/tnt186-cust-p02-germanywestcentral-er/peerings/AzurePrivatePeering; primarySubnet=192.168.52.232/30; secondarySubnet=192.168.52.236/30}
vmotionNetwork         : 192.168.53.128/25

availability                 : @{strategy=SingleZone; zone=3}
circuit                      : @{expressRouteID=/subscriptions/06f677fc-7d25-4ac5-b705-42afe8be8e27/resourceGroups/tnt25-cust-p02-germanywestcentral/providers/Microsoft.Network/expressRouteCircuits/tnt25-cust-p02-germ 
                               anywestcentral-er; expressRoutePrivatePeeringID=/subscriptions/06f677fc-7d25-4ac5-b705-42afe8be8e27/resourceGroups/tnt25-cust-p02-germanywestcentral/providers/Microsoft.Network/expressRo 
                               uteCircuits/tnt25-cust-p02-germanywestcentral-er/peerings/AzurePrivatePeering; primarySubnet=192.168.48.232/30; secondarySubnet=192.168.48.236/30}
encryption                   : @{status=Disabled}
endpoints                    : @{hcxCloudManager=https://hcx.a77c17c4d40b4760b.germanywestcentral.avs.azure.com/; hcxCloudManagerIp=192.168.48.9;
                               nsxtManager=https://nsx.a77c17c4d40b4760b.germanywestcentral.avs.azure.com/; nsxtManagerIp=192.168.48.3; vcenterIp=192.168.48.2;
                               vcsa=https://vc.a77c17c4d40b4760b.germanywestcentral.avs.azure.com/}
externalCloudLinks           : {}
identitySources              : {}
internet                     : Disabled
managementCluster            : @{clusterId=1; clusterSize=3; displayName=Cluster-1; hosts=System.Object[]; provisioningState=Succeeded; vsanDatastoreName=vsanDatastore}
managementNetwork            : 192.168.48.0/26
networkBlock                 : 192.168.48.0/22
nsxPublicIpQuotaRaised       : Disabled
nsxtCertificateThumbprint    : 5B89C97E166B3272A0C6DA4B1445463F8170CB32
provisioningNetwork          : 192.168.50.0/25
provisioningState            : Succeeded
vcenterCertificateThumbprint : 24761F3CF6E142305BA4F794112624E844CF001A
vmotionNetwork               : 192.168.49.128/25
```

#### List Clusters in Private Clouds

GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters?api-version=2023-09-01

So let's build this programmatically now

```powershell
# $subscriptionId = Read-host "Please enter your subscription id" - IF NOT Using list_sub_login.ps1 first
$subscriptionId = (Get-AzContext).Subscription.Id
$resourceGroupName = Read-host "Please enter your resource group name"
$privateCloudName = Read-host "Please enter your private cloud name"
$uri = "https://management.azure.com/subscriptions/" + $subscriptionId + "/resourceGroups/" + $resourceGroupName + "/providers/Microsoft.AVS/privateClouds/"+ $privateCloudName + "/clusters?api-version=2023-09-01"

$headers = @{   
'Authorization' = "Bearer $token"
}

$result = Invoke-WebRequest -Method GET -Uri $uri -Headers $headers
$content = $result.Content
```

|There is an oddity with the Azure VMware Solution REST API, it there is only one cluster, it will return a single object, if there are more than one, it will return an array of objects. So you need to check the type of object returned and then process it accordingly.|

**NB: Cluster-1 is the default name of the cluster created when the Private Cloud is created. It also case-sensitive.**

```powershell
if ("" -eq ($content | ConvertFrom-Json).value) 
{
    "true"
    $uri = "https://management.azure.com/subscriptions/" + $subscriptionId + "/resourceGroups/" +$resourceGroupName + "/providers/Microsoft.AVS/privateClouds/" +$privateCloudName + "/clusters/Cluster-1?api-version=2023-09-01"
    $headers = @{   
    'Authorization' = "Bearer $token"
    }

    $result = Invoke-WebRequest -Method GET -Uri $uri -Headers $headers
    $content = $result.Content
} else {
    write-output "Multiple Clusters"
    write-output "Cluster-1"
    $uri = "https://management.azure.com/subscriptions/" + $subscriptionId + "/resourceGroups/" +$resourceGroupName + "/providers/Microsoft.AVS/privateClouds/" +$privateCloudName + "/clusters/Cluster-1?api-version=2023-09-01"
    $headers = @{   
    'Authorization' = "Bearer $token"
    }

    $cluster1Result = Invoke-WebRequest -Method GET -Uri $uri -Headers $headers
    $cluster1Content = $cluster1Result.Content

    Write-output "Cluster-2"
    $clusterName = ($content | ConvertFrom-Json).value.name
    $uri = "https://management.azure.com/subscriptions/" + $subscriptionId + "/resourceGroups/" +$resourceGroupName + "/providers/Microsoft.AVS/privateClouds/" +$privateCloudName + "/clusters/" + $clusterName + "?api-version=2023-09-01"
    $headers = @{   
    'Authorization' = "Bearer $token"
    }

    $cluster2Result = Invoke-WebRequest -Method GET -Uri $uri -Headers $headers
    $cluster2Content = $cluster2Result.Content

    ## create custom JSON array
    $clusterContents = "[" + $cluster1Content +","+ $cluster2Content + "]"

    $content = $clusterContents

}
```

Lets Extract the JSON from the result

```powershell
($content | ConvertFrom-Json)
```

To get an idea of what is possible, you can output to GM "Get-Member" to see what properties are available.

```powershell
($content | ConvertFrom-Json) | Get-Member
```

Some examples below
```powershell
(($content | ConvertFrom-Json)).properties

clusterId         : 1
clusterSize       : 3
displayName       : Cluster-1
hosts             : {esx03-r06.p02.germanywestcentral.avs.azure.com, esx03-r18.p02.germanywestcentral.avs.azure.com, esx11-r14.p02.germanywestcentral.avs.azure.com}
provisioningState : Succeeded
vsanDatastoreName : vsanDatastore

(($content | ConvertFrom-Json)).properties.hosts

esx03-r06.p02.germanywestcentral.avs.azure.com
esx03-r18.p02.germanywestcentral.avs.azure.com
esx11-r14.p02.germanywestcentral.avs.azure.com

(($content | ConvertFrom-Json)).id

/subscriptions/bd4d88c1-fc0f-482f-b57b-2f3ed541945e/resourceGroups/contoso-gwc-avs-rg/providers/Microsoft.AVS/privateClouds/contoso-gwc-avs-sddc01/clusters/Cluster-1


```
