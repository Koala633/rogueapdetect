# rogueapdetect

Détecte la présence d'un rogue AP.Les rogues AP sont de faux hotspot wifi servant a subtiliser les données des utilisateurs se conenctant dessus.Il y a une version pour windows avec le fichier .exe et une autre version pour linux en bash.Les 2 version fonctionnent de la meme façon, on vérifis basiquement si le réseau sur lequel vous etes connecté ne comporte pas de doublure dans vos paramètres car les rogues AP ont en général le meme nom que votré réseau privé.

- Pour windows: téléchargez juste l'exécutable et lancez le (votre antivirus va d'abord l'analyser c'est normal).
- Pour linux: téléchargez le fichier rogueapdetect.sh et lancez le tel que: bash rogueapdetect.sh (le script fonctionne avec network-manager)
- Pour windows: une version en ruby existe également si jamais vous avez ruby d'installé sur votre machine.
- Par soucis de transparence le code source du fichier exécutable est disponible dans le script: rogueapdetect.py
