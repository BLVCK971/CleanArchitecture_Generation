# Demander le nom de X à l'utilisateur
$X = Read-Host "Entrez le nom de X"

# Créer le dossier pour X
md $X

# Créer les répertoires pour les commandes et les requêtes X
md "$X/Commands"
md "$X/Queries"

# Copier et remplacer les fichiers Service par TenantAzureAd
$sourceFolder = "Services"
$targetFolder = $X

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
            $targetPath = Join-Path (Join-Path $targetFolder $category) "${command}$X"
            If (!(Test-Path -Path $targetPath)) {
                New-Item -ItemType Directory -Path $targetPath
            }
            Get-ChildItem -Path $sourcePath -Filter *.cs | ForEach-Object {
                $content = Get-Content $_.FullName -Raw
                $updatedContent = $content.Replace("Service", $X)
                $newFileName = $_.Name.Replace("Service", $X)
                Set-Content -Path (Join-Path $targetPath $newFileName) -Value $updatedContent
            }
        }
    }

    If ($category -eq "Queries") {
        ForEach ($query in $queries) {
            $sourcePath = Join-Path (Join-Path $sourceFolder $category) "GetService${query}"
            $targetPath = Join-Path (Join-Path $targetFolder $category) "Get${X}${query}"
            If (!(Test-Path -Path $targetPath)) {
                New-Item -ItemType Directory -Path $targetPath
            }
            Get-ChildItem -Path $sourcePath -Filter *.cs | ForEach-Object {
                $content = Get-Content $_.FullName -Raw
                $updatedContent = $content.Replace("Service", $X)
                $newFileName = $_.Name.Replace("Service", $X)
                Set-Content -Path (Join-Path $targetPath $newFileName) -Value $updatedContent
            }
        }
    }
}

Write-Host "Le contenu des fichiers .cs de Services a été copié dans les fichiers correspondants de $X avec succès."
