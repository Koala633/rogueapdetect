#!/bin/bash

f_verif(){
grep 'psk=' /etc/NetworkManager/system-connections/* > verif.txt
essid=`cat essid.txt`
if grep -q ${essid} "verif.txt";  then  # verif de la présence de le ssid de la box privé dans le fichier psk de network-manager
echo -e "\e[1;31m Ce réseau: ${essid} porte le meme nom que votre réseau privé il s'agit surement d'un rogue AP, déconnectez-vous immédiatement....\e[0m"
echo -e "Exit..."
rm -rf *.txt
else 
echo -e "\e[1;33m Bye...\e[0m"   # si le ssid de la box privé n'est pas présent dans le fichier psk de netwotk-manager c'est qu'il s'agit surement d'un simple hotspot
rm -rf *.txt
fi
}

iwconfig | tee interfaces.txt
    if [ "$(wc -w < interfaces.txt)" == 0 ]; 
      then
        echo -e "Erreur aucune interface wifi detectée, branchez votre carte wifi"
        rm -rf *.txt
        exit 1   
    else [ "$(grep -c IEEE interfaces.txt)" == 1 ];
interface=$(head -n 1 interfaces.txt | awk '{ print $1 }')  
        echo -e "Interface sélectionée: ${interface}"
    fi

echo -e "\e[1;34m[*]\e[0m En recherche d'un potentiel rogue AP... WAIT"
iwconfig ${interface} | grep ESSID | awk -F: '{print $2}' > ssid.txt # prise du ssid ou l'on est connecté
ssid=`cat ssid.txt` # on le transforme en variable
sed 's/\"//g' ssid.txt  > essid.txt  # on vire les guillemets et on redirige le ssid "nu" dans le fichier essid.txt
essid=`cat essid.txt`
nmcli device wifi show-password > open.txt
if grep -q "Aucun" "open.txt";  then # on vérifis si le réseau est ouvert ou pas
echo -e "\e[1;33m Connexion sur un réseau OUVERT avec comme nom: ${essid} soyez vigilant...\e[0m"
f_verif  # si le réseau est ouvert on lancer la fonction f_verif qui va détecter si le réseau n'a pas le meme nom que le réseau privé
elif ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then  # sinon on test la connexion
  echo -e "\e[1;32m Vous etes connecter a: ${essid}, la connexion semble normal vous pouvez continuer votre navigation.\e[0m"
rm -rf *.txt
else
echo -e "\e[1;31m Pas de connexion trouvée... tentez de vous reconnecter a votre réseau visible avec un cadenas a coté de l'icone.\e[0m" # aucune connexion de trouvée on sort du script
rm -rf *.txt
fi

