import 'package:mongo_dart/mongo_dart.dart';

class Impuesto {
  ObjectId id;
  String nombre;
  double valor;
  String sincronizado;
  Impuesto({
    required this.id,
    required this.nombre,
    required this.valor,
    required this.sincronizado,
  });
  //
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'valor': valor,
      'sincronizado': sincronizado,
    };
  }

  factory Impuesto.fromMap(Map<String, dynamic> map) {
    return Impuesto(
      id: map['_id'],
      nombre: map['nombre'],
      valor: double.parse(map['valor'].toString()),
      sincronizado: map['sincronizado'],
    );
  }

  Impuesto.defecto()
      : id = ObjectId(),
        nombre = '',
        valor = 0,
        sincronizado = '';

  isEmpty() {
    return (nombre.isEmpty && sincronizado.isEmpty);
  }
}
