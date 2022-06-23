import 'package:mongo_dart/mongo_dart.dart';

import 'combo_detalle.dart';

class Combos {
  ObjectId id;

  String nombre;

  List<CombosDetalle> datosDescontar;

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

  static Combos fromBitacoraNube(datosCombo) {
    datosCombo['datosDescontar'];

    var mapa = (datosCombo['datosDescontar'])[0];

    List<CombosDetalle> lista = [];

    for (var i = 0; i < mapa.length; i++) {
      lista.add(CombosDetalle.fromMap(mapa[i.toString()]));
    }
    Combos combos = Combos(
      id: datosCombo['_id'],
      nombre: datosCombo['nombre'],
      datosDescontar: lista,
      sincronizado: datosCombo['sincronizado'],
    );
    return combos;
  }
}
