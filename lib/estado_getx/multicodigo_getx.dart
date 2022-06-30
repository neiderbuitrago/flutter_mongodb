// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../modelos/multicodigo.dart';

class EstadoMulticodigos extends GetxController {
  var nuevoEditar = true;
  var nombreProducto = ''.obs;
  ObjectId idProducto = <ObjectId>{}.obs as ObjectId;
  var codigo = "".obs;
  Multicodigo multicodigo = <Multicodigo>{}.obs as Multicodigo;

  List<Multicodigo> lista = [];

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
  limpiarCampos() {
    controllerMulticodigo[0].text = nombreProducto.value;
    controllerMulticodigo[1].clean;
    controllerMulticodigo[2].clean;
    codigo.value = '0';
    focusnode[1].requestFocus();
  }
}
