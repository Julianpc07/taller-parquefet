| Caso | Entrada | Resultado esperado | Criterio que cubre |
| :--- | :--- | :--- | :--- |
| CP-01 | Usuario: Personal, Vehículo: Carro, Entrada: 08:00, Salida: 09:30[5D[K
09:30, Pago: $4.500 | Se cobra $4.500 (2 horas completas) por tarifa person[6D[K
personal. | Criterio 1 |
| CP-02 | Usuario: Estudiante, Vehículo: Moto, Entrada: 10:00, Salida: 11:1[4D[K
11:15, Pago: $0 | Se cobra $0 (tarifa gratuita para estudiantes). | Criteri[7D[K
Criterio 2 |
| **CP-03** | Usuario: Personal, Vehículo: Carro, Entrada: 08:00, Salida: 2[1D[K
22:30, Pago: Error | Se muestra mensaje de error: "El vehículo no puede per[3D[K
permanecer más de 14 horas". | Criterio 3 |
| CP-04 | Usuario: Personal, Vehículo: Carro, Entrada: 08:00, Salida: 09:00[5D[K
09:00, Pago: $3.000 | Se cobra $3.000 (1 hora) por tarifa personal. | Crite[5D[K
Criterio 4 |

**Nota sobre casos agregados:**
Se agregó el **Caso CP-03** para cubrir explícitamente el **Criterio 3** (l[2D[K
(límite de permanencia), ya que en la tabla original solo se tenía un caso [K
para los criterios 1, 2 y 4. Este caso valida el comportamiento del sistema[7D[K
sistema cuando el tiempo supera las 14 horas.

