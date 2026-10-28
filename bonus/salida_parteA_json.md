# Reto 5 · Parte A · Notas de portería a JSON validado

Modelo: qwen3.5:4b, temperatura 0, semilla 42.

| # | Nota | placa | tipo | evento | hora | tipo_usuario | Válido |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 7:42 am entra el carro ABC123 de un estudiante, carné al día. | ABC123 | carro | entrada | 07:42 | estudiante | Sí |
| 2 | Sale la moto XYZ45F del profe de sistemas a las 18:15. | XYZ45F | moto | salida | 18:15 | personal | Sí |
| 3 | Visitante en carro placa JKL987 ingresa 10:05, va a admisiones. | JKL987 | carro | entrada | 10:05 | visitante | Sí |
| 4 | 13:30 salió la moto QWE12D, era de un visitante, pagó 2 horas. | QWE12D | moto | salida | 13:30 | visitante | Sí |
| 5 | Entró DEF456, es de una funcionaria de bienestar. | DEF456 | carro | entrada | 00:00 | personal | Sí |
| 6 | Moto RTY78G en la talanquera como a las 3, dice que viene por un paquete. | RTY78G | moto | entrada | 15:00 | visitante | Sí |

## JSON crudo devuelto por el modelo

1. `{
  "placa": "ABC123",
  "tipo": "carro",
  "evento": "entrada",
  "hora": "07:42",
  "tipo_usuario": "estudiante"
}`
2. `{
  "placa": "XYZ45F",
  "tipo": "moto",
  "evento": "salida",
  "hora": "18:15",
  "tipo_usuario": "personal"
}`
3. `{
  "placa": "JKL987",
  "tipo": "carro",
  "evento": "entrada",
  "hora": "10:05",
  "tipo_usuario": "visitante"
}`
4. `{
  "placa": "QWE12D",
  "tipo": "moto",
  "evento": "salida",
  "hora": "13:30",
  "tipo_usuario": "visitante"
}`
5. `{
  "placa": "DEF456",
  "tipo": "carro",
  "evento": "entrada",
  "hora": "00:00",
  "tipo_usuario": "personal"
}`
6. `{
  "placa": "RTY78G",
  "tipo": "moto",
  "evento": "entrada",
  "hora": "15:00",
  "tipo_usuario": "visitante"
}`
