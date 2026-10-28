@echo off
REM Reto 4 - Parte A: cadena de pensamiento con phi-demo
REM phi-demo no tiene modo de razonamiento: por eso NO lleva --think=false
REM Ejecutar desde la RAIZ del repositorio, en cmd:   reto4\ejecutar_parteA.bat
chcp 65001 >nul

echo [1/2] Pregunta en una linea, sin cadena de pensamiento...
ollama run phi-demo < reto4\parteA_sin_cot.txt > reto4\salida_parteA_sin_cot.md

echo [2/2] Evaluacion paso a paso con datos concretos...
ollama run phi-demo < reto4\parteA_con_cot.txt > reto4\salida_parteA_con_cot.md

echo.
echo Listo. Salidas en reto4\salida_parteA_*.md
echo La parte B se hace a mano en el chat: siga reto4\parteB_chat_largo.txt
