// ignore_for_file: avoid_print, null_argument_to_non_null_type, prefer_typing_uninitialized_variables

import 'package:flutter_mongodb/utilidades.dart';

import 'package:mongo_dart/mongo_dart.dart';

import '../modelos/combo.dart';

class ComboDB {
  static var db, coleccion;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccion = await db.collection("combos");
  }

  static Future getParametro(String letras) async {
    try {
      List datos = await coleccion
          .find(where
              .match("nombre", letras, caseInsensitive: true)
              .sortBy("nombre", descending: false))
          .toList();
      return datos.isEmpty ? null : datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static getId(ObjectId id) async {
    try {
      List datos = await coleccion.find(where.id(id)).toList();
      //  print(datos);
      if (datos.isEmpty) {
        return null;
      } else {
        List<Combos> lista = Combos.fromMapList(datos);
        return lista[0];
      }
    } catch (e) {
      print(e);

      return Future.value();
    }
  }

  static Future<void> insertar(Combos valor) async {
    if (await existeNombre(valor)) {
      try {
        await coleccion.insertAll([valor.toMap()]);
        print("Combo insertado");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> actualizar(Combos valor) async {
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

  static Future<void> eliminar(Combos valor) async {
    try {
      await coleccion.remove(
        where.eq('_id', valor.id),
      );
    } catch (e) {
      print(e);
    }
  }

  //comprobar si el nombre existe
  static Future<bool> existeNombre(Combos value) async {
    //  EstadoCombos estadocombo = Get.find<EstadoCombos>();
    try {
      final existe = await coleccion
          .find(where
              .eq("nombre", value.nombre)
              .or(where.eq("nombre", value.nombre.toLowerCase())))
          .toList();
      return (existe.isEmpty)
          ? true
          : (existe[0]['_id'] == value.id)
              ? true
              : false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
