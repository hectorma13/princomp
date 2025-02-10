      .data 
      .text
main:
      # Si $t1 o $t2 <= 0, entonces, finaliza el programa
      blez $t1, end
      blez $t2, end

      # Si se ejecuta lo siguiente, es porque $t1 y $t2 > 0 
      move $t3, $zero # Inicializamos $t3 en 0
      li $t4, 1 # Inicializamos $t4 en 1, pues irá creciendo hasta que $t4 = $t1

# Comenzamos con nuestro bucle y sus comprobaciones
bucle:
      bgt $t4, $t1, end # Si $t4 > $t1, entonces finaliza el programa
      div $t4, $t2 # Dividimos $t4 / $t2
      # Sabemos que, HI = $t4 % $t2 y LO = $t4 / $t2
      mfhi $t5 # Rescatamos el resto de HI en $t5 para analizarlo
      addi $t4, 1 # Hacemos $t4 = $t4 + 1
      bne $t5, $zero, bucle # Comprobamos si el resto es igual a cero
      addi $t3, $t3 , 1 # Sumamos 1 a $t3, pues es divisible si esto se ejecuta
      j bucle # Volvemos al bucle

# Fin de nuestro programa
end:
      li $v0, 10
      syscall
