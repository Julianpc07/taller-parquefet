@echo off
REM Reto 1 - Rescatar un prompt malo (ParqueFET)
REM Ejecutar desde la RAIZ del repositorio, en cmd:   reto1\ejecutar.bat
chcp 65001 >nul

echo [1/3] Prompt malo...
ollama run qwen-demo --think=false < reto1\prompt_malo.txt > reto1\salida_1_prompt_malo.md

echo [2/3] Prompt con la formula base y delimitadores...
ollama run qwen-demo --think=false < reto1\prompt_formula.txt > reto1\salida_2_prompt_formula.md

echo [3/3] Variante sin el bloque de restricciones...
ollama run qwen-demo --think=false < reto1\prompt_variante_sin_restricciones.txt > reto1\salida_3_variante_sin_restricciones.md

echo.
echo Listo. Las salidas quedaron en la carpeta reto1\ (archivos salida_*.md).
echo Ahora complete reto1\comparacion.md con lo que observe.
