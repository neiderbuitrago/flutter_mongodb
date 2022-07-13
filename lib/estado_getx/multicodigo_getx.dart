// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/estado_getx/productos_getx.dart';
import 'package:get/get.dart';

import 'package:mongo_dart/mongo_dart.dart';

import '../db/multicodigo.dart';
import '../modelos/multicodigo.dart';

class EstadoMulticodigos extends GetxController {
  var context;
  var nuevoEditar = true;
  var nombreProducto = ''.obs;

  late Multicodigo multicodigo = {}.obs as Multicodigo;

  List<Multicodigo> listaMulticodigos = <Multicodigo>[].obs;

  late List controllerMulticodigo = [
    TextEditingController(text: nombreProducto.value),
    TextEditingController(),
    TextEditingController()
  ].obs;
  late List focusnode = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ].obs;

  consultarMulticodigos(String codigo) {
    EstadoProducto estadoProducto = Get.find<EstadoProducto>();
    MulticodigoDB.getParametro(
      estadoProducto.productoConsultado.id,
    ).then((value) {
      if (value != null) {
        listaMulticodigos = Multicodigo.fromMapList(value);
        update();
      }
    });
  }

  guardarMulticodigo() {
    EstadoProducto estadoProducto = Get.find<EstadoProducto>();
    EstadoMulticodigos estado = Get.find<EstadoMulticodigos>();
    Multicodigo multicodigoGuardar = Multicodigo(
      id: (estado.nuevoEditar) ? ObjectId() : estado.multicodigo.id,
      codigo: (estado.controllerMulticodigo[1].text).toString().toUpperCase(),
      idProducto: estadoProducto.productoConsultado.id,
      detalle: estado.controllerMulticodigo[2].text,
      sincronizado: '',
    );

    if (estado.nuevoEditar) {
      MulticodigoDB.insertar(multicodigoGuardar).then(
        (value) {
          limpiarCampos();
          consultarMulticodigos('');
        },
      );
    } else {
      MulticodigoDB.actualizar(multicodigoGuardar).then(
        (value) {
          limpiarCampos();
          consultarMulticodigos('');
        },
      );
    }
  }

  editarMulticodigo(Multicodigo codigo) {
    nuevoEditar = false;
    multicodigo = codigo;
    controllerMulticodigo[1].text = codigo.codigo;
    controllerMulticodigo[2].text = codigo.detalle;
    focusnode[1].requestFocus();
  }

  limpiarCampos() {
    nuevoEditar = true;
    controllerMulticodigo[0].text = nombreProducto.value;
    controllerMulticodigo[1].text = '';
    controllerMulticodigo[2].text = '';
    focusnode[1].requestFocus();
    update();
  }

  eliminar(Multicodigo multicodigo) {
    MulticodigoDB.eliminar(multicodigo);
    limpiarCampos();
    consultarMulticodigos('');
  }
}
