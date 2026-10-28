```python
from datetime import datetime
from typing import Dict, Set, Tuple, Optional, Any

def registrar_entrada(
    vehiculo: Dict[str, Any],
    carne: Dict[str, Any],
    ocupados: Dict[str, int],
    carnes_con_vehiculo_dentro: Set[str],
    hora_entrada: datetime
) -> Tuple[bool, str]:
    """
    Decide si un vehículo puede entrar al parqueadero y registra la entrada[7D[K
entrada si es posible.

    Reglas de negocio aplicadas:
    1. Solo vehículos registrados a un carné vigente pueden entrar.
    2. Capacidad máxima: 120 carros y 300 motos.
    3. Estudiantes y personal no pagan; visitantes pagan por hora/fracción.[14D[K
hora/fracción.
    4. Un carné solo puede tener un vehículo dentro a la vez.[4D[K
vez.
    5. Ningún vehículo puede permanecer más de 14 horas seguidas.

    Args:
        vehiculo (dict): Objeto con 'placa' (str), 'tipo' ('carro' o 'moto'[6D[K
'moto') y 'carne_id' (str o None).
        carne (dict): Objeto con 'id' (str), 'vigente' (bool) y 'tipo_usuar[11D[K
'tipo_usuario' (str).
        ocupados (dict): Diccionario con cupos actuales: {'carros': int, 'm[2D[K
'motos': int}.
        carnes_con_vehiculo_dentro (set): Conjunto de IDs de carnés que ya [K
tienen vehículo dentro.
        hora_entrada (datetime): Hora actual de llegada.

    Returns:
        tuple: (bool, str) -> (True, "OK") si entra; (False, motivo_español[14D[K
motivo_español) si se rechaza.
               Si entra, actualiza 'ocupados' y añade el carne_id a 'carnes[7D[K
'carnes_con_vehiculo_dentro'.
    """
    
    # Validación 1: Carné debe existir y ser vigente
    if vehiculo.get("carne_id") is None or not carne.get("vigente", False):[7D[K
False):
        return (False, "El vehículo no está registrado a un carné vi[2D[K
vigente.")

    placa = vehiculo["placa"]
    tipo_vehiculo = vehiculo["tipo"]  # 'carro' o 'moto'
    carne_id = vehiculo["carne_id"]
    
    # Validación 2: Un carné ya tiene vehículo dentro
    if carne_id in carnes_con_vehiculo_dentro:
        return (False, f"El carné {carne_id} ya tiene un vehículo dentro.")[9D[K
dentro.")

    # Validación 3: Capacidad del parqueadero
    tipo_capacidad = "carros" if tipo_vehiculo == "carro" else "motos"
    capacidad_maxima = {"carros": 120, "motos": 300}
    
    if ocupados.get(tipo_capacidad, 0) >= capacidad_maxima[tipo_capacidad]:[33D[K
capacidad_maxima[tipo_capacidad]:
        return (False, f"El parqueadero es[2D[K
está lleno. No quedan cupos para {tipo_vehiculo}.")

    # Validación 4: Duración máxima de estacionamiento (14 horas)
    # A

