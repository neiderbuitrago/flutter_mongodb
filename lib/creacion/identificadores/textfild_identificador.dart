import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../estado_getx/identificadores.dart';
import '../Productos/widget.dart';

class TextfildIdentificador extends StatefulWidget {
  const TextfildIdentificador({
    Key? key,
    this.guardarLosCambios,
    required this.labelText,
    required this.index,
  }) : super(key: key);

  final bool? guardarLosCambios;
  final String labelText;
  final int index;

  @override
  _TextfildIdentificadorState createState() => _TextfildIdentificadorState();
}

class _TextfildIdentificadorState extends State<TextfildIdentificador> {
  @override
  Widget build(BuildContext context) {
    EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();

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
          focusNode: estadoIdentificador.focusnode[widget.index],
          autofocus: (widget.index == 0) ? true : false,
          controller: estadoIdentificador.controllerIdentificador[widget.index],
          decoration: InputDecoration(
            suffixIconColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: (widget.index == 0)
                ? 'Serial, Fecha Vence, Lote, Color, Talla, etc'
                : '',
            labelText: widget.labelText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          ),
          inputFormatters: (widget.index > 1
              //permitir solo numeros y un punto
              ? [FilteringTextInputFormatter.allow(RegExp('[0-9-.]'))]
              : []),
          onChanged: (value) {},
          onSubmitted: (value) {
            //cambiar de foco
            if (widget.index == 3) {
              estadoIdentificador.focusnode[1].requestFocus();
            } else {
              estadoIdentificador.focusnode[widget.index + 1].requestFocus();
            }
          },
        ),
      ),
    );
  }
}
