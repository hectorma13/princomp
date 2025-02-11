#/* 
# * File:   repasotablas.cpp
# * Authores: Carlos y Alberto
# *
# * Descripción: El usuario introducira por teclado la tabla de multiplicar que
# * quiere repasar. Si introduce un 0 el programa finalizara. Si introduce un
# * numero mayor que 0 debera pregutar al usuario por todas las multiplicaciones
# * del numero introducido por lo numero del 1 al 10. Al final de cada tabla se
# * visualizara el porcentaje de aciertos.
# */
##include <iostream>
#
#int main(int argc, char** argv) {
#
#  std::cout << "Programa para repasar las tablas de multiplicar.\n";
#  int n; // numero del que quiero repasar la tabla
#  do {
#    std::cout<<"¿Qué tabla deseas repasar? Introduce un número (0 para salir): ";
#    std::cin >> n;
#    if (n == 0) break; // si introduce un 0 sale del bucle
#    int aciertos = 0; // incializamos el numero de aciertos
#    for (int i = 1; i <= 10; i++) {
#      std::cout << i << " x " << n << " ? ";
#      int resultado;
#      std::cin >> resultado;
#      if (resultado == (i * n)) {
#        aciertos++;
#      }
#    }      
#    int porcentaje = aciertos * 10;
#    std::cout << "Tu porcenaje de aciertos es del " << porcentaje << "%\n";
#  } while (n != 0);
#  std::cout << "Termina el programa.\n";
#}

# Asignación de variables a registros
# n               ->    $s0
# aciertos        ->    $s1
# i               ->    $s2
# resultado       ->    $s3 (podría estar en un registro temporal)
# porcentaje      ->    $s4 (hay varias llamadas al syscall)


      .data # Sección donde declararemos nuestros datos
strTitle:               .asciiz "Programa para repasar las tablas de multiplicar.\n"
strWhichTable:          .asciiz "¿Qué tabla deseas repasar? Introduce un número (0 para salir): "
strX:                   .asciiz " x "
strDoubt:               .asciiz " ? "
strYourPercentage:      .asciiz "Tu porcenaje de aciertos es del "
strPercentage:          .asciiz "%\n"
strFinish:              .asciiz "Termina el programa.\n"
# Modificación (versión 2)
strNewTry:              .asciiz "Error, inténtalo de nuevo: "

      .text # Sección donde se escribirá el código del programa
#int main(int argc, char** argv) {
main:
#
#  std::cout << "Programa para repasar las tablas de multiplicar.\n";
      la    $a0,strTitle
      li    $v0,4
      syscall
#  int n; // numero del que quiero repasar la tabla

#  do {
do_while:
#    std::cout<<"¿Qué tabla deseas repasar? Introduce un número (0 para salir): ";
      la    $a0,strWhichTable
      li    $v0,4
      syscall 
#    std::cin >> n;
      li    $v0,5
      syscall
      move  $s0,$v0

#    if (n == 0) break; // si introduce un 0 sale del bucle
if_n0:
      beqz  $s0,do_while_end

#    int aciertos = 0; // incializamos el numero de aciertos
      move  $s1,$zero

#    for (int i = 1; i <= 10; i++) {
      li    $s2,1
for:
      bgt   $s2,10,for_fin
#      std::cout << i << " x " << n << " ? ";
      li    $v0,1
      move  $a0,$s2
      syscall

      li    $v0,4
      la    $a0,strX
      syscall

      li    $v0,1
      move  $a0,$s0
      syscall

      li    $v0,4
      la    $a0,strDoubt
      syscall

#      int resultado;
#      std::cin >> resultado;

      li    $v0,5
      syscall
      move  $s3,$v0
#      if (resultado == (i * n)) {

if_resultado:
      
      mul   $t0,$s2,$s0
      # Modificación (versión 2)
      bne   $s3,$t0,segunda_oportunidad
#        aciertos++;
      addi  $s1,1
#      }
if_resultado_fin:
#    }
      addi  $s2,1
      b     for

# Modificación (versión 2)
segunda_oportunidad:
      li    $v0,4
      la    $a0,strNewTry
      syscall

      li    $v0,5
      syscall
      move  $s3,$v0

      mul   $t0,$s2,$s0
      bne   $s3,$t0,segunda_incorrecta
      addi  $s1,1
      b     if_resultado_fin

# Modificación (versión 2)
segunda_incorrecta:
      b     if_resultado_fin

for_fin:
#    int porcentaje = aciertos * 10;
      mul  $s4,$s1,10

#    std::cout << "Tu porcenaje de aciertos es del " << porcentaje << "%\n";
      li    $v0,4
      la    $a0,strYourPercentage
      syscall

      li    $v0,1
      move  $a0,$s4
      syscall

      li    $v0,4
      la    $a0,strPercentage
      syscall

#  } while (n != 0);
      bnez  $s0,do_while
do_while_end:
#  std::cout << "Termina el programa.\n";

      li    $v0,4
      la    $a0,strFinish
      syscall


#}
      li    $v0, 10     # Cargamos en $v0 la instrucción para finalizar el programa
      syscall           # Llamamos al sistema para finalizar el programa
