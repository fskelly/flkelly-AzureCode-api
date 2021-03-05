## Authenticate

# Variables
$tenantId = "" # Enter Tenant Id.
$clientId = "" # Enter Client Id.
$clientSecret = "" # Enter Client Secret.
$subscriptionId = "" # Enter Subscription Id.
$resource = "https://management.core.windows.net/"

## Get TOKEN
$requestAccessTokenUri = "https://login.microsoftonline.com/$tenantId/oauth2/token"
$body = "grant_type=client_credentials&client_id=$clientId&client_secret=$clientSecret&resource=$resource"
$token = Invoke-RestMethod -Method Post -Uri $requestAccessTokenUri -Body $body -ContentType 'application/x-www-form-urlencoded'
Write-Host "Print Token" -ForegroundColor Green
Write-Output $token
