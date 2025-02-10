      .data
      .text
# Comprobamos primero la segunda condición
# pues es un or y si se cumple, la expresión
# es directamente verdadera
# Condición: (($t2-$t3) == $t1
main:
      sub $t4, $t2, $t3
      beq $t4, $t1, verdadero

# Si la condición (($t2-$t3) == $t1 es falsa
# ahora, se comprueba la primera
# Primera: ($t1 < $t3) && ($t2 >= $t3)
# Desde que cualquier lado del and && sea falso
# la expresión es falsa automáticamente
primera_condicion:
      bge $t1, $t3, falso # Caso contrario, si se da, es falsa
      blt $t2, $t3, falso # Caso contrario, si se da, es falsa
      j verdadero # Si no se ha dado ninguna, la expr. es verdadera

falso: 
      move $t5, $zero # Como es falso, $t5 = 0
      j fin # Salta al fin del programa

verdadero:
      li $t5, 1 # Como es falso, $t5 = 1

fin:
      li $v0, 10 # Carga en $v0 el código 10 o fin de programa
      syscall # Llama al sistema para finaliza el programa