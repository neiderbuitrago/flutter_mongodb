import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../estado_getx/multicodigo_getx.dart';
import '../widget.dart';

class TextfildMulticodigo extends StatefulWidget {
  const TextfildMulticodigo({
    Key? key,
    this.guardarLosCambios,
    required this.labelText,
    required this.index,
  }) : super(key: key);

  final bool? guardarLosCambios;
  final String labelText;
  final int index;

  @override
  _TextfildMulticodigoState createState() => _TextfildMulticodigoState();
}

class _TextfildMulticodigoState extends State<TextfildMulticodigo> {
  @override
  Widget build(BuildContext context) {
    EstadoMulticodigos estadoMulticodigo = Get.find<EstadoMulticodigos>();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // ignore: dead_code
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        child: TextField(
          readOnly: (widget.index == 0) ? true : false,
          focusNode: estadoMulticodigo.focusnode[widget.index],
          autofocus: (widget.index == 1) ? true : false,
          controller: estadoMulticodigo.controllerMulticodigo[widget.index],
          decoration: InputDecoration(
            suffixIconColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: widget.labelText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          ),
          onChanged: (widget.index == 2)
              ? (value) {
                  estadoMulticodigo.controllerMulticodigo[0].text =
                      '${estadoMulticodigo.nombreProducto.value} $value';
                }
              : null,
          onSubmitted: (value) {
            //cambiar de foco
            if (widget.index == 3) {
              estadoMulticodigo.focusnode[1].requestFocus();
            } else {
              estadoMulticodigo.focusnode[widget.index + 1].requestFocus();
            }
          },
        ),
      ),
    );
  }
}
