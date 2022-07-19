// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/fracciones.dart';
import 'package:flutter_mongodb/db/multicodigo.dart';
import 'package:flutter_mongodb/estado_getx/productos_getx.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../db/productos_mongo.dart';
import '../funciones_generales/alertas_mensajes.dart';
import '../funciones_generales/numeros.dart';
import '../modelos/fracciones.dart';

class EstadoVentaFraccionada extends GetxController {
  var costoGeneralProducto = ''.obs;
  var listaBodegasVisibles = false.obs;
  var nuevoEditar = true.obs;
  var context;

  late List<String> camposTitulo = [
    "Codigo",
    'Nombre Producto',
    'Cantidades a descontar',
    'Precio venta',
    'Utilidad % ',
  ].obs;

  late Fracciones fraccionesConsultadas = {}.obs as Fracciones;

  late List<TextEditingController> controladoresFraccion = [
    for (var i = 0; i < 12; i++) TextEditingController()
  ];
  late List<FocusNode> focofracciones = [
    for (var i = 0; i < 13; i++) FocusNode()
  ];

  // List listaDewidgetParaCard = [].obs;

  calcularGanancias() {
    //cxe = cantidad por empaque
    double cxe = numeroDecimal(controladoresFraccion[0].text);
    if (cxe != 0) {
      //pc = precio de compra
      double pc = numeroDecimal(costoGeneralProducto.value);
      //
      double cantidadDescontar = numeroDecimal(controladoresFraccion[10].text);
      double costoFraccion = (pc / cxe) * cantidadDescontar;
      if (controladoresFraccion[10].text != '') {
        double utilidadPesos =
            (numeroDecimal(controladoresFraccion[10].text) - costoFraccion);
        double porcentaje = (utilidadPesos / costoFraccion);
        controladoresFraccion[11].text = (porcentaje * 100).toString();
      }
    }
  }

  calcularPrecioVenta({required int index, required String value}) {
    double pc = numeroDecimal(costoGeneralProducto.value);
    double cxe = numeroDecimal(controladoresFraccion[0].text);
    double cantidadDescontar =
        numeroDecimal(controladoresFraccion[index - 2].text);
    double costoFraccion = (pc / cxe) * cantidadDescontar;
    int precioVenta =
        ((costoFraccion * numeroDecimal(value)) / 100 + costoFraccion).toInt();
    controladoresFraccion[index - 1].text = (precioVenta.round()).toString();
  }

  consultarSiCodigoFraccionExiste<bool>(String valor, BuildContext context) {
    if (valor != "") {
      retornar() {
        controladoresFraccion[2].text = '';
        FocusScope.of(context).requestFocus(focofracciones[2]);
        return true;
      }

      FraccionesDB.getCodigo(valor).then(
        (value) {
          if (value != null) {
            informarInferior(
                messageText: '$valor ya existe en base de datos',
                titleText: "Error código duplicado ");
            retornar();
          } else {
            ProductosDB.getcodigo(valor).then(
              (value) {
                if (value != null) {
                  informarInferior(
                    titleText: "El código $valor pertenece al producto",
                    messageText: value[0]['nombre'],
                  );
                  retornar();
                } else {
                  MulticodigoDB.getCodigo(valor).then(
                    (value) async {
                      if (value != null) {
                        var producto =
                            await ProductosDB.getId(value[0]['idProducto']);
                        //crear un alerta
                        informarInferior(
                            messageText:
                                " ${(producto != null) ? producto[0]["nombre"] : ""}   ${value[0]['detalle']}",
                            titleText:
                                "El código $valor pertenece al Multicodigo");
                        retornar();
                      } else {
                        return false;
                      }
                    },
                  );
                }
              },
            );
          }
        },
      );
    }
  }

  guardarFracciones(BuildContext context, ObjectId idProducto) async {
    context = context;
    if (controladoresFraccion[3].text != "" &&
        controladoresFraccion[4].text != "" &&
        controladoresFraccion[5].text != "") {
      Fracciones fracciones = Fracciones(
          id: ObjectId(),
          idProducto: idProducto,
          codigo: controladoresFraccion[2].text,
          nombre: controladoresFraccion[3].text,
          cantidadDescontar: numeroDecimal(controladoresFraccion[4].text),
          precio: numeroDecimal(controladoresFraccion[5].text),
          cantidadXEmpaque: numeroDecimal(controladoresFraccion[0].text),
          cantidad: numeroDecimal(controladoresFraccion[1].text),
          bodega1: numeroDecimal(controladoresFraccion[7].text),
          bodega2: numeroDecimal(controladoresFraccion[8].text),
          bodega3: numeroDecimal(controladoresFraccion[9].text),
          bodega4: numeroDecimal(controladoresFraccion[10].text),
          bodega5: numeroDecimal(controladoresFraccion[11].text));

      nuevoEditar.value
          ? await FraccionesDB.insertar(fracciones)
              .then((value) => limpiarFracciones())
          : await FraccionesDB.actualizar(fracciones)
              .then((value) => limpiarFracciones());
    }
  }

  limpiarFracciones() {
    EstadoProducto estadoProducto = Get.find<EstadoProducto>();
    nuevoEditar.value = true;
    for (var element in controladoresFraccion) {
      element.clear();
    }
    estadoProducto.manejaVentaFraccionada.value = false;
    FocusScope.of(context).requestFocus(focofracciones[0]);
  }
}
