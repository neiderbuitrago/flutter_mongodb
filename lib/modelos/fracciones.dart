import 'package:mongo_dart/mongo_dart.dart';

class Fracciones {
  ObjectId id;
  ObjectId idProducto;
  double cantidadXEmpaque;
  String codigo;
  String nombre;
  double cantidadDescontar;
  double precio;
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
    required this.precio,
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
      'cantidadXEmpaque': cantidadXEmpaque,
      'codigo': codigo,
      'nombre': nombre,
      'cantidadDescontar': cantidadDescontar,
      'precio': precio,
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
      precio: map['precio'],
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
        precio != 0.0);
  }
}
