import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../db/tarifa_impuestos.dart';
import '../modelos/tarifa_impuestos.dart';

class EstadoTarImpuestos extends GetxController {
  var nuevoEditar = true.obs;

  late Impuesto impuesto = <Impuesto>{}.obs as Impuesto;
  late List<TextEditingController> controlador = <TextEditingController>[
    TextEditingController(),
    TextEditingController()
  ];
  late List<FocusNode> focusNode = <FocusNode>[
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];

  var listaImpuestos = <Map<String, dynamic>>[].obs;

  Future getFilterList(String filter) async {
    return await TarifaImpuestosDB.getParametro(filter)
        .then((value) => listaImpuestos.value = value);
  }
}
