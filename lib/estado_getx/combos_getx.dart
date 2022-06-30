import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../db/combo.dart';
import '../funciones_generales/numeros.dart';
import '../modelos/combo.dart';
import '../modelos/combo_detalle.dart';

class EstadoCombos extends GetxController {
  late List<CombosDetalle> combosDetalleAux = <CombosDetalle>[].obs;
  late Combos comboConsultado = <Combos>{}.obs as Combos;
  late List<Map<String, dynamic>> combosDetalleOriginal =
      <Map<String, dynamic>>[].obs;

  late List controlleresCombosDetalle = [TextEditingController()].obs;
  var nuevoEditar = true.obs;
  var codigoCombo = ObjectId().obs;
  var operacion = 'INSERT'.obs;
  late List<Combos> listaCombosFiltrados = <Combos>[].obs;
  var detalleCombosNombresCombos = false.obs;

  var tituloCombos = 'Seleccionar Combo'.obs;
  var seleccionarCrear = true.obs;

  editarCombo(ObjectId codigo) {
    operacion.value = 'UPDATE';
    codigoCombo.value = codigo;
    ComboDB.getId(codigo).then((value) {
      if (value != null) {
        controlleresCombosDetalle = [
          for (var i = 0; i < value.datosDescontar.length + 1; i++)
            TextEditingController()
        ];
      }

      combosDetalleAux = value.datosDescontar.map((e) {
        return CombosDetalle(
          id: e.id,
          nombre: e.nombre,
          cantidad: e.cantidad,
          fraccion: e.fraccion,
        );
      }).toList();
      controlleresCombosDetalle[0].text = value.nombre;
      pintarDetalle();
    });
  }

  pintarDetalle() {
    for (var i = 0; i < combosDetalleAux.length; i++) {
      controlleresCombosDetalle[i + 1].text =
          quitarDecimales(combosDetalleAux[i].cantidad);
    }
  }

  cambiarSeleccionarCrear() {
    limpiarControllers();
    seleccionarCrear.value = !seleccionarCrear.value;
  }

  limpiarControllers() {
    for (var i = 1; i < controlleresCombosDetalle.length; i++) {
      controlleresCombosDetalle[i].text = '';
    }
  }

  crearOEditarCombo() {
    detalleCombosNombresCombos.value = !detalleCombosNombresCombos.value;

    tituloCombos.value =
        (tituloCombos.value == 'Editar Combo') ? 'Crear Combo' : 'Editar Combo';
  }
}
