"""Reto 5 · Parte A · Salida estructurada para ParqueFET.

Convierte las notas que el vigilante escribe en portería (texto libre) en datos
validados con un esquema de Pydantic. Adaptado de scripts/reporte_json.py del
repositorio de la clase.

    cd bonus
    uv run reporte_json_parquefet.py
"""
import sys
from typing import Literal

from pydantic import BaseModel, ValidationError

from comun import preguntar

# Evita errores con tildes y signos al guardar la salida en un archivo en Windows
sys.stdout.reconfigure(encoding="utf-8")


class NotaPorteria(BaseModel):
    placa: str
    tipo: Literal["carro", "moto"]
    evento: Literal["entrada", "salida"]
    hora: str  # formato HH:MM, 24 horas
    tipo_usuario: Literal["estudiante", "personal", "visitante", "desconocido"]


# 4 notas completas y 2 incompletas o ambiguas (las dos últimas)
NOTAS = [
    "7:42 am entra el carro ABC123 de un estudiante, carné al día.",
    "Sale la moto XYZ45F del profe de sistemas a las 18:15.",
    "Visitante en carro placa JKL987 ingresa 10:05, va a admisiones.",
    "13:30 salió la moto QWE12D, era de un visitante, pagó 2 horas.",
    # Incompleta: no dice la hora ni si es carro o moto
    "Entró DEF456, es de una funcionaria de bienestar.",
    # Ambigua: no queda claro si entra o sale, ni el tipo de usuario
    "Moto RTY78G en la talanquera como a las 3, dice que viene por un paquete.",
]

PROMPT = """Extrae los datos de esta nota escrita por el vigilante de portería del parqueadero ParqueFET.
- hora: en formato HH:MM de 24 horas.
- tipo_usuario: estudiante, personal (profesores y funcionarios), visitante, o desconocido si la nota no lo dice.

<nota>{nota}</nota>"""

print("# Reto 5 · Parte A · Notas de portería a JSON validado\n")
print("Modelo: qwen3.5:4b, temperatura 0, semilla 42.\n")
print("| # | Nota | placa | tipo | evento | hora | tipo_usuario | Válido |")
print("| --- | --- | --- | --- | --- | --- | --- | --- |")

crudos = []
for i, nota in enumerate(NOTAS, start=1):
    r = preguntar(PROMPT.format(nota=nota), formato=NotaPorteria.model_json_schema())
    crudo = r.message.content
    crudos.append(crudo)
    try:
        n = NotaPorteria.model_validate_json(crudo)  # falla si el JSON no cumple el esquema
        print(f"| {i} | {nota} | {n.placa} | {n.tipo} | {n.evento} | {n.hora} | {n.tipo_usuario} | Sí |")
    except ValidationError as e:
        errores = "; ".join(err["msg"] for err in e.errors())
        print(f"| {i} | {nota} | — | — | — | — | — | No: {errores} |")

print("\n## JSON crudo devuelto por el modelo\n")
for i, crudo in enumerate(crudos, start=1):
    print(f"{i}. `{crudo}`")
