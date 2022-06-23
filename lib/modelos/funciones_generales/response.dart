import 'package:flutter/material.dart';

class AnchoDePantalla {
  late BuildContext context;
  late double ancho;
  late double alto;
  late double altoteclado;
  late double anchoLista;

  AnchoDePantalla({
    required this.context,
    required this.ancho,
    required this.alto,
    required this.altoteclado,
    required this.anchoLista,
  });
}

anchoPantalla(context) {
  double ancho = MediaQuery.of(context).size.width;
  double alto = MediaQuery.of(context).size.height;
  AnchoDePantalla anchoDePantalla = AnchoDePantalla(
    context: context,
    ancho: ancho,
    alto: alto,
    altoteclado: MediaQuery.of(context).viewInsets.bottom,
    anchoLista: (ancho <= 500)
        ? ancho - 100
        : (ancho > 500 && ancho < 800)
            ? 450
            : (ancho > 800 && ancho < 1200)
                ? 600
                : 750,
  );
  return anchoDePantalla;
}
