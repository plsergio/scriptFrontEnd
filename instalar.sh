#!/bin/bash
set -e
# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" $?."' EXIT

playbook="scriptFrontEnd"
caminhoInstalacao=$PWD


instalarProgramasMinimos(){
  echo 'Digite a senha do Linux:'
  sudo apt install -y dialog 
  sudo apt install -y git ansible python
}

criarAmbienteDoplaybook(){
    ansible-playbook main.yml
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
