# Reto 5 (bonus) · Del texto libre a datos, y prompts medidos con casos

Adapté los dos scripts del repositorio de la clase (`scripts/reporte_json.py` y `scripts/evalua.py`) al caso ParqueFET. `comun.py` es una copia sin cambios del repositorio de la clase. Los corrí con `bonus\ejecutar.bat`, que usa uv para instalar Python y las librerías.

| Archivo | Qué es |
| --- | --- |
| `reporte_json_parquefet.py` | Parte A: notas del vigilante de portería → JSON validado con Pydantic |
| `evalua_parquefet.py` | Parte B: clasificar mensajes de usuarios en 4 categorías, prompt v1 contra v2 |
| `salida_parteA_json.md` | Salida de la parte A (qwen3.5:4b) |
| `salida_parteB_qwen4b.md` | Salida de la parte B con qwen3.5:4b |
| `salida_parteB_qwen08b.md` | Salida de la parte B con qwen3.5:0.8b |

## Parte A · Notas de portería a JSON

El esquema `NotaPorteria` tiene 5 campos: `placa`, `tipo` (carro o moto), `evento` (entrada o salida), `hora` (HH:MM) y `tipo_usuario` (estudiante, personal, visitante o desconocido). Lo probé con 6 notas: 4 completas y 2 incompletas o ambiguas.

| # | Nota | Resultado | ¿Correcto? |
| --- | --- | --- | --- |
| 1 | Carro ABC123 de un estudiante, 7:42 am | carro, entrada, 07:42, estudiante | Sí |
| 2 | Moto XYZ45F del profe de sistemas, 18:15 | moto, salida, 18:15, personal | Sí, y entendió que "profe" es personal |
| 3 | Visitante en carro JKL987, 10:05 | carro, entrada, 10:05, visitante | Sí |
| 4 | Moto QWE12D de un visitante, 13:30, pagó 2 horas | moto, salida, 13:30, visitante | Sí, pero el dato de que pagó 2 horas se perdió porque el esquema no tiene dónde guardarlo |
| 5 | DEF456 de una funcionaria, **sin hora ni tipo** | **carro**, entrada, **00:00**, personal | **No**: inventó que es un carro y puso la hora 00:00 |
| 6 | Moto RTY78G "como a las 3", viene por un paquete | moto, **entrada**, **15:00**, **visitante** | **Dudoso**: supuso que entraba, que eran las 3 de la tarde y que era visitante, aunque la nota no lo dice |

Las 6 respuestas pasaron la validación de Pydantic. Pero en las notas 5 y 6 el modelo **rellenó lo que faltaba con datos inventados** para cumplir el esquema. Como `tipo`, `evento` y `hora` son obligatorios y solo aceptan ciertos valores, el modelo no tenía cómo decir "no sé", y prefirió adivinar. Solo `tipo_usuario` tenía la opción `desconocido`, y en la nota 6 tampoco la usó.

**Conclusión:** un JSON válido no es un JSON correcto. El esquema asegura la forma de los datos, pero no que sean verdad. En un sistema real, un carro registrado a las 00:00 que en realidad entró a otra hora puede causar un cobro mal hecho o una alerta falsa de las 14 horas. Para corregirlo, haría opcionales los campos que pueden faltar (o les agregaría un valor `desconocido`) y le diría en el prompt que no invente datos.

## Parte B · Evaluación A/B de prompts

Categorías: ACCESO, CAPACIDAD, COBRO y PERMANENCIA. Hice 10 casos etiquetados a mano, de los cuales 3 son ambiguos porque mezclan dos temas.

- **v1:** solo la lista de categorías (zero-shot).
- **v2:** una definición de cada categoría con las reglas de ParqueFET, una regla para mensajes que mezclan temas y dos ejemplos distintos a los casos de prueba.

| Modelo | v1 | v2 |
| --- | --- | --- |
| qwen3.5:4b | 8 / 10 | 8 / 10 |
| qwen3.5:0.8b | 6 / 10 | **9 / 10** |

### Qué pasó

**Con qwen3.5:4b, v2 no mejoró nada.** Las dos versiones acertaron los 7 casos claros y fallaron los mismos 2 casos ambiguos. Este modelo ya entendía bien las categorías solo con el nombre, así que las definiciones no le agregaron nada.

**Con qwen3.5:0.8b, v2 mejoró mucho: de 6 a 9.** Con v1, el modelo pequeño clasificó como ACCESO cosas que no lo eran: "no había cupo para carros", "una moto lleva desde ayer parqueada" y "cuántos cupos de moto quedan". Parece que cuando no estaba seguro respondía ACCESO, la primera de la lista. Con las definiciones de v2 acertó los tres. O sea, las definiciones y los ejemplos le sirven mucho más a un modelo pequeño que a uno grande.

**El caso que falló en todos:** "Dejé el carro toda la noche porque se varó y ahora me quieren cobrar una multa." Lo etiqueté como PERMANENCIA (el carro pasó las 14 horas), pero los cuatro resultados dijeron COBRO. Revisándolo, el usuario sí está reclamando por un cobro, así que la respuesta del modelo también tiene sentido. El problema puede estar en mi etiqueta y no en el modelo: con casos ambiguos, hasta quien hace las pruebas puede dudar.

**Un caso curioso:** "El parqueadero estaba lleno, esperé afuera y me cobraron desde que llegué." El modelo de 4b dijo CAPACIDAD en las dos versiones, y el de 0.8b acertó COBRO en las dos. El modelo más grande no siempre acierta más.

### Conclusión

Con estos datos no diría que v2 es mejor en general: con el modelo de 4b empató, y con el de 0.8b sí ganó claramente. Depende del modelo que se use. También creo que 10 casos son muy pocos para decidir: un solo caso cambia el resultado en un 10 %, y uno de mis casos tenía una etiqueta discutible. Lo que sí me quedó claro es la ventaja de medir: sin esta tabla habría supuesto que el prompt largo siempre es mejor, y con el modelo de 4b no fue así.
