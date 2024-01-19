# Déploiement de l'infra

## 1) Authentification sur terraform cloud pour gérer le backend du tfstate
Créer un fichier nommé `~/.terraformrc` et ajouter votre token terraform dans le fichier.
Vous pouvez trouver votre token ici (`https://app.terraform.io/app/settings/tokens`)

```bash
credentials "app.terraform.io" {
  token = "<YOUR-TERRAFORM-CLOUD-TOKEN>"
}
```

## 2) Authentification et configuration provider AWS
Créer un ficher nommé `~/.aws/credentials` et ajouter vos informations de connexion dans le fichier.
Vous pouvez trouver ou créer vos informations de connexion dans l'onglet IAM d'AWS ici (https://console.aws.amazon.com/iam/home)

```bash
[default]
aws_access_key_id = XXXXXXXXXXXXXXXXX
aws_secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

Créer maintenant un autre ficher nommé `~/.aws/config` afin de finaliser la configuration d'AWS.

```
[default]
region=eu-west-3
output=json
```


## 3) Créer une clé ssh pour vos ops
Afin de pouvoir se connecter par la suite sur vos instances et base de données, il est nécessaire de générer une clé ssh et d'injecter sa clé publique dans le fichier `infra/6_bastion.tf` comme ci-dessous :

```bash
resource "aws_key_pair" "ecs_deployer" {
  key_name   = "ops-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDMx6L+la1Tup3Utj9qJnz9HaH+YCwK8sWMn8cTGSeW7LbIPX0PbJiOSwJGi0mCKrTseRlcwyAYIZlM/RkM4MUd5++ll9o3XHTj0SiqUceNxSP0dy/9ZMQwtO3k4YAA6CdaivYRF9D2x/053wDeOQ60rxvyh6H8V22gVEUC5XDKBQdwK4/Y52Pes5oyndv2Zbwl8t8/xjyYzxXmLGz0ZbvKHLNGAb5qXhF+09zJvi9q+XyGqumOAm06uquL5sRTN54QOiMiv7qvKdrNa80pHgsWZc2euRJls4X/ySIKcqoIzpySFXKLlhmnqmg5J7Xlx/FWKqKH/TJWPrGtc9z19nLN6IjNdYcIUZp7bi51hr8vCjTJYf2QqDkzpE4Bzdf77MxlyTohfYoskfb7WSCt6GJI1ptN4rJEnqw8iTsozQ9OqbG5QlRTxWuJ8efSLtnjiUrJHeTVqdWDtWphKq1wGD+2I7dZlYr9cMrZ7zb+5HXmap/uCH3c8HYfRzHmFAIsPwvpbVsbn+boqw4YgDWk5qlPLRpUgICL1az6X02vu3IGbwo06wmvqAZNE1GGz6OG/c5UTIZWRtuZA2fN35Wenc8MaAq9B3e9uK4PWlgfYk+X0gTGJYoHh9j0nUxM/Bepam//7TqTHhqF1fgehqZ+Eh9OCr0D8mRiGB4QCy8/fhGIbw== toto@keltio.fr"
}
```

Pour créer la clé ssh, il suffit de taper la commande suivante :
```bash
ssh-keygen -t rsa -b 4096 -C "toto@keltio.fr"
```

## 4) Initialiser votre terraform local

Si aucun workspace n'a déjà été créé il faut créer un workspace terraform. Chaque workspace contiendra en mémoire les ressources d'un environnement applicatif précis (prod, recette, dev).
Pour créer un environnement il suffit de taper la commande suivante :

```bash
cd infra
terraform workspace new <VOTRE-ENV> # Par exemple : prod, recette, dev
```

Une fois le workspace créé, vous pouvez maintenant initialiser terraform
```bash
cd infra
terraform init
```

Remarques :
- Après avoir créé le workspace il faut aller sur terraform cloud et s'assurer que le workspace va executer le code en local (avant de faire le terraform init). Pour faire cela il faut aller sur cette page https://app.terraform.io/app/<Votre Terraform Organization (Peut être trouvé dans le ficher versions.tf)>/workspaces/<Votre Terraform workspace (avec le prefix)>/settings/general

<p align="center">
  <img src="img/terraform_cloud_execution_mode.png"
       width="600"
       alt="Secrets"/>
</p>

- Les variables étant totalement dynamique dans le code en fonction des environnements, il faut par la suite configurer la valeur pour les environnements dans les fichiers suivants : `infra/1_settings.tf`

## 5) Déployer l'infra
Vous pouvez maintenant déployer le socle de l'infra en tapant les commandes suivantes.
```bash
cd infra
terraform apply
```

## 5) Mise à jour de l'infra
Si vous souhaitez mettre à jour l'infra (plus de ram, cpu, instances ...), il suffit d'aller dans le fichier main et de modifier les valeurs puis relancer `terraform apply`

## 6) Destruction de l'infra
Pour detruire l'infra, il suffit de lancer la commande suivante.
```bash
terraform destroy
```
