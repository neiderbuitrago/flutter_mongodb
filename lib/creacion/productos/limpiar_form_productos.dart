import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../estado_getx/combos_getx.dart';
import '../../estado_getx/fracciones_getx.dart';
import '../../estado_getx/productos_getx.dart';
import '../../estado_getx/identificadores.dart';
import '../../estado_getx/venta_x_cantidad_getx.dart';
import '../../modelos/combo.dart';
import '../../modelos/presentacion.dart';

void limpiarTextos({required int index}) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();
  EstadoCombos estadoCombos = Get.find<EstadoCombos>();
  limpiar() {
    estadoProducto.manejaIdentificador.value = false;
    estadoProducto.manejaCombos.value = false;
    estadoProducto.manejaMulticodigos.value = false;
    estadoProducto.manejaVentaXPeso.value = false;
    estadoProducto.estadoDelProducto.value = true;
    estadoProducto.seleccionTipoProducto.value = 'Activo';
    estadoProducto.nuevoEditar.value = true;
  }

  if (index == 0) {
    for (var i = 0; i < estadoProducto.controladores.length; i++) {
      if (i != 2 && i != 3 && i != 4 && i != 17) {
        estadoProducto.controladores[i].clear();
      }
      limpiar();

      estadoProducto.sigienteCodigo();
    }
  } else {
    for (var i = 1; i < estadoProducto.controladores.length; i++) {
      if (i != 2 && i != 3 && i != 4 && i != 17) {
        estadoProducto.controladores[i].clear();
      }
    }

    estadoProducto.manejaVentaFraccionada.value = false;
    estadoProducto.manejaVentaXCantidad.value = false;
    limpiar();

    estadoCombos.tituloCombos.value = '';
    estadoCombos.codigoCombo.value = ObjectId();
    estadoProducto.nombreComboSeleccionado.value = '';
    estadoProducto.comboSeleccionado = Combos.defecto();
    estadoIdentificador.mapIdentificador.clear();
    estadoProducto.presentacionSeleccionada = Presentacion.defecto();
  }
}

limpiarVentaXCantidad() {
  EstadoVentaXCantidad estado = Get.find<EstadoVentaXCantidad>();
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  estado.nuevoEditar.value = true;
  for (var element in estado.controladoresVentaXCantidad) {
    element.clear();
  }
  estadoProducto.manejaVentaXCantidad.value = false;
}
