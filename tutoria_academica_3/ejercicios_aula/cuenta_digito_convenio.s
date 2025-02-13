# /*
# Enunciado:
# Realizar un programa que cuente el número de veces que aparece un dígito en
# un número entero positivo.
# 
# Por ejemplo si el usuario introduce como numero el valor 12242 y como dígito el valor 2,
# debe imprimir por la pantalla el número 3 (que es las veces que aparece 2 en 12242).
# 
# Los pasos a seguir deben ser:
# 
# 1) Imprimir título
# 2) Pedir un número
# 3) Si el número es negativo salir del programa
# 4) Pedir un dígito. Si está fuera del rango de 0 a 9, volver a preguntar
# 5) Hace bucle que vaya obteniendo el dígito de las unidades, decenas, centenas.
#   Si coincide con el buscado, incrementar contador
# 6) Mostrar por pantalla el contador con mensaje adecuado
# 7) Volver al punto 2
# 8) Terminar el programa con un mensaje de despedida.
# 
# */
# 
# #include <iostream>
# int main() {
#   std::cout << "\nPrograma que cuenta el numero de veces que aparece un digito en numero entero positivo.\n";
# 
#   while (true) {
#     int numero;
#     std::cout << "\nIntroduzca un numero entero positivo (negativo para finalizar el programa): ";
#     std::cin >> numero;
#     if (numero < 0)
#       break;
# 
#     int digito;
#     do {
#       std::cout << "Introduzca un digito (0-9): ";
#       std::cin >> digito;
#     } while ((digito < 0) || (digito > 9));
#     int cuenta = 0;
#     do {
#       int resto = numero % 10;
#       numero /= 10;
#       if ( resto == digito )
#         cuenta++;
#     } while ( numero != 0 );
#     std::cout << "El numero de veces que aparece el digito en el numero es: "
#         << cuenta << '\n';
#   }
#   std::cout << "\nFin del programa.\n";
# }

        .data # Sección donde se encuentran los datos de nuestro programa
strTitulo:      .asciiz "\nPrograma que cuenta el numero de veces que aparece un digito en numero entero positivo.\n"
strIntroNum:    .asciiz "\nIntroduzca un numero entero positivo (negativo para finalizar el programa): "
strIntroDigito: .asciiz "Introduzca un digito (0-9): "
strNumero:      .asciiz "El numero de veces que aparece el digito en el numero es: "
strFin:         .asciiz "\nFin del programa.\n"
strSalto:	.asciiz "\n"

        .text # Sección que contiene el código del programa
######################################

# Tabla de relación entre variables y registros
# numero -> $s0
# digito -> $s1
# cuenta -> $s3
# resto  -> $t1

# Variable Extra
# valor_10 -> $s2

# int main() {
main:
#   std::cout << "\nPrograma que cuenta el numero de veces que aparece un digito en numero entero positivo.\n";
        li      $v0,4
        la      $a0,strTitulo
        syscall
# 
#   while (true) {
whileTrue:
        # Condición siempre se cumple, no hace falta ninguna instrucción

#     int numero;
#     std::cout << "\nIntroduzca un numero entero positivo (negativo para finalizar el programa): ";
        li      $v0,4
        la      $a0,strIntroNum
        syscall
#     std::cin >> numero;
        li      $v0,5
        syscall
        move    $s0,$v0

#     if (numero < 0)
ifNumero0:
        bltz    $s0,whileTrue_fin

#     int digito;
#     do {
do_while1:
#       std::cout << "Introduzca un digito (0-9): ";
	li	$v0,4
	la	$a0,strIntroDigito
	syscall
	
#       std::cin >> digito;
	li	$v0,5
	syscall
	move	$s1,$v0
	
#     } while ((digito < 0) || (digito > 9));
	bltz	$s1,do_while1
	bgt	$s1,9,do_while1

do_while1_fin:
#     int cuenta = 0;
	move	$s3,$zero
	li	$s2,10
#     do {
do_while2:
#       int resto = numero % 10;
	div	$s0,$s2
	mfhi	$t1 # Obtenemos el resto de la división (alojado en HI)
#       numero /= 10;
	div	$s0,$s0,$s2
#       if ( resto == digito )
ifRestoDigito:
	bne	$t1,$s1,ifRestoDigito_fin

ifRestoDigito_then:
#         cuenta++;
	add	$s3,$s3,1
	
ifRestoDigito_fin:
	
#     } while ( numero != 0 );
	beqz	$s0,do_while2_fin
	b	do_while2
	
do_while2_fin:
#     std::cout << "El numero de veces que aparece el digito en el numero es: "
	li	$v0,4
	la	$a0,strNumero
	syscall
	
#         << cuenta << '\n';
	li	$v0,1
	move	$a0,$s3
	syscall
	
	li	$v0,4
	la	$a0,strSalto
	syscall
#   }
	b	whileTrue
whileTrue_fin:
#   std::cout << "\nFin del programa.\n";
        li      $v0,4
        la      $a0,strFin
        syscall
# }
fin_programa:
        li      $v0,10
        syscall
