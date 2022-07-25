import 'package:mongo_dart/mongo_dart.dart';

class IdentificadorDetalle {
  ObjectId id;
  ObjectId idPadre;
  String nombre;
  String identificador;
  double cantidad;
  IdentificadorDetalle({
    required this.id,
    required this.idPadre,
    required this.nombre,
    required this.identificador,
    required this.cantidad,
  });
  //
  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "idPadre": idPadre,
      'nombre': nombre,
      'identificador': identificador,
      'cantidad': cantidad,
    };
  }

  factory IdentificadorDetalle.fromMap(Map<String, dynamic> map) {
    return IdentificadorDetalle(
      id: map['_id'],
      idPadre: map['idPadre'],
      nombre: map['nombre'],
      identificador: map['identificador'],
      cantidad: map['cantidad'],
    );
  }

  static Map<int, IdentificadorDetalle> toListMap(List<dynamic> list) {
    Map<int, IdentificadorDetalle> map = {};
    for (var i = 0; i < list.length; i++) {
      map[i] = IdentificadorDetalle.fromMap(list[i]);
    }
    return map;
  }

  void llenarInstancia(IdentificadorDetalle identificador) {}
}

class IdentificadorVenta extends IdentificadorDetalle {
  double temCantidad;
  IdentificadorVenta({
    this.temCantidad = 0.0,
  }) : super(
          id: ObjectId(),
          idPadre: ObjectId(),
          nombre: "",
          identificador: "",
          cantidad: 0.0,
        );

  llenarInstancia(detalle) {
    id = detalle.id;
    idPadre = detalle.idPadre;
    nombre = detalle.nombre;
    identificador = detalle.identificador;
    cantidad = detalle.cantidad;
  }
}
