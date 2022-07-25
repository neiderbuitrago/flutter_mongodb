// ignore_for_file: avoid_print, null_argument_to_non_null_type

import 'package:flutter_mongodb/modelos/fracciones.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../utilidades.dart';

class FraccionesDB {
  // ignore: prefer_typing_uninitialized_variables
  static var db, coleccion;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccion = await db.collection("fracciones");
  }

  static Future getCodigo(String codigo) async {
    try {
      List datos = await coleccion
          .find(where.eq("codigo", codigo.toUpperCase()))
          .toList();

      return (datos.isNotEmpty) ? datos : null;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future getId(ObjectId id) async {
    try {
      List datos = await coleccion.find(where.id(id)).toList();
      if (datos.isEmpty) return null;
      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future getIdPadre(ObjectId id) async {
    try {
      List datos = await coleccion.find(where.eq("idProducto", id)).toList();
      if (datos.isEmpty) return null;
      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<void> insertar(Fracciones value) async {
    try {
      await coleccion.insertAll([value.toMap()]);
      print("tarifa impuestos insertada");
    } catch (e) {
      print(e);
    }
  }

  static Future<void> actualizar(Fracciones value) async {
    try {
      await coleccion.update(where.eq("_id", value.id), value.toMap());
    } catch (e) {
      print(e);
    }
  }

  static Future<void> eliminar(ObjectId id) async {
    try {
      await coleccion.remove(
        where.eq('_id', id),
      );
      //mostrar alerta inferior  de eliminado

    } catch (e) {
      print(e);
    }
  }

  static Future<bool> existeNombre(Fracciones value) async {
    try {
      final existe = await coleccion.find(where.eq('_id', value.id)).toList();

      return existe.isEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
