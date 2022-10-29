import os 
import requests
import time

print("RAPPEL: ne JAMAIS se connecter sur un réseau OUVERT si celui-ci empreinte le meme nom (ou quasiment le meme) que votre réseau privé")
ssid = input("Entrez le nom de votre réseau privé: ")
print(ssid)

url = "http://www.google.com"
timeout = 5
try:
    request = requests.get(url, timeout=timeout)
    print("Vous etes connecté")
except (requests.ConnectionError, requests.Timeout) as exception:
    print("Vous n'etes pas connecté")
os.system("netsh wlan show profile > verif.txt")


doublure = ssid
count = 0
with open("verif.txt", 'r') as f:
    for line in f:
        words = line.split()
        for i in words:
            if(i==doublure):
                count=count+1
print("Réseaux similaires a", doublure, ":", count)


if count > 1:
  print("Possible rogue AP détecté, déconnexion...")
  os.system("netsh wlan disconnect")
  os.system("del verif.txt")
  print("Déconnexion du réseau douteux effectuée, vous pouvez fermer cette console")
  time.sleep(60)
else:
  print("Pas de rogue AP détecté, soyez prudent")
  os.system("del verif.txt")
  print("Rien a signaler, vous pouvez fermer cette console")
  time.sleep(60)
