# Universidad de La Laguna
# Escuela Superior de Ingeniería y Tecnología
# Grado en Ingeniería Informática
# Principios de Computadores 2024-2025
#
# @file ejercicio1.s
# @author Héctor Martín Álvarez alu0101714059@ull.edu.es
# @date 04/02/2025
# @brief Calcula el mínimo y el máximo de dos registros y suma todos los valores entre ellos.
      .data
      .text
if:
      blt $t1, $t2, then # Comprueba si $t1 < $t2
      # Se ejecuta si no se cumple $t1 < $t2
      move $t3, $t2 # $t3 = $t2
      move $t4, $t1 # $t4 = $t1
      move $t5, $zero # Inicializa $t5 = 0 para sumar después
      j loop # Salta directamente al bucle

then:
      move $t3, $t1 # $t3 = $t1
      move $t4, $t2 # $t4 = $t2
      move $t5, $zero # Inicializa $t5 = 0 para sumar después

# Bucle principal para sumar los valores entre $t3 y $t4
loop:
      bgt $t3, $t4, fin # Si $t3 > $t4, se acaba
      add $t5, $t5, $t3 # suma el valor de $t3 en $t5
      addi $t3, 1 # Suma 1 a $t3 para la siguiente iteración
      j loop # Vuelve al bucle para hacer la siguiente iteración

fin:
      li $v0, 10 # Carga el código para acabar el programa en $v0
      syscall # Realiza una llamada al sistema, por lo que acaba el programa
