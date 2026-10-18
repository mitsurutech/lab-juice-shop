# Lab OWASP Juice Shop avec Docker Compose : apprendre la sécurité des applications web en attaquant une boutique en ligne vulnérable

[English](README.md) | [Français](README.fr.md) | [日本語](README.ja.md) | [Español](README.es.md)

[![check](https://github.com/mitsurutech/lab-juice-shop/actions/workflows/check.yml/badge.svg)](https://github.com/mitsurutech/lab-juice-shop/actions/workflows/check.yml)

Un **lab de sécurité des applications web** prêt à l’emploi pour la classe, proposé par la [plateforme d’apprentissage MitsuruTech](https://mitsurutech.co.uk/fr/learning), où les écoles et les établissements donnent à chaque élève ses propres bases de données, conteneurs et terminal dans le navigateur. Chaque élève reçoit sa propre copie d’**OWASP Juice Shop**, une boutique en ligne volontairement vulnérable, avec une centaine de défis couvrant l’[OWASP Top 10](https://owasp.org/www-project-top-ten/) : injection, authentification défaillante, contrôle d’accès défaillant, cross-site scripting, mauvaise configuration de la sécurité et plus encore. Les élèves trouvent les failles, **expliquent pourquoi chacune fonctionne et comment le code aurait dû être écrit**, et rendent des preuves, sans rien installer et sans risque pour la machine de quiconque.

C’est un seul fichier `docker-compose`, `compose.yaml`, qui fonctionne de la même façon sur votre machine et sur la plateforme, où chaque élève dispose d’une copie privée sans aucune sortie vers Internet.

## La règle à retenir

**Attaquez votre propre copie, et rien d’autre.** Tout ce que fait ce lab se passe dans votre copie privée, qui n’a aucune route vers Internet ni vers les autres élèves : la seule chose que vous pouvez atteindre est l’application que le lab a démarrée pour vous. Ne dirigez jamais un outil vers un site web, un réseau ou une machine qui ne vous appartient pas, dans un lab comme ailleurs : au Royaume-Uni, c’est une infraction au titre du [Computer Misuse Act 1990](https://www.legislation.gov.uk/ukpga/1990/18/contents), et la plupart des pays ont une loi équivalente. Comprendre comment fonctionnent les failles, c’est apprendre à écrire des logiciels qui n’en ont pas, et une bonne première discussion en classe porte sur la raison d’être de cette règle et sur ce qu’est la divulgation responsable.

## Ce que contient le lab

| Service | Image | Mémoire | Ce que c’est |
| --- | --- | --- | --- |
| `juice-shop` | [`bkimminich/juice-shop:v20.3.0`](https://hub.docker.com/r/bkimminich/juice-shop) | 512 Mo | la boutique, sur le port 3000, exécutée sous un compte sans privilèges (utilisateur 65532) et sans aucune capacité |

Elle démarre en quelques secondes et utilise à peu près 100 Mo en usage léger ; une classe qui s’en sert intensivement en utilisera davantage.

Les images sont des programmes tiers, exécutés sans modification à partir des images publiques des projets eux-mêmes et figées sur une version (jamais `latest`), de sorte que le lab ne change pas sous les pieds d’une classe d’une leçon à l’autre. Rien n’est construit ici et rien de ce dépôt n’est distribué dans ces images.

## L’utiliser sur la plateforme

La [plateforme d’apprentissage MitsuruTech](https://mitsurutech.co.uk/fr/learning) donne à chaque élève sa propre copie d’un lab, dans le navigateur, avec un terminal à côté.

**Pour l’essayer :** ouvrez la [page des conteneurs](https://mitsurutech.co.uk/fr/container), trouvez ce lab dans **Laboratoires d’exemple** et appuyez sur Démarrer. Aucun compte n’est nécessaire pour en essayer un.

**Pour le donner comme travail à une classe :**

1. Dans votre module, créez une tâche de type **Lab** et choisissez **Dans un dépôt GitHub**.
2. Indiquez `https://github.com/mitsurutech/lab-juice-shop` avec la branche `main`. Le fichier compose par défaut est `compose.yaml`. Faites d’abord un fork du dépôt si vous voulez modifier le fichier.
3. Publiez. La copie de chaque élève part du commit que vous avez publié, de sorte qu’une modification ultérieure ici ne change pas un lab déjà donné.
4. Précisez dans la tâche ce qu’il faut rendre (voir [Pour les enseignants](#pour-les-enseignants)), puis distribuez-la comme n’importe quelle autre tâche.

Le [guide des labs de sécurité](https://mitsurutech.co.uk/fr/help/security-labs) du manuel et son [guide des labs de conteneurs](https://mitsurutech.co.uk/fr/help/labs) disent le reste : ce qu’un fichier compose peut contenir, la mémoire dont dispose une copie, et comment un enseignant ouvre, suit et note la copie d’un élève.

Pas encore de compte d’établissement ? [La première année est gratuite](https://mitsurutech.co.uk/fr/pricing) jusqu’à 50 élèves, et [l’inscription](https://mitsurutech.co.uk/fr/signup) ne demande qu’une adresse e-mail.

## L’exécuter sur votre propre machine

Il vous faut Docker avec le plugin Compose. Le premier démarrage télécharge les images.

```bash
docker compose -f compose.yaml -f local.yaml up
```

Ouvrez <http://localhost:3000> pour la boutique.

`local.yaml` publie les ports sur `127.0.0.1` uniquement, de sorte que le lab n’est accessible que depuis votre ordinateur et nulle part ailleurs. Arrêtez-le avec `Ctrl-C` et supprimez-le avec `docker compose -f compose.yaml -f local.yaml down -v`. Faites-le tourner sur une machine depuis laquelle vous acceptez d’attaquer : l’application est volontairement vulnérable.

## Pas à pas

1. **Ouvrez la boutique** (sur la plateforme, appuyez sur **Ouvrir** sur la page du lab) et explorez-la comme le ferait un client : inscrivez-vous, ajoutez des articles au panier, lisez les avis.
2. **Trouvez le Score Board.** Il liste tous les défis par difficulté et passe chacun au vert quand il est résolu, et aucun lien n’y mène : le trouver est le premier défi.
3. **Montez en difficulté.** Les défis couvrent l’OWASP Top 10 : injection, authentification défaillante, contrôle d’accès défaillant, cross-site scripting, mauvaise configuration de la sécurité et plus encore. Regardez ce que le navigateur envoie et reçoit, lisez ce que fait le code de la page, et demandez-vous pour chaque entrée ce que le programme en suppose. Les indices du Score Board vont plus loin, et un élève qui a d’abord essayé en tire plus.
4. **Gardez votre place.** La boutique oublie son état à l’arrêt du lab : un élève qui continuera demain copie le **code de reprise** (continue code) que propose le Score Board.

## Pour les enseignants

Rien dans ce lab n’est noté automatiquement. L’élève rend des preuves et vous les notez, comme pour n’importe quel autre lab.

**Demandez des preuves en deux volets.** D’abord, la preuve du travail : une capture d’écran des défis résolus sur le Score Board, avec l’adresse propre du lab visible dans le navigateur, pour qu’il soit clair que c’est sa copie. Ensuite, la compréhension : pour chacun, une explication écrite avec ses propres mots de ce qu’est la faille, de l’entrée exacte utilisée et de la raison pour laquelle elle a fonctionné, de ce qu’un attaquant pourrait en faire et de la façon dont le code aurait dû être écrit. Le second volet vous dit si c’est compris ou recopié depuis un pas-à-pas. Pour un travail plus solide, demandez la correction en plus de l’attaque.

**Place dans un cursus.** Juice Shop convient à l’OWASP Top 10 dans une application réaliste : menaces et vulnérabilités, injection, faiblesses d’authentification et de session, contrôle d’accès, défaillances cryptographiques et mauvaise configuration de la sécurité, et l’évaluation des vulnérabilités comme méthode. Il appuie aussi le volet juridique et éthique d’une unité : autorisation et périmètre, Computer Misuse Act 1990 et divulgation responsable. Vérifiez le libellé exact dans l’unité de votre propre organisme certificateur : aucun n’est cité ici.

**Qui voit quoi.** Ces labs sont souvent utilisés avec des élèves de 16 et 17 ans. Une copie est privée pour l’élève qui l’a démarrée. Un membre du personnel qui enseigne le module peut l’ouvrir pour voir ce que l’élève a fait, et l’ouverture du travail d’un élève est consignée dans le journal d’accès, que l’élève peut lire.

## Ce qui ne fonctionne pas dans un lab

Un petit nombre de défis ont besoin d’Internet ou d’un service d’IA et ne peuvent pas être résolus dans un lab, qui n’a aucune sortie. L’état de la boutique est gardé en mémoire et disparaît donc à l’arrêt du lab : utilisez le code de reprise pour continuer. Elle reçoit 512 Mo.

## Dépannage

- **La boutique ne s’ouvre pas juste après Démarrer.** Attendez quelques secondes et appuyez de nouveau sur Ouvrir : le lab ne se déclare prêt que lorsque la boutique répond.
- **Sur votre machine, le port 3000 est déjà utilisé.** Changez le numéro de gauche dans `local.yaml`, par exemple `127.0.0.1:3001:3000`, et ouvrez ce port à la place.
- **Un défi a besoin d’Internet.** Il ne peut pas être résolu ici, par conception.

## Vérification du lab

`test/check.sh` démarre le lab comme le lanceur de la plateforme démarre chaque service (toutes les capacités retirées, `no-new-privileges`, une limite de processus, des limites de mémoire et aucune sortie vers Internet), puis vérifie depuis l’intérieur de son réseau ce que cette page promet. Il nécessite Docker et s’exécute à chaque push, ce qui correspond au badge en haut de la page.

```bash
test/check.sh
```

## Versions et licences tierces

[OWASP Juice Shop](https://github.com/juice-shop/juice-shop) est sous licence MIT. L’image est `bkimminich/juice-shop:v20.3.0`.

## Licence

Cette œuvre est sous licence [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/). Vous pouvez la partager et l’adapter pour apprendre et enseigner, à condition de citer Mitsuru Technologies Ltd, de ne pas l’utiliser commercialement et de partager tout ce que vous en tirez sous la même licence. Le texte complet est dans le fichier `LICENSE`. Elle couvre le fichier compose, les tests et cette documentation. L’application qu’il contient garde la licence de son propre projet, indiquée plus haut.

## À propos

Réalisé par [Mitsuru Technologies](https://mitsurutech.co.uk) pour la [plateforme d’apprentissage MitsuruTech](https://mitsurutech.co.uk/fr/learning) : Python, Java, Go, Node, SQL et Linux dans le navigateur pour les écoles et les établissements, avec des labs de conteneurs, des applications web déployées depuis GitHub et des quiz qui se corrigent tout seuls. Essayez du code sans compte dans le [bac à sable](https://mitsurutech.co.uk/fr/playground).

D’autres labs du même éditeur : [lab-juice-shop](https://github.com/mitsurutech/lab-juice-shop), [lab-dvwa](https://github.com/mitsurutech/lab-dvwa), [lab-webgoat](https://github.com/mitsurutech/lab-webgoat), [lab-mysql-phpmyadmin](https://github.com/mitsurutech/lab-mysql-phpmyadmin), [lab-git-gitea](https://github.com/mitsurutech/lab-git-gitea) et [lab-sample](https://github.com/mitsurutech/lab-sample).
