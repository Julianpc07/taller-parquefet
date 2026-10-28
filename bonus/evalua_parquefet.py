"""Reto 5 · Parte B · Evaluación A/B de dos versiones de un prompt para ParqueFET.

Clasifica mensajes que llegan a la oficina del parqueadero en 4 categorías y mide
cuántos acierta cada versión del prompt contra casos etiquetados a mano.
Adaptado de scripts/evalua.py del repositorio de la clase.

    cd bonus
    uv run evalua_parquefet.py
    uv run evalua_parquefet.py --modelo qwen3.5:0.8b
"""
import argparse
import re
import sys

from comun import preguntar

sys.stdout.reconfigure(encoding="utf-8")

CATEGORIAS = ["ACCESO", "CAPACIDAD", "COBRO", "PERMANENCIA"]

# 10 casos etiquetados a mano; los marcados como ambiguos mezclan dos temas
CASOS = [
    ("No me dejaron entrar porque dicen que mi carné está vencido, pero lo renové ayer.", "ACCESO", False),
    ("Llegué a las 7 y ya no había cupo para carros.", "CAPACIDAD", False),
    ("Me cobraron $6.000 por una hora y diez minutos en carro, ¿está bien?", "COBRO", False),
    ("Hay una moto que lleva desde ayer en la mañana parqueada en el sótano.", "PERMANENCIA", False),
    ("Soy profesor y en la salida me quisieron cobrar como visitante.", "COBRO", False),
    ("Quiero registrar la moto de mi hermano a mi carné para poder entrarla.", "ACCESO", False),
    ("¿Hay forma de saber cuántos cupos de moto quedan antes de llegar?", "CAPACIDAD", False),
    # Ambiguos
    ("Mi esposa entró con el carro y ahora no me dejan entrar con la moto usando el mismo carné.", "ACCESO", True),
    ("Dejé el carro toda la noche porque se varó y ahora me quieren cobrar una multa.", "PERMANENCIA", True),
    ("El parqueadero estaba lleno, esperé 20 minutos afuera y aun así me cobraron desde que llegué.", "COBRO", True),
]

V1 = """Clasifica el mensaje de un usuario del parqueadero ParqueFET en UNA categoría: ACCESO, CAPACIDAD, COBRO o PERMANENCIA.
Responde solo con la categoría.
Mensaje: "{mensaje}\""""

V2 = """Clasifica el mensaje de un usuario del parqueadero ParqueFET en UNA categoría.
- ACCESO: el problema es quién puede entrar: carné vencido, vehículo no registrado al carné o un carné que ya tiene otro vehículo dentro.
- CAPACIDAD: el problema son los cupos: parqueadero lleno o cuántos cupos quedan (120 carros, 300 motos).
- COBRO: el problema es el pago: cuánto se cobra, a quién se cobra o desde cuándo se cuenta el tiempo. Solo los visitantes pagan.
- PERMANENCIA: el problema es el tiempo dentro: vehículos que superan o se acercan a las 14 horas seguidas.
Si el mensaje toca dos temas, elige el de la queja o la pregunta principal.

Ejemplos:
"Cambié de carro y la talanquera ya no reconoce mi carné" -> ACCESO
"Me dijeron que no había cupo, pero adentro vi puestos vacíos" -> CAPACIDAD

Responde solo con ACCESO, CAPACIDAD, COBRO o PERMANENCIA.
Mensaje: "{mensaje}\""""

PATRON = re.compile("|".join(CATEGORIAS))


def clasificar(plantilla, mensaje, modelo):
    r = preguntar(plantilla.format(mensaje=mensaje), modelo=modelo, num_predict=10)
    m = PATRON.search(r.message.content.upper())
    return m.group(0) if m else r.message.content.strip()


ap = argparse.ArgumentParser()
ap.add_argument("--modelo", default="qwen3.5:4b")
a = ap.parse_args()

print(f"# Reto 5 · Parte B · Evaluación A/B con {a.modelo}\n")
print("| Versión | Mensaje | Ambiguo | Esperado | Obtenido | ¿Acertó? |")
print("| --- | --- | --- | --- | --- | --- |")

resumen = []
for nombre, plantilla in [("v1", V1), ("v2", V2)]:
    ok = 0
    for mensaje, esperado, ambiguo in CASOS:
        obtenido = clasificar(plantilla, mensaje, a.modelo)
        acierto = obtenido == esperado
        ok += acierto
        print(f"| {nombre} | {mensaje} | {'Sí' if ambiguo else 'No'} | {esperado} | {obtenido} | {'Sí' if acierto else 'No'} |")
    resumen.append(f"{nombre}: {ok}/{len(CASOS)}")

print("\n**Resultado:** " + " · ".join(resumen))
