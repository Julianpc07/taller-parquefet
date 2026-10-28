@echo off
REM Reto 5 (bonus) - ParqueFET
REM Requisitos: uv instalado y los modelos qwen3.5:4b y qwen3.5:0.8b descargados.
REM Ejecutar desde la RAIZ del repositorio, en cmd:   bonus\ejecutar.bat
chcp 65001 >nul
set PYTHONIOENCODING=utf-8
cd bonus

echo Preparando el entorno de Python (solo tarda la primera vez)...
uv sync

echo [1/3] Parte A - notas de porteria a JSON validado...
uv run reporte_json_parquefet.py > salida_parteA_json.md

echo [2/3] Parte B - evaluacion A/B con qwen3.5:4b...
uv run evalua_parquefet.py --modelo qwen3.5:4b > salida_parteB_qwen4b.md

echo [3/3] Parte B - evaluacion A/B con qwen3.5:0.8b...
uv run evalua_parquefet.py --modelo qwen3.5:0.8b > salida_parteB_qwen08b.md

cd ..
echo.
echo Listo. Salidas en bonus\salida_*.md
echo Ahora complete bonus\analisis.md
