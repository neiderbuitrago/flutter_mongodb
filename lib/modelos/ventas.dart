import 'package:flutter_mongodb/modelos/fracciones.dart';
import 'package:flutter_mongodb/modelos/productos.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'identificador.dart';

class ProductosEnVenta {
  late ObjectId id;
  late Productos producto;
  late double cantidad;
  late double precioUnd;
  late double subtotal;
  late double total;
  late double descuento;
  late double comision;
  late double impuesto;
  late bool ventaDeFracciones;
  int? productosAgregados = 0;
  late FraccionesEnVenta? fracciones;
  late IdentificadorVenta? identificadorVenta;

  ProductosEnVenta({
    required this.id,
    required this.producto,
    required this.cantidad,
    required this.precioUnd,
    required this.subtotal,
    required this.total,
    required this.descuento,
    required this.comision,
    required this.impuesto,
    required this.ventaDeFracciones,
    this.productosAgregados,
    this.fracciones,
    this.identificadorVenta,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'producto': producto,
        'cantidad': cantidad,
        'precioUnd': precioUnd,
        'subtotal': subtotal,
        'total': total,
        'descuento': descuento,
        'comision': comision,
        'impuesto': impuesto,
        'ventaDeFracciones': ventaDeFracciones,
        'productosAgregados': productosAgregados,
        'fracciones': fracciones,
        'identificadorVenta': identificadorVenta,
      };

  static ProductosEnVenta fromJson(Map<String, dynamic> json) =>
      ProductosEnVenta(
        id: json['id'],
        producto: json['producto'],
        cantidad: json['cantidad'],
        precioUnd: json['precioUnd'],
        subtotal: json['subtotal'],
        total: json['total'],
        descuento: json['descuento'],
        comision: json['comision'],
        impuesto: json['impuesto'],
        ventaDeFracciones: json['ventaDeFracciones'],
        productosAgregados: json['productosAgregados'],
        fracciones: json['fracciones'],
        identificadorVenta: json['identificadorVenta'],
      );
}
