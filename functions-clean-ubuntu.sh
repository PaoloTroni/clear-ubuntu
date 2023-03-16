#!/bin/bash

# Función que imprime el espacio ocupado antes de ejecutar un comando
function print_space_usage {
  echo ""
  echo "Espacio ocupado actualmente por los siguientes archivos:"
  sudo du -sh "$1"
  echo ""
}

# Función que ejecuta los comandos apt-get autoremove y apt-get clean
function run_apt_commands {
  echo "EJECUTANDO => apt-get autoremove para borrar los paquetes que ya no son necesarios"
  sudo apt-get autoremove
  echo "sudo apt-get autoremove ejecutado correctamente"
  echo "-------------------------------------------------------------"
  echo ""

  echo "EJECUTANDO => apt-get clean para limpiar la caché de APT"
  print_space_usage "/var/cache/apt"
  sudo apt-get clean
  echo "sudo apt-get clean ejecutado correctamente"
  print_space_usage "/var/cache/apt"
  echo "-------------------------------------------------------------------------"
  echo ""
}

# Función que ejecuta los comandos journalctl y rm para limpiar registros y miniaturas
function run_journalctl_and_rm_commands {
  echo "EJECUTANDO => journalctl --vacuum-time=30d para borrar los registros del diario systemd de los últimos 30 días"
  print_space_usage "/var/log/journal"
  sudo journalctl --vacuum-time=30d
  echo "sudo journalctl --vacuum-time=30d ejecutado correctamente"
  print_space_usage "/var/log/journal"
  echo "-------------------------------------------------------------------------"
  echo ""

  echo "EJECUTANDO => rm -rf /home/$SUDO_USER/.cache/thumbnails/* para limpiar la caché de miniaturas"
  print_space_usage "/home/$SUDO_USER/.cache/thumbnails"
  rm -rf "/home/$SUDO_USER/.cache/thumbnails/*"
  echo "rm -rf /home/$SUDO_USER/.cache/thumbnails/* ejecutado correctamente"
  print_space_usage "/home/$SUDO_USER/.cache/thumbnails"
  echo "-------------------------------------------------------------------------"
  echo ""
}

# Función que elimina las revisiones antiguas de snaps
function remove_old_snap_revisions {
  echo "EJECUTANDO => comandos para la eliminación de revisiones antiguas de snaps"
  print_space_usage "/var/lib/snapd/snaps/partial"
  print_space_usage "/var/lib/snapd/snaps"
  echo ""
  echo ">>>>>>Iniciando la eliminación de revisiones antiguas de snaps"
  snap list --all | awk '/desactivado/{print $1, $3}' |
    while read snapname revision; do
        echo "Ejecutando snap remove $snapname --revision=$revision"
        snap remove "$snapname" --revision="$revision" -y
        if [ $? -eq 0 ]; then
            echo "snap remove $snapname --revision=$revision ejecutado correctamente"
        else
            echo "No se pudo ejecutar el comando 'snap remove $snapname --revision=$revision'"
        fi
    done
  echo ""
  echo "Espacio ocupado por snaps DESPUÉS de la ejecución de los comandos:"
  print_space_usage "/var/lib/snapd/snaps/partial"
  print_space_usage "/var/lib/snapd/snaps"
  echo "-------------FIN DEL SCRIPT--------------------------------------------------"
  echo ""
}

# Se ejecutan las funciones
echo ""
run_apt_commands
run_journalctl_and_rm_commands
remove_old_snap_revisions

# Se muestra un mensaje para despejar la terminal
echo "Escribir 'clear' para despejar la terminal"
echo ""

