// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../db/identificadores.dart';
import '../../estado_getx/productos_getx.dart';
import '../../estado_getx/identificadores.dart';
import '../../funciones_generales/numeros.dart';
import '../../modelos/identificador.dart';
import '../widget.dart';

Padding guardar(
  BuildContext context,
  Function actualizar,
) {
  EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();

  limpiarDatos() {
    estadoIdentificador.controllerIdentificador[1].clear();
    estadoIdentificador.controllerIdentificador[2].clear();
    estadoIdentificador.focusnode[1].requestFocus();
    estadoIdentificador.nuevoEditar.value = true;
    consultarDatos(actualizar);
  }

  return elevatedButtonGuardar1(
      context: context,
      focusNode: estadoIdentificador.focusnode[3],
      onPressed: () {
        if (estadoIdentificador.controllerIdentificador[0].text.isNotEmpty &&
            estadoIdentificador.controllerIdentificador[1].text.isNotEmpty) {
          IdentificadorDetalle detalleGuardar = IdentificadorDetalle(
            id: estadoIdentificador.nuevoEditar.value
                ? ObjectId()
                : estadoIdentificador.identificadorConsultado.id,
            idPadre: estadoProducto.productoConsultado.id,
            nombre: estadoIdentificador.controllerIdentificador[0].text,
            identificador:
                estadoIdentificador.controllerIdentificador[1].text.trim(),
            cantidad: numeroDecimal(
                estadoIdentificador.controllerIdentificador[2].text),
          );

          //validar si es una edicion

          if (estadoIdentificador.nuevoEditar.value) {
            IdentificadorDB.insertar(detalleGuardar).then((value) {
              limpiarDatos();
            });
          } else {
            IdentificadorDB.actualizar(detalleGuardar).then((value) {
              limpiarDatos();
            });
          }

          // } else {
          //   informarInferior(
          //       titleText: 'Error',
          //       messageText:
          //           ('El identificador ${estadoIdentificador.controllerIdentificador[1].text}  ya existe'));
          // }

        }
      });
}

consultarDatos(Function actualizar) async {
  EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  estadoIdentificador.mapIdentificador.clear();
  var value =
      await IdentificadorDB.getParametro(estadoProducto.productoConsultado.id);
  print(value);
  if (value != null) {
    estadoIdentificador.mapIdentificador = value;
  }
  actualizar();
}
