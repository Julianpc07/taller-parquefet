@echo off
REM Reto 2 - System prompt del revisor de ParqueFET
REM Ejecutar desde la RAIZ del repositorio, en cmd:   reto2\ejecutar.bat
chcp 65001 >nul

echo Creando los modelos revisor-parquefet-v1 y revisor-parquefet-v2...
ollama create revisor-parquefet-v1 -f reto2\Modelfile.v1
ollama create revisor-parquefet-v2 -f reto2\Modelfile.v2

echo.
echo === Revision de la funcion con errores ===
echo [1/3] qwen-demo (sin system prompt)...
ollama run qwen-demo --think=false < reto2\revision_funcion.txt > reto2\salida_revision_qwen_demo.md
echo [2/3] revisor-parquefet-v1...
ollama run revisor-parquefet-v1 --think=false < reto2\revision_funcion.txt > reto2\salida_revision_v1.md
echo [3/3] revisor-parquefet-v2...
ollama run revisor-parquefet-v2 --think=false < reto2\revision_funcion.txt > reto2\salida_revision_v2.md

echo.
echo === Ataques contra v1 (antes de endurecer) ===
ollama run revisor-parquefet-v1 --think=false < reto2\ataque_a_pedir_instrucciones.txt > reto2\salida_ataque_a_v1.md
ollama run revisor-parquefet-v1 --think=false < reto2\ataque_b_salirse_de_la_tarea.txt > reto2\salida_ataque_b_v1.md
ollama run revisor-parquefet-v1 --think=false < reto2\ataque_c_orden_en_comentario.txt > reto2\salida_ataque_c_v1.md

echo === Ataques contra v2 (despues de endurecer) ===
ollama run revisor-parquefet-v2 --think=false < reto2\ataque_a_pedir_instrucciones.txt > reto2\salida_ataque_a_v2.md
ollama run revisor-parquefet-v2 --think=false < reto2\ataque_b_salirse_de_la_tarea.txt > reto2\salida_ataque_b_v2.md
ollama run revisor-parquefet-v2 --think=false < reto2\ataque_c_orden_en_comentario.txt > reto2\salida_ataque_c_v2.md

echo.
echo Listo. Las salidas quedaron en reto2\ (archivos salida_*.md).
echo Ahora complete reto2\analisis.md con lo que observe.
