# Reto 4 · Razonar y manejar el contexto

## Parte A · Cadena de pensamiento

Usé `phi-demo` (phi4-mini, temperatura 0, semilla 42). No lleva `--think=false` porque este modelo no razona solo: solo lo hace si se le pide por escrito.

Las dos versiones tienen el mismo código y las mismas reglas. La única diferencia es que la segunda le pide evaluar cada `if` paso a paso con datos concretos (carné vigente, carro, 120 carros y 300 motos ocupados) antes de concluir.

| Versión | Prompt | Salida |
| --- | --- | --- |
| Sin cadena de pensamiento | `parteA_sin_cot.txt` | `salida_parteA_sin_cot.md` |
| Con cadena de pensamiento | `parteA_con_cot.txt` | `salida_parteA_con_cot.md` |

### Errores de la función y cuáles encontró

| # | Error | Sin CoT | Con CoT |
| --- | --- | --- | --- |
| 1 | `> 120` debería ser `>= 120`: con 120 carros, `120 > 120` es False y el carro entra | No | No |
| 2 | No revisa la capacidad de motos | Sí | No (dijo que sí la revisaba) |
| 3 | No revisa si el carné ya tiene un vehículo adentro | Sí | Sí |
| 4 | No revisa que el vehículo esté registrado al carné | No | Sí |
| **Total** | | **2 de 4** | **2 de 4** |

### Qué pasó

Esperaba que la versión paso a paso encontrara el error del `> 120`, pero no lo hizo. Al revisar cómo razonó, encontré que **se equivocó haciendo los pasos**:

- Con el carné vigente, `not vehiculo.carne_vigente` da False y la función sigue. El modelo escribió bien que daba False, pero puso que la función "retorna False" en ese punto.
- Con 120 carros, `120 > 120` es **False**. El modelo dijo que era **True** y que la función rechazaba el carro. Justo en el paso que tenía que descubrir el error, lo calculó mal.
- En la evaluación de la moto se inventó una condición `ocupados["motos"] > 300` que no existe en el código, y por eso concluyó que la capacidad de motos sí se revisaba.

Las correcciones de código tampoco sirven. Las dos versiones agregaron `> 300` para las motos, o sea, el mismo error de borde. Y para la regla del carné inventaron condiciones que no tienen sentido: `ocupados["carros"] > 1 or ocupados["motos"] > 1` (con CoT) y `ocupados["carros"] > 0 and ocupados["motos"] > 0` (sin CoT), que bloquearían a todo el mundo apenas haya un carro y una moto adentro.

**Conclusión:** pedirle que razone paso a paso no lo hizo más preciso. Un modelo pequeño como phi4-mini puede escribir los pasos y aun así hacer mal una comparación tan simple como `120 > 120`. Lo bueno de la cadena de pensamiento es que el error **quedó a la vista**: sin los pasos, no habría sabido por qué no encontraba el problema. Con los pasos se ve exactamente dónde se equivocó, y una persona lo puede revisar. Pero no se puede confiar en que el razonamiento escrito sea correcto solo porque está ordenado.

## Parte B · La instrucción que se olvida

Lo hice a mano en el chat de `qwen-demo` (con `--think=false`), siguiendo `parteB_chat_largo.txt`. En las dos versiones bajé la memoria del modelo con `/set parameter num_ctx 512` y usé una regla propia del caso: empezar siempre con «Veredicto ParqueFET:».

- **Versión A:** la regla se la dije como un mensaje más del chat. Salida: `salida_parteB_versionA.md`.
- **Versión B:** hice `/clear` y puse la misma regla con `/set system`. Salida: `salida_parteB_versionB.md`.

En las dos le hice las mismas dos preguntas largas: cómo debería funcionar el control de entrada y salida del parqueadero de una universidad, y cómo se cobra por hora o fracción a los visitantes.

| Versión | Dónde está la regla | Respuesta 1 empieza con la regla | Respuesta 2 empieza con la regla |
| --- | --- | --- | --- |
| A | Mensaje del chat | Sí | **No**: empezó con «El cálculo del cobro…» |
| B | System prompt | Sí | Sí |

### Qué pasó

En la versión A, cuando le escribí la regla me respondió «Veredicto ParqueFET: Entendido…» y la primera respuesta larga también empezó así. Pero en la segunda ya no la cumplió.

La razón es la memoria del chat. En cada turno, Ollama le vuelve a mandar al modelo toda la conversación, pero con `num_ctx 512` solo le caben unos 512 tokens. Cada respuesta salió de unas 500 palabras, que son más de 512 tokens, o sea que ni una sola respuesta completa cabe con la pregunta siguiente. Cuando la conversación ya no cabe, Ollama borra los mensajes más viejos. En la segunda pregunta ya había borrado el mensaje con la regla y también la primera respuesta, así que el modelo solo vio la pregunta y no tenía cómo saber que existía la regla. Y como la primera respuesta también se borró, tampoco pudo copiar el «Veredicto ParqueFET:» del inicio.

En la versión B la regla está en el system prompt, y Ollama nunca lo borra al recortar la conversación: siempre se queda junto al último mensaje. Por eso el modelo vio la regla en las dos preguntas y la cumplió las dos veces.

### Para un agente que trabaja durante horas

Las reglas que siempre se tienen que cumplir deben ir en el system prompt, no en un mensaje de la conversación, porque los mensajes se pueden perder cuando el historial crece. Además, para que no se pierda información importante en conversaciones largas se puede resumir el historial cada cierto tiempo, guardar las notas importantes en un archivo que el agente vuelva a leer, o repartir el trabajo en sub-agentes que empiecen con el contexto limpio.
