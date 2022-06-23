import 'package:mongo_dart/mongo_dart.dart';

class Productos {
  final ObjectId id;
  final String codigo;
  final String nombre;
  final ObjectId marcaId;
  final ObjectId grupoId;
  final ObjectId impuestoId;
  final double cantidad;
  final double bodega1;
  final double bodega2;
  final double bodega3;
  final double bodega4;
  final double bodega5;
  final double cantidadMinima;
  final double cantidadMaxima;
  final DateTime fechaVenta;
  final DateTime fechaCompra;
  final ObjectId presentacionId;
  final double comision;
  final double descuentoPorcentaje;
  final double descuentoValor;
  final String ubicacion;
  final bool activoInactivo;
  final bool pesado;
  final bool manejaCombo;
  final bool manejaFracciones;
  final bool manejaVentaXCantidad;
  final bool manejaIdentificador;
  final bool manejaMulticodigo;
  final bool manejaBodegas;
  final bool manejaInventario;
  final ObjectId comboId;
  final double precioCompra;
  final double precioVenta1;
  final double precioVenta2;
  final double precioVenta3;
  final String sincronizado;
  final DateTime fechaCreacion;

  const Productos({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.marcaId,
    required this.grupoId,
    required this.impuestoId,
    required this.cantidad,
    required this.bodega1,
    required this.bodega2,
    required this.bodega3,
    required this.bodega4,
    required this.bodega5,
    required this.cantidadMinima,
    required this.cantidadMaxima,
    required this.fechaVenta,
    required this.fechaCompra,
    required this.presentacionId,
    required this.comision,
    required this.descuentoPorcentaje,
    required this.descuentoValor,
    required this.ubicacion,
    required this.activoInactivo,
    required this.pesado,
    required this.manejaCombo,
    required this.manejaFracciones,
    required this.manejaVentaXCantidad,
    required this.manejaIdentificador,
    required this.manejaMulticodigo,
    required this.manejaBodegas,
    required this.manejaInventario,
    required this.comboId,
    required this.precioCompra,
    required this.precioVenta1,
    required this.precioVenta2,
    required this.precioVenta3,
    required this.sincronizado,
    required this.fechaCreacion,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'nombre': nombre,
      'marcaId': marcaId,
      'grupoId': grupoId,
      'impuestoId': impuestoId,
      'cantidad': cantidad,
      'bodega1': bodega1,
      'bodega2': bodega2,
      'bodega3': bodega3,
      'bodega4': bodega4,
      'bodega5': bodega5,
      'cantidadMinima': cantidadMinima,
      'cantidadMaxima': cantidadMaxima,
      'fechaVenta': fechaVenta,
      'fechaCompra': fechaCompra,
      'presentacionId': presentacionId,
      'comision': comision,
      'descuentoPorcentaje': descuentoPorcentaje,
      'descuentoValor': descuentoValor,
      'ubicacion': ubicacion,
      'activoInactivo': activoInactivo,
      'pesado': pesado,
      "manejaCombo": manejaCombo,
      "manejaFracciones": manejaFracciones,
      "manejaVentaXCantidad": manejaVentaXCantidad,
      "manejaIdentificador": manejaIdentificador,
      "manejaMulticodigo": manejaMulticodigo,
      "manejaBodegas": manejaBodegas,
      "manejaInventario": manejaInventario,
      "comboId": comboId,
      "precioCompra": precioCompra,
      "precioVenta1": precioVenta1,
      "precioVenta2": precioVenta2,
      "precioVenta3": precioVenta3,
      "sincronizado": sincronizado,
      "fechaCreacion": fechaCreacion,
    };
  }

  static Productos? fromMap(Map<String, dynamic> map) {
    return Productos(
      id: map['_id'] as ObjectId,
      codigo: map['codigo'],
      nombre: map['nombre'],
      marcaId: map['marcaId'] as ObjectId,
      grupoId: map['grupoId'] as ObjectId,
      impuestoId: map['impuestoId'] as ObjectId,
      cantidad: map['cantidad'],
      bodega1: map['bodega1'],
      bodega2: map['bodega2'],
      bodega3: map['bodega3'],
      bodega4: map['bodega4'],
      bodega5: map['bodega5'],
      cantidadMinima: map['cantidadMinima'],
      cantidadMaxima: map['cantidadMaxima'],
      fechaVenta: map['fechaVenta'],
      fechaCompra: map['fechaCompra'],
      presentacionId: map['presentacionId'] as ObjectId,
      comision: map['comision'],
      descuentoPorcentaje: map['descuentoPorcentaje'],
      descuentoValor: map['descuentoValor'],
      ubicacion: map['ubicacion'],
      activoInactivo: map['activoInactivo'],
      pesado: map['pesado'],
      manejaCombo: map['manejaCombo'],
      manejaFracciones: map['manejaFracciones'],
      manejaVentaXCantidad: map['manejaVentaXCantidad'],
      manejaIdentificador: map['manejaIdentificador'],
      manejaMulticodigo: map['manejaMulticodigo'],
      manejaBodegas: map['manejaBodegas'],
      manejaInventario: map['manejaInventario'],
      comboId: map['comboId'] as ObjectId,
      precioCompra: map['precioCompra'],
      precioVenta1: map['precioVenta1'],
      precioVenta2: map['precioVenta2'],
      precioVenta3: map['precioVenta3'],
      sincronizado: map['sincronizado'],
      fechaCreacion: map['fechaCreacion'],
    );
  }
}
