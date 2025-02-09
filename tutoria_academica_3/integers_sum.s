# Principios de Computadores (2024-2025) TA3
# Nombre: Héctor Martín Álvarez (alu0101714059@ull.edu.es)
# Descripción: Un programa que hace la suma de dos enteros

            .data       # Sección donde declaramos los datos
cadena_input:          .asciiz "Introduzca un entero: "
cadena_sum:            .asciiz "La suma de los enteros es: "

            .text       # Sección donde escribiremos el código
main:
      # Imprimimos un mensaje para que el usuario introduzca un entero que almacenaremos
      la    $a0,cadena_input  # Movemos a $a0 la cadena que queremos mostrar
      li    $v0,4             # Indica al programa que vamos a imprimir una cadena
      syscall                 # Hacemos una llamada al sistema
      li    $v0,5             # Indicamos al programa que vamos a leer un entero
      syscall                 # Hacemos una llamada al sistema
      move  $s0, $v0          # Movemos la input del usuario a $s0

      # Repetimos lo mismo otra vez para almacenar el segundo entero introducido por el usuario
      la    $a0,cadena_input  # Movemos a $a0 la cadena que queremos mostrar
      li    $v0,4             # Indica al programa que vamos a imprimir una cadena
      syscall                 # Hacemos una llamada al sistema
      li    $v0,5             # Indicamos al programa que vamos a leer un entero
      syscall                 # Hacemos una llamada al sistema
      move  $s1,$v0           # Movemos la input del usuario a $s1

      # Ahora, realizamos la suma de los enteros y la mostramos por pantalla 
      add   $s2,$s0,$s1       # Se suman los dos enteros y se guarda el resultado en $s2
      la    $a0,cadena_sum    # Carga en $v0 la dirección del mensaje que irá antes del resultado final
      li    $v0,4             # Indica al programa que se imprimirá una cadena de texto
      syscall                 # Hacemos una llamada al sistema para imprimir la cadena_sum
      move  $a0,$s2           # Cargamos el resultado de la suma en $a0
      li    $v0,1             # Indicamos al prograwma que queremos imprimir un entero
      syscall                 # Llamamos al programa para imprimir la suma
      li    $v0,10            # Indicamos al programa que queremos finalizar la ejecución
      syscall                 # Llamamos al programa para finalizar la ejecución del mismo
