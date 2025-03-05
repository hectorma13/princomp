# AUTOR: Héctor Martín Álvarez
# FECHA: 05/03/2025
# VERSIÓN: 2 (reintento después de la sesión a partir del código en C++)
#// Programa para evaluar polinomio tercer grado

# #include <iostream>
# #include <iomanip>

# int main(void) {
#   std::cout << std::fixed << std::setprecision(8);  // Ignorar
#   float a,b,c,d;
#   std::cout << "\nEvaluacion polinomio f(x) = a x^3 + b x^2 + c x + d"
#             << " en un intervalo [r,s]\n";
#   std::cout << "\nIntroduzca coeficiente a: ";
#   std::cin >> a;
#   std::cout << "Introduzca coeficiente b: ";
#   std::cin >> b;
#   std::cout << "Introduzca coeficiente c: ";
#   std::cin >> c;
#   std::cout << "Introduzca coeficiente d: ";
#   std::cin >> d;
#   int r,s;
#   do {
#     std::cout << "\nLímite inferior r: ";
#     std::cin >> r;
#     std::cout << "Límite superior s: ";
#     std::cin >> s;
#   } while (r > s);

#   for (int x = r ; x <= s ; x++) {
#     // float f = x*x*x*a + x*x*b + x*c + d;
#     float f = d;
#     f += x*c;
#     f += x*x*b;
#     f += x*x*x*a;
#     if (f >= 2.5) {
#       std::cout << "\nf(" << x << ") = " << f;
#     }
#   }
#   std::cout << "\n\nTermina el programa\n";
# }

	.data
strTitulo:	.ascii	"\nEvaluacion polinomio f(x) = a x^3 + b x^2 + c x + d"
		.asciiz	" en un intervalo [r,s]\n"
strIntroA:	.asciiz	"\nIntroduzca coeficiente a: "
strIntroB:	.asciiz	"Introduzca coeficiente b: "
strIntroC:	.asciiz	"Introduzca coeficiente c: "
strIntroD:	.asciiz	"Introduzca coeficiente d: "

strIntroR:	.asciiz	"\nLímite inferior r: "
strIntroS:	.asciiz	"Límite superior s: "

strF:		.asciiz	"\nf("
strIgual:	.asciiz	") = "
strTermina:	.asciiz	"\n\nTermina el programa\n"

####################################
# Relación entre registros/variables
# a	-->	$f20
# b	-->	$f21
# c	-->	$f22
# d	-->	$f23
# r	-->	$s0
# s	-->	$s1
# x	-->	$s2
# f	-->	$f24
####################################
	.text
# int main(void) {

main:

#   std::cout << std::fixed << std::setprecision(8);  // Ignorar
#   float a,b,c,d;
#   std::cout << "\nEvaluacion polinomio f(x) = a x^3 + b x^2 + c x + d"
#             << " en un intervalo [r,s]\n";

	li	$v0,4
	la	$a0,strTitulo
	syscall

#   std::cout << "\nIntroduzca coeficiente a: ";
#   std::cin >> a;

	li	$v0,4
	la	$a0,strIntroA
	syscall

	li	$v0,6
	syscall
	mov.s	$f20,$f0

#   std::cout << "Introduzca coeficiente b: ";
#   std::cin >> b;

	li	$v0,4
	la	$a0,strIntroB
	syscall

	li	$v0,6
	syscall
	mov.s	$f21,$f0

#   std::cout << "Introduzca coeficiente c: ";
#   std::cin >> c;

	li	$v0,4
	la	$a0,strIntroC
	syscall

	li	$v0,6
	syscall
	mov.s	$f22,$f0

#   std::cout << "Introduzca coeficiente d: ";
#   std::cin >> d;

	li	$v0,4
	la	$a0,strIntroD
	syscall

	li	$v0,6
	syscall
	mov.s	$f23,$f0

#   int r,s;
#   do {
do_while:
#     std::cout << "\nLímite inferior r: ";

	li	$v0,4
	la	$a0,strIntroR
	syscall

#     std::cin >> r;

	li	$v0,5
	syscall
	move	$s0,$v0

#     std::cout << "Límite superior s: ";

	li	$v0,4
	la	$a0,strIntroS
	syscall

#     std::cin >> s;

	li	$v0,5
	syscall
	move	$s1,$v0

#   } while (r > s);
	bgt	$s0,$s1,do_while

do_while_fin:

#   for (int x = r ; x <= s ; x++) {
	move	$s2,$s0
for:
	bgt	$s2,$s1,for_fin
#     // float f = x*x*x*a + x*x*b + x*c + d;
#     float f = d;
	mtc1	$s2,$f4
	cvt.s.w	$f5,$f4 #$f5 = x
	mov.s	$f24,$f23

#     f += x*c;
	mul.s	$f6,$f5,$f22
	add.s	$f24,$f24,$f6


#     f += x*x*b;
	mul.s	$f6,$f5,$f5
	mul.s	$f6,$f6,$f21
	add.s	$f24,$f24,$f6
#     f += x*x*x*a;

	mul.s	$f6,$f5,$f5
	mul.s	$f6,$f6,$f5
	mul.s	$f6,$f6,$f20
	add.s	$f24,$f24,$f6
if:
	li.s	$f7,2.5
	c.lt.s	$f24,$f7
	bc1t	if_fin
#     if (f >= 2.5) {
if_dentro:
#       std::cout << "\nf(" << x << ") = " << f;
	li	$v0,4
	la	$a0,strF
	syscall
	li	$v0,1
	move	$a0,$s2
	syscall
	li	$v0,4
	la	$a0,strIgual
	syscall
	li	$v0,2
	mov.s	$f12,$f24
	syscall
#     }
if_fin:
#   }
	addi	$s2,1
	b	for

for_fin:

#   std::cout << "\n\nTermina el programa\n";
# }

	li	$v0,4
	la	$a0,strTermina
	syscall

	li	$v0,10
	syscall
