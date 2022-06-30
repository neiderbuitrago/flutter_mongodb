// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../db/identificadores.dart';
import '../../estado_getx/getx_productos.dart';
import '../../estado_getx/identificadores.dart';
import '../../modelos/identificador.dart';
import '../venta_x_cantidad/widget.dart';
import '../widget.dart';

Padding guardar(
  BuildContext context,
  Function actualizar,
) {
  agregarALista({detalle}) {
    EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();

    estadoIdentificador.controllerIdentificador[1].text = '';
    estadoIdentificador.controllerIdentificador[2].text = '';

    actualizar();
  }

  bool permitirGuardar = true;
  EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();
  return elevatedButtonGuardar1(
    context: context,
    focusNode: estadoIdentificador.focusnode[3],
    onPressed: () {
      if (estadoIdentificador.controllerIdentificador[0].text.isNotEmpty &&
          estadoIdentificador.controllerIdentificador[1].text.isNotEmpty &&
          estadoIdentificador.controllerIdentificador[2].text.isNotEmpty) {
        IdentificadorDetalle detalle = IdentificadorDetalle(
          id: estadoIdentificador.nuevoEditar
              ? ObjectId()
              : estadoIdentificador.identificador.id,
          idPadre: estadoIdentificador.identificador.idPadre,
          nombre: estadoIdentificador.controllerIdentificador[0].text,
          identificador:
              estadoIdentificador.controllerIdentificador[1].text.trim(),
          cantidad: comprovarSihayNumero(
              estadoIdentificador.controllerIdentificador[2].text),
        );
        if (estadoIdentificador.datosIdentificador.isNotEmpty) {
          //validar si es una edicion
          if (estadoIdentificador.nuevoEditar) {
            for (var element in estadoIdentificador.datosIdentificador.values) {
              if (element.identificador.toUpperCase() ==
                  (estadoIdentificador.controllerIdentificador[1].text)
                      .toUpperCase()) {
                permitirGuardar = false;
                break;
              }
            }
          }
        }
        //llenar los datos de detalle

        if (permitirGuardar) {
          agregarALista(detalle: detalle);
        } else {
          informarInferior(
              titleText: 'Error',
              messageText:
                  ('El identificador ${estadoIdentificador.controllerIdentificador[1].text}  ya existe'));
        }
        permitirGuardar = true;
      }
      estadoIdentificador.focusnode[1].requestFocus();
    },
  );
}

guardarIdentificadores() {
  EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  IdentificadorDetalle newIdentificador = IdentificadorDetalle(
    id: estadoIdentificador.nuevoEditar
        ? ObjectId()
        : estadoProducto.productoConsultado.id,
    idPadre: estadoProducto.productoConsultado.id,
    identificador: estadoIdentificador.controllerIdentificador[1].text,
    nombre: estadoIdentificador.controllerIdentificador[0].text,
    cantidad: estadoProducto.productoConsultado.cantidad,
  );

  if (estadoIdentificador.nuevoEditar) {
    IdentificadorDB.insertar(newIdentificador);
  } else {
    IdentificadorDB.actualizar(newIdentificador);
  }
}
