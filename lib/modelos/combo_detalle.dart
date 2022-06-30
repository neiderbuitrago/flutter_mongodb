import 'package:mongo_dart/mongo_dart.dart';

class CombosDetalle {
  ObjectId id;
  String nombre;
  double cantidad;
  double fraccion;
  CombosDetalle({
    required this.id,
    required this.nombre,
    required this.cantidad,
    required this.fraccion,
  });
  //
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'cantidad': cantidad,
      'fraccion': fraccion,
    };
  }

  factory CombosDetalle.fromMap(Map<String, dynamic> map) {
    return CombosDetalle(
      id: map['_id'],
      nombre: map['nombre'],
      cantidad: double.parse(map['cantidad'].toString()),
      fraccion: double.parse(map['fraccion'].toString()),
    );
  }

  static List<CombosDetalle> toListCombo(List<dynamic> datosCombo) {
    List<CombosDetalle> combosDetalle = [];
    for (int i = 0; i < datosCombo.length; i++) {
      CombosDetalle comboDetalle = CombosDetalle(
        id: datosCombo[i].id,
        nombre: datosCombo[i].nombre,
        cantidad: datosCombo[i].cantidad,
        fraccion: datosCombo[i].fraccion,
      );
      combosDetalle.add(comboDetalle);
    }
    return combosDetalle;
  }
}
