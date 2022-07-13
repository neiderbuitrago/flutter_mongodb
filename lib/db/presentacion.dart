// ignore_for_file: avoid_print

import 'package:flutter_mongodb/utilidades.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../modelos/presentacion.dart';

class PresentacionDB {
  // ignore: prefer_typing_uninitialized_variables
  static var db, coleccion;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccion = await db.collection("presentacion");
  }

  static Future getParametro(String letras) async {
    try {
      var datos = await coleccion
          .find(where
              .match("nombre", letras, caseInsensitive: true)
              .sortBy("nombre", descending: false))
          .toList();

      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future getId(ObjectId id) async {
    try {
      List datos = await coleccion.find(where.id(id)).toList();
      return (datos.isEmpty) ? null : datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future getUnidad(String value) async {
    try {
      List datos = await coleccion.find(where.eq("nombre", value)).toList();
      return (datos.isEmpty) ? null : datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<void> insertar(Presentacion marcas) async {
    //comprovar si existe

    if (await existeNombre(marcas)) {
      try {
        await coleccion.insertAll([marcas.toMap()]);
        print("marca insertada");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> actualizar(Presentacion marcas) async {
    if (await existeNombre(marcas)) {
      try {
        await coleccion.update(
          where.eq("_id", marcas.id),
          marcas.toMap(),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> eliminar(Presentacion marcas) async {
    try {
      await coleccion.remove(
        where.eq('_id', marcas.id),
      );
    } catch (e) {
      print(e);
    }
  }

  //comprobar si el nombre existe
  static Future<bool> existeNombre(Presentacion nombre) async {
    try {
      final existe = await coleccion
          .find(where
              .eq("nombre", nombre.nombre)
              .or(where.eq("nombre", nombre.nombre.toUpperCase())))
          .toList();
      return (existe.isEmpty) ? true : (existe[0]["_id"] == nombre.id);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
