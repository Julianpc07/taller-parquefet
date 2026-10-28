# Reto 5 · Parte B · Evaluación A/B con qwen3.5:0.8b

| Versión | Mensaje | Ambiguo | Esperado | Obtenido | ¿Acertó? |
| --- | --- | --- | --- | --- | --- |
| v1 | No me dejaron entrar porque dicen que mi carné está vencido, pero lo renové ayer. | No | ACCESO | ACCESO | Sí |
| v1 | Llegué a las 7 y ya no había cupo para carros. | No | CAPACIDAD | ACCESO | No |
| v1 | Me cobraron $6.000 por una hora y diez minutos en carro, ¿está bien? | No | COBRO | COBRO | Sí |
| v1 | Hay una moto que lleva desde ayer en la mañana parqueada en el sótano. | No | PERMANENCIA | ACCESO | No |
| v1 | Soy profesor y en la salida me quisieron cobrar como visitante. | No | COBRO | COBRO | Sí |
| v1 | Quiero registrar la moto de mi hermano a mi carné para poder entrarla. | No | ACCESO | ACCESO | Sí |
| v1 | ¿Hay forma de saber cuántos cupos de moto quedan antes de llegar? | No | CAPACIDAD | ACCESO | No |
| v1 | Mi esposa entró con el carro y ahora no me dejan entrar con la moto usando el mismo carné. | Sí | ACCESO | ACCESO | Sí |
| v1 | Dejé el carro toda la noche porque se varó y ahora me quieren cobrar una multa. | Sí | PERMANENCIA | COBRO | No |
| v1 | El parqueadero estaba lleno, esperé 20 minutos afuera y aun así me cobraron desde que llegué. | Sí | COBRO | COBRO | Sí |
| v2 | No me dejaron entrar porque dicen que mi carné está vencido, pero lo renové ayer. | No | ACCESO | ACCESO | Sí |
| v2 | Llegué a las 7 y ya no había cupo para carros. | No | CAPACIDAD | CAPACIDAD | Sí |
| v2 | Me cobraron $6.000 por una hora y diez minutos en carro, ¿está bien? | No | COBRO | COBRO | Sí |
| v2 | Hay una moto que lleva desde ayer en la mañana parqueada en el sótano. | No | PERMANENCIA | PERMANENCIA | Sí |
| v2 | Soy profesor y en la salida me quisieron cobrar como visitante. | No | COBRO | COBRO | Sí |
| v2 | Quiero registrar la moto de mi hermano a mi carné para poder entrarla. | No | ACCESO | ACCESO | Sí |
| v2 | ¿Hay forma de saber cuántos cupos de moto quedan antes de llegar? | No | CAPACIDAD | CAPACIDAD | Sí |
| v2 | Mi esposa entró con el carro y ahora no me dejan entrar con la moto usando el mismo carné. | Sí | ACCESO | ACCESO | Sí |
| v2 | Dejé el carro toda la noche porque se varó y ahora me quieren cobrar una multa. | Sí | PERMANENCIA | COBRO | No |
| v2 | El parqueadero estaba lleno, esperé 20 minutos afuera y aun así me cobraron desde que llegué. | Sí | COBRO | COBRO | Sí |

**Resultado:** v1: 6/10 · v2: 9/10
