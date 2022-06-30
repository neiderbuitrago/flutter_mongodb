import 'package:flutter_mongodb/estado_getx/multicodigo_getx.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../db/multicodigo.dart';
import '../../modelos/multicodigo.dart';

guardarMulticodigo() {
  EstadoMulticodigos estado = Get.find<EstadoMulticodigos>();
  Multicodigo multicodigoGuardar = Multicodigo(
    id: (estado.nuevoEditar) ? ObjectId() : estado.multicodigo.id,
    codigo: estado.codigo.value,
    idProducto: estado.idProducto,
    detalle: estado.controllerMulticodigo[2].text,
    sincronizado: '0',
  );

  if (estado.nuevoEditar) {
    MulticodigoDB.insertar(multicodigoGuardar);
  } else {
    MulticodigoDB.actualizar(multicodigoGuardar);
  }
}

editarMulticodigo(codigo) {
  EstadoMulticodigos estado = Get.find<EstadoMulticodigos>();
  estado.nuevoEditar = false;
  estado.codigo.value = codigo;
  estado.multicodigo = codigo;
  estado.controllerMulticodigo[1].text = codigo.codigo;
  estado.controllerMulticodigo[2].text = codigo.detalle;
  estado.focusnode[1].requestFocus();
}
