# FECHA DE ÚLTIMA MODIFICACIÓN: 30/04/2025

# #include <iostream>
# #include <iomanip>

# const int v1Largo = 10;
# double v1[v1Largo] = {-3.125,  8.875,  7.6875, -0.71875, -5.25, -3.875,
#   -3.3125, -0.375,  0.140625, 0.96875};

# const int v2Largo = 6;
#double v2[v2Largo] = {-1.03125,  5.640625,  2.953125, -1.625, -2.90625, -0.25};

# const int v3Largo = 4;
# double v3[] = {0.0, 10.0, 5.0, 5.0};

# double media(double* vect, int n) {
#   double acumulado = 0.0;
#   for(int i = 0; i < n; i++) {
#     acumulado = acumulado + vect[i];
#   }
#   double mediaAritmetica = acumulado / n;
#   return mediaAritmetica;
# }

# void separa(double* v, int largo) {
#   double mediaVector = media(v, largo);
#   std::cout << mediaVector << " es la media\n";
#   for(int i = 0; i < largo; i++) {
#     double valor = v[i];
#     std::cout << valor;
#     if (valor >= mediaVector) {
#       std::cout << " es mayor o igual";
#     } else {
#       std::cout << " es menor";
#     }
#     std::cout << " que la media\n";
#   }
# }

# int main() {
#   std::cout << std::setprecision(18);  // ignorar

#   std::cout << "\nSepara Elementos Vector double Según Media\n";

#   while(true) {
#     std::cout << "\nElige vector 1, 2, 3 o 0 para terminar: ";
#     int opcion;
#     std::cin >> opcion;
#     if (opcion == 0) {
#       break;
#     }
#     if ((opcion < 0) || (opcion > 3)) {
#       std::cout << "Opción incorrecta";
#       continue;
#     }
#     double* vTrabajo = v1;
#     int largoTrabajo = v1Largo;
#     if (opcion == 2) {
#       vTrabajo = v2;
#       largoTrabajo = v2Largo;
#     }
#     if (opcion == 3) {
#       vTrabajo = v3;
#       largoTrabajo = v3Largo;
#     }
#     separa(vTrabajo, largoTrabajo);
#   }
#   std::cout << "\nTermina el programa\n";
# }


.data
v1Largo:	.word 10
v1:		.double	-3.125,  8.875,  7.6875, -0.71875, -5.25, -3.875
		.double	-3.3125, -0.375,  0.140625, 0.96875

v2Largo:	.word 6
v2:		.double -1.03125,  5.640625,  2.953125, -1.625, -2.90625, -0.25

v3Largo:	.word 4
v3:		.double 0.0, 10.0, 5.0, 5.0

strEsLaMedia:	.asciiz	" es la media\n"
strMayorOIgual:	.asciiz	" es mayor o igual que la media\n"
strMenorMedia:	.asciiz	" es menor que la media\n"

strTitulo:	.asciiz	"\nSepara Elementos Vector double Según Media\n"
strElige:	.asciiz	"\nElige vector 1, 2, 3 o 0 para terminar: "
strOpcionInc:	.asciiz	"Opción incorrecta"
strTermina:	.asciiz	"\nTermina el programa\n"

sizeD = 8

	.text

# ↓↓↓↓ Debes codificar a partir de aquí ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

########################################################################
# double media(double* vect, int n) {

# Parámetros de entrada
# double* vect		-->	$a0
# int n			-->	$a1

# Parámetros de salida:
# double mediaAritmetica -->	$f0

# La función no llama ni al syscall ni a otra función
# Entonces, no hace falta usar la PILA

# int i			-->	$t0
# double acumulado	-->	$f4
# vect[i]		-->	$f6

# Se utilizan algunos registros (ya sea del coprocesador o no) para realizar
# cálculos de elementos en posiciones diferentes de los vectores que cambian
# iteración a iteración (cómo, por ejemplo, v[i], etc.)

media:
#   double acumulado = 0.0;
	li.d	$f4,0.0

#   for(int i = 0; i < n; i++) {
	move	$t0,$zero
for_media:
	bge	$t0,$a1,for_media_fin

#     acumulado = acumulado + vect[i];
	# Cálculo de vect[i]
	l.d	$f6,0($a0)
	add	$a0,$a0,sizeD

	add.d	$f4,$f4,$f6

	addi	$t0,$t0,1
	b	for_media
#   }
for_media_fin:

#   double mediaAritmetica = acumulado / n;
	mtc1	$a1,$f8
	cvt.d.w	$f6,$f8
	div.d	$f0,$f4,$f6

#   return mediaAritmetica;
	b	media_salida
# }
media_salida:
	jr	$ra

media_fin:
########################################################################

########################################################################
# void separa(double* v, int largo) {

# Parámetros de entrada
# double* v		-->	$a0 ($s0)
# int largo		-->	$a1 ($s1)

# Parámetros de salida: Ninguno porque es void

# La función llama a syscall y a otra función
# Entonces, hace falta usar la PILA
# Haremos PUSH y POP

# double mediaVector	-->	$f20
# int i			-->	$s2
# double valor		-->	$f22

# Se utilizan algunos registros (ya sea del coprocesador o no) para realizar
# cálculos de elementos en posiciones diferentes de los vectores que cambian
# iteración a iteración (cómo, por ejemplo, v[i], etc.)

separa:

	# PUSH: $ra, $s0, $s1, $s2, $f20, $f22
	# Son 4 registros de tamaño 4 y dos de tamaño 8
	# 4*4 = 16 + 8 * 2 = 32
	addi	$sp,$sp,-32
	sw	$ra,0($sp)
	sw	$s0,4($sp)
	sw	$s1,8($sp)
	sw	$s2,12($sp)
	s.d	$f20,16($sp)
	s.d	$f22,24($sp)

	move	$s0,$a0
	move	$s1,$a1

#   double mediaVector = media(v, largo);
	move	$a0,$s0
	move	$a1,$s1
	jal	media

	mov.d	$f20,$f0

#   std::cout << mediaVector << " es la media\n";
	li	$v0,3
	mov.d	$f12,$f20
	syscall

	li	$v0,4
	la	$a0,strEsLaMedia
	syscall

#   for(int i = 0; i < largo; i++) {
	move	$s2,$zero
for_separa:
	bge	$s2,$s1,for_separa_fin

#     double valor = v[i];
	# Cálculo de v[i]
	l.d	$f22,0($s0)
	add	$s0,$s0,sizeD

#     std::cout << valor;
	li	$v0,3
	mov.d	$f12,$f22
	syscall

#     if (valor >= mediaVector) {
if_separa:
	c.lt.d	$f22,$f20
	bc1t	else_separa

#       std::cout << " es mayor o igual";
	li	$v0,4
	la	$a0,strMayorOIgual
	syscall

	b	if_separa_fin
#     } else {
else_separa:
#       std::cout << " es menor";
	li	$v0,4
	la	$a0,strMenorMedia
	syscall

#     }
if_separa_fin:

#     std::cout << " que la media\n"; NO SE HACE!!!!!!!!!!!!!
#   }

	addi	$s2,$s2,1
	b	for_separa
for_separa_fin:

# }
separa_salida:

	# POP: $ra, $s0, $s1, $s2, $f20, $f22
	lw	$ra,0($sp)
	lw	$s0,4($sp)
	lw	$s1,8($sp)
	lw	$s2,12($sp)
	l.d	$f20,16($sp)
	l.d	$f22,24($sp)
	addi	$sp,$sp,32

	jr	$ra

separa_fin:
########################################################################
#  ↑↑↑↑↑ Debes codificar hasta aquí ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑


# ########################################################################
# int main() {
# int opcion → $s0
# double* vTrabajo → $s1
# int largoTrabajo → $s2
main:
	#   std::cout << "\nSepara Elementos Vector double Según Media\n";
	li	$v0,4
	la	$a0,strTitulo
	syscall

	#   while(true) {
while_true:

	#     std::cout << "\nElige vector 1, 2, 3 o 0 para terminar: ";
	li	$v0,4
	la	$a0,strElige
	syscall

	#     std::cin >> opcion;
	li	$v0,5
	syscall
	move	$s0,$v0

	#     if (opcion == 0) {
	#       break;
	#     }
	beqz	$s0,while_true_fin


	#     if ((opcion < 0) || (opcion > 3)) {
if_opcionValida:
	bltz	$s0,if_opcionValida_then
	ble	$s0,3,if_opcionValida_fin
if_opcionValida_then:
	#       std::cout << "Opción incorrecta";
	li	$v0,4
	la	$a0,strOpcionInc
	syscall

	#       continue;
	b	while_true
	#     }
if_opcionValida_fin:
	#     double* vTrabajo = v1;
	la	$s1,v1
	#     int largoTrabajo = v1Largo;
	lw	$s2,v1Largo
	#     if (opcion == 2) {
if_opcion2:
	bne	$s0,2,if_opcion2_fin
	#       vTrabajo = v2;
	la	$s1,v2
	#       largoTrabajo = v2Largo;
	lw	$s2,v2Largo
	#     }
if_opcion2_fin:

	#     if (opcion == 3) {
if_opcion3:
	bne	$s0,3,if_opcion3_fin
	#       vTrabajo = v3;
	la	$s1,v3
	#       largoTrabajo = v3Largo;
	lw	$s2,v3Largo
	#     }
if_opcion3_fin:

# ↓↓↓↓ Debes codificar a partir de aquí ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
# double* vTrabajo → $s1
# int largoTrabajo → $s2

	#     separa(vTrabajo, largoTrabajo);
	move	$a0,$s1
	move	$a1,$s2
	jal	separa

#  ↑↑↑↑↑ Debes codificar hasta aquí ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

	#   }
	b	while_true
while_true_fin:

	#   std::cout << "\nTermina el programa\n";
	li	$v0,4
	la	$a0,strTermina
	syscall

	# }
	li	$v0,10
	syscall
