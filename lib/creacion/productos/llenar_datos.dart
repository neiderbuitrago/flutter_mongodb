// ignore_for_file: avoid_print

import 'package:flutter_mongodb/creacion/productos/limpiar_form_productos.dart';
import 'package:flutter_mongodb/db/combo.dart';
import 'package:flutter_mongodb/db/identificadores.dart';
import 'package:flutter_mongodb/db/marcas_mongo.dart';
import 'package:flutter_mongodb/db/productos_mongo.dart';
import 'package:flutter_mongodb/db/venta_x_cantida_mongo.dart';
import 'package:flutter_mongodb/estado_getx/getx_marcas.dart';
import 'package:flutter_mongodb/modelos/fracciones.dart';
import 'package:get/get.dart';
import '../../db/fracciones.dart';
import '../../db/grupos_mongo.dart';
import '../../db/tarifa_impuestos_mongo.dart';
import '../../estado_getx/fracciones_getx.dart';
import '../../estado_getx/getx_productos.dart';
import '../../estado_getx/identificadores.dart';
import '../../estado_getx/venta_x_cantidad_getx.dart';
import '../../funciones_generales/numeros.dart';
import '../../modelos/identificador.dart';
import '../../modelos/productos.dart';

llenarDatos({
  required String codigo,
}) async {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();
  EstadoVentaFraccionada estadoFracciones = Get.find<EstadoVentaFraccionada>();
  EstadoVentaXCantidad estadoVentaXCantidad = Get.find<EstadoVentaXCantidad>();
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
              if (producto.manejaIdentificador)
                {
                  estadoIdentificador.datosIdentificador.clear(),
                  IdentificadorDB.getId(
                    producto.id,
                  ).then((identificador) {
                    if (identificador != null) {
                      estadoIdentificador.datosIdentificador =
                          IdentificadorDetalle.toListMap(identificador);
                    }
                  })
                },
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
              ComboDB.getId(producto.id).then((value1) {
                if (value1 != null) {
                  estadoProducto.nombreComboSeleccionado.value =
                      value1[0]['nombre'];
                  estadoProducto.idComboSeleccionado.value = value1[0]['_id'];
                } else {
                  estadoProducto.nombreComboSeleccionado.value = '';
                  estadoProducto.idComboSeleccionado.value = 0;
                }
              }),

              //
              estadoProducto.manejaMulticodigos.value =
                  producto.manejaMulticodigo,
              estadoProducto.manejaVentaXPeso.value = producto.pesado,
              estadoProducto.estadoDelProducto.value = producto.activoInactivo,
              estadoProducto.seleccionTipoProducto.value =
                  producto.tipoProducto,

              //
              if (producto.manejaFracciones)
                {
                  //EL CODIGO  DEL PRODUCTO ESTA EN LAS FRACCIONES

                  FraccionesDB.getId(producto.id).then((value1) {
                    if (value1 != null) {
                      var datosfracciones = Fracciones.fromMap(value1);
                      estadoFracciones.controladoresFraccion[0].text =
                          enBlancoSiEsCero(datosfracciones.cantidadXEmpaque);

                      estadoFracciones.controladoresFraccion[1].text =
                          datosfracciones.nombre1;
                      estadoFracciones.controladoresFraccion[2].text =
                          enBlancoSiEsCero(datosfracciones.cantidadDescontar1);
                      estadoFracciones.controladoresFraccion[3].text =
                          enBlancoSiEsCero(datosfracciones.precio1);
                      estadoFracciones.controladoresFraccion[5].text =
                          datosfracciones.nombre2;
                      estadoFracciones.controladoresFraccion[6].text =
                          enBlancoSiEsCero(datosfracciones.cantidadDescontar2);
                      estadoFracciones.controladoresFraccion[7].text =
                          enBlancoSiEsCero(datosfracciones.precio2);
                      estadoFracciones.controladoresFraccion[9].text =
                          datosfracciones.nombre3;
                      estadoFracciones.controladoresFraccion[10].text =
                          enBlancoSiEsCero(datosfracciones.cantidadDescontar3);
                      estadoFracciones.controladoresFraccion[11].text =
                          enBlancoSiEsCero(datosfracciones.precio3);
                      estadoFracciones.controladoresFraccion[13].text =
                          datosfracciones.nombre4;
                      estadoFracciones.controladoresFraccion[14].text =
                          enBlancoSiEsCero(datosfracciones.cantidadDescontar4);
                      estadoFracciones.controladoresFraccion[15].text =
                          enBlancoSiEsCero(datosfracciones.precio4);
                      estadoFracciones.controladoresFraccion[17].text =
                          enBlancoSiEsCero(datosfracciones.cantidad);
                      estadoFracciones.controladoresFraccion[18].text =
                          enBlancoSiEsCero(datosfracciones.bodega1);
                      estadoFracciones.controladoresFraccion[19].text =
                          enBlancoSiEsCero(datosfracciones.bodega2);
                      estadoFracciones.controladoresFraccion[20].text =
                          enBlancoSiEsCero(datosfracciones.bodega3);
                      estadoFracciones.controladoresFraccion[21].text =
                          enBlancoSiEsCero(datosfracciones.bodega4);
                      estadoFracciones.controladoresFraccion[22].text =
                          enBlancoSiEsCero(datosfracciones.bodega5);
                    }
                  })
                }
              else
                {
                  //EL CODIGO  DEL PRODUCTO NO ESTA EN LAS FRACCIONES
                  for (var element in estadoFracciones.controladoresFraccion)
                    {element.text = ''}
                },

              //Venta por cantidad
              VentaXCantidadDB.getId(producto.id).then(
                (value1) {
                  if (value1 != null) {
                    estadoVentaXCantidad.controladoresVentaXCantidad[0].text =
                        enBlancoSiEsCero(value1.desde1);
                    estadoVentaXCantidad.controladoresVentaXCantidad[1].text =
                        enBlancoSiEsCero(value1.hasta1);
                    estadoVentaXCantidad.controladoresVentaXCantidad[2].text =
                        enBlancoSiEsCero(value1.precio1);
                    estadoVentaXCantidad.controladoresVentaXCantidad[4].text =
                        enBlancoSiEsCero(value1.desde2);
                    estadoVentaXCantidad.controladoresVentaXCantidad[5].text =
                        enBlancoSiEsCero(value1.hasta2);
                    estadoVentaXCantidad.controladoresVentaXCantidad[6].text =
                        enBlancoSiEsCero(value1.precio2);
                    estadoVentaXCantidad.controladoresVentaXCantidad[8].text =
                        enBlancoSiEsCero(value1.desde3);
                    estadoVentaXCantidad.controladoresVentaXCantidad[9].text =
                        enBlancoSiEsCero(value1.hasta3);
                    estadoVentaXCantidad.controladoresVentaXCantidad[10].text =
                        enBlancoSiEsCero(value1.precio3);
                    estadoVentaXCantidad.controladoresVentaXCantidad[12].text =
                        enBlancoSiEsCero(value1.desde4);
                    estadoVentaXCantidad.controladoresVentaXCantidad[13].text =
                        enBlancoSiEsCero(value1.hasta4);
                    estadoVentaXCantidad.controladoresVentaXCantidad[14].text =
                        enBlancoSiEsCero(value1.precio4);
                  } else {
                    for (var element
                        in estadoVentaXCantidad.controladoresVentaXCantidad) {
                      element.text = '';
                    }
                  }
                },
              )
            }
          : {
              limpiarTextos(index: 1),
              print("No se encontro el producto"),
            };
    },
  );
}
