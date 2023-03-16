# Scripts para "limpiar" Ubuntu

En este repositorio hay dos archivos similares, los dos hacen lo mismo, la única diferencia es que uno esta escrito de forma "linear" y otro está optimizado con funciones.

## Lo que estos archivos hacen es:
- Ejecuta apt-get autoremove para borrar los paquetes que ya no son necesarios"
- Ejecuta apt-get clean para limpiar la caché de APT
- Ejecuta journalctl --vacuum-time=30d para borrar los registros del diario systemd de los últimos 30 días
- Ejecuta rm -rf home/$SUDO_USER/.cache/thumbnails/* para limpiar la caché de miniaturas
- Ejecuta un script para eliminar rervisiones antiguas de snaps

## Para ejecutar estos archivos:
- Es suficiente ejecutar uno solo (hacen exactamente lo mismo)
- Guardar en el ordenador
- Habilitar el archivo para que se ejecute: Con "click derecho" > Propiedades > Permisos > Permitir ejecutar el archivo como un programa
- Abrir una terminal en la carpeta donde está guardado el archivo
- Escribir en la terminal: sudo ./NOMBRE_DEL_ARCHIVO.sh, introducir su contraseña y LISTO!

Estos comandos los saqué de una búsqueda por internet y en especial, en la siguiente página web: 
https://itsfoss.com/es/liberar-espacio-ubuntu-linux/#6-limpiar-la-cach%C3%A9-de-miniaturas-conocimiento-intermedio

y realicé los scripts con intención de optimizar la faena de liberar espacio en mi ordenador.
