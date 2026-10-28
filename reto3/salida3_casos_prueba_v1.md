| Caso | Entrada | Resultado esperado | Criterio que cubre |
| :--- | :--- | :--- | :--- |
| CP-01 | Usuario con carné vigente, vehículo registrado correctamente. | E[1D[K
El sistema permite la entrada y registra el vehículo en el parqueadero. | 1[1D[K
1 |
| CP-02 | Usuario sin carné activo o carné expirado, intenta registrar vehí[4D[K
vehículo. | El sistema rechaza la entrada y muestra un mensaje de error ind[3D[K
indicando que el carné no es válido. | 1 |
| CP-03 | Parqueadero lleno (120 carros + 300 motos), usuario intenta regis[5D[K
registrar nuevo vehículo. | El sistema bloquea la inscripción y muestra un [K
mensaje indicando la disponibilidad restante (0). | 2 |
| CP-04 | Parqueadero con espacio disponible, usuario intenta registrar veh[3D[K
vehículo. | El sistema permite la entrada y registra el vehículo. | 2 |
| CP-05 | Visitante (carro), permanencia de 1 hora exacta. | El sistema cal[3D[K
calcula y muestra un monto a pagar de $3.000. | 3 |
| CP-06 | Visitante (moto), permanencia de 1 hora exacta. | El sistema calc[4D[K
calcula y muestra un monto a pagar de $1.500. | 3 |
| CP-07 | Visitante (carro), permanencia de 1 hora y 1 minuto (fracción). |[1D[K
| El sistema calcula y muestra un monto a pagar de $3.000 (por fracción de [K
hora). | 3 |
| CP-08 | Estudiante o personal, vehículo registrado, intenta realizar pago[4D[K
pago. | El sistema muestra un mensaje indicando que no hay costo por la per[3D[K
permanencia. | 3 |
| CP-09 | Carné activo con un vehículo ya dentro del parqueadero, usuario i[1D[K
intenta registrar otro vehículo. | El sistema rechaza la inscripción y mues[4D[K
muestra un mensaje indicando que el carné ya tiene un vehículo ocupando el [K
espacio. | 4 |
| CP-10 | Carné activo sin vehículos registrados, usuario intenta registrar[9D[K
registrar nuevo vehículo. | El sistema permite la inscripción del vehículo [K
bajo ese carné. | 4 |
| CP-11 | Vehículo con permanencia exacta de 14 horas, usuario intenta real[4D[K
realizar salida/pago. | El sistema permite la transacción y registra la sal[3D[K
salida. | 5 |
| CP-12 | Vehículo con permanencia de 14 horas y 1 minuto, usuario intenta [K
realizar salida/pago. | El sistema bloquea la transacción y muestra un mens[4D[K
mensaje indicando que el límite de 14 horas ha sido superado. | 5 |

**Nota sobre casos agregados:**
Se agregaron los casos **CP-07** (para cubrir la regla de "hora o fracción"[9D[K
fracción" en Criterio 3) y **CP-12** (para cubrir el caso límite exacto de [K
14 horas en Criterio 5), asegurando que todos los criterios tengan al menos[5D[K
menos un caso de prueba específico.

