# AUTOR: Héctor Martín Álvarez
# FECHA: 24/04/2025
# E-MAIL: alu0101714059@ull.edu.es

#// Desarrollar un programa para calcular el costo total de un viaje por carretera
#// y si nuestro presupuesto lo cubre. Se pedirá un entero con los Km del viaje,
#// un entero con los Km por litro de combustible, un float con el precio del
#// litro de combustible y un float con el presupuesto disponible.
#// Se indicarán el costo total del viaje
#// y si supera nuestro presupuesto.
#
##include <iostream>
##include <iomanip>
#
#int main() {
#  std::cout << std::fixed << std::setprecision(8);  // Ignorar
#  std::cout << "\nCosto viaje\n";
#
#  int Kms;
#  std::cout << "Introduce Km del viaje (entero): ";
#  std::cin >> Kms;
#
#  int KmsPorLitro;
#  std::cout << "Introduce los Km por litro (entero): ";
#  std::cin >> KmsPorLitro;
#
#  float precioLitro;
#  std::cout << "Introduce el precio por litro: ";
#  std::cin >> precioLitro;
#
#  float presupuesto;
#  std::cout << "Introduce el presupuesto: ";
#  std::cin >> presupuesto;
#
#  float costo = ((float)Kms) / KmsPorLitro * precioLitro;
#
#  std::cout << "El recorrido de " << Kms << " Km supone un costo de " << costo;
#
#  if(costo > presupuesto) {
#    std::cout << "\nSupera el presupuesto";
#  }
#
#  std::cout << "\nTermina el programa\n";
#}

        .data
strCostoViaje:          .asciiz "\nCosto viaje\n"
strKmViaje:             .asciiz "Introduce Km del viaje (entero): "
strKmLitro:             .asciiz "Introduce los Km por litro (entero): "
strPrecioLitro:         .asciiz "Introduce el precio por litro: "
strPresupuesto:         .asciiz "Introduce el presupuesto: "
strRecorridoDe:         .asciiz "El recorrido de "
strTieneCosto:          .asciiz " Km supone un costo de "
strSuperaPres:          .asciiz "\nSupera el presupuesto"
strFinPrograma:         .asciiz "\nTermina el programa\n"

        .text
############################################
# Tabla de equivalencias variables-registros
# Kms           ->      $s0
# KmsPorLitro   ->      $s1
# precioLitro   ->      $f20
# presupuesto   ->      $f21
# costo         ->      $f22

#int main() {
main:

#  std::cout << std::fixed << std::setprecision(8);  // Ignorar
#  std::cout << "\nCosto viaje\n";

        li              $v0,4
        la              $a0,strCostoViaje
        syscall

#  int Kms;
#  std::cout << "Introduce Km del viaje (entero): ";

        li              $v0,4
        la              $a0,strKmViaje
        syscall

#  std::cin >> Kms;

        li              $v0,5
        syscall 
        move            $s0,$v0

#  int KmsPorLitro;
#  std::cout << "Introduce los Km por litro (entero): ";

        li              $v0,4
        la              $a0,strKmLitro
        syscall

#  std::cin >> KmsPorLitro;

        li              $v0,5
        syscall 
        move            $s1,$v0

#  float precioLitro;
#  std::cout << "Introduce el precio por litro: ";

        li              $v0,4
        la              $a0,strPrecioLitro
        syscall

#  std::cin >> precioLitro;

        li              $v0,6
        syscall
        mov.s           $f20,$f0

#  float presupuesto;
#  std::cout << "Introduce el presupuesto: ";

        li              $v0,4
        la              $a0,strPresupuesto
        syscall

#  std::cin >> presupuesto;

        li              $v0,6
        syscall
        mov.s           $f21,$f0

#  float costo = ((float)Kms) / KmsPorLitro * precioLitro;
        
        mtc1            $s1,$f4
        cvt.s.w         $f23,$f4

        mtc1            $s0,$f6
        cvt.s.w         $f24,$f6

        div.s           $f5,$f24,$f5
        mul.s           $f22,$f23,$f20     

#  std::cout << "El recorrido de " << Kms << " Km supone un costo de " << costo;

        li              $v0,4
        la              $a0,strRecorridoDe
        syscall 

        li              $v0,1
        move            $a0,$s0
        syscall 

        li              $v0,4
        la              $a0,strTieneCosto
        syscall 

        li              $v0,2
        mov.s           $f12,$f22
        syscall

#  if(costo > presupuesto) {

if:
        c.lt.s          $f21,$f22
        bc1f            fin  

if_dentro:
#    std::cout << "\nSupera el presupuesto";

        li      $v0,4
        la      $a0,strSuperaPres
        syscall

#  }
fin:
#
#  std::cout << "\nTermina el programa\n";
#}

        li      $v0,4
        la      $a0,strFinPrograma
        syscall

        li      $v0,10
        syscall
