import 'package:get/get.dart';
import '../estado_getx/combos_getx.dart';

int indiceReverse(int index) {
  final EstadoCombos estadoCombos = Get.find<EstadoCombos>();
  return (estadoCombos.controlleresCombosDetalle.length - 1) - index;
}
