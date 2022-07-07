import 'package:mongo_dart/mongo_dart.dart';

class Fracciones {
  ObjectId id;
  double cantidadXEmpaque;
  String codigo1;
  String nombre1;
  double cantidadDescontar1;
  double precio1;
  String codigo2;
  String nombre2;
  double cantidadDescontar2;
  double precio2;
  String codigo3;
  String nombre3;
  double cantidadDescontar3;
  double precio3;
  String codigo4;
  String nombre4;
  double cantidadDescontar4;
  double precio4;
  double cantidad;
  double bodega1;
  double bodega2;
  double bodega3;
  double bodega4;
  double bodega5;
  Fracciones({
    required this.id,
    this.cantidadXEmpaque = 0,
    this.codigo1 = '',
    this.nombre1 = '',
    this.cantidadDescontar1 = 0.0,
    this.precio1 = 0.0,
    this.codigo2 = '',
    this.nombre2 = '',
    this.cantidadDescontar2 = 0.0,
    this.precio2 = 0.0,
    this.codigo3 = '',
    this.nombre3 = '',
    this.cantidadDescontar3 = 0.0,
    this.precio3 = 0.0,
    this.codigo4 = '',
    this.nombre4 = '',
    this.cantidadDescontar4 = 0.0,
    this.precio4 = 0.0,
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
      'codigo1': codigo1,
      'nombre1': nombre1,
      'cantidadDescontar1': cantidadDescontar1,
      'precio1': precio1,
      'codigo2': codigo2,
      'nombre2': nombre2,
      'cantidadDescontar2': cantidadDescontar2,
      'precio2': precio2,
      'codigo3': codigo3,
      'nombre3': nombre3,
      'cantidadDescontar3': cantidadDescontar3,
      'precio3': precio3,
      'codigo4': codigo4,
      'nombre4': nombre4,
      'cantidadDescontar4': cantidadDescontar4,
      'precio4': precio4,
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
      cantidadXEmpaque: map['cantidadXEmpaque'],
      codigo1: map['codigo1'],
      nombre1: map['nombre1'],
      cantidadDescontar1: map['cantidadDescontar1'],
      precio1: map['precio1'],
      codigo2: map['codigo2'],
      nombre2: map['nombre2'],
      cantidadDescontar2: map['cantidadDescontar2'],
      precio2: map['precio2'],
      codigo3: map['codigo3'],
      nombre3: map['nombre3'],
      cantidadDescontar3: map['cantidadDescontar3'],
      precio3: map['precio3'],
      codigo4: map['codigo4'],
      nombre4: map['nombre4'],
      cantidadDescontar4: map['cantidadDescontar4'],
      precio4: map['precio4'],
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
        cantidadDescontar1 != 0.0 &&
        nombre1.isEmpty &&
        precio1 != 0.0);
  }
}
