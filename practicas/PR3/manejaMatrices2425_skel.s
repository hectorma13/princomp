# #include <iostream>
# #include <iomanip>
# #include <cmath>

# const int MAXELTOS = 100;

# typedef struct {
#   int nFil;
#   int nCol;
#   float elementos[MAXELTOS];
# } structMat;


# structMat mat1 {
#   6,
#   6,
#   {
#     11.11, 12.12, 13.13, 14.14, 15.15, 16.16,
#     21.21, 22.22, 23.23, 24.24, 25.25, 26.26,
#     31.31, 32.32, 33.33, 34.34, 35.35, 36.36,
#     41.41, 42.42, 43.43, 44.44, 45.45, 46.46,
#     51.51, 52.52, 53.53, 54.54, 55.55, 56.56,
#     61.61, 62.62, 63.63, 64.64, 65.65, 66.66
#   }
# };

# structMat mat2 {
#   7,
#   10,
#   {
#     -36.886, -58.201,  78.671,  19.092, -50.781,  33.961, -59.511, 12.3125,
#     57.306,  -1.938, -86.858, -81.852,  54.623, -22.574,  88.217,  64.374,
#     52.875, 47.918, -83.549,  19.041, 4.255, -31.875,  82.526,  27.394,
#     56.527,  39.448,  18.429, 97.057,  76.933,  14.583, 67.79, -9.861,
#     -97.875,  32.369, -18.494, -43.392,  39.857, 87.65625, -31.875 , -17.786,
#     30.073,  87.65625,  -6.889,  64.601, -85.018,  70.559, -48.853, -62.627,
#     -60.147,  -5.524, 84.323, -51.718,  93.127, -10.757,  32.119, 98.3125,
#     69.471, 73.814,   3.724,  57.208, -41.528, -17.458, -64.226, -71.297,
#     -97.875,   7.095, -79.112, 33.819,  63.531, -96.181
#   }
# };

# structMat mat3 {
#   1,
#   8,
#   {
#     -36.52,  35.3 ,  79.05, -58.69, -55.23, -19.44, -88.63, -93.61
#   }
# };

# structMat mat4 {
#   16,
#   1,
#   { -90.57, -65.11, -58.21, -73.23, -89.38, -79.25,  16.82,  66.3 ,
#     -96.14, -97.16, -24.66,   5.27, -33.5 , -13.09,  27.13, -74.83 }
# };

# structMat mat5 {
#   1,
#   1,
#   { 78.98 }
# };

# structMat mat6 {
#   0,
#   0,
#   { 0 }
# };

# // Matriz de acceso libre para modificar
# structMat mat7 {
#   0,
#   0,
#   // Inicializamos los MAXELTOS primeros elementos a 0
#   { 0 }
# };

# int main() {
#   std::cout << std::fixed << std::setprecision(8);  // Ignorar
#   std::cout << "\nComienza programa manejo matrices\n";

#   structMat* matTrabajo = &mat1;
#   while(true) {
#     int numCol = matTrabajo->nCol;
#     int numFil = matTrabajo->nFil;
#     float* datos = matTrabajo->elementos;
#     std::cout << "\n\nLa matriz tiene dimension " << numFil<< 'x'
#               << numCol << '\n';
#     for(int f = 0; f < numFil; f++) {
#       for(int c = 0; c < numCol; c++) {
#         std::cout << datos[f*numCol + c] << ' ';
#       }
#       std::cout << '\n';
#     }
#     std::cout << '\n';
#     std::cout <<
#     "(0) Terminar el programa\n"
#     "(1) Cambiar la matriz de trabajo\n"
#     "(2) Definir matriz 7\n"
#     "(3) Cambiar un valor de la matriz\n"
#     "(7) Contar valores superiores a un umbral\n"
#     "\nIntroduce opción elegida: ";

#     int opcion;
#     std::cin >> opcion;


#     if(opcion == 0) {
#       break;
#     }

#     // Opción 1 ////////////////////////////////////////////////////////////
#     if(opcion == 1) {
#       std::cout << "\nElije la matriz de trabajo (1..7): ";
#       int matT;
#       std::cin >> matT;
#       switch(matT) {
#         case 1:
#           matTrabajo = &mat1;
#           break;
#         case 2:
#           matTrabajo = &mat2;
#           break;
#         case 3:
#           matTrabajo = &mat3;
#           break;
#         case 4:
#           matTrabajo = &mat4;
#           break;
#         case 5:
#           matTrabajo = &mat5;
#           break;
#         case 6:
#           matTrabajo = &mat6;
#           break;
#         case 7:
#           matTrabajo = &mat7;
#           break;
#         default:
#           std::cout << "Numero de matriz de trabajo incorrecto\n";
#           continue;  // volvemos al principio del bucle
#       }
#       continue;
#     }

#     // Opción 2: Definir matriz 7 //////////////////////////////////////////
#     if (opcion == 2) {
#       int nFil;
#       int nCol; // numero de columnas
#       std::cout << "Introduce el numero de filas: ";
#       std::cin >> nFil;
#       if (nFil < 1 || nFil > MAXELTOS) {
#         std::cout <<
#           "Error: dimension incorrecta.  Numero de filas incorrecto\n";
#         continue;  // volvemos al principio del bucle
#       }
#       std::cout << "Introduce el numero de columnas: ";
#       std::cin >> nCol;
#       if (nCol < 1 || nCol > MAXELTOS) {
#         std::cout <<
#           "Error: dimension incorrecta.  Numero de columnas incorrecto\n";
#         continue;  // volvemos al principio del bucle
#       }
#       if (nFil * nCol > MAXELTOS) {
#         std::cout << "Error: dimension incorrecta.  Demasiados elementos\n";
#         continue;  // volvemos al principio del bucle
#       }

#       // inicializa la matriz 7 con los valores introducidos
#       mat7.nFil = nFil;
#       mat7.nCol = nCol;
#       // solicitar los valores de los elementos de la matriz por filas
#       for(int f = 0; f < nFil; f++) {
#         for(int c = 0; c < nCol; c++) {
#           std::cout << "Introduce el elemento (" << f << ',' << c << "): ";
#           std::cin >> mat7.elementos[f * nCol + c];
#         }
#       }
#       continue;
#     }

#     // Opción 3  //////////////////////////////////////////////////////////
#     if(opcion == 3) {
#       std::cout << "\nIndice de fila: ";
#       int indFil;
#       std::cin >> indFil;
#       if ((indFil < 0) || (indFil >= numFil)) {
#         std::cout <<
#           "Error: dimension incorrecta.  Numero de fila incorrecto\n";
#         continue;  // volvemos al principio del bucle
#       }
#       std::cout << "Indice de columna: ";
#       int indCol;
#       std::cin >> indCol;
#       if ((indCol < 0) || (indCol >= numCol)){
#         std::cout <<
#           "Error: dimension incorrecta.  Numero de columna incorrecto\n";
#         continue;  // volvemos al principio del bucle
#       }
#       std::cout << "Nuevo valor para el elemento: ";
#       float valor;
#       std::cin >> valor;
#       // cambiar el valor de la matriz de trabajo en la posicion introducida
#       datos[indFil * numCol + indCol] = valor;
#       continue;
#     }

#     // Opción 7 ////////////////////////////////////////////////////////////
#     if(opcion == 7) {
#       std::cout << "Introduce el umbral: ";
#       float umbral;
#       std::cin >> umbral;
#       int contador = 0;
#       for(int f = 0; f < numFil; f++) {
#         for(int c = 0; c < numCol; c++) {
#           float valor = datos[f * numCol + c];
#           if (valor > umbral) {
#             contador++;
#           }
#         }
#       }
#       std::cout << "\nNumero de valores superiores al umbral: " << contador;

#       continue;
#     }

#     // Opción Incorrecta ///////////////////////////////////////////////////
#     std::cout << "Error: opcion incorrecta\n";
#   }
#   std::cout << "\nTermina el programa\n";
# }

MAXELTOS=100 # numero maximo de elemenos
nFil=0 # desplazamiento al campo filas
nCol=4 # desplazamiento al campo columnas
elementos=8 # desplazamiento datos matriz
sizeF=4 # numero de bytes que ocupa un flotante
  .data

mat1: .word 6
      .word 6
      .float 11.11, 12.12, 13.13, 14.14, 15.15, 16.16
      .float 21.21, 22.22, 23.23, 24.24, 25.25, 26.26
      .float 31.31, 32.32, 33.33, 34.34, 35.35, 36.36
      .float 41.41, 42.42, 43.43, 44.44, 45.45, 46.46
      .float 51.51, 52.52, 53.53, 54.54, 55.55, 56.56
      .float 61.61, 62.62, 63.63, 64.64, 65.65, 66.66

mat2: .word 7
      .word 10
      .float -36.886, -58.201, 78.671, 19.092, -50.781, 33.961, -59.511
      .float 12.3125, 57.306, -1.938, -86.858, -81.852,  54.623, -22.574
      .float 88.217, 64.374, 52.875, 47.918, -83.549,  19.041, 4.255, -31.875
      .float 82.526,  27.394, 56.527, 39.448,  18.429, 97.057,  76.933
      .float 14.583, 67.79, -9.861, -97.875, 32.369, -18.494, -43.392, 39.857 
      .float 87.65625, -31.875, -17.786, 30.073,  87.65625,  -6.889,  64.601
      .float -85.018,  70.559, -48.853, -62.627, -60.147,  -5.524, 84.323
      .float -51.718,  93.127, -10.757,  32.119, 98.3125, 69.471, 73.814
      .float 3.724,  57.208, -41.528, -17.458, -64.226, -71.297, -97.875
      .float 7.095, -79.112, 33.819,  63.531, -96.181

mat3:
      .word 1
      .word 8
      .float -36.52,  35.3 ,  79.05, -58.69, -55.23, -19.44, -88.63, -93.61

mat4:
      .word 16
      .word 1
      .float -90.57, -65.11, -58.21, -73.23, -89.38, -79.25,  16.82,  66.3
      .float -96.14, -97.16, -24.66,   5.27, -33.5 , -13.09,  27.13, -74.83

mat5:
      .word 1
      .word 1
      .float 78.98

mat6:
      .word 0
      .word 0
      .float 0.0

mat7: .word 0
      .word 0
      .space MAXELTOS*sizeF

titulo: .asciiz "\nComienza programa manejo matrices\n"
dimstr: .asciiz "\n\nLa matriz tiene dimension "
xstr:   .asciiz "x"
menu:   .ascii "(0) Terminar el programa\n"
        .ascii "(1) Cambiar la matriz de trabajo\n"
        .ascii "(2) Definir matriz 7\n"
        .ascii "(3) Cambiar un valor de la matriz\n"
        .ascii "(7) Contar valores superiores a un umbral\n"
        .asciiz "\nIntroduce opción elegida: ";
petmat: .asciiz "\nElije la matriz de trabajo (1..7): "
errmat: .asciiz "Numero de matriz de trabajo incorrecto\n"
petnf:  .asciiz "Introduce el numero de filas: ";
errnf:  .asciiz "Error: dimension incorrecta.  Numero de filas incorrecto\n"
petnc:  .asciiz "Introduce el numero de columnas: "
errnc:  .asciiz "Error: dimension incorrecta.  Numero de columnas incorrecto\n"
errmax: .asciiz "Error: dimension incorrecta.  Demasiados elementos\n"
petel:  .asciiz "Introduce el elemento (" 
petcom: .asciiz ","
petel2: .asciiz "): "
petfil: .asciiz "\nIndice de fila: "
errfil: .asciiz "Error: dimension incorrecta.  Numero de fila incorrecto\n" 
petcol: .asciiz "Indice de columna: "
errcol: .asciiz "Error: dimension incorrecta.  Numero de columna incorrecto\n"
petval: .asciiz "Nuevo valor para el elemento: "
petum:  .asciiz "Introduce el umbral: "
umbstr: .asciiz "\nNumero de valores superiores al umbral: "
erropc: .asciiz "Error: opcion incorrecta\n"
finstr: .asciiz "\nTermina el programa\n"

