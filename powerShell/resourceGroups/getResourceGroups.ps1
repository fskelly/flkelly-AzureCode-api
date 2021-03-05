## Get Azure Resource Groups
$resourceGroupApiUri = "https://management.azure.com/subscriptions/$subscriptionId/resourcegroups?api-version=2017-05-10"
$headers = @{}
$headers.Add("Authorization","$($Token.token_type) "+ " " + "$($Token.access_token)")
$resourceGroups = Invoke-RestMethod -Method Get -Uri $resourceGroupApiUri -Headers $headers
Write-Host "Print Resource groups" -ForegroundColor Green
Write-Output $resourceGroups