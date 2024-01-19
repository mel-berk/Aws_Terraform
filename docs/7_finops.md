# Analyse des coûts de l'infra

## Avoir une estimation des coûts avec Terracost

Aller dans le dossier terraform ou l'on souhaite avoir une prévision des coûts et lancer la commande suivante :
```bash
export TERRAFORM_CLOUD_TOKEN=<YOUR-TERRAFORM-TOKEN>
infracost breakdown --path . --usage-file infracost-usage.yml
```

## Coûts estimé des infras

Production ~= 200€ / mois
