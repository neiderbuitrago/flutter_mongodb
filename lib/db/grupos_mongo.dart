// ignore_for_file: avoid_print, null_argument_to_non_null_type, prefer_typing_uninitialized_variables

import 'package:flutter_mongodb/modelos/marcas.dart';
import 'package:flutter_mongodb/utilidades.dart';
import 'package:mongo_dart/mongo_dart.dart';

class GruposDB {
  static var db, coleccion;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccion = await db.collection("grupos");
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

  static Future<void> insertar(MarcasGrupos marcas) async {
    //comprovar si existe

    if (await existeNombre(marcas.nombre)) {
      try {
        await coleccion.insertAll([marcas.toMap()]);
        print("marca insertada");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> actualizar(MarcasGrupos marcas) async {
    if (await existeNombre(marcas.nombre)) {
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

  static Future<void> eliminar(MarcasGrupos marcas) async {
    try {
      await coleccion.remove(
        where.eq('_id', marcas.id),
      );
    } catch (e) {
      print(e);
    }
  }

  //comprobar si el nombre existe
  static Future<bool> existeNombre(String nombre) async {
    try {
      final existe = await coleccion
          .find(where
              .eq("nombre", nombre)
              .or(where.eq("nombre", nombre.toLowerCase())))
          .toList();
      return (existe.isEmpty) ? true : false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
