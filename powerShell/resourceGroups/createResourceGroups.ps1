## Remember to run pre-reqs for token

## UPDATE VARIABLES BELOW

## Create RG Variables
$rgNameToCreate = ""
$rgLocation = ""
$apiVersion = "2020-09-01"

## HEADERS
$headers = @{}
$headers.Add("Authorization","$($Token.token_type) "+ " " + "$($Token.access_token)")
$createResourceGroupApiUri = "https://management.azure.com/subscriptions/"+$subscriptionId+"/resourcegroups/"+$rgNameToCreate+"?api-version="+$apiVersion
$body = @{
    location = $rgLocation
}
 
## Create RG with API
$createResourceGroup = Invoke-RestMethod -Method Put -Uri $createResourceGroupApiUri -Headers $headers -ContentType "application/json" -Body ($body | ConvertTo-Json)
