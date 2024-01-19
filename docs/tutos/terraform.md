# Terraform info

## Create new env

Les environnements sont représentés par des `workspace` en terraform. Cela permet de gérer plusieurs tfstate en fonction des environnements.

Pour créer un workspace (infra env), il suffit de taper la commande suivante :

```bash
terraform workspace new <VOTRE ENV> # Par exemple : prod, recette, dev
```
