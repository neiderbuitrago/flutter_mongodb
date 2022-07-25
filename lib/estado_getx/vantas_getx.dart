// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/modelos/productos.dart';
import 'package:flutter_mongodb/modelos/ventas.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../db/venta_x_cantida_mongo.dart';
import '../funciones_generales/numeros.dart';
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
  var totalFactura = 0.0.obs;

  //variable para saber cuantos productos se agregaron por fracciones

  List<ProductosEnVenta> productosEnFacturacion = <ProductosEnVenta>[].obs;
  VentaXCantidad ventaXCantidad = VentaXCantidad(id: ObjectId());
  List<Fracciones> fraccionesConsultadas = <Fracciones>[].obs;

  //identificadores
  List<IdentificadorVenta> listaMapIdentificador = <IdentificadorVenta>[].obs;
  List<FocusNode> focusIdentificadores = <FocusNode>[].obs;
  List<TextEditingController> controlIdentificadores =
      <TextEditingController>[].obs;

  //fracciones
  List<TextEditingController> controlFracciones = <TextEditingController>[].obs;
  List<FocusNode> focusFracciones = <FocusNode>[].obs;
  List<FraccionesEnVenta> listafracciones = <FraccionesEnVenta>[].obs;

  cargarParametros(producto) async {
    cantidad.value = producto.cantidad;

    if (producto.manejaVentaXCantidad) {
      var venta = await VentaXCantidadDB.getId(producto.id);
      if (venta != null) {
        ventaXCantidad = VentaXCantidad.fromMap(venta[0]);
      }
    }
    // if (producto.manejaFracciones) {
    //   var fraccion = await FraccionesDB.getId(producto.id);
    //   if (fraccion != null) {
    //     fraccionesConsultadas = Fracciones.fromMap(fraccion[0]);
    //   }
    // }
    // if (producto.manejaIdentificador) {
    //   var identificador = await IdentificadorDB.getId(producto.id);
    //   if (identificador != null) {
    //     listaMapIdentificador = identificador;
    //   }
    // }
  }

  agregarAVentas({
    required Productos producto,
    bool? ventaDeFracciones,
    double? precioVenta,
    FraccionesEnVenta? fracciones,
  }) async {
    controladores.addAll([
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ]);

    focusNode.addAll([
      FocusNode(),
      FocusNode(),
      FocusNode(),
    ]);

    ProductosEnVenta productoEnVenta = ProductosEnVenta(
      id: producto.id,
      producto: producto,
      cantidad: 1,
      precioUnd: precioVenta ?? producto.precioVenta1,
      subtotal: precioVenta ?? producto.precioVenta1,
      total: producto.precioVenta1,
      descuento: 0,
      comision: 0,
      impuesto: 0,
      ventaDeFracciones: ventaDeFracciones ?? false,
      fracciones: fracciones,
    );
    productosEnFacturacion.add(productoEnVenta);
    indexProductoSelecc.value = productosEnFacturacion.length - 1;
    actualizarTotal();

    cargarParametros(producto);
    update();
    FocusScope.of(context).requestFocus(focusBuscar);
  }

//AGREGAR FRACCIONES A PRODUCTOS EN FACTURACION
  agregarFraccionFacturacion() {
    int cantidadProductosAgregar = -1;
    int indice =
        indicerevez(indexProductoSelecc.value, productosEnFacturacion.length);
    var a = productosEnFacturacion[indexProductoSelecc.value];

    for (var element in listafracciones) {
      cantidadProductosAgregar++;

      if (element.temCantidad > 0) {
        //fraccion agregada a productos en facturacion

        if (cantidadProductosAgregar < 1) {
          a.fracciones = element;
          a.cantidad = element.temCantidad;
          a.precioUnd = element.temPrecioVenta;
          a.subtotal = element.temCantidad * element.temPrecioVenta;
          a.ventaDeFracciones = true;
          update();
        }

        //agregar producto a ventas y agregar los datos de la fraccion.
        if (cantidadProductosAgregar > 0) {
          agregarAVentas(producto: a.producto, ventaDeFracciones: true);
          indexProductoSelecc.value = productosEnFacturacion.length - 1;
          var b = productosEnFacturacion[indexProductoSelecc.value];
          b.fracciones = element;
          b.cantidad = element.temCantidad;
          b.precioUnd = element.temPrecioVenta;
          b.subtotal = element.temCantidad * element.temPrecioVenta;
          // b.ventaDeFracciones = true;
        }
      }
      actualizarsubtotal(indexOri: indice);
      update();
    }
  }

  agregarIdentificadorVenta() {
    int cantidadProductosAgregar = -1;
    int indice =
        indicerevez(indexProductoSelecc.value, productosEnFacturacion.length);

    var a = productosEnFacturacion[indexProductoSelecc.value];
    //Limpiar identificador de ventas
    a.identificadorVenta = null;

    for (var element in listaMapIdentificador) {
      if (element.temCantidad > 0) {
        //fraccion agregada a productos en facturacion
        cantidadProductosAgregar++;
        if (cantidadProductosAgregar < 1) {
          a.identificadorVenta = element;
          a.cantidad = element.temCantidad;
          // a.identificadorVenta = true;
          update();
        }

        //agregar producto a ventas y agregar los datos de la fraccion.
        if (cantidadProductosAgregar > 0) {
          agregarAVentas(producto: a.producto);
          indexProductoSelecc.value = productosEnFacturacion.length - 1;
          var b = productosEnFacturacion[indexProductoSelecc.value];
          b.identificadorVenta = element;
          b.cantidad = element.temCantidad;

          // b.ventaDeFracciones = true;
        }
      }
      actualizarsubtotal(indexOri: indice);
      update();
    }
  }

  actualizarsubtotal({required int indexOri}) {
    int indiceRevez = indicerevez(indexOri, productosEnFacturacion.length);
    productosEnFacturacion[indiceRevez].subtotal =
        productosEnFacturacion[indiceRevez].cantidad *
            productosEnFacturacion[indiceRevez].precioUnd;

    controladores[indexOri * 3 + 2].text = puntosDeMil(
        quitarDecimales((productosEnFacturacion[indiceRevez].subtotal)));

    actualizarTotal();
  }

  //suma total de todos los productos
  double actualizarTotal() {
    double total = 0;
    for (var element in productosEnFacturacion) {
      total += element.subtotal;
    }
    totalFactura.value = total;
    return total;
  }
}
