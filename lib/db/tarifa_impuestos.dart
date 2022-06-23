// ignore_for_file: avoid_print, null_argument_to_non_null_type

import 'package:mongo_dart/mongo_dart.dart';

import '../modelos/tarifa_impuestos.dart';
import '../utilidades.dart';

class TarifaImpuestosDB {
  static var db, coleccionTarImpuestos;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccionTarImpuestos = await db.collection("tarifa_impuestos");
  }

  static Future<List<Map<String, dynamic>>> getParametro(String letras) async {
    try {
      var datos = await coleccionTarImpuestos
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

  static Future<void> insertar(Impuesto tarifaImpuestos) async {
    if (await existeNombre(tarifaImpuestos)) {
      try {
        await coleccionTarImpuestos.insertAll([tarifaImpuestos.toMap()]);
        print("tarifa impuestos insertada");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future actualizar(Impuesto tarifaImpuestos) async {
    if (await existeNombre(tarifaImpuestos)) {
      try {
        var a = await coleccionTarImpuestos.update(
          where.eq("_id", tarifaImpuestos.id),
          tarifaImpuestos.toMap(),
        );
        return a["updatedExisting"];
      } catch (e) {
        print(e);
        return false;
      }
    }
  }

  static Future<void> eliminar(Impuesto tarifaImpuestos) async {
    try {
      await coleccionTarImpuestos.remove(
        where.eq('_id', tarifaImpuestos.id),
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> existeNombre(Impuesto impuesto) async {
    try {
      final existe = await coleccionTarImpuestos
          .find(where
              .match("nombre", impuesto.nombre, caseInsensitive: true)
              .and(where.eq("valor", impuesto.valor)))
          .toList();

      return existe.isEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
