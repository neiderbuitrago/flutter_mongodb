import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../funciones_generales/numeros.dart';
import '../modelos/identificador.dart';

class EstadoIdentificador extends GetxController {
  List<IdentificadorDetalle> mapIdentificador = <IdentificadorDetalle>[].obs;

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
  var nuevoEditar = true.obs;

  var nombreProducto = ''.obs;

  late IdentificadorDetalle identificadorConsultado =
      <IdentificadorDetalle>{}.obs as IdentificadorDetalle;
//sumar las cantidades de los identificadores

  double sumaTotales() {
    return mapIdentificador.fold(0, (t, e) => t + e.cantidad);
  }

  editarIdentificador(IdentificadorDetalle identificador) {
    identificadorConsultado = identificador;
    nuevoEditar.value = false;
    controllerIdentificador[0].text = identificador.nombre;
    controllerIdentificador[1].text = identificador.identificador.toString();
    controllerIdentificador[2].text = enBlancoSiEsCero(identificador.cantidad);
  }
}
