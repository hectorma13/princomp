# AUTOR: Héctor Martín Álvarez
# FECHA: 27/02/2025

#// Programa para convertir de grados Fahrenheit a Celsius
#// Usa la fórmula C = (F - 32)/1.8
#
##include <iostream>
##include <iomanip>
#
#int main() {
#  std::cout << std::fixed << std::setprecision(8);  // Ignorar
#
#  std::cout << "Introduzca grados Fahrenheit (entero): ";
#  int F;
#  std::cin >> F;
#  
#  float C = (F - 32) / 1.8;
#  
#  std::cout << "Temperatura en grados Celsius: " << C;
#  
#  std::cout << "\nTermina el programa\n";
#}
	.data # Sección que contiene los datos del programa
strIntroduzca:		.asciiz "Introduzca grados Fahrenheit (entero): "
strTempEnCelsius:	.asciiz "Temperatura en grados Celsius: "
strTerminaProg:		.asciiz "\nTermina el programa\n"

############################################################
# Relación entre variables (C++) y registros (MIPS Assembly)
# F (int)	->	$s0
# C (float)	->	$f20
############################################################

	.text # Sección que contiene el código del programa

#int main() {
main:

#  std::cout << std::fixed << std::setprecision(8);  // Ignorar

#  std::cout << "Introduzca grados Fahrenheit (entero): ";
	li	$v0,4
	la	$a0,strIntroduzca
	syscall

#  int F;
#  std::cin >> F;

	li	$v0,5
	syscall
	move	$s0,$v0

#  float C = (F - 32) / 1.8;
	li	$t0,32		# $t0 = 32
	sub	$s1,$s0,$t0	# $s1 = F - 32

	mtc1	$s1,$f21	# $f21  es copia cruda de $s1
	cvt.s.w	$f22,$f21	# Convertimos la copia cruda en float simple

	li.s	$f4,1.8
	div.s	$f20,$f22,$f4

#  std::cout << "Temperatura en grados Celsius: " << C;
	li	$v0,4
	la	$a0,strTempEnCelsius
	syscall

	li	$v0,2
	mov.s	$f12,$f20
	syscall

#  std::cout << "\nTermina el programa\n";
	li	$v0,4
	la	$a0,strTerminaProg
	syscall
	
	li	$v0,10
	syscall

#}
