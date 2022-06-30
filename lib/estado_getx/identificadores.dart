import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modelos/identificador.dart';

class EstadoIdentificador extends GetxController {
  late Map<int, IdentificadorDetalle> datosIdentificador =
      <int, IdentificadorDetalle>{}.obs;

  late List controllerIdentificador = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ].obs;
  late List focusnode = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ].obs;
//codigo del detalle
  bool nuevoEditar = true;

  late IdentificadorDetalle identificador =
      <IdentificadorDetalle>{}.obs as IdentificadorDetalle;
  double sumaTotales() {
    return datosIdentificador.values
        .fold(0, (sum, item) => sum + item.cantidad);
  }

  editarIdentificador(IdentificadorDetalle identificador) {
    controllerIdentificador[0].text = identificador.nombre;
    controllerIdentificador[1].text = identificador.identificador.toString();
    controllerIdentificador[2].text = identificador.cantidad.toString();
  }
}
