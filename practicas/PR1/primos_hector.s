# AUTOR: Héctor Martín Álvarez
# FECHA ÚLTIMA MODIFICACIÓN: 19/02/2025

#include <iostream>
#
#int main(void) {
#    int inferior, superior,i,j;
#    bool esPrimo;
#
#    std::cout << "\nPR1. Principios de Computadores.\n";
#  std::cout << "\nUn numero primo es un natural mayor que 1 que es divisble\n"
#             << "unicamente entre 1 y el mismo. Este programa descubre los\n"
#             << "numero primos en un rango de numero naturales [a,b] siendo\n"
#            << "a y b naturales mayores que 1. El programa debera comprobar\n"
#            << "que se cumple ademas que b es mayor o igual que a y que son\n"
#             << "menores que 1001 para que ejecute en tiempo razonable.\n\n";
#   
#    while (true) {
#        std::cout << "Introduce el limite inferior [a]: ";
#        std::cin >> inferior;
#        if ((inferior < 2) || (inferior > 1000)) {
#            std::cout << "Error, vuelve a introducir el rango.\n";
#            continue;
#        }
#        std::cout << "Introduce el limite superior [b]: ";
#        std::cin >> superior;
#        if ((superior < 2) || (superior < inferior) || (superior > 1000)) {
#            std::cout << "Error, vuelve a introducir el rango.\n";
#            continue;
#        }
#        break;
#    }
#
#    for (i = inferior; i <= superior; i++) {
#        esPrimo = true;
#        for (j = 2; j < i; j++) {
#            if (i % j == 0) {
#                esPrimo = false;
#                break;
#            }
#        }
#        if (esPrimo) {
#            std::cout << i << " ";
#        }
#    }
#    std::cout << "\nFin del programa.\n";
#    return 0;
#}

        .data # Sección donde se encuentran los datos de nuestro programa
        
strTitulo:      .asciiz "\nPR1. Principios de Computadores.\n";
strInstruc:
        .ascii  "\nUn numero primo es un natural mayor que 1 que es divisble\n"
        .ascii  "unicamente entre 1 y el mismo. Este programa descubre los\n"
        .ascii  "numero primos en un rango de numero naturales [a,b] siendo\n"
        .ascii  "a y b naturales mayores que 1. El programa debera comprobar\n"
        .ascii  "que se cumple ademas que b es mayor o igual que a y que son\n"
        .asciiz "menores que 1001 para que ejecute en tiempo razonable.\n\n";
strFin:         .asciiz "\nFin del programa.\n"
strEspacio:     .asciiz " "
strLimiteInf:   .asciiz "Introduce el limite inferior [a]: "
strLimiteSup:   .asciiz "Introduce el limite superior [b]: "
strErrRango:    .asciiz "Error, vuelve a introducir el rango.\n"

        .text # Sección que contiene el código del programa
###########################################################

# Tabla de relación entre variables y registros
# inferior      ->      $s0
# superior      ->      $s1
# i             ->      $s2
# j             ->      $s3
# esPrimo       ->      $s4

#int main(void) {
main:
#    int inferior, superior,i,j;
#    bool esPrimo;
#
#    std::cout << "\nPR1. Principios de Computadores.\n";

        li      $v0,4
        la      $a0,strTitulo
        syscall

#  std::cout << "\nUn numero primo es un natural mayor que 1 que es divisble\n"
#            << "unicamente entre 1 y el mismo. Este programa descubre los\n"
#            << "numero primos en un rango de numero naturales [a,b] siendo\n"
#            << "a y b naturales mayores que 1. El programa debera comprobar\n"
#            << "que se cumple ademas que b es mayor o igual que a y que son\n"
#            << "menores que 1001 para que ejecute en tiempo razonable.\n\n";

        li      $v0,4
        la      $a0,strInstruc
        syscall

#   
#    while (true) {

while_true:

#        std::cout << "Introduce el limite inferior [a]: ";

        li      $v0,4
        la      $a0,strLimiteInf
        syscall

#        std::cin >> inferior;
        li      $v0,5
        syscall
        move    $s0,$v0

#        if ((inferior < 2) || (inferior > 1000)) {

if_inferior:

        blt     $s0,2,if_inferior_then
        bgt     $s0,1000,if_inferior_then
        b       if_inferior_fin

if_inferior_then:

#            std::cout << "Error, vuelve a introducir el rango.\n";
        li      $v0,4
        la      $a0,strErrRango
        syscall

#            continue;

        b       while_true

#        }

if_inferior_fin:

#        std::cout << "Introduce el limite superior [b]: ";

        li      $v0,4
        la      $a0,strLimiteSup
        syscall

#        std::cin >> superior;

        li      $v0,5
        syscall
        move    $s1,$v0

#        if ((superior < 2) || (superior < inferior) || (superior > 1000)) {

if_superior:

        blt     $s1,2,if_superior_then
        blt     $s1,$s0,if_superior_then
        bgt     $s1,1000,if_superior_then
        b       if_superior_fin

if_superior_then:

#            std::cout << "Error, vuelve a introducir el rango.\n";

        li      $v0,4
        la      $a0,strErrRango
        syscall

#            continue;

        b       while_true

#        }

if_superior_fin:

#        break;

        b while_true_fin

#    }

while_true_fin:
#
#    for (i = inferior; i <= superior; i++) {

        move    $s2,$s0

for_rango:

        bgt     $s2,$s1,for_rango_fin

#        esPrimo = true;

        li      $s4,1

#        for (j = 2; j < i; j++) {

        li      $s3,2

for_es_primo:

        bge     $s3,$s2,for_es_primo_fin

#            if (i % j == 0) {

if_resto:

        div     $s2,$s3
        mfhi    $t0
        beqz    $t0,if_resto_then
        b       if_resto_fin

if_resto_then:

#                esPrimo = false;

        move    $s4,$zero

#                break;

        b       for_es_primo_fin

#            }
if_resto_fin:

        addi    $s3,1
        b       for_es_primo
#        }

for_es_primo_fin:

#        if (esPrimo) {

if_esPrimo:

        beqz    $s4,if_esPrimo_fin

if_esPrimo_then:

#            std::cout << i << " ";

        li      $v0,1
        move    $a0,$s2
        syscall
        li      $v0,4
        la      $a0,strEspacio
        syscall

#        }

if_esPrimo_fin:

        addi    $s2,1
        b       for_rango

#    }

for_rango_fin:

#    std::cout << "\nFin del programa.\n";

        li      $v0,4
        la      $a0,strFin
        syscall

#    return 0;
#}

fin_programa:

        li      $v0,10
        syscall
