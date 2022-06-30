// ignore_for_file: avoid_print

import 'package:flutter_mongodb/utilidades.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../modelos/identificador.dart';

class IdentificadorDB {
  static var db, coleccion;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccion = await db.collection("identificadores");
  }

  static Future getParametro(ObjectId idPadre) async {
    try {
      var datos = await coleccion
          .find(
              where.eq("idPadre", idPadre).sortBy("detalle", descending: false))
          .toList();

      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future getId(ObjectId id) async {
    try {
      var datos = await coleccion.find(where.id(id)).toList();
      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<void> insertar(IdentificadorDetalle valor) async {
    //comprovar si existe

    if (await existeNombre(valor)) {
      try {
        await coleccion.insertAll([valor.toMap()]);
        print("marca insertada");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> actualizar(IdentificadorDetalle valor) async {
    if (await existeNombre(valor)) {
      try {
        await coleccion.update(
          where.eq("_id", valor.id),
          valor.toMap(),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> eliminar(IdentificadorDetalle valor) async {
    try {
      await coleccion.remove(
        where.eq('_id', valor.id),
      );
    } catch (e) {
      print(e);
    }
  }

  //comprobar si el nombre existe
  static Future<bool> existeNombre(IdentificadorDetalle nombre) async {
    try {
      final existe = await coleccion
          .find(where.eq("idPadre", nombre.idPadre).or(where
              .eq("nombre", nombre.nombre)
              .or(where.eq("identificador", nombre.identificador))))
          .toList();
      return (existe.isEmpty) ? true : false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
