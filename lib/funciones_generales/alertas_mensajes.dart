import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> informarFlotante({
  required BuildContext context,
  String? titulo,
  required String valor,
  required String texto,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetAnimationDuration: const Duration(milliseconds: 700),
        backgroundColor: Colors.white.withOpacity(0.88),
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
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 50,
                ),
                textos(titulo ?? 'No se puede guardar'),
                const SizedBox(
                  height: 10,
                ),
                Center(child: textos(texto)),
                textos(valor),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     FloatingActionButton.extended(
                //       label: const Text('Cancelar'),
                //       onPressed: () {
                //         Navigator.of(context).pop(false);
                //       },
                //     ),
                //     FloatingActionButton.extended(
                //       label: const Text('Aceptar'),
                //       onPressed: () {
                //         Navigator.of(context).pop(true);
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget alertaRedondeada() {
  return const AlertDialog(
    title: Text('Titulo'),
    content: Text('Contenido'),
  );
}

Text textos(String texto) {
  return Text(
    texto,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

Future<dynamic> dialogoEliminacion(
    BuildContext context, int i, List productosEnVentaLisreve) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: SizedBox(
          height: 350,
          // width: 180,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 200,
                    child: Image.asset(
                      "assets/delete.gif",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Opacity(
                        opacity: 1.0,
                        child: textButtonReusable(
                          () {
                            Navigator.of(context).pop(i);
                          },
                          Column(
                            children: [
                              const Text(
                                "Anular solo:",
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${productosEnVentaLisreve[i]["NProducto"]}",
                                style: const TextStyle(fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textButtonReusable(
                        () {
                          Navigator.of(context).pop("todo");
                        },
                        const Text(
                          "Anular todo",
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

TextButton textButtonReusable(
  VoidCallback onPressed,
  Widget titulo,
) {
  return TextButton(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shadowColor: Colors.blueAccent,
      elevation: 10,
      side: const BorderSide(
        color: Colors.blue,
        width: 0.5,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
    ),
    onPressed: onPressed,
    child: Padding(padding: const EdgeInsets.all(3.0), child: titulo),
  );
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
