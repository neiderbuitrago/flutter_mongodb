import 'package:mongo_dart/mongo_dart.dart';

class Multicodigo {
  ObjectId id;
  String codigo;
  ObjectId idProducto;
  String detalle;
  String sincronizado;
  Multicodigo({
    required this.id,
    required this.codigo,
    required this.idProducto,
    required this.detalle,
    required this.sincronizado,
  });
  //
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'idProducto': idProducto,
      'detalle': detalle,
      'sincronizado': sincronizado,
    };
  }

  factory Multicodigo.fromMap(Map<String, dynamic> map) {
    return Multicodigo(
      id: map['_id'],
      codigo: map['codigo'],
      idProducto: map['idProducto'],
      detalle: map['detalle'],
      sincronizado: map['sincronizado'],
    );
  }
}
