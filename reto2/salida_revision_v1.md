1. Veredicto: CAMBIOS REQUERIDOS
2. Hallazgos:
   - Línea 3: Falta verificar la capacidad de motos (300), ignorando el cas[3D[K
caso `vehiculo.tipo == "moto"`.
   - Línea 5: No se valida si un carné ya tiene vehículo ocupado, permitien[9D[K
permitiendo múltiples vehículos por carnet.
   - Línea 5: No se verifica el límite máximo de permanencia de 14 horas pa[2D[K
para evitar estacionamientos prolongados.
   - Seguridad: Falta validación explícita del tipo de carnet (estudiante/p[13D[K
(estudiante/personal vs visitante) antes de permitir ingreso, aunque la reg[3D[K
regla principal es el carné vigente.

Corrección sugerida: Agregar verificación de capacidad total por tipo y lóg[3D[K
lógica para evitar múltiples vehículos en un mismo carné.

