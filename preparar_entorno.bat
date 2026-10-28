@echo off
REM Descarga los modelos y crea qwen-demo y phi-demo.
REM Requisito: Ollama instalado y abierto (ver COMO_EJECUTAR.md, paso 1).
REM Ejecutar desde la RAIZ del repositorio, en cmd:   preparar_entorno.bat
chcp 65001 >nul

echo Verificando Ollama...
ollama --version
if errorlevel 1 (
  echo No se encontro Ollama. Instalelo desde https://ollama.com/download, abra una terminal nueva y repita.
  exit /b 1
)

echo.
echo Descargando modelos (entre los tres ocupan unos 7 GB, puede tardar)...
ollama pull qwen3.5:4b
ollama pull phi4-mini
ollama pull qwen3.5:0.8b

echo.
echo Creando los modelos de practica (temperatura 0, semilla 42)...
ollama create qwen-demo -f modelfiles\Modelfile.qwen-demo
ollama create phi-demo -f modelfiles\Modelfile.phi-demo

echo.
ollama list
echo.
echo Entorno listo. Siga con reto1\ejecutar.bat
