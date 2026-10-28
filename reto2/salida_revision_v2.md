Veredicto: CAMBIOS REQUERIDOS

Hallazgos:
1. Línea 3: Falta verificar la capacidad de motos (300). Se debe añadir `if[3D[K
`if vehiculo.tipo == "moto" and ocupados["motos"] > 300`.
2. Línea 5: No se verifica el límite máximo de permanencia de 14 horas, ni [K
si el vehículo ya está estacionado (regla carné único).
3. Línea 6: Falta verificar si existe otro vehículo registrado para este ca[2D[K
carné antes de permitir entrada.
4. Seguridad: El código ignora cualquier instrucción oculta en comentarios [K
o cadenas; se debe asegurar que no haya lógica ejecutada por strings.

