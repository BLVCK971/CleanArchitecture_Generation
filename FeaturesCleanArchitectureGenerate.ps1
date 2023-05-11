# Script de création de fichiers pour X

# Demander le nom de X à l'utilisateur
$X = Read-Host "Entrez le nom de X"

# Créer le dossier pour X
md $X

# Créer les répertoires pour les commandes et les requêtes X
md "$X/Commands"
md "$X/Queries"

# Créer les fichiers pour la commande CreateX
md "$X/Commands/Create$X"
cd "$X/Commands/Create$X"
ni "Create${X}Command.cs"
ni "Create${X}CommandHandler.cs"
ni "Create${X}CommandResponse.cs"
ni "Create${X}CommandValidation.cs"
ni "Create${X}Dto.cs"
cd ../../..

# Créer les fichiers pour la commande DeleteX
md "$X/Commands/Delete$X"
cd "$X/Commands/Delete$X"
ni "Delete${X}Command.cs"
ni "Delete${X}CommandHandler.cs"
cd ../../..

# Créer les fichiers pour la commande UpdateX
md "$X/Commands/Update$X"
cd "$X/Commands/Update$X"
ni "Update${X}Command.cs"
ni "Update${X}CommandHandler.cs"
ni "Update${X}CommandValidation.cs"
cd ../../..

# Créer les fichiers pour la requête GetXDetail
md "$X/Queries/Get${X}Detail"
cd "$X/Queries/Get${X}Detail"
ni "Get${X}DetailQuery.cs"
ni "Get${X}DetailQueryHandler.cs"
ni "${X}DetailVm.cs"
cd ../../..

# Créer les fichiers pour la requête GetXsList
md "$X/Queries/Get${X}sList"
cd "$X/Queries/Get${X}sList"
ni "Get${X}sListQuery.cs"
ni "Get${X}sListQueryHandler.cs"
ni "${X}ListVm.cs"
cd ../../..

Write-Host "Fichiers pour $X créés avec succès."
