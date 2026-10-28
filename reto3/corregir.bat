@echo off
REM Reto 3 - Repite la cadena desde el paso 2 con el prompt corregido.
REM Antes guarda la version original (v1) para mostrar el antes y el despues.
REM Ejecutar desde la RAIZ del repositorio, en cmd:   reto3\corregir.bat
chcp 65001 >nul

echo Guardando la version original como _v1...
copy /y reto3\prompt2_criterios.txt reto3\prompt2_criterios_v1.txt >nul
copy /y reto3\salida2_criterios.md reto3\salida2_criterios_v1.md >nul
copy /y reto3\prompt3_casos_prueba.txt reto3\prompt3_casos_prueba_v1.txt >nul
copy /y reto3\salida3_casos_prueba.md reto3\salida3_casos_prueba_v1.md >nul

echo Repitiendo desde el paso 2 con el prompt corregido...
call reto3\ejecutar.bat 2
