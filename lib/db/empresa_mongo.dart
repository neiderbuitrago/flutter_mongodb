// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, null_argument_to_non_null_type

import 'package:mongo_dart/mongo_dart.dart';

import '../modelos/empresa.dart';
import '../utilidades.dart';

class EmpresaDB {
  static var db, coleccionEmpresa;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccionEmpresa = await db.collection("empresa");
  }

  static Future<Map<String, dynamic>> getEmpresa() async {
    try {
      final empresa = await coleccionEmpresa.findOne();
      return empresa;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<void> insertar(Empresa empresa) async {
    try {
      await coleccionEmpresa.insertAll([empresa.toMap()]);
      print("empresa insertada");
    } catch (e) {
      print(e);
    }
  }

  static Future<void> actualizar(Empresa empresa) async {
    try {
      await coleccionEmpresa.update(
        where.eq("_id", empresa.id),
        empresa.toMap(),
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> comprobarEmpresa() async {
    List empresa;
    try {
      empresa = await coleccionEmpresa.find().toList();
      print(empresa);
      if (empresa.isEmpty) {
        insertar(empresaXDefecto);
      }
    } catch (e) {
      print(e);
    }
  }
}

Empresa empresaXDefecto = Empresa(
  id: ObjectId(),
  nit: "00",
  nombre: "SU EMPRESA",
  direccion: "",
  ciudad: "",
  telefono: "",
  email: "",
  eslogan: "",
  propietario: "",
  mensaje: "",
  numeroSalidas1: 0,
  numeroSalidas2: 0,
  numeroSalidas3: 0,
  nombreDocumento1: "",
  nombreDocumento2: "",
  nombreDocumento3: "",
  numeroEntradas: 0,
  notaCredito: 0,
  notaDebito: 0,
);
