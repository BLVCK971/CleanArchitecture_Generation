$sourceFolder = "Services"
$targetFolder = "TenantAzureAds"

# Créez le dossier TenantAzureAds s'il n'existe pas
If (!(Test-Path -Path $targetFolder)) {
    New-Item -ItemType Directory -Path $targetFolder
}

$categories = @("Commands", "Queries")
$commands = @("Create", "Delete", "Update")
$queries = @("Detail", "List")

# Parcourir les dossiers et fichiers de Services
ForEach ($category in $categories) {
    $targetCategoryPath = Join-Path $targetFolder $category
    If (!(Test-Path -Path $targetCategoryPath)) {
        New-Item -ItemType Directory -Path $targetCategoryPath
    }

    If ($category -eq "Commands") {
        ForEach ($command in $commands) {
            $sourcePath = Join-Path (Join-Path $sourceFolder $category) "${command}Service"
            $targetPath = Join-Path (Join-Path $targetFolder $category) "${command}TenantAzureAd"
            If (!(Test-Path -Path $targetPath)) {
                New-Item -ItemType Directory -Path $targetPath
            }
            Get-ChildItem -Path $sourcePath -Filter *.cs | ForEach-Object {
                $content = Get-Content $_.FullName -Raw
                $updatedContent = $content.Replace("Service", "TenantAzureAd")
                $newFileName = $_.Name.Replace("Service", "TenantAzureAd")
                Set-Content -Path (Join-Path $targetPath $newFileName) -Value $updatedContent
            }
        }
    }

    If ($category -eq "Queries") {
        ForEach ($query in $queries) {
            $sourcePath = Join-Path (Join-Path $sourceFolder $category) "GetService${query}"
            $targetPath = Join-Path (Join-Path $targetFolder $category) "GetTenantAzureAd${query}"
            If (!(Test-Path -Path $targetPath)) {
                New-Item -ItemType Directory -Path $targetPath
            }
            Get-ChildItem -Path $sourcePath -Filter *.cs | ForEach-Object {
                $content = Get-Content $_.FullName -Raw
                $updatedContent = $content.Replace("Service", "TenantAzureAd")
                $newFileName = $_.Name.Replace("Service", "TenantAzureAd")
                Set-Content -Path (Join-Path $targetPath $newFileName) -Value $updatedContent
            }
        }
    }
}

Write-Host "Le contenu des fichiers .cs de Services a été copié dans les fichiers correspondants de TenantAzureAds avec succès."
