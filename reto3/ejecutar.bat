@echo off
REM Reto 3 - Del requisito a los casos de prueba (ParqueFET)
REM Ejecutar desde la RAIZ del repositorio, en cmd:
REM    reto3\ejecutar.bat       corre la cadena completa (pasos 1, 2 y 3)
REM    reto3\ejecutar.bat 2     repite desde el paso 2 (usa la salida 1 que ya existe)
REM    reto3\ejecutar.bat 3     repite solo el paso 3
chcp 65001 >nul

set DESDE=%1
if "%DESDE%"=="" set DESDE=1

if %DESDE% GTR 1 goto paso2
echo [1/3] Prompt 1 - few-shot: requisito a historia de usuario...
ollama run qwen-demo --think=false < reto3\prompt1_historia_fewshot.txt > reto3\salida1_historia.md

:paso2
if %DESDE% GTR 2 goto paso3
echo [2/3] Prompt 2 - formato fijo: historia a criterios Dado/Cuando/Entonces...
copy /b reto3\prompt2_inicio.txt + reto3\salida1_historia.md + reto3\prompt2_fin.txt reto3\prompt2_criterios.txt >nul
ollama run qwen-demo --think=false < reto3\prompt2_criterios.txt > reto3\salida2_criterios.md

:paso3
echo [3/3] Prompt 3 - tabla de casos de prueba con auto-verificacion...
copy /b reto3\prompt3_inicio.txt + reto3\salida2_criterios.md + reto3\prompt3_fin.txt reto3\prompt3_casos_prueba.txt >nul
ollama run qwen-demo --think=false < reto3\prompt3_casos_prueba.txt > reto3\salida3_casos_prueba.md

echo.
echo Listo. Prompts armados: prompt2_criterios.txt y prompt3_casos_prueba.txt
echo Salidas: salida1_historia.md, salida2_criterios.md, salida3_casos_prueba.md
echo Ahora revise la cadena y complete reto3\nota_correccion.md
