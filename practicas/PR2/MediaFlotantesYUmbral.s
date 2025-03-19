# AUTOR: HÉCTOR MARTÍN ÁLVAREZ
# FECHA ÚLTIMA MODIFICACIÓN: 12/03/2025
# // En un bucle solicitar flotantes hasta que se meta un 0.0
# // (que no se tendrá en cuenta).
# // Al final indicar el número de números introducidos, el valor media.
# // Si la media supera 1.5 sacar mensaje indicando que se supera el umbral.

# include <iostream>
# include <iomanip>

# int main() {
#   std::cout << std::fixed << std::setprecision(8);  // Ignorar
#   std::cout << "\nMedia de flotantes y umbral\n";
#   float acumulado = 0.0;
#   int numValores = 0;
#   while(true) {
#     float valor;
#     std::cout << "Introduce valor (0.0 para terminar): ";
#     std::cin >> valor;
#     if(valor == 0.0) {
#       break;
#     }
#     acumulado += valor;
#     numValores++;
#   }
#   if (numValores > 0) {
#     float media = acumulado / numValores;
#     std::cout << "\nSe introdujeron " << numValores
#         << " valores. Su media es " << media;
#     if (media > 1.5) {
#       std::cout << "\nSe supera el umbral";
#     }
#   } else {
#     std::cout << "\nNo se introdujo ningún valor";
#   }
#   std::cout << "\n\nTerminamos\n";
# }

	.data
strTitulo:	.asciiz	"\nMedia de flotantes y umbral\n"
strIntroduce:	.asciiz	"Introduce valor (0.0 para terminar): "
strSeIntrodujo:	.asciiz	"\nSe introdujeron "
strValores:	.asciiz	" valores. Su media es "
strSupera:	.asciiz	"\nSe supera el umbral"
strNingun:	.asciiz	"\nNo se introdujo ningún valor"
strTerminamos:	.asciiz	"\n\nTerminamos\n"

	.text
######################################
# Relación entre variables y registros
# acumulado (float)	->	$f20
# numValores (int)	->	$s0
# valor (float)		->	$f21
# media (float)		->	$f22

# Se utilizan variables temporales
# para alojar enteros que se utilizan
# una única vez
######################################

# int main() {
#   std::cout << std::fixed << std::setprecision(8);  // Ignorar

main:

#   std::cout << "\nMedia de flotantes y umbral\n";

	li	$v0,4
	la	$a0,strTitulo
	syscall

#   float acumulado = 0.0;

	li.s	$f20,0.0

#   int numValores = 0;

	move	$s0,$zero

#   while(true) {
while_true:

while_true_dentro:
#     float valor;
#     std::cout << "Introduce valor (0.0 para terminar): ";

	li	$v0,4
	la	$a0,strIntroduce
	syscall

#     std::cin >> valor;

	li	$v0,6
	syscall
	mov.s	$f21,$f0

#     if(valor == 0.0) {
if_cero:
	li.s	$f4,0.0
	c.eq.s	$f21,$f4
	bc1f	if_cero_fuera

if_cero_dentro:
#       break;

	b	while_true_fuera
#     }

if_cero_fuera:
#     acumulado += valor;

	add.s	$f20,$f20,$f21

#     numValores++;

	addi	$s0,1

	b	while_true_dentro	# Volvemos al bucle while
#   }

while_true_fuera:

#   if (numValores > 0) {

if_numValores:
	blez	$s0,if_numValores_else

if_numValores_dentro:

#     float media = acumulado / numValores;

	mtc1	$s0,$f5
	cvt.s.w	$f6,$f5

	div.s	$f22,$f20,$f6

#     std::cout << "\nSe introdujeron " << numValores

	li	$v0,4
	la	$a0,strSeIntrodujo
	syscall

	li	$v0,1
	move	$a0,$s0
	syscall

#         << " valores. Su media es " << media;

	li	$v0,4
	la	$a0,strValores
	syscall

	li	$v0,2
	mov.s	$f12,$f22
	syscall

#     if (media > 1.5) {
if_media:
	li.s	$f4,1.5
	c.le.s	$f22,$f4
	bc1t	if_media_fuera

if_media_dentro:

#       std::cout << "\nSe supera el umbral";

	li	$v0,4
	la	$a0,strSupera
	syscall

#     }

if_media_fuera:

	b	if_numValores_fuera

#   } else {

if_numValores_else:

#     std::cout << "\nNo se introdujo ningún valor";

	li	$v0,4
	la	$a0,strNingun
	syscall

#   }

if_numValores_fuera:

fin:
#   std::cout << "\n\nTerminamos\n";

	li	$v0,4
	la	$a0,strTerminamos
	syscall

	li	$v0,10
	syscall
# }
