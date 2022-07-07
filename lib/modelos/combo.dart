import 'package:flutter_mongodb/modelos/productos.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Combos {
  ObjectId id;
  String nombre;
  List<Map<String, dynamic>> datosDescontar;

  String sincronizado;
  Combos({
    required this.id,
    required this.nombre,
    required this.datosDescontar,
    required this.sincronizado,
  });
  //
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'datosDescontar': datosDescontar,
      'sincronizado': sincronizado,
    };
  }

  factory Combos.fromMap(Map<dynamic, dynamic> map) {
    return Combos(
      id: map['_id'],
      nombre: map['nombre'],
      datosDescontar: map['datosDescontar'],
      sincronizado: map['sincronizado'],
    );
  }
  //lista de combos desde la base de datos mongoDB en formato List mapList
  static List<Combos> fromMapList(List mapList) {
    List<Combos> list = [];
    for (var map in mapList) {
      list.add(Combos.fromBitacoraNube(map));
    }
    return list;
  }

  static Combos fromBitacoraNube(datosCombo) {
    datosCombo['datosDescontar'];

    var mapa = (datosCombo['datosDescontar']);

    List<Map<String, dynamic>> lista = [];

    for (var i = 0; i < mapa.length; i++) {
      lista.add((mapa[i]) as Map<String, dynamic>);
    }
    Combos combos = Combos(
        id: datosCombo['_id'],
        nombre: datosCombo['nombre'],
        datosDescontar: lista,
        sincronizado: datosCombo['sincronizado']);
    return combos;
  }

  static List<Map<String, dynamic>> toListCombos(List datosCombo) {
    List<Map<String, dynamic>> lista = [];

    for (var i = 0; i < datosCombo.length; i++) {
      lista.add(CombosDetalle.toMap(datosCombo[i]));
    }

    return lista;
  }

  static Combos defecto() {
    return Combos(
      id: ObjectId(),
      nombre: '',
      datosDescontar: [],
      sincronizado: '',
    );
  }

  isEmpty() {
    return (nombre.isEmpty && datosDescontar.isEmpty);
  }
}
//
//
//
//
//

class CombosDetalle {
  ObjectId id;
  String codigo;
  String nombre;
  double cantidad;
  double fraccion;
  CombosDetalle({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.cantidad,
    required this.fraccion,
  });
  //
  static Map<String, dynamic> toMap(CombosDetalle valor) {
    return {
      '_id': valor.id,
      'codigo': valor.codigo,
      'nombre': valor.nombre,
      'cantidad': valor.cantidad,
      'fraccion': valor.fraccion,
    };
  }

  factory CombosDetalle.fromMap(map) {
    return CombosDetalle(
      id: map['_id'],
      codigo: map['codigo'],
      nombre: map['nombre'],
      cantidad: double.parse(map['cantidad'].toString()),
      fraccion: double.parse(map['fraccion'].toString()),
    );
  }

  static List<CombosDetalle> toListComboDetalle(List<dynamic> datosCombo) {
    List<CombosDetalle> combosDetalle = [];
    for (int i = 0; i < datosCombo.length; i++) {
      CombosDetalle comboDetalle = CombosDetalle(
        id: datosCombo[i]["_id"],
        codigo: datosCombo[i]["codigo"],
        nombre: datosCombo[i]["nombre"],
        cantidad: datosCombo[i]["cantidad"],
        fraccion: datosCombo[i]["fraccion"],
      );
      combosDetalle.add(comboDetalle);
    }
    return combosDetalle;
  }

  static CombosDetalle toProducto(Productos datosProducto) {
    return CombosDetalle(
      id: datosProducto.id,
      codigo: datosProducto.codigo,
      nombre: datosProducto.nombre,
      cantidad: 1,
      fraccion: 0,
    );
  }
}
