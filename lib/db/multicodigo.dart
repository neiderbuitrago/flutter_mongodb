// ignore_for_file: avoid_print, null_argument_to_non_null_type, prefer_typing_uninitialized_variables

import 'package:flutter_mongodb/db/productos_mongo.dart';
import 'package:flutter_mongodb/estado_getx/multicodigo_getx.dart';
import 'package:flutter_mongodb/modelos/multicodigo.dart';
import 'package:flutter_mongodb/utilidades.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../funciones_generales/alertas_mensajes.dart';

class MulticodigoDB {
  static var db, coleccion;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccion = await db.collection("multicodigo");
  }

  static Future getParametro(ObjectId idProducto) async {
    try {
      var datos = await coleccion
          .find(where
              .eq("idProducto", idProducto)
              .sortBy("detalle", descending: false))
          .toList();
      (datos.isEmpty) ? null : (Multicodigo.fromMapList(datos));

      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future getId(ObjectId id) async {
    try {
      var datos = await coleccion.findOne(where.id(id));
      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<void> insertar(Multicodigo valor) async {
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

  static Future<void> actualizar(Multicodigo valor) async {
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

  static Future<void> eliminar(Multicodigo valor) async {
    try {
      await coleccion.remove(
        where.eq('_id', valor.id),
      );
    } catch (e) {
      print(e);
    }
  }

  //comprobar si el nombre existe
  static Future<bool> existeNombre(Multicodigo nombre) async {
    EstadoMulticodigos estado = Get.find<EstadoMulticodigos>();
    try {
      final existe =
          await coleccion.find(where.eq("codigo", nombre.codigo)).toList();
      return (existe.isEmpty)
          //si no esta en los multicodigos buscar en los productos
          ? await ProductosDB.getcodigo(nombre.codigo).then((value) {
              if (value != null) {
                informarFlotante(
                  context: estado.context,
                  texto: "El código ${nombre.codigo} pertenece al producto",
                  valor: value[0]['nombre'],
                );
              }
              return (value == null);
            })
          : (existe[0]['_id'] == nombre.id)
              ? true
              : () {
                  informarFlotante(
                    context: estado.context,
                    texto: "El código ${nombre.codigo} ya existe",
                    valor: existe[0]['detalle'],
                  );
                  return false;
                }();
    } catch (e) {
      print(e);
      return false;
    }
  }
}
