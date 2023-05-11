# Demander le nom de X à l'utilisateur
$X = Read-Host "Entrez le nom de X"

# Demander le nom de Y à l'utilisateur
$Y = Read-Host "Entrez le nom de Y"

# Créer le dossier pour X
md $X

# Créer les répertoires pour les commandes et les requêtes X
md "$X/Commands"
md "$X/Queries"

# Copier et remplacer les fichiers Y par X
$sourceFolder = "${Y}s"
$targetFolder = $X

# Créez le dossier X s'il n'existe pas
If (!(Test-Path -Path $targetFolder)) {
    New-Item -ItemType Directory -Path $targetFolder
}

$categories = @("Commands", "Queries")
$commands = @("Create", "Delete", "Update")
$queries = @("Detail", "sList")

# Parcourir les dossiers et fichiers de Y
ForEach ($category in $categories) {
    $targetCategoryPath = Join-Path $targetFolder $category
    If (!(Test-Path -Path $targetCategoryPath)) {
        New-Item -ItemType Directory -Path $targetCategoryPath
    }

    If ($category -eq "Commands") {
        ForEach ($command in $commands) {
            $sourcePath = Join-Path (Join-Path $sourceFolder $category) "${command}$Y"
            $targetPath = Join-Path (Join-Path $targetFolder $category) "${command}$X"
            If (!(Test-Path -Path $targetPath)) {
                New-Item -ItemType Directory -Path $targetPath
            }
            Get-ChildItem -Path $sourcePath -Filter *.cs | ForEach-Object {
                $content = Get-Content $_.FullName -Raw
                $updatedContent = $content.Replace($Y, $X)
                $newFileName = $_.Name.Replace($Y, $X)
                Set-Content -Path (Join-Path $targetPath $newFileName) -Value $updatedContent
            }
        }
    }

    If ($category -eq "Queries") {
        ForEach ($query in $queries) {
            $sourcePath = Join-Path (Join-Path $sourceFolder $category) "Get${Y}${query}"
            $targetPath = Join-Path (Join-Path $targetFolder $category) "Get${X}${query}"
            If (!(Test-Path -Path $targetPath)) {
                New-Item -ItemType Directory -Path $targetPath
            }
            Get-ChildItem -Path $sourcePath -Filter *.cs | ForEach-Object {
                $content = Get-Content $_.FullName -Raw
                $updatedContent = $content.Replace($Y, $X)
                $newFileName = $_.Name.Replace($Y, $X)
                Set-Content -Path (Join-Path $targetPath $newFileName) -Value $updatedContent
            }
        }
    }
}

Write-Host "Le contenu des fichiers .cs de ${Y}s a été copié dans les fichiers correspondants de $X avec succès."
