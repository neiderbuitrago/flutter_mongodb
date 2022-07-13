import 'package:flutter/material.dart';
import 'package:flutter_mongodb/modelos/presentacion.dart';
import 'package:get/get.dart';

class EstadoPresentacion extends GetxController {
  var nuevoEditar = true.obs;
  var check = false.obs;

  late Presentacion presentacion = <Presentacion>{}.obs as Presentacion;
  late List<TextEditingController> controlador = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
  ];
  late List<FocusNode> focusNode = <FocusNode>[
    for (var i = 0; i < 4; i++) FocusNode()
  ];
  limpiarCampos() {
    nuevoEditar.value = true;
    controlador[0].text = '';
    controlador[1].text = '';
    check.value = false;
  }

  editar(datos) {
    nuevoEditar.value = false;
    presentacion = Presentacion.fromMap(datos);
    controlador[0].text = presentacion.nombre;
    controlador[1].text = presentacion.simbolo;
    check.value = presentacion.visible;
  }
  // defecto(){
  //   PresentacionDB().defecto().then((value) {
  //     presentacion = value;
  //     controlador[0].text = presentacion.nombre;
  //     controlador[1].text = presentacion.simbolo;
  //     check.value = presentacion.visible;
  //   });
  // }
}
