# PRINCIPIO DE COMPUTADORES. Curso 2024-2025.

## PR1

### Descripción

Te proponemos realizar en ensamblador un programa para calcular los números primos (números naturales mayor que uno que tienen únicamente dos divisores positivos: él mismo, y uno) que se encuentren en un rango [a,b] que el usuario facilitará por la consola.

El usuario deberá introducir los límites del rango [a,b], debiendo el programa comprobar que ambos números son mayores que uno y menores que 1001, y que b es mayor o igual que a. Una vez realizada la entrada de datos, el programa imprimirá por pantalla una lista separada por espacios de los números primos incluidos en el rango.

Dejaremos en el campus el [código C++ que resuelve este problema](https://github.com/hectorma13/princomp/blob/main/practicas/PR1/primos.cpp), y también pondremos a tu disposición una [aplicación web para pasar tests a tu práctica](https://codetest.iaas.ull.es/testeaPrinComp/testea/5cbba20e0e0bcfc30057b027de2cb257?idu=24250901089). Antes de ver el código en C++ que te dejaremos intenta hacer una versión propia tuya (te ayudará a comprender el algoritmo). Recuerda que si no lo entiendes puedes preguntar a tu profesor de prácticas en una tutoría.

### Guía de Estilo

Al escribir el código fuente se debe de respetar las siguientes reglas:

- Poner nombre de la persona autora y fecha de la última modificación en las primeras líneas del fichero fuente
- Las líneas deberán tener, preferiblemente, menos de 72 caracteres y nunca superar los 80. Este límite se aplica también a los comentarios.
- Para el sangrado utilizar solo espacios o solo tabuladores (de tamaño 8), pero no mezclar.
- Sangrar siempre las instrucciones
- Hacer un sangrado consistente:
    - Usar el mismo sangrado para todas las instrucciones (al considerar que todas son iguales para la CPU).
    - Sangrar a un mayor nivel las instrucciones dentro del un bloque (de forma análoga a lo que se hace en lenguajes de alto nivel)
- Poner las etiquetas del segmento .text en línea independiente, no junto con una instrucción. Las etiquetas en la zona .data si pueden estar en la misma línea que una directiva (.asciz, .word, .float, etc.)
- El sangrado de las etiquetas debe garantizar que sean fáciles de encontrar y leer, por lo que debe ser distinto del de las líneas que la rodean (anterior y posterior). Las posibles opciones son:
    - Poner todas las etiquetas sin sangrado, en la primera "columna" de la línea
    - Sangrarlas dentro de un bloque siguiendo el sangrado de las instrucciones.
- El nombre de las etiquetas debe ser significativo, especialmente aquellas relacionadas con estructuras de control (condicionales y bucles)
- Poner la tabla que relate las variables del pseudocódigo en C++ (o las variables del problema si no te vas a basar en C++) con los registros donde estarán almacenadas.
- Comentar adecuadamente el código para hacerlo legible y entendible.
    - Cada conjunto de instrucciones en ensamblador debe ir precedido por un comentario que indique que se pretende conseguir.
    - Si te has basado en el C++ para escribir el ensamblador, la instrucción de C++ es suficiente como documentación.
    - Si se usa código C++ como comentario, las instrucciones que siguen al comentario deben realizar EXACTAMENTE lo que figura en el código C++, y no otra cosa parecida.
