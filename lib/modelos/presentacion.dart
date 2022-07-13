import 'package:mongo_dart/mongo_dart.dart';

class Presentacion {
  final ObjectId id;
  final String nombre;
  final String sincronizado;
  final String simbolo;
  final bool visible;
  final DateTime fecha;

  const Presentacion({
    required this.id,
    required this.nombre,
    required this.sincronizado,
    required this.fecha,
    required this.simbolo,
    required this.visible,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'sincronizado': sincronizado,
      'fecha': fecha,
      'simbolo': simbolo,
      'visible': visible,
    };
  }

  Presentacion.defecto()
      : id = ObjectId(),
        nombre = '',
        sincronizado = '',
        fecha = DateTime.now(),
        simbolo = '',
        visible = false;

  Presentacion.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        nombre = map['nombre'],
        sincronizado = map['sincronizado'],
        fecha = map['fecha'],
        simbolo = map['simbolo'],
        visible = map['visible'];

  isEmpty() {
    return (nombre.isEmpty && sincronizado.isEmpty && simbolo.isEmpty);
  }
}
