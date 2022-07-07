// ignore_for_file: avoid_print

import 'package:flutter_mongodb/creacion/productos/limpiar_form_productos.dart';
import 'package:flutter_mongodb/creacion/venta_x_cantidad/widget.dart';
import 'package:flutter_mongodb/db/combo.dart';
import 'package:flutter_mongodb/db/marcas_mongo.dart';
import 'package:flutter_mongodb/db/productos_mongo.dart';
import 'package:flutter_mongodb/db/venta_x_cantida_mongo.dart';
import 'package:flutter_mongodb/modelos/combo.dart';
import 'package:flutter_mongodb/modelos/fracciones.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../db/fracciones.dart';
import '../../db/grupos_mongo.dart';
import '../../db/tarifa_impuestos_mongo.dart';
import '../../estado_getx/fracciones_getx.dart';
import '../../estado_getx/productos_getx.dart';
import '../../estado_getx/venta_x_cantidad_getx.dart';
import '../../funciones_generales/numeros.dart';
import '../../modelos/productos.dart';
import '../../modelos/venta_x_cantidad.dart';

llenarDatos({
  required String codigo,
}) async {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  // EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();
  var controladores = estadoProducto.controladores;
  Productos producto;
  ProductosDB.getcodigo(codigo).then(
    (value) {
      (value != null)
          ? {
              producto = Productos.fromMap(value[0]),
              estadoProducto.productoConsultado = producto,
              estadoProducto.nuevoEditar.value = false,
              estadoProducto.controladores[0].text = producto.codigo,

              controladores[1].text = producto.nombre,
              MarcaDB.getId(producto.marcaId).then((value1) {
                if (value1 != null) {
                  estadoProducto.guardarIdMarcaGrupoImpuesto(
                      index: 2, value: value1[0]);
                }
              }),
              GruposDB.getId(producto.grupoId).then((value1) {
                if (value1 != null) {
                  estadoProducto.guardarIdMarcaGrupoImpuesto(
                      index: 3, value: value1[0]);
                }
              }),
              TarifaImpuestosDB.getId(producto.impuestoId).then((value1) {
                if (value1 != null) {
                  estadoProducto.guardarIdMarcaGrupoImpuesto(
                      index: 4, value: value1[0]);
                }
              }),
              controladores[5].text = producto.precioCompra.toString(),
              controladores[6].text = producto.cantidad.toString(),
              controladores[7].text = producto.bodega1.toString(),
              controladores[8].text = producto.bodega2.toString(),
              controladores[9].text = producto.bodega3.toString(),
              controladores[10].text = producto.bodega4.toString(),
              controladores[11].text = producto.bodega5.toString(),
              controladores[12].text = producto.precioVenta1.toString(),
              controladores[13].text = producto.precioVenta2.toString(),
              controladores[14].text = producto.precioVenta3.toString(),
              controladores[15].text = producto.cantidadMinima.toString(),
              controladores[16].text = producto.cantidadMaxima.toString(),
              controladores[17].text = producto.presentacionId.toString(),
              controladores[18].text = producto.comision.toString(),
              controladores[19].text = producto.descuentoPorcentaje.toString(),
              controladores[20].text = producto.descuentoValor.toString(),
              controladores[21].text = producto.ubicacion.toString(),
              estadoProducto.manejaVentaFraccionada.value =
                  producto.manejaFracciones,
              estadoProducto.manejaVentaXCantidad.value =
                  producto.manejaVentaXCantidad,
              estadoProducto.manejaIdentificador.value =
                  producto.manejaIdentificador,
              estadoProducto.manejaCombos.value = producto.manejaCombo,
              // ComboDB.getId(producto.comboId).then((value1) {
              //   if (value1 != null) {
              //     estadoProducto.comboSeleccionado = Combos.fromMap(value1[0]);
              //     estadoProducto.nombreComboSeleccionado.value =
              //         value1[0]['nombre'];

              //     estadoProducto.nuevoEditar.value = false;
              //   } else {
              //     estadoProducto.nombreComboSeleccionado.value = '';
              //     estadoProducto.comboSeleccionado = Combos.defecto();
              //   }
              // }),

              //
              estadoProducto.manejaMulticodigos.value =
                  producto.manejaMulticodigo,
              estadoProducto.manejaVentaXPeso.value = producto.pesado,
              estadoProducto.estadoDelProducto.value = producto.activoInactivo,
              estadoProducto.seleccionTipoProducto.value =
                  producto.tipoProducto,
            }
          : {
              limpiarTextos(index: 1),
              print("No se encontro el producto"),
            };
    },
  );
}

llenarFracciones(ObjectId id) {
  EstadoVentaFraccionada estadoFracciones = Get.find<EstadoVentaFraccionada>();
  List controlador = estadoFracciones.controladoresFraccion;
  FraccionesDB.getId(id).then((value1) {
    if (value1 != null) {
      var fraccion = Fracciones.fromMap(value1[0]);
      estadoFracciones.fraccionesConsultadas = fraccion;
      estadoFracciones.nuevoEditar.value = false;
      controlador[0].text = enBlancoSiEsCero(fraccion.cantidadXEmpaque);
      controlador[1].text = fraccion.nombre1;
      controlador[2].text = enBlancoSiEsCero(fraccion.cantidadDescontar1);
      controlador[3].text = enBlancoSiEsCero(fraccion.precio1);
      controlador[5].text = fraccion.nombre2;
      controlador[6].text = enBlancoSiEsCero(fraccion.cantidadDescontar2);
      controlador[7].text = enBlancoSiEsCero(fraccion.precio2);
      controlador[9].text = fraccion.nombre3;
      controlador[10].text = enBlancoSiEsCero(fraccion.cantidadDescontar3);
      controlador[11].text = enBlancoSiEsCero(fraccion.precio3);
      controlador[13].text = fraccion.nombre4;
      controlador[14].text = enBlancoSiEsCero(fraccion.cantidadDescontar4);
      controlador[15].text = enBlancoSiEsCero(fraccion.precio4);
      controlador[17].text = enBlancoSiEsCero(fraccion.cantidad);
      controlador[18].text = enBlancoSiEsCero(fraccion.bodega1);
      controlador[19].text = enBlancoSiEsCero(fraccion.bodega2);
      controlador[20].text = enBlancoSiEsCero(fraccion.bodega3);
      controlador[21].text = enBlancoSiEsCero(fraccion.bodega4);
      controlador[22].text = enBlancoSiEsCero(fraccion.bodega5);
      estadoFracciones.calcularGanancias();
    } else {
      for (var element in controlador) {
        element.text = '';
      }
      estadoFracciones.nuevoEditar.value = true;
    }
  });
}

llenarVentaXCantidad(ObjectId id) {
  EstadoVentaXCantidad estadoVentaXCantidad = Get.find<EstadoVentaXCantidad>();
  List controlador = estadoVentaXCantidad.controladoresVentaXCantidad;
  VentaXCantidadDB.getId(id).then(
    (value1) {
      if (value1 != null) {
        estadoVentaXCantidad.nuevoEditar.value = false;
        VentaXCantidad valor = VentaXCantidad.fromMap(value1[0]);
        controlador[0].text = enBlancoSiEsCero(valor.desde1);
        controlador[1].text = enBlancoSiEsCero(valor.hasta1);
        controlador[2].text = enBlancoSiEsCero(valor.precio1);
        controlador[4].text = enBlancoSiEsCero(valor.desde2);
        controlador[5].text = enBlancoSiEsCero(valor.hasta2);
        controlador[6].text = enBlancoSiEsCero(valor.precio2);
        controlador[8].text = enBlancoSiEsCero(valor.desde3);
        controlador[9].text = enBlancoSiEsCero(valor.hasta3);
        controlador[10].text = enBlancoSiEsCero(valor.precio3);
        controlador[12].text = enBlancoSiEsCero(valor.desde4);
        controlador[13].text = enBlancoSiEsCero(valor.hasta4);
        controlador[14].text = enBlancoSiEsCero(valor.precio4);
        calcularGananciasVentaXcantidad();
      } else {
        for (var element in controlador) {
          element.text = '';
        }
        estadoVentaXCantidad.nuevoEditar.value = true;
      }
    },
  );
}

// llenarIdentificador(producto.manejaIdentificador)
//                 {
//                   estadoIdentificador.mapIdentificador.clear();
//                   IdentificadorDB.getId(
//                     producto.id,
//                   ).then((identificador) {
//                     if (identificador != null) {
//                       estadoIdentificador.mapIdentificador = identificador;
//                     }
//                   })
//                 },