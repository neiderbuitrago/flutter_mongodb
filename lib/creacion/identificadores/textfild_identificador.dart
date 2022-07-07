// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mongodb/creacion/identificadores/widget.dart';
import 'package:flutter_mongodb/db/identificadores.dart';
import 'package:flutter_mongodb/estado_getx/productos_getx.dart';
import 'package:get/get.dart';

import '../../estado_getx/identificadores.dart';

textfildIdentificador({
  required String labelText,
  required int index,
  required Function actualizar,
}) {
  EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();

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
        focusNode: estadoIdentificador.focusnode[index],
        autofocus: (index == 0) ? true : false,
        controller: estadoIdentificador.controllerIdentificador[index],
        decoration: InputDecoration(
          suffixIconColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: (index == 0)
              ? 'Serial, Fecha Vence, Lote, Color, Talla, etc'
              : '',
          labelText: labelText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        ),
        inputFormatters: (index == 2
            //permitir solo numeros y un punto
            ? [FilteringTextInputFormatter.allow(RegExp('[0-9-.]'))]
            : []),
        onChanged: (value) {
          if (index == 1) {
            if (value.isEmpty) {
              consultarDatos(actualizar);
            }
          }
        },
        onSubmitted: (value) {
          //cambiar de foco
          if (index == 3) {
            estadoIdentificador.focusnode[1].requestFocus();
          } else {
            if (index == 1) {
              IdentificadorDB.getIdentificador(
                idPadre: estadoProducto.productoConsultado.id,
                identificador: value,
              ).then((value) {
                if (value != null) {
                  estadoIdentificador.mapIdentificador = value;
                  actualizar();
                }
              });
            }

            estadoIdentificador.focusnode[index + 1].requestFocus();
          }
        },
      ),
    ),
  );
}
