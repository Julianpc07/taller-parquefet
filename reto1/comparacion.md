# Reto 1 · Rescatar un prompt malo

Usé `qwen-demo` (qwen3.5:4b, temperatura 0, semilla 42) con `--think=false`.

- `prompt_malo.txt`: el prompt original del caso, una sola línea.
- `prompt_formula.txt`: el mismo pedido con los cinco bloques y las reglas dentro de `<reglas>`.
- `prompt_variante_sin_restricciones.txt`: igual al anterior pero sin el bloque de restricciones.

## Lo que el modelo tuvo que adivinar con el prompt malo

| Decisión que el prompt no dice | Qué hizo el modelo |
| --- | --- |
| Lenguaje | Usó JavaScript, porque dijo que es "el estándar para el navegador" |
| Nombre y parámetros | Hizo una clase con `registrarEntrada(vehiculo, placa)`, donde vehiculo es el modelo del carro |
| Qué devuelve | Solo true o false, sin decir por qué |
| Dónde guarda | En una lista y en el localStorage del navegador |
| Qué reglas valida | Solo que no venga vacío. Ninguna regla del parqueadero |
| Carros y motos | No los diferencia ni controla cupos |
| Cobro | No cobra nada |
| Cosas de más | Un ID con la fecha, un estado "En servicio" y funciones que nadie pidió |

Además la respuesta quedó cortada a la mitad, porque se gastó los tokens explicando y armando cosas extra.

## Comparación de las tres versiones

| Regla | Prompt malo | Fórmula base | Sin restricciones |
| --- | --- | --- | --- |
| Carné vigente | No | Más o menos (no compara que el carné sea el mismo del vehículo) | Más o menos (igual) |
| Capacidad de carros y motos | No | No funciona (ver abajo) | Sí, con `>=` |
| Un vehículo por carné | No | Sí | Sí |
| No cobrar ni revisar 14 h en la entrada | Sí, porque no sabía | Sí | No, empezó a validar las 14 horas |
| Rechazar tipos raros | No | Sí | No, todo lo que no es carro lo cuenta como moto |
| Devuelve (bool, motivo) | No | Sí | Sí |
| Solo código con type hints y docstring | No | Sí | Sí |
| Código completo | No (cortado) | Sí | No (cortado) |

Con la fórmula base cambió casi todo: pasó a Python, usó los parámetros que le pedí, devolvió la tupla y aplicó casi todas las reglas.

Pero tiene un error que no se ve a simple vista. Busca los cupos con `ocupados.get("carro")`, y en el diccionario la clave es `"carros"`, con s. Entonces siempre da 0 y **el parqueadero nunca se llena**. El código parece bien, pero no cumple la capacidad. Además:

- Trató vehículo y carné como diccionarios, y en el prompt dije que eran objetos.
- No revisa que el carné del vehículo sea el mismo carné que llega.
- Recibe la hora de entrada pero no la guarda.
- Puso "Máximo 40 líneas" en el docstring como si fuera una regla.

## La variante sin restricciones

Solo le quité el bloque de restricciones, y cambiaron varias cosas:

- El código se alargó tanto que quedó sin terminar.
- Empezó a validar las 14 horas en la entrada, cuando eso va a la salida.
- Dejó de rechazar tipos raros: una bicicleta entraría como moto.
- Lo curioso es que acá sí escribió bien `"carros"` y `"motos"`. Cambiar una parte del prompt cambió también cosas que no tenían nada que ver.

## Conclusión

Cada bloque de la fórmula le quita al modelo algo que antes tenía que adivinar. El contexto con las reglas fue lo que más cambió el resultado, porque sin eso el modelo no sabía nada del parqueadero. Las restricciones lo mantuvieron corto y enfocado solo en la entrada. Aun así, un buen prompt no asegura un código correcto: el error de `"carro"` contra `"carros"` solo lo encontré leyendo el código con calma.
