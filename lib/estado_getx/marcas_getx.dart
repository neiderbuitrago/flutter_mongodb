import 'package:flutter/material.dart';
import 'package:flutter_mongodb/modelos/marcas.dart';
import 'package:get/get.dart';

class EstadoMarcas extends GetxController {
  var nuevoEditar = true.obs;

  late MarcasGrupos marca = <MarcasGrupos>{}.obs as MarcasGrupos;
  late List<TextEditingController> controlador = <TextEditingController>[
    TextEditingController()
  ];
  late List<FocusNode> focusNode = <FocusNode>[FocusNode(), FocusNode()];
}
