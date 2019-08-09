#!/bin/bash
set -e
# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" $?."' EXIT

playbook="FrontEnd-Desenv"
caminhoInstalacao=$PWD

solicitarLoginDeRede(){
    dialog \
    --title 'Instalação do '$playbook \
    --sleep 1 \
    --infobox 'Solicitando credenciais da rede...' \
    5 50

    usuario=$( dialog --stdout --inputbox 'Digite seu login de rede: ' 0 50 )
    senha=$( dialog --stdout --passwordbox 'Digite a sua senha de rede: ' 0 50 )
}

instalarProgramasMinimos(){
  echo 'Digite a senha do Linux:'
  sudo apt install -y dialog 
  solicitarLoginDeRede
  sudo apt install -y git ansible python
}

criarAmbienteDoplaybook(){
    ansible-playbook main.yml -e gituser=$usuario -e gitpassword=$senha
}

limparInstalacao(){
 dialog \
  --title 'Instalação de Programas' \
  --sleep 2 \
  --infobox 'Limpando a Instalação...' \
  5 50
 sudo apt autoclean -y
 sudo apt autoremove -y 
# sudo rm -Rf $caminhoInstalacao
}

instalarProgramasMinimos
criarAmbienteDoplaybook
limparInstalacao

 dialog \
  --title 'Reinicializar' \
  --sleep 2 \
  --infobox 'É preciso reiniciar...' \
  5 50
