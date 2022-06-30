import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../estado_getx/combos_getx.dart';
import '../../estado_getx/fracciones_getx.dart';
import '../../estado_getx/getx_productos.dart';
import '../../estado_getx/identificadores.dart';
import '../../estado_getx/venta_x_cantidad_getx.dart';

void limpiarTextos({required int index}) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();
  EstadoVentaXCantidad estadoVentaXCantidad = Get.find<EstadoVentaXCantidad>();
  EstadoVentaFraccionada estadoVentaFraccionada =
      Get.find<EstadoVentaFraccionada>();
  EstadoCombos estadoCombos = Get.find<EstadoCombos>();

  if (index == 0) {
    for (var i = 0; i < estadoProducto.controladores.length; i++) {
      estadoProducto.controladores[i].clear();
    }
  } else {
    for (var i = 1; i < estadoProducto.controladores.length; i++) {
      estadoProducto.controladores[i].clear();
    }
  }
  estadoIdentificador.datosIdentificador.clear();
  estadoProducto.manejaVentaFraccionada.value = false;
  estadoProducto.manejaVentaXCantidad.value = false;
  estadoProducto.manejaIdentificador.value = false;
  estadoProducto.manejaCombos.value = false;
  estadoProducto.manejaMulticodigos.value = false;
  estadoProducto.manejaVentaXPeso.value = false;
  estadoProducto.estadoDelProducto.value = true;

  estadoProducto.seleccionTipoProducto.value = 'Activo';

//  limpiarControlador(estadoIdentificador.controllerIdentificador);
  limpiarControlador(estadoVentaXCantidad.controladoresVentaXCantidad);
  limpiarControlador(estadoVentaFraccionada.controladoresFraccion);
  estadoCombos.tituloCombos.value = '';
  estadoCombos.codigoCombo.value = ObjectId();
  estadoProducto.nombreComboSeleccionado.value = '';
  estadoProducto.idComboSeleccionado.value = 0;
  //
  estadoIdentificador.datosIdentificador.clear();
}

limpiarControlador(List controladores) {
  for (var element in controladores) {
    element.clear();
  }
}
