import 'package:flutter/material.dart';

Future<dynamic> informarFlotante({
  required BuildContext context,
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
                textos('No se puede guardar'),
                const SizedBox(
                  height: 10,
                ),
                textos(texto),
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

Text textos(String texto) {
  return Text(
    texto,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}
