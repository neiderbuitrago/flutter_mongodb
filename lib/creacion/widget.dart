// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/productos_mongo.dart';

import 'package:get/get.dart';

Future<int> nuevoCodigostring() async {
  int codigo = 1;
  var codigos = await ProductosDB.getcodigoAll();

  if (codigos != null) {
    List listaCodigos = codigos.map((e) => e["codigo"]).toList();
    print(listaCodigos);
    for (var i = 1; i <= codigos.length; i++) {
      if (listaCodigos.contains(i.toString())) {
        codigo++;
      } else {
        break;
      }
    }
  } else {
    codigo = 1;
  }

  return codigo;
}

Future<dynamic> confirmacionEliminar({
  required BuildContext context,
  required String valor,
  required String texto,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: 350,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textos('¿Esta seguro?'),
                const SizedBox(
                  height: 10,
                ),
                textos(texto),
                textos(valor),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton.extended(
                      label: const Text('Cancelar',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    FloatingActionButton.extended(
                      label: const Text(
                        'Aceptar',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Text textos(String texto) {
  return Text(
    texto,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );
}

Padding elevatedButtonGuardar1({
  required BuildContext context,
  required onPressed,
  required FocusNode focusNode,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FloatingActionButton.extended(
      focusNode: focusNode,
      onPressed: onPressed,
      label: const Text(
        'Guardar',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: const Icon(
        Icons.save,
        color: Colors.white,
      ),
    ),
  );
}

class InformeFlotanteInferior extends StatelessWidget {
  const InformeFlotanteInferior({
    Key? key,
    required this.titleText,
    required this.messageText,
  }) : super(key: key);
  final String titleText;
  final String messageText;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content:
            informarInferior(titleText: titleText, messageText: messageText));
  }
}

informarInferior({required String titleText, required String messageText}) {
  Get.snackbar(
    '',
    '',
    titleText: Text(
      titleText,
      style: const TextStyle(color: Colors.black, fontSize: 20),
    ),
    messageText: Text(
      messageText,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    icon: const Icon(Icons.error),
    backgroundColor: const Color.fromARGB(255, 185, 243, 253),
    colorText: Colors.black,
    borderRadius: 20,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(100),
    duration: const Duration(seconds: 2),
    borderColor: Colors.black,
    borderWidth: 1,
    forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
    boxShadows: [
      BoxShadow(
        blurRadius: 20,
        // spreadRadius: 5.0,
        offset: const Offset(0, 48),
        color: Colors.black.withOpacity(0.2),
      ),
    ],
  );
}
