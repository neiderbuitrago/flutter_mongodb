import 'package:mongo_dart/mongo_dart.dart';

class MarcasGrupos {
  final ObjectId id;
  final String nombre;
  final String sincronizado;
  final DateTime fecha;

  const MarcasGrupos({
    required this.fecha,
    required this.id,
    required this.nombre,
    required this.sincronizado,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'sincronizado': sincronizado,
      'fecha': fecha,
    };
  }

  MarcasGrupos.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        nombre = map['nombre'],
        sincronizado = map['sincronizado'],
        fecha = map['fecha'];
}
