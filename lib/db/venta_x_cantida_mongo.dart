// ignore_for_file: avoid_print, null_argument_to_non_null_type

import 'package:mongo_dart/mongo_dart.dart';
import '../modelos/venta_x_cantidad.dart';
import '../utilidades.dart';

class VentaXCantidadDB {
  // ignore: prefer_typing_uninitialized_variables
  static var db, coleccion;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccion = await db.collection("VentaXCantidad");
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
      var datos = await coleccion.find(where.id(id)).toList();
      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<void> insertar(VentaXCantidad value) async {
    if (await existeNombre(value)) {
      try {
        await coleccion.insertAll([value.toMap()]);
        print("tarifa impuestos insertada");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future actualizar(VentaXCantidad value) async {
    if (await existeNombre(value)) {
      try {
        var a = await coleccion.update(
          where.eq("_id", value.idPadre),
          value.toMap(),
        );
        return a["updatedExisting"];
      } catch (e) {
        print(e);
        return false;
      }
    }
  }

  static Future<void> eliminar(VentaXCantidad value) async {
    try {
      await coleccion.remove(
        where.eq('_id', value.idPadre),
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> existeNombre(VentaXCantidad value) async {
    try {
      final existe =
          await coleccion.find(where.eq('_id', value.idPadre)).toList();

      return existe.isEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
