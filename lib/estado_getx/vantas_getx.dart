// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/validation_function.dart';
import 'package:flutter_mongodb/modelos/productos.dart';
import 'package:flutter_mongodb/modelos/ventas.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../db/fracciones.dart';
import '../db/identificadores.dart';
import '../db/venta_x_cantida_mongo.dart';
import '../modelos/fracciones.dart';
import '../modelos/identificador.dart';
import '../modelos/venta_x_cantidad.dart';

class EstadoVentas extends GetxController {
  late BuildContext context;
  TextEditingController controladorBuscar = TextEditingController();
  FocusNode focusBuscar = FocusNode();
  List<TextEditingController> controladores = <TextEditingController>[].obs;

  List<FocusNode> focusNode = <FocusNode>[].obs;

  var precioventa = 0.0.obs;
  var cantidad = 0.0.obs;
  var indexProductoSelecc = 0.obs;

  //variable para saber cuantos productos se agregaron por fracciones

  List<ProductosEnVenta> productoEnFacturacion = <ProductosEnVenta>[].obs;
  VentaXCantidad ventaXCantidad = VentaXCantidad(id: ObjectId());
  late Fracciones fraccionesConsultadas = {}.obs as Fracciones;

//identificadores
  List<IdentificadorDetalle> mapIdentificador = <IdentificadorDetalle>[].obs;

  //fracciones
  List<TextEditingController> controlFracciones = <TextEditingController>[].obs;
  List<FocusNode> focusFracciones = <FocusNode>[].obs;
  var listafracciones = [].obs;
  cargarParametros(producto) async {
    cantidad.value = producto.cantidad;

    if (producto.manejaVentaXCantidad) {
      var venta = await VentaXCantidadDB.getId(producto.id);
      if (venta != null) {
        ventaXCantidad = VentaXCantidad.fromMap(venta[0]);
      }
    }
    if (producto.manejaFracciones) {
      var fraccion = await FraccionesDB.getId(producto.id);
      if (fraccion != null) {
        fraccionesConsultadas = Fracciones.fromMap(fraccion[0]);
      }
    }
    if (producto.manejaIdentificador) {
      var identificador = await IdentificadorDB.getId(producto.id);
      if (identificador != null) {
        mapIdentificador = identificador;
      }
    }
  }

  agregarAVentas({
    required Productos producto,
    bool? ventaDeFracciones,
  }) async {
    controladores.add(TextEditingController());
    controladores.add(TextEditingController());
    controladores.add(TextEditingController());

    ProductosEnVenta productoEnVenta = ProductosEnVenta(
      id: producto.id,
      producto: producto,
      cantidad: 1,
      precioUnd: producto.precioVenta1,
      subtotal: producto.precioVenta1,
      total: producto.precioVenta1,
      descuento: 0,
      comision: 0,
      impuesto: 0,
      ventaDeFracciones: ventaDeFracciones ?? false,
    );
    productoEnFacturacion.add(productoEnVenta);
    indexProductoSelecc.value = productoEnFacturacion.length - 1;

    pintarCantidades();
    cargarParametros(producto);
    update();
  }

  pintarCantidades() {
    for (int i = 0; i < productoEnFacturacion.length; i++) {
      controladores[i * 3].text =
          quitarDecimales(productoEnFacturacion[i].cantidad);

      controladores[i * 3 + 1].text =
          quitarDecimales(productoEnFacturacion[i].precioUnd);

      controladores[i * 3 + 2].text =
          quitarDecimales(productoEnFacturacion[i].subtotal);
    }
  }

  colocarValoresDeFracciones() {
    int cantidadProductosAgregar = -1;
    for (int i = 0; i < controlFracciones.length; i++) {
      if (((i == 0) || (i == 2) || (i == 4) || (i == 6)) &&
          controlFracciones[i].text.isNotEmpty) {
        cantidadProductosAgregar++;
        int indicelista = (i == 0)
            ? 0
            : (i == 2)
                ? 1
                : (i == 4)
                    ? 2
                    : 3;
        listafracciones[indicelista]["cantidadPaquetes"] =
            double.parse(controlFracciones[i].text);
        //cambiar precio
        listafracciones[indicelista]["precio"] =
            double.parse(controlFracciones[i + 1].text);
        //cambiar en productoEnFacturacion la ventaDeFracciones a true
        productoEnFacturacion[indexProductoSelecc.value].ventaDeFracciones =
            true;
      }
    }

//agregar map

    //agregar producto si falta a lista  de productosEnFacturacion

    for (int i = 0; i < cantidadProductosAgregar; i++) {
      agregarAVentas(
          producto: productoEnFacturacion[indexProductoSelecc.value].producto,
          ventaDeFracciones: true);
    }

    update();
  }
}
