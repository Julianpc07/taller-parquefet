# Reto 3 · Del requisito a los casos de prueba

Requisito: «Que los visitantes puedan pagar el parqueadero desde el celular antes de salir.»
Modelo: `qwen-demo` con `--think=false`.

## La cadena

| Paso | Técnica | Prompt | Salida |
| --- | --- | --- | --- |
| 1 | Few-shot con dos ejemplos propios de ParqueFET | `prompt1_historia_fewshot.txt` | `salida1_historia.md` |
| 2 | Formato fijo Dado / Cuando / Entonces | `prompt2_criterios.txt` | `salida2_criterios.md` |
| 3 | Tabla Markdown + auto-verificación | `prompt3_casos_prueba.txt` | `salida3_casos_prueba.md` |

Cada salida pasa completa al siguiente prompt. Eso lo hace `ejecutar.bat`, que une el inicio del prompt, la salida anterior y el cierre.

## Primera ejecución (v1)

Archivos: `prompt2_inicio_v1.txt`, `prompt2_criterios_v1.txt`, `salida2_criterios_v1.md`, `prompt3_casos_prueba_v1.txt` y `salida3_casos_prueba_v1.md`.

**Paso 1: bien.** Salió en el formato de los ejemplos y con el rol correcto: «Como visitante, quiero poder realizar el pago del parqueadero desde mi celular antes de salir, para evitar filas en la portería…». El final del beneficio quedó un poco raro, pero la historia sirve.

**Paso 2: aquí se dañó la cadena.** En vez de escribir criterios sobre pagar desde el celular, el modelo tomó las 5 reglas de `<reglas>` y convirtió cada una en un criterio. Solo el criterio 3 habla del pago. Los demás hablan de «registrar vehículos» o «inscripciones», que no tienen nada que ver con la historia. Y el criterio 5 dice que si el vehículo pasa de 14 horas el sistema bloquea el pago y la salida, o sea, el carro se quedaría encerrado.

**Paso 3: heredó el error.** La tabla tiene 12 casos, pero casi todos prueban las reglas y no el pago desde el celular. Además calculó mal un cobro: en el CP-07, un carro con 1 hora y 1 minuto debería pagar 2 horas ($6.000), y el modelo puso $3.000. La nota de auto-verificación dice que «agregó» el CP-07 y el CP-12, pero esos casos ya estaban en la tabla desde el principio: dijo que revisó, pero no se nota que lo haya hecho.

## Corrección

Corregí el **prompt 2**, porque fue el primer paso con error y todo lo que venía después dependía de él.

Cambios en `prompt2_inicio.txt`:

1. Le dije que los criterios tienen que describir el pago desde el celular y que no convierta cada regla en un criterio, porque las reglas son contexto.
2. Le dije que use solo las reglas que afectan el pago.
3. Le expliqué cómo se cobra la fracción con un ejemplo: 1 hora y 10 minutos en carro = 2 horas = $6.000.

Lo repetí con `reto3\corregir.bat`, que guarda la versión anterior como `_v1` y vuelve a correr los pasos 2 y 3.

## Resultado después de la corrección (v2)

**Paso 2: mejoró bastante.** Ahora los 4 criterios son sobre el pago desde el celular. El criterio 1 explica bien que cada fracción se cobra como hora completa, y el 2 distingue quién paga y quién no. Pero todavía tiene dos problemas:

- El criterio 3 sigue mostrando un error al pagar si se pasan las 14 horas, en vez de dejar pagar y avisar.
- El criterio 4 revisa la capacidad del parqueadero al momento de pagar, y eso no tiene sentido: el carro ya está adentro.

**Paso 3: empeoró.** La tabla solo tiene 4 casos y tiene errores graves:

- No hay **ningún caso de un visitante**, aunque la historia es justamente sobre visitantes.
- Le cobra al **personal** ($4.500 y $3.000), y según las reglas el personal no paga.
- En el CP-01 calcula 1 hora y 30 minutos como $4.500. Con la regla de la fracción serían 2 horas, o sea $6.000, y para el personal debería ser $0.
- El CP-04 dice que cubre el criterio 4 (capacidad), pero en realidad prueba un cobro.
- Otra vez, la nota dice que «agregó» el CP-03 por auto-verificación, cuando era parte de la tabla desde el principio.

## Qué aprendí

Corregir el paso 2 sí arregló el problema principal: los criterios dejaron de ser una copia de las reglas y ahora hablan de la historia. Pero el paso 3 salió peor, aunque su prompt no cambió. En una cadena, cambiar un paso cambia todo lo que viene después, y no siempre para bien.

También vi que la auto-verificación («revisa que cada criterio tenga un caso») no es confiable con un modelo de 4b: las dos veces dijo que había agregado casos que ya estaban, y no detectó que le cobraba al personal ni que faltaban los visitantes.

Si siguiera, corregiría el **prompt 3**. Le pondría las reglas de cobro dentro de `<reglas>` (en v1 y v2 no las tiene, solo ve los criterios), le pediría al menos dos casos de visitante, uno en carro y otro en moto, y le daría un ejemplo de un caso ya calculado. La ventaja de la cadena es que puedo repetir solo ese paso con `reto3\ejecutar.bat 3` sin tocar los anteriores.
