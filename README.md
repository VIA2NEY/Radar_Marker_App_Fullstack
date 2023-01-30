# Radar_Marker_App_Fullstack
## Introduction
Cette application est une application mobile développée à l'aide de Flutter et de Django. Le back-end est géré par Django et la partie mobile est développée en utilisant Flutter. Cette application permet à l'utilisateur de voir les radars qu'il y a dans la ville et d'en ajoutée s'il en voit d'autre.

## Prérequis
Avant de commencer à utiliser cette application, veuillez vous assurer que vous avez installé les outils suivants sur votre ordinateur :

* Flutter SDK
* Django 

## Installation
Clonez le répertoire de l'application depuis votre terminal en utilisant la commande suivante :
```bash
  git clone https://github.com/VIA2NEY/Radar_Marker_App_Fullstack.git
```


Accédez au répertoire du back-end en utilisant la commande suivante :

```bash
  cd RADAR MARKEUR\backend\radar_marker_app>
```



Exécutez le serveur Django en utilisant la commande suivante :

<code>python manage.py runserver</code>.


Accédez au répertoire de la partie mobile en utilisant la commande suivante :

```bash
  cd RADAR MARKEUR\mobile_radar_marqueur>
```

Installez les dépendances de l'application mobile Flutter :

<code>flutter pub get</code>.

## Utilisation
Ouvrez l'application sur un émulateur mobile ou sur votre téléphone .
- Nous vous recommandons d'utiliser un émulateur pour effectuer les tests. Si vous n'avez pas d'émulateur, aller sur cette page pour de suivre ce [tutoriel](https://developer.android.com/studio/run/emulator?hl=fr)
- Si vous voulez vous connecter depuis votre téléphone,d'abord assurer vous que vous êtes sur le meme reseau que votre ordinateur.Ensuite, activer le mode développeur de votre téléphone puis brancher votre téléphone à votre ordinateur et enfin déboguer l'application. Aussi, nous vous recommandons de suivre ce [tutoriel](https://stackoverflow.com/questions/55908089/why-is-flutter-refusing-to-connect-on-localhost8000-or-127-0-018000) afin d'apporter quelque modification au code pour pouvoir faire les test sur votre téléphone
Connectez-vous en utilisant vos informations d'identification.
Puis ajouter ou consulté les marqueurs qui sont sur votre chemin.
## Conclusion
Cette application est une application simple qui permet à l'utilisateur de se connecter de consulter et d'ajouter des informations sur les radar routier. Le back-end est géré par Django et la partie mobile est développée en utilisant Flutter. J'espère que vous apprécierez cette application et que vous la trouverez utile.
