# Taller · Ingeniería de prompts y de contexto · ParqueFET

Diplomado en Ingeniería de Software con IA y Sistemas Agénticos · FET · Sesión 03

## Integrante

- Julián Andrés Pobre Campuzano

## Caso

**Caso 1 · ParqueFET**: control del parqueadero del campus.

Reglas de negocio:

- Solo ingresan vehículos registrados a un carné vigente.
- Capacidad: 120 carros y 300 motos.
- Estudiantes y personal no pagan; visitantes pagan $3.000 (carro) o $1.500 (moto) por hora o fracción.
- Un carné solo puede tener un vehículo dentro a la vez.
- Ningún vehículo puede permanecer más de 14 horas seguidas.

## Modelos usados

| Modelo | Basado en | Configuración | Retos |
| --- | --- | --- | --- |
| `qwen-demo` | qwen3.5:4b | temperatura 0, semilla 42, `--think=false` | 1, 2, 3 y 4 (parte B) |
| `phi-demo` | phi4-mini | temperatura 0, semilla 42 | 4 (parte A) |
| `revisor-parquefet-v1` y `-v2` | qwen3.5:4b | temperatura 0, semilla 42, system prompt propio | 2 |
| qwen3.5:4b y qwen3.5:0.8b | — | temperatura 0, semilla 42, desde Python | 5 (bonus) |

## Equipo

| | |
| --- | --- |
| Computador | HP Laptop 15 |
| Sistema operativo | Windows 11 Home |
| Procesador | AMD Ryzen 7 7730U |
| RAM | 16 GB |
| GPU | Radeon Graphics integrada (sin GPU dedicada) |
| Ollama | versión 0.40.10 |
| Python | 3.15 (instalado con uv 0.13.6) |

## Estructura

```
taller-parquefet/
├── README.md
├── preparar_entorno.bat   # descarga los modelos y crea qwen-demo y phi-demo
├── modelfiles/            # Modelfiles de qwen-demo y phi-demo
├── reto1/                 # fórmula base y delimitadores
├── reto2/                 # system prompt del revisor, Modelfile v1 y v2, ataques
├── reto3/                 # cadena requisito → historia → criterios → casos de prueba
├── reto4/                 # cadena de pensamiento y la instrucción que se olvida
└── bonus/                 # reto 5: JSON validado y evaluación A/B en Python
```

Cada carpeta tiene los prompts (`.txt`), el script que los ejecuta (`.bat`), las salidas tal como las dio el modelo (`salida_*.md`) y el análisis (`.md`). La parte B del reto 4 se hizo a mano en el chat de Ollama, y sus salidas son la copia de la conversación.

## Reflexión

La técnica que más efecto tuvo en ParqueFET fue darle contexto al modelo: las reglas del parqueadero dentro de `<reglas>` o en el system prompt. Sin eso, el modelo escribió el código en JavaScript, sin ninguna regla, y revisó la función como si fuera Python genérico, diciendo que estaba bien. Con las reglas, pasó a cumplir casi todo y los revisores encontraron errores reales. También me sirvió mucho ver que el system prompt es el lugar correcto para lo que no se puede olvidar: en el reto 2 resistió los ataques y en el reto 4 la regla se mantuvo aunque la conversación se recortara.

Pero lo que más me quedó es que una respuesta ordenada no es una respuesta correcta. Ningún modelo encontró el error del `> 120`, aunque se lo pedí directamente, y cuando le pedí razonar paso a paso dijo que `120 > 120` era verdadero. En el reto 1 el código se veía bien y el parqueadero nunca se llenaba por un error de `"carro"` contra `"carros"`. En el reto 3 la auto-verificación dijo que había agregado casos que ya estaban. Y en el bonus todos los JSON pasaron la validación, aunque dos tenían datos inventados.

Si mañana tuviera que pedirle a una herramienta de IA que programe algo de ParqueFET, haría tres cosas distintas: le daría siempre las reglas de negocio completas y un formato de salida claro, dividiría el trabajo en pasos pequeños para revisar cada uno, y no aceptaría el código sin probarlo con los casos límite (120 carros, 300 motos, una hora y un minuto), porque ahí es donde más se equivoca.
