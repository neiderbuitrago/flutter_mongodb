// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, null_argument_to_non_null_type

import 'package:flutter_mongodb/modelos/marcas.dart';
import 'package:flutter_mongodb/utilidades.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ProductosDB {
  static var db, coleccionProductos;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccionProductos = await db.collection("productos");
  }

  static Future<List<Map<String, dynamic>>> getnombre(String letras) async {
    try {
      var datos = await coleccionProductos
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

  static Future<List<Map<String, dynamic>>> getcodigo(String letras) async {
    try {
      var datos = await coleccionProductos
          .findOne(where
              .eq("codigo", letras)
              .or(where.eq("codigo", letras.toLowerCase())))
          .toList();

      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  // static Future<List<Map<String, dynamic>>> getNombreMarcaGrupo(
  //     String letras, ) async {
  //   try {
  //     var datos = await coleccionProductos
  //         .find(where
  //             .match("nombre", letras, caseInsensitive: true)
  //             .sortBy("nombre", descending: false))
  //         .toList();

  //     return datos;
  //   } catch (e) {
  //     print(e);
  //     return Future.value();
  //   }
  // }

  static Future<void> insertar(MarcasGrupos datos) async {
    //comprovar si existe

    if (await existeNombre(datos.nombre)) {
      try {
        await coleccionProductos.insertAll([datos.toMap()]);
        print("marca insertada");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> actualizar(MarcasGrupos datos) async {
    if (await existeNombre(datos.nombre)) {
      try {
        await coleccionProductos.update(
          where.eq("_id", datos.id),
          datos.toMap(),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> eliminar(MarcasGrupos datos) async {
    try {
      await coleccionProductos.remove(
        where.eq('_id', datos.id),
      );
    } catch (e) {
      print(e);
    }
  }

  //comprobar si el nombre existe
  static Future<bool> existeNombre(String nombre) async {
    try {
      final existe = await coleccionProductos
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
