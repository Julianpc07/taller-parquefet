```python
from datetime import datetime
from typing import Any

def registrar_entrada(vehiculo: dict, carne: dict, ocupados: dict, carnes_c[8D[K
carnes_con_vehiculo_dentro: set, hora_entrada: datetime) -> tuple[bool, str[3D[K
str]:
    """
    Decide si un vehículo puede entrar al parqueadero y registra la entrada[7D[K
entrada.
    
    Reglas aplicadas:
    - Solo vehículos registrados a carnés vigentes.
    - Capacidad: 120 carros, 300 motos.
    - Un carné solo tiene un vehículo dentro a la vez.
    - Máximo 40 líneas.
    """
    # Validar tipos de entrada
    if not isinstance(vehiculo, dict) or not isinstance(carne, dict):
        return False, "Datos inválidos"
    
    tipo_veh = vehiculo.get("tipo")
    placa = vehiculo.get("placa")
    carne_id = vehiculo.get("carne_id")
    
    if not placa or not tipo_veh:
        return False, "Falta placa o tipo de vehículo"
    
    if tipo_veh not in ["carro", "moto"]:
        return False, f"Tipo de vehículo inválido: {tipo_veh}"
    
    # Validar carné
    if carne_id is None or not carne.get("vigente"):
        return False, "Vehículo no registrado o carné inválido"
    
    # Verificar capacidad
    tipo_capacidad = {"carro": 120, "moto": 300}
    limite = tipo_capacidad.get(tipo_veh)
    if ocupados.get(tipo_veh, 0) >= limite:
        return False, f"Parqueadero lleno para {tipo_veh}"
    
    # Verificar si el carné ya tiene vehículo dentro
    if carne_id in carnes_con_vehiculo_dentro:
        return False, "Este carné ya tiene un vehículo dentro"
    
    # Registrar entrada
    ocupados[tipo_veh] = ocupados.get(tipo_veh, 0) + 1
    carnes_con_vehiculo_dentro.add(carne_id)
    
    return True, "OK"
```

