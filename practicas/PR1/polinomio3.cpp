// Programa para evaluar polinomio tercer grado

#include <iostream>
#include <iomanip>

int main(void) {
  std::cout << std::fixed << std::setprecision(8);  // Ignorar
  float a,b,c,d;
  std::cout << "\nEvaluacion polinomio f(x) = a x^3 + b x^2 + c x + d"
            << " en un intervalo [r,s]\n";
  std::cout << "\nIntroduzca coeficiente a: ";
  std::cin >> a;
  std::cout << "Introduzca coeficiente b: ";
  std::cin >> b;
  std::cout << "Introduzca coeficiente c: ";
  std::cin >> c;
  std::cout << "Introduzca coeficiente d: ";
  std::cin >> d;
  int r,s;
  do {
    std::cout << "\nLÃ­mite inferior r: ";
    std::cin >> r;
    std::cout << "LÃ­mite superior s: ";
    std::cin >> s;
  } while (r > s);

  for (int x = r ; x <= s ; x++) {
    // float f = x*x*x*a + x*x*b + x*c + d;
    float f = d;
    f += x*c;
    f += x*x*b;
    f += x*x*x*a;
    if (f >= 2.5) {
      std::cout << "\nf(" << x << ") = " << f;
    }
  }
  std::cout << "\n\nTermina el programa\n";
}
