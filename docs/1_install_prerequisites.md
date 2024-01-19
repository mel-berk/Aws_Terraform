# Prerequis

## 1) Installer terraform sur sa machine
Vous pouvez trouver ici les binaires d'installations : https://learn.hashicorp.com/tutorials/terraform/install-cli

## 2) Installer jq sur sa machine
Si vous êtes sur linux vous pouvez installer jq de la manière suivante :
```
sudo apt install jq -y
```

## 3) Installer aws-vault sur sa machine
Afin de pouvoir gérer les crédentials aws avec efficacité sur son environnement de travail, nous utilisons aws-vault. Il faut donc l'installer. 
Vous pouvez trouver ici les explications d'installations : https://github.com/99designs/aws-vault#installing

## 4) Installer boto sur sa machine
Les scripts terraform lance de temps des scripts python pour palier aux bugs natifs d'AWS ou terraform. Il faut donc installer une petite librairie que l'on utilise dans l'un des modules.
```bash
pip install boto3
```

## 5) Installer le cli AWS sur sa machine
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

## 6) Installer le cli infracost sur sa machine
Il est possible d'installer infracost simplement en suivant la documentation suivante : https://www.infracost.io/docs/

Pour tester que le cli fonctionne bien on peut lancer la commande suivante :
```bash
infracost
```

## 7) Créer une clé ssh pour se connecter sur le bastion

Pour créer la clé ssh, il suffit de taper la commande suivante :
```bash
ssh-keygen -t rsa -b 4096 -C "<mon email>"
```

Une fois la clé généré, il faut prendre le contenu de la clé publique (id_rsa.pub) et la copier dans le ficher `infra/1_settings.tf`
