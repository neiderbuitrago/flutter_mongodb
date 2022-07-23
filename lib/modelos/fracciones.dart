import 'package:mongo_dart/mongo_dart.dart';

class Fracciones {
  ObjectId id;
  ObjectId idProducto;
  double cantidadXEmpaque;
  String codigo;
  String nombre;
  double cantidadDescontar;
  double precioUnd;
  double cantidad;
  double bodega1;
  double bodega2;
  double bodega3;
  double bodega4;
  double bodega5;
  Fracciones({
    required this.id,
    required this.idProducto,
    required this.cantidadXEmpaque,
    this.codigo = "",
    required this.nombre,
    required this.cantidadDescontar,
    required this.precioUnd,
    this.cantidad = 0.0,
    this.bodega1 = 0.0,
    this.bodega2 = 0.0,
    this.bodega3 = 0.0,
    this.bodega4 = 0.0,
    this.bodega5 = 0.0,
  });
  //
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'idProducto': idProducto,
      'cantidadXEmpaque': cantidadXEmpaque,
      'codigo': codigo,
      'nombre': nombre,
      'cantidadDescontar': cantidadDescontar,
      'precioUnd': precioUnd,
      'cantidad': cantidad,
      'bodega1': bodega1,
      'bodega2': bodega2,
      'bodega3': bodega3,
      'bodega4': bodega4,
      'bodega5': bodega5,
    };
  }

  factory Fracciones.fromMap(map) {
    return Fracciones(
      id: map['_id'],
      idProducto: map['idProducto'],
      cantidadXEmpaque: map['cantidadXEmpaque'],
      codigo: map['codigo'],
      nombre: map['nombre'],
      cantidadDescontar: map['cantidadDescontar'],
      precioUnd: map['precioUnd'],
      cantidad: map['cantidad'],
      bodega1: map['bodega1'],
      bodega2: map['bodega2'],
      bodega3: map['bodega3'],
      bodega4: map['bodega4'],
      bodega5: map['bodega5'],
    );
  }
  isEmpty() {
    return (cantidadXEmpaque != 0.0 &&
        cantidadDescontar != 0.0 &&
        nombre.isEmpty &&
        precioUnd != 0.0);
  }
}
//extender la clase agregando los valores de la venta de fracciones

class FraccionesEnVenta extends Fracciones {
  double temCantidad;
  double temPrecioVenta;
  double temSubtotal;
  FraccionesEnVenta({
    this.temCantidad = 0.0,
    this.temPrecioVenta = 0.0,
    this.temSubtotal = 0.0,
  }) : super(
          id: ObjectId(),
          idProducto: ObjectId(),
          cantidadXEmpaque: 0.0,
          codigo: "",
          nombre: "",
          cantidadDescontar: 0.0,
          precioUnd: 0.0,
          cantidad: 0.0,
          bodega1: 0.0,
          bodega2: 0.0,
          bodega3: 0.0,
          bodega4: 0.0,
          bodega5: 0.0,
        );
  llenarInstancia(Fracciones fracciones) {
    id = fracciones.id;
    idProducto = fracciones.idProducto;
    cantidadXEmpaque = fracciones.cantidadXEmpaque;
    codigo = fracciones.codigo;
    nombre = fracciones.nombre;
    cantidadDescontar = fracciones.cantidadDescontar;
    precioUnd = fracciones.precioUnd;
    cantidad = fracciones.cantidad;
    bodega1 = fracciones.bodega1;
    bodega2 = fracciones.bodega2;
    bodega3 = fracciones.bodega3;
    bodega4 = fracciones.bodega4;
    bodega5 = fracciones.bodega5;
  }
}
