// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/productos_mongo.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../db/venta_x_cantida_mongo.dart';
import '../../estado_getx/productos_getx.dart';
import '../../estado_getx/venta_x_cantidad_getx.dart';
import '../../funciones_generales/alertas_mensajes.dart';
import '../../funciones_generales/numeros.dart';
import '../../modelos/productos.dart';
import '../../modelos/venta_x_cantidad.dart';
import '../widget.dart';
import 'limpiar_form_productos.dart';

class BotonGuardar extends StatelessWidget {
  const BotonGuardar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EstadoProducto estadoProducto = Get.find<EstadoProducto>();
    // EstadoVentaFraccionada estadoFracciones =
    //     Get.find<EstadoVentaFraccionada>();
    EstadoVentaXCantidad estadoVentaXCantidad =
        Get.find<EstadoVentaXCantidad>();

    Future onPressed2() async {
      if (estadoProducto.formKey.value.currentState!.validate()) {
        if (estadoProducto.controladores[0].text == "" ||
            estadoProducto.controladores[1].text == "" ||
            estadoProducto.controladores[2].text == "" ||
            estadoProducto.controladores[3].text == "" ||
            estadoProducto.controladores[4].text == "") {
          informarInferior(
            titleText: 'Advertencia',
            messageText: 'Faltan datos por completar',
          );
        } else {
          Productos productoAGuardar = Productos(
              id: (estadoProducto.nuevoEditar.value)
                  ? ObjectId()
                  : estadoProducto.productoConsultado.id,
              codigo: estadoProducto.controladores[0].text.trim(),
              nombre: estadoProducto.controladores[1].text.trim(),
              marcaId: estadoProducto.marcaSeleccionada.id,
              grupoId: estadoProducto.grupoSeleccionado.id,
              impuestoId: estadoProducto.impuestoSeleccionado.id,
              cantidad: numeroDecimal(estadoProducto.controladores[6].text),
              bodega1: numeroDecimal(estadoProducto.controladores[7].text),
              bodega2: numeroDecimal(estadoProducto.controladores[8].text),
              bodega3: numeroDecimal(estadoProducto.controladores[9].text),
              bodega4: numeroDecimal(estadoProducto.controladores[10].text),
              bodega5: numeroDecimal(estadoProducto.controladores[11].text),
              cantidadMinima:
                  numeroDecimal(estadoProducto.controladores[15].text),
              cantidadMaxima:
                  numeroDecimal(estadoProducto.controladores[16].text),
              //provicional
              presentacionId: estadoProducto.presentacionSeleccionada.id,
              comision: numeroDecimal(estadoProducto.controladores[18].text),
              descuentoPorcentaje:
                  numeroDecimal(estadoProducto.controladores[19].text),
              descuentoValor:
                  numeroDecimal(estadoProducto.controladores[20].text),
              ubicacion: estadoProducto.controladores[21].text,
              activoInactivo: estadoProducto.estadoDelProducto.value,
              pesado: estadoProducto.manejaVentaXPeso.value,
              manejaCombo: estadoProducto.manejaCombos.value,
              manejaFracciones: estadoProducto.manejaVentaFraccionada.value,
              manejaVentaXCantidad: estadoProducto.manejaVentaXCantidad.value,
              manejaIdentificador: estadoProducto.manejaIdentificador.value,
              manejaMulticodigo: estadoProducto.manejaMulticodigos.value,
              manejaBodegas: estadoProducto.manejaBodegas.value,
              tipoProducto: estadoProducto.seleccionTipoProducto.value,
              //provicional
              comboId: estadoProducto.comboSeleccionado.id,
              precioCompra: numeroDecimal(estadoProducto.controladores[5].text),
              precioVenta1:
                  numeroDecimal(estadoProducto.controladores[12].text),
              precioVenta2:
                  numeroDecimal(estadoProducto.controladores[13].text),
              precioVenta3:
                  numeroDecimal(estadoProducto.controladores[14].text),
              sincronizado: '',
              fechaVenta: DateTime.now(),
              fechaCompra: DateTime.now(),
              fechaCreacion: DateTime.now());
          (estadoProducto.nuevoEditar.value)
              ? await ProductosDB.insertar(productoAGuardar).then((value) {
                  if (value) {
                    limpiarTextos(index: 0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Producto Creado')),
                    );
                  } else {
                    informarInferior(
                      titleText: 'Error al guardar',
                      messageText:
                          'El nombre ${productoAGuardar.nombre} ya existe',
                    );
                  }
                })
              : await ProductosDB.actualizar(productoAGuardar).then((value) {
                  if (value) {
                    limpiarTextos(index: 0);
                    scaffoldMessenger(
                        context: context, mensaje: 'Producto Actualizado');
                  } else {
                    informarInferior(
                      titleText: 'Error al guardar',
                      messageText:
                          'El nombre ${productoAGuardar.nombre} ya existe',
                    );
                  }
                });

          //fracciones

          // VentasXCantidad

          if (estadoProducto.manejaVentaXCantidad.value) {
            VentaXCantidad ventaXCantidad = VentaXCantidad(
              id: productoAGuardar.id,
              desde1: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[0].text),
              hasta1: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[1].text),
              precio1: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[2].text),
              desde2: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[4].text),
              hasta2: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[5].text),
              precio2: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[6].text),
              desde3: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[8].text),
              hasta3: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[9].text),
              precio3: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[10].text),
              desde4: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[12].text),
              hasta4: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[13].text),
              precio4: numeroDecimal(
                  estadoVentaXCantidad.controladoresVentaXCantidad[14].text),
            );
            estadoVentaXCantidad.nuevoEditar.value
                ? await VentaXCantidadDB.insertar(ventaXCantidad)
                    .then((value) => limpiarVentaXCantidad())
                : await VentaXCantidadDB.actualizar(ventaXCantidad)
                    .then((value) => limpiarVentaXCantidad());
          }
        }
      }
    }

    return SizedBox(
      width: 20,
      height: 70,
      child: elevatedButtonGuardar1(
          context: context,
          focusNode: estadoProducto.focusNode[23],
          onPressed: onPressed2),
    );
  }
}
