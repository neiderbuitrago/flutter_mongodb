import 'package:flutter/material.dart';
import 'package:flutter_mongodb/modelos/marcas.dart';
import 'package:get/get.dart';

class EstadoGrupos extends GetxController {
  var nuevoEditar = true.obs;

  late MarcasGrupos grupo = <MarcasGrupos>{}.obs as MarcasGrupos;
  late List<TextEditingController> controlador =
      <TextEditingController>[TextEditingController()].obs;
  late List<FocusNode> focusNode = <FocusNode>[FocusNode(), FocusNode()];
}
