

require 'highline/import'

puts "\e[1;3m[*] RAPPEL: ne JAMAIS se connecter sur un réseau OUVERT si celui-ci empreinte le meme nom (ou quasiment le meme) que votre réseau privé\e[0m"
puts "Entrez le nom de votre réseau wifi privé: "
$ssid = gets.chomp

puts"Lancement de l'analyse en cours..."

ping = `ping 8.8.8.8`
if ping.include?("perte 0%")
puts"Vous etes connecté a internet"
else
puts"Pas connecté a internet: tentez de vous reconnecter, si un réseau OUVERT portant le meme nom (ou quasiment le meme) que votre réseau privé apparait c'est que c'est probablement un rogue AP, ne pas se connecter dessus"
end

`netsh wlan show profile > verif.txt`

doublure = 0

File.open("verif.txt", "r:iso8859-1") do |f|
  f.each_line do |line|
    line.split(' ').each do |occurence|
      doublure += 1 if occurence == $ssid
    end
  end
end

puts "\n" + doublure.to_s

if doublure.to_s > "1"
puts "Votre réseau privé: #{$ssid} a le meme nom qu'un autre réseau auquel vous vous etes connecté, cela veut peut-etre dire que vous etes actuellement connecté sur un rogue AP !... déconnexion en cours par précaution..."
`netsh wlan disconnect`
`del verif.txt`
puts "Déconnexion éffectuée, tapez 'wifi' dans la barre de recherche windows puis dans les paramètres wifi cliquez sur 'gérer les réseaux connus' et supprimmez les doublons avant de vous reconnecter sur votre réseau privé (visible par un petit cadenas) en rentrant la clé de sécurité dans la fenetre windows.Ne JAMAIS rentrer la clé de sécurité ailleurs que quand vous cliquez sur votre réseau wifi privé pour vous connecter"
else
puts "Pas de rogue AP détecté, si jamais vous etes connecté sur un réseau ouvert faites attention a ne pas consulter des données sensibles (compte bancaire etc...)"
`del verif.txt`
end
