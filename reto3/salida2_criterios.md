Criterio 1: Cálculo del tiempo cobrado
Dado que el sistema registra la hora exacta de entrada del vehículo
Cuando el usuario realiza el pago desde su celular
Entonces se calcula el tiempo transcurrido redondeando hacia arriba para co[2D[K
cobrar cada fracción de hora como una hora completa.

Criterio 2: Identificación del tipo de usuario y tarifa
Dado que el sistema verifica si el carné es vigente y si el conductor es es[2D[K
estudiante o personal
Cuando el usuario realiza el pago desde su celular
Entonces se aplica la tarifa gratuita para estudiantes/personal o $3.000 po[2D[K
por hora (carro) / $1.500 por hora (moto) según corresponda.

Criterio 3: Validación de límites de permanencia
Dado que el sistema conoce la hora de entrada registrada en el carné
Cuando el usuario realiza el pago desde su celular y el tiempo total supera[6D[K
supera las 14 horas
Entonces se muestra un mensaje de error indicando que el vehículo no puede [K
permanecer más de 14 horas seguidas.

Criterio 4: Verificación de capacidad del parqueadero
Dado que el sistema cuenta el número actual de carros y motos dentro del es[2D[K
espacio
Cuando el usuario realiza el pago desde su celular
Entonces se muestra un mensaje de error indicando que el parqueadero está l[1D[K
lleno si excede los 120 carros o 300 motos.

