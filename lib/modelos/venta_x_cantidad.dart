import 'package:mongo_dart/mongo_dart.dart';

class VentaXCantidad {
  ObjectId id;
  double desde1;
  double hasta1;
  double precio1;
  double desde2;
  double hasta2;
  double precio2;
  double desde3;
  double hasta3;
  double precio3;
  double desde4;
  double hasta4;
  double precio4;
  String sincronizado;
  VentaXCantidad({
    required this.id,
    this.desde1 = 0.0,
    this.hasta1 = 0.0,
    this.precio1 = 0.0,
    this.desde2 = 0.0,
    this.hasta2 = 0.0,
    this.precio2 = 0.0,
    this.desde3 = 0.0,
    this.hasta3 = 0.0,
    this.precio3 = 0.0,
    this.desde4 = 0.0,
    this.hasta4 = 0.0,
    this.precio4 = 0.0,
    this.sincronizado = '',
  });

  //
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'desde1': desde1,
      'hasta1': hasta1,
      'precio1': precio1,
      'desde2': desde2,
      'hasta2': hasta2,
      'precio2': precio2,
      'desde3': desde3,
      'hasta3': hasta3,
      'precio3': precio3,
      'desde4': desde4,
      'hasta4': hasta4,
      'precio4': precio4,
      'sincronizado': sincronizado,
    };
  }

  factory VentaXCantidad.fromMap(Map<String, dynamic> map) {
    return VentaXCantidad(
      id: map['_id'],
      desde1: map['desde1'],
      hasta1: map['hasta1'],
      precio1: map['precio1'],
      desde2: map['desde2'],
      hasta2: map['hasta2'],
      precio2: map['precio2'],
      desde3: map['desde3'],
      hasta3: map['hasta3'],
      precio3: map['precio3'],
      desde4: map['desde4'],
      hasta4: map['hasta4'],
      precio4: map['precio4'],
      sincronizado: map['sincronizado'],
    );
  }

//iniciar un objeto de tipo Marca desde un string

}
