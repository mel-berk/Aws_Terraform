# Se connecter au VPN

1) Après avoir fait ```terraform apply```, rendez-vous sur la console Amazon > VPC > [Client VPN Endpoints](https://eu-west-3.console.aws.amazon.com/vpc/home?region=eu-west-3#ClientVPNEndpoints:sort=clientVpnEndpointId) (Vérifier d'avoir bien choisi la région eu-west-3).  
2) Sélectionnez le Point de terminaison VPN client créé.  
3) Cliquez sur le bouton "Download Client Configuration"  
4) Éditez le fichier téléchargé avec votre éditeur de texte.  
5) Les premières lignes resembleront à ça:  

```bash
remote cvpn-endpoint-<...>.prod.clientvpn.<REGION-AWS>.amazonaws.com 443
```

6) Ajoutez votre nom dans le nom de l'hôte, comme ceci:  

```bash
remote companyName.cvpn-endpoint-<...>.prod.clientvpn.<AWS-REGION>.amazonaws.com 443
```

Après cela, vous pourrez vous connecter au vpn et avoir les informations sur qui s'est connecté et quand

```bash
sudo openvpn --cert ca/<nom utilisateur>.crt --key ca/<nom utilisateur>.key --config downloaded-client-config.ovpn
```

## Connexion à la base de donnée

Après s'être connecté au VPN, lancer les commandes suivantes pour accéder à votre base de donnée

```bash
dig companyName-prod-rds.chsnauevtsiu.eu-west-3.rds.amazonaws.com @172.16.0.2 
# RESULT
; <<>> DiG 9.16.1-Ubuntu <<>> companyName-prod-rds.chsnauevtsiu.eu-west-3.rds.amazonaws.com@172.16.0.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 9454
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;companyName-prod-rds.chsnauevtsiu.eu-west-3.rds.amazonaws.com\@172.16.0.2. IN A

;; Query time: 16 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: mer. oct. 06 17:09:02 CEST 2021
;; MSG SIZE  rcvd: 96
```

Connectez-vous ensuite à la base de données avec l'ip

```bash
psql -h 172.16.20.244 -p 8000 -d <POSTGRES_DB> -U <POSTGRES_USER>
```

<b>Remarques :</b>Nous ne pouvons pas utiliser le nom d'hôte de la base de données car la connexion VPN ne le résout pas même avec le paramètre défini dans le fichier de configuration VPN

