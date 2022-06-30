// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/modelos/tarifa_impuestos.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../modelos/marcas.dart';
import '../modelos/productos.dart';

class EstadoProducto extends GetxController {
  var manejaVentaFraccionada = false.obs;
  var manejaVentaXCantidad = false.obs;
  var manejaIdentificador = false.obs;
  var manejaCombos = false.obs;
  var manejaMulticodigos = false.obs;
  var manejaVentaXPeso = false.obs;
  var manejaBodegas = false.obs;
  var manejaInventario = false.obs;
  var estadoDelProducto = true.obs;
  var colorTextovalido = false.obs;
  var cambiarSwitch = false.obs;
  var idComboSeleccionado = 0.obs;
  var nombreComboSeleccionado = ''.obs;
  var seleccionTipoProducto = 'Activo'.obs;
  late MarcasGrupos marcaSeleccionada = <MarcasGrupos>{}.obs as MarcasGrupos;
  late MarcasGrupos grupoSeleccionado = <MarcasGrupos>{}.obs as MarcasGrupos;
  late Impuesto impuestoSeleccionado = <Impuesto>{}.obs as Impuesto;
  var comboSeleccionado = 0.obs;
  var marcasFiltradas = [].obs;
  List<TextEditingController> controladores = <TextEditingController>[].obs;
  List<FocusNode> focusNode = <FocusNode>[].obs;
  List<Widget> listadeTexfromFieldPrincipal = <Widget>[].obs;
  var formKey = GlobalKey<FormState>().obs;

  late Productos productoConsultado = {}.obs as Productos;
  var nuevoEditar = true.obs;

  var productoNoEncontrados = Productos(
    id: ObjectId(),
    codigo: '',
    nombre: '',
    marcaId: ObjectId(),
    grupoId: ObjectId(),
    impuestoId: ObjectId(),
    cantidad: 0,
    bodega1: 0,
    bodega2: 0,
    bodega3: 0,
    bodega4: 0,
    bodega5: 0,
    cantidadMinima: 0,
    cantidadMaxima: 0,
    fechaVenta: DateTime.now(),
    fechaCompra: DateTime.now(),
    presentacionId: ObjectId(),
    comision: 0,
    descuentoPorcentaje: 0,
    descuentoValor: 0,
    ubicacion: '',
    activoInactivo: false,
    pesado: false,
    manejaCombo: false,
    manejaFracciones: false,
    manejaVentaXCantidad: false,
    manejaIdentificador: false,
    manejaMulticodigo: false,
    manejaBodegas: false,
    tipoProducto: 'Activo',
    comboId: ObjectId(),
    precioCompra: 0,
    precioVenta1: 0,
    precioVenta2: 0,
    precioVenta3: 0,
    sincronizado: '',
    fechaCreacion: DateTime.now(),
  ).obs;

  Map tipoProducto = {
    0: 'Activo',
    1: 'Inactivo',
    2: 'No descontar stock',
    3: 'Insumo',
  }.obs;

  cambiarTipoProducto() {
    int index =
        tipoProducto.values.toList().indexOf(seleccionTipoProducto.value) + 1;
    seleccionTipoProducto.value = tipoProducto[(index == 4) ? 0 : index];
    cambiarSwitch.value = (index == 1 || index == 2) ? true : false;
  }

  guardarIdMarcaGrupoImpuesto({required int index, required value}) {
    print('el codigo de la marca es $value');
    if (value != null) {
      switch (index) {
        case 2:
          marcaSeleccionada = MarcasGrupos.fromMap(value);
          controladores[2].text = marcaSeleccionada.nombre;
          break;
        case 3:
          grupoSeleccionado = MarcasGrupos.fromMap(value);
          controladores[3].text = grupoSeleccionado.nombre;
          break;
        case 4:
          impuestoSeleccionado = Impuesto.fromMap(value);
          controladores[4].text = impuestoSeleccionado.nombre;
          break;
      }
    }
  }

  List<String> campos = [
    'Codigo',
    'Nombre',
    'Marca',
    'Grupo',
    'Impuesto',
    'Precio Costo',
    'Cantidad',
    'Bodega1',
    'Bodega2',
    'Bodega3',
    'Bodega4',
    'Bodega5',
    'Precio Venta 1',
    'Precio Venta 2',
    'Precio Venta 3',
    'Cantidad Minima',
    'Cantidad Maxima',
    'Presentacion',
    'Comision %',
    'Descuento Porcentaje',
    'Descuento Fijo',
    'Ubiacion',
    'Venta Fraccionada',
    'Venta X Cantidad',
    'Manejo Identificador',
    'Combos',
    'Multicodicos',
    'Venta X Peso',
    'Estado',
  ];

  funtionHabilitar({required int index}) {
    switch (index) {
      case 22:
        manejaVentaFraccionada.value = !manejaVentaFraccionada.value;
        break;
      case 23:
        manejaVentaXCantidad.value = !manejaVentaXCantidad.value;
        break;
      case 24:
        manejaIdentificador.value = !manejaIdentificador.value;
        break;
      case 25:
        manejaCombos.value = !manejaCombos.value;
        break;
      case 26:
        manejaMulticodigos.value = !manejaMulticodigos.value;
        break;
      case 27:
        manejaVentaXPeso.value = !manejaVentaXPeso.value;
        break;
      case 28:
        estadoDelProducto.value = !estadoDelProducto.value;
        break;
    }
  }
}
