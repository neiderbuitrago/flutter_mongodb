// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mongodb/db/combo.dart';

import 'package:get/get.dart';

import '../../estado_getx/combos_getx.dart';
import '../../funciones_generales/numeros.dart';
import '../../modelos/combo.dart';
import '../validation_function.dart';

class TexfieldCombos extends StatefulWidget {
  const TexfieldCombos({
    Key? key,
    this.guardarLosCambios,
    required this.labelText,
    required this.index,
  }) : super(key: key);

  final bool? guardarLosCambios;
  final String labelText;
  final int index;

  @override
  _TexfieldCombosState createState() => _TexfieldCombosState();
}

class _TexfieldCombosState extends State<TexfieldCombos> {
  @override
  Widget build(BuildContext context) {
    EstadoCombos estadoCombos = Get.find<EstadoCombos>();
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
          autofocus: (widget.index == 0) ? true : false,
          controller: estadoCombos.controlleresCombosDetalle[widget.index],
          decoration: InputDecoration(
            suffix: (widget.index == 0)
                ? InkWell(
                    onTap: () {
                      estadoCombos.crearOEditarCombo();
                    },
                    child: Obx(() => Icon(
                          (estadoCombos.detalleCombosNombresCombos.value
                              ? Icons.close
                              : Icons.search),
                          color: Colors.primaries[indiceReverse(widget.index) %
                              Colors.primaries.length],
                        )))
                : null,
            suffixIconColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: widget.labelText,
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey[400],
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          ),
          inputFormatters: (widget.index > 1)
              ? [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))]
              : [],
          onChanged: (widget.index > 0)
              ? (value) {
                  print(widget.index);
                  print(indiceReverse(widget.index));
                  double cantidad =
                      numeroDecimal((value.isEmpty) ? "0" : value);
                  estadoCombos.combosDetalleAux[widget.index - 1].cantidad =
                      cantidad;
                  //  .update("cantidad", (value) => cantidad);
                }
              : (widget.index == 0)
                  ? (value) {
                      ComboDB.getParametro(
                              estadoCombos.controlleresCombosDetalle[0].text)
                          .then((value) {
                        if (value != null) {
                          estadoCombos.listaCombosFiltrados =
                              Combos.fromMapList(value);
                        }
                      });
                    }
                  : (value) {},
          onTap: () {
            print(" numero de controlleres: ${widget.index}");
          },
        ),
      ),
    );
  }
}
