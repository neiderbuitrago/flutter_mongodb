import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EstadoVentaXCantidad extends GetxController {
  List<TextEditingController> controladoresVentaXCantidad =
      <TextEditingController>[
    for (var i = 0; i < 16; i++) TextEditingController()
  ].obs;
  List<FocusNode> focusNode = <FocusNode>[].obs;

  var nuevoEditar = true.obs;
  late Map<int, bool> datosValidosVentaXCantidad = {
    1: true,
    4: true,
    5: true,
    8: true,
    9: true,
    12: true,
    13: true,
  }.obs;
  List camposTitulo = [
    'Desde',
    'Hasta',
    'Precio unitario',
    'Utilidad % ',
  ];
  changeValue(int key, bool value) {
    datosValidosVentaXCantidad[key] = value;
    datosValidosVentaXCantidad.forEach((key, value) {});
  }
}
