// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, null_argument_to_non_null_type

import 'package:flutter_mongodb/modelos/marcas.dart';
import 'package:flutter_mongodb/utilidades.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MarcaDB {
  static var db, coleccionMarca;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccionMarca = await db.collection("marcas");
  }

  static Future<List<Map<String, dynamic>>> getParametro(String letras) async {
    try {
      var datos = await coleccionMarca
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

  static Future<void> insertar(MarcasGrupos marcas) async {
    //comprovar si existe

    if (await existeNombre(marcas.nombre)) {
      try {
        await coleccionMarca.insertAll([marcas.toMap()]);
        print("marca insertada");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> actualizar(MarcasGrupos marcas) async {
    if (await existeNombre(marcas.nombre)) {
      try {
        await coleccionMarca.update(
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
      await coleccionMarca.remove(
        where.eq('_id', marcas.id),
      );
    } catch (e) {
      print(e);
    }
  }

  //comprobar si el nombre existe
  static Future<bool> existeNombre(String nombre) async {
    try {
      final existe = await coleccionMarca
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
