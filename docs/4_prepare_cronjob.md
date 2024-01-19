# Cronjob

Le cronjob est un ensemble de code qui sera exécuté sur AWS Lambda. Afin de pouvoir le déployer, il faut réaliser les prérequis suivants avant de lancer le déploiement du backend :

## Zip du layer lambda

La lambda fonction ayant besoin de librairie python supplémentaires, nous créons un layer qui sera utilisé par AWS pour injecter les dépendances python. De cette façon, les imports des librairies comme pandas fonctionneront.
```bash
cd cronjob/lambda_layer
chmod +x get_layer_packages.sh
./get_layer_packages.sh
zip -r ../aws_zip/companyName_python37_layer.zip .
```

## Zip le code de la lambda function

```bash
cd cronjob/lambda_function
# zip -r <output_file> <folder_1> <folder_2> ... <folder_n>
zip -r ../aws_zip/lambda_function.zip .
```

## Notes
Si vous modifiez le code du cronjob, il faut re-créer le zip de la lambda function et le zip du layer si les dépendances python ont changés. Vous pourrez par la suite mettre à jour le cronjob en lançant de nouveau le déploiement du backend.
