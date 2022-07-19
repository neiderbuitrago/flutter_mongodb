// ignore_for_file: avoid_print

import 'package:flutter_mongodb/creacion/productos/limpiar_form_productos.dart';
import 'package:flutter_mongodb/creacion/venta_x_cantidad/widget.dart';
import 'package:flutter_mongodb/db/marcas_mongo.dart';
import 'package:flutter_mongodb/db/presentacion.dart';
import 'package:flutter_mongodb/db/productos_mongo.dart';
import 'package:flutter_mongodb/db/venta_x_cantida_mongo.dart';
import 'package:flutter_mongodb/modelos/fracciones.dart';

import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../db/combo.dart';
import '../../db/fracciones.dart';
import '../../db/grupos_mongo.dart';
import '../../db/tarifa_impuestos_mongo.dart';
import '../../estado_getx/fracciones_getx.dart';
import '../../estado_getx/productos_getx.dart';
import '../../estado_getx/venta_x_cantidad_getx.dart';
import '../../funciones_generales/numeros.dart';
import '../../modelos/combo.dart';
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
                } else {
                  estadoProducto.controladores[2].text = '';
                }
              }),
              GruposDB.getId(producto.grupoId).then((value1) {
                if (value1 != null) {
                  estadoProducto.guardarIdMarcaGrupoImpuesto(
                      index: 3, value: value1[0]);
                } else {
                  estadoProducto.controladores[3].text = '';
                }
              }),
              TarifaImpuestosDB.getId(producto.impuestoId).then((value1) {
                if (value1 != null) {
                  estadoProducto.guardarIdMarcaGrupoImpuesto(
                      index: 4, value: value1[0]);
                } else {
                  estadoProducto.controladores[3].text = '';
                }
              }),
              controladores[5].text = quitarDecimales(producto.precioCompra),
              controladores[6].text = quitarDecimales(producto.cantidad),
              controladores[7].text = quitarDecimales(producto.bodega1),
              controladores[8].text = quitarDecimales(producto.bodega2),
              controladores[9].text = quitarDecimales(producto.bodega3),
              controladores[10].text = quitarDecimales(producto.bodega4),
              controladores[11].text = quitarDecimales(producto.bodega5),
              controladores[12].text = quitarDecimales(producto.precioVenta1),
              controladores[13].text = quitarDecimales(producto.precioVenta2),
              controladores[14].text = quitarDecimales(producto.precioVenta3),
              controladores[15].text = quitarDecimales(producto.cantidadMinima),
              controladores[16].text = quitarDecimales(producto.cantidadMaxima),
              PresentacionDB.getId(producto.presentacionId).then((value1) {
                if (value1 != null) {
                  estadoProducto.guardarIdPresentacion(
                      index: 17, value: value1[0]);
                }
              }),
              controladores[18].text = quitarDecimales(producto.comision),
              controladores[19].text =
                  quitarDecimales(producto.descuentoPorcentaje),
              controladores[20].text = quitarDecimales(producto.descuentoValor),
              controladores[21].text = producto.ubicacion.toString(),
              estadoProducto.manejaVentaFraccionada.value =
                  producto.manejaFracciones,
              estadoProducto.manejaVentaXCantidad.value =
                  producto.manejaVentaXCantidad,
              estadoProducto.manejaIdentificador.value =
                  producto.manejaIdentificador,
              estadoProducto.manejaCombos.value = producto.manejaCombo,
              ComboDB.getId(producto.comboId).then((value1) {
                if (value1 != null) {
                  estadoProducto.comboSeleccionado = value1;
                  estadoProducto.nombreComboSeleccionado.value = value1.nombre;
                } else {
                  estadoProducto.nombreComboSeleccionado.value = '';
                  estadoProducto.comboSeleccionado = Combos.defecto();
                }
              }),
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
  FraccionesDB.getIdPadre(id).then((value1) {
    if (value1 != null) {
      List<Fracciones> lista = value1.forEach((element) {
        (Fracciones.fromMap(element));
      }).toList();

      estadoFracciones.nuevoEditar.value = false;
      controlador[0].text = lista[0].cantidadXEmpaque.toString();
      controlador[11].text = enBlancoSiEsCero(lista[0].cantidad);
      controlador[6].text = enBlancoSiEsCero(lista[0].bodega1);
      controlador[7].text = enBlancoSiEsCero(lista[0].bodega2);
      controlador[8].text = enBlancoSiEsCero(lista[0].bodega3);
      controlador[9].text = enBlancoSiEsCero(lista[0].bodega4);
      controlador[10].text = enBlancoSiEsCero(lista[0].bodega5);
      for (int i = 0; i < lista.length; i++) {
        if (i == 0) {
          controlador[1].text = lista[i].codigo;
          controlador[2].text = lista[i].nombre;
          controlador[3].text = lista[i].cantidadDescontar.toString();
          controlador[4].text = lista[i].precio.toString();
        }
      }
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