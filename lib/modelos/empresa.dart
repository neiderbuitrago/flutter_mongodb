import 'package:mongo_dart/mongo_dart.dart';

class Empresa {
  final ObjectId id;
  final String nit;
  final String nombre;
  final String direccion;
  final String ciudad;
  final String telefono;
  final String email;
  final String eslogan;
  final String propietario;
  final String mensaje;
  final int numeroSalidas1;
  final int numeroSalidas2;
  final int numeroSalidas3;
  final String nombreDocumento1;
  final String nombreDocumento2;
  final String nombreDocumento3;
  final int numeroEntradas;
  final int notaCredito;
  final int notaDebito;

  const Empresa({
    required this.id,
    required this.nit,
    required this.nombre,
    required this.direccion,
    required this.ciudad,
    required this.telefono,
    required this.email,
    required this.eslogan,
    required this.propietario,
    required this.mensaje,
    required this.numeroSalidas1,
    required this.numeroSalidas2,
    required this.numeroSalidas3,
    required this.nombreDocumento1,
    required this.nombreDocumento2,
    required this.nombreDocumento3,
    required this.numeroEntradas,
    required this.notaCredito,
    required this.notaDebito,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nit': nit,
      'nombre': nombre,
      'direccion': direccion,
      'ciudad': ciudad,
      'telefono': telefono,
      'email': email,
      'eslogan': eslogan,
      'propietario': propietario,
      'mensaje': mensaje,
      'numeroSalidas1': numeroSalidas1,
      'numeroSalidas2': numeroSalidas2,
      'numeroSalidas3': numeroSalidas3,
      'nombreDocumento1': nombreDocumento1,
      'nombreDocumento2': nombreDocumento2,
      'nombreDocumento3': nombreDocumento3,
      'numeroEntradas': numeroEntradas,
      'notaCredito': notaCredito,
      'notaDebito': notaDebito,
    };
  }

  Empresa.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        nit = map['nit'],
        nombre = map['nombre'],
        direccion = map['direccion'],
        ciudad = map['ciudad'],
        telefono = map['telefono'],
        email = map['email'],
        eslogan = map['eslogan'],
        propietario = map['propietario'],
        mensaje = map['mensaje'],
        numeroSalidas1 = map['numeroSalidas1'],
        numeroSalidas2 = map['numeroSalidas2'],
        numeroSalidas3 = map['numeroSalidas3'],
        nombreDocumento1 = map['nombreDocumento1'],
        nombreDocumento2 = map['nombreDocumento2'],
        nombreDocumento3 = map['nombreDocumento3'],
        numeroEntradas = map['numeroEntradas'],
        notaCredito = map['notaCredito'],
        notaDebito = map['notaDebito'];
}
