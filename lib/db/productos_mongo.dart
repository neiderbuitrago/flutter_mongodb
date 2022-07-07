// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, null_argument_to_non_null_type

import 'package:flutter_mongodb/modelos/productos.dart';
import 'package:flutter_mongodb/utilidades.dart';

import 'package:mongo_dart/mongo_dart.dart';

class ProductosDB {
  static var db, coleccionProductos;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccionProductos = await db.collection("productos");
  }

//consultar por silaba contenida en el nombre
  static Future getnombre(String letras) async {
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

//consultar por el codigo de barras
  static Future getcodigo(String letras) async {
    try {
      List datos =
          await coleccionProductos.find(where.eq("codigo", letras)).toList();
      if (datos.isEmpty) {
        return null;
      } else {
        return datos;
      }
    } catch (e) {
      print("error al consultar codigo de barras $e");
      return Future.value();
    }
  }

//consultar todos los codigos de barras
  static Future getcodigoAll() async {
    try {
      var datos = await coleccionProductos.find().fields(["codigo"]).toList();
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

  static Future<void> insertar(Productos datos) async {
    //comprovar si existe

    if (await existeNombre(datos)) {
      try {
        await coleccionProductos.insertAll([datos.toMap()]);
        print("Producto insertada");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> actualizar(Productos datos) async {
    if (!await existeNombre(datos)) {
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

  static Future<void> eliminar(Productos datos) async {
    try {
      await coleccionProductos.remove(
        where.eq('_id', datos.id),
      );
    } catch (e) {
      print(e);
    }
  }

  //comprobar si el nombre existe
  static Future<bool> existeNombre(Productos nombre) async {
    try {
      List existe = await coleccionProductos
          .find(where.eq("nombre", nombre.nombre).or(where
              .eq("nombre", nombre.nombre.toUpperCase())
              .or(where.eq("codigo", nombre.codigo))
              .or(where.eq("codigo", nombre.codigo.toUpperCase()))))
          .toList();
      bool resultado = (existe.isEmpty)
          ? false
          : (existe[0]["_id"] == nombre.id)
              ? false
              : true;
      resultado = existe
          .map((e) {
            return e["_id"] != nombre.id;
          })
          .toList()
          .contains(true);
      print("producto existe $resultado");
      return resultado;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
