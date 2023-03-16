#!/bin/bash
echo " "
# Ejecuta el comando "sudo apt-get autoremove"
echo "EJECUTANDO => apt-get autoremove para borrar los paquetes que ya no son necesarios"
echo " "
sudo apt-get autoremove
echo " "
echo "sudo apt-get autoremove ejecutado correctamente"
echo " "
echo "-------------------------------------------------------------"
echo " "

# Ejecuta el comando "sudo apt-get clean"
echo "EJECUTANDO => apt-get clean para limpiar la caché de APT"
echo " "
echo "Espacio ocupado por la caché de APT ANTES de la ejecución del comando:"
sudo du -sh /var/cache/apt 
sudo apt-get clean
echo " "
echo "sudo apt-get clean ejecutado correctamente"
echo " "
echo "Espacio ocupado por la caché de APT DESPUÉS de la ejecución del comando"
sudo du -sh /var/cache/apt
echo " "
echo "-------------------------------------------------------------------------"
echo " "

# Ejecuta el comando "sudo journalctl --vacuum-time=30d"
echo "EJECUTANDO => journalctl --vacuum-time=30d para borrar los registros del diario systemd de los últimos 30 días"
echo " "
echo "Espacio ocupado por estos registros ANTES de la ejecución del comando:"
sudo journalctl --disk-usage
echo " "
sudo journalctl --vacuum-time=30d
echo " "
echo "sudo journalctl --vacuum-time=30d ejecutado correctamente"
echo " "
echo "Espacio ocupado por estos registros DESPUÉS de la ejecución del comando"
sudo journalctl --disk-usage
echo " "
echo "-------------------------------------------------------------------------"
echo " "

# Ejecuta el comando "rm -rf $HOME/.cache/thumbnails/*"
echo "EJECUTANDO => rm -rf home/$SUDO_USER/.cache/thumbnails/* para limpiar la caché de miniaturas"
echo " "
echo "Espacio ocupado por la caché de miniaturas ANTES de la ejecución del comando:"
du -sh /home/$SUDO_USER/.cache/thumbnails
rm -rf /home/$SUDO_USER/.cache/thumbnails/*
echo " "
echo "rm -rf /home/$SUDO_USER/.cache/thumbnails/* ejecutado correctamente"
echo " "
echo "Espacio ocupado por la caché de miniaturas DESPUÉS de la ejecución del comando:"
du -sh /home/$SUDO_USER/.cache/thumbnails
echo " "
echo "-------------------------------------------------------------------------"
echo " "

# Ejecuta el script que elimina revisiones antiguas de snaps

echo "EJECUTANDO => comandos para la eliminación de revisiones antiguas de snaps"
echo " "
echo "Espacio ocupado por snaps ANTES de la ejecución del comandos:"
du -h /var/lib/snapd/snaps
echo " "
set -u
echo ">>>>>>>Iniciando la eliminación de revisiones antiguas de snaps"
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
echo " "
echo "Espacio ocupado por snaps DESPUÉS de la ejecución de los comandos:"
du -h /var/lib/snapd/snaps
echo " "
echo "-------------FIN DEL SCRIPT--------------------------------------------------"
echo " "
echo "escribir "clear" para despejar la terminal"
