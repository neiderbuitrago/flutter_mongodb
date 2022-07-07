import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../estado_getx/combos_getx.dart';
import '../../estado_getx/fracciones_getx.dart';
import '../../estado_getx/productos_getx.dart';
import '../../estado_getx/identificadores.dart';
import '../../estado_getx/venta_x_cantidad_getx.dart';
import '../../modelos/combo.dart';

void limpiarTextos({required int index}) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();
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

  estadoProducto.manejaVentaFraccionada.value = false;
  estadoProducto.manejaVentaXCantidad.value = false;
  estadoProducto.manejaIdentificador.value = false;
  estadoProducto.manejaCombos.value = false;
  estadoProducto.manejaMulticodigos.value = false;
  estadoProducto.manejaVentaXPeso.value = false;
  estadoProducto.estadoDelProducto.value = true;
  estadoProducto.seleccionTipoProducto.value = 'Activo';
//  limpiarControlador(estadoIdentificador.controllerIdentificador);
  estadoCombos.tituloCombos.value = '';
  estadoCombos.codigoCombo.value = ObjectId();
  estadoProducto.nombreComboSeleccionado.value = '';
  estadoProducto.comboSeleccionado = Combos.defecto();
  estadoIdentificador.mapIdentificador.clear();
}

limpiarFracciones() {
  EstadoVentaFraccionada estadoFracciones = Get.find<EstadoVentaFraccionada>();
  estadoFracciones.nuevoEditar.value = true;
  for (var element in estadoFracciones.controladoresFraccion) {
    element.clear();
  }
}

limpiarVentaXCantidad() {
  EstadoVentaXCantidad estado = Get.find<EstadoVentaXCantidad>();
  estado.nuevoEditar.value = true;
  for (var element in estado.controladoresVentaXCantidad) {
    element.clear();
  }
}
