import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../db/combo.dart';
import '../funciones_generales/numeros.dart';
import '../modelos/combo.dart';

class EstadoCombos extends GetxController {
  late List<CombosDetalle> combosDetalleAux = <CombosDetalle>[].obs;
  late Combos comboConsultado = <Combos>{}.obs as Combos;
  late List<Map<String, dynamic>> combosDetalleOriginal =
      <Map<String, dynamic>>[].obs;

  late List controlleresCombosDetalle = [TextEditingController()].obs;
  TextEditingController controllerFiltro = TextEditingController();
  var nuevoEditar = true.obs;
  var codigoCombo = ObjectId().obs;
  var operacion = 'INSERT'.obs;
  late List<Combos> listaCombosFiltrados = <Combos>[].obs;
  var detalleCombosNombresCombos = false.obs;

  var tituloCombos = 'Seleccionar Combo'.obs;
  var seleccionarCrear = true.obs;

  editarCombo(Combos combo) async {
    await ComboDB.getId(combo.id).then((comboo) {
      if (comboo != null) {
        limpiarDetalles();
        nuevoEditar.value = false;
        comboConsultado = comboo;
        for (var i = 0; i < comboo.datosDescontar.length; i++) {
          controlleresCombosDetalle.add(TextEditingController());
        }

        combosDetalleAux =
            CombosDetalle.toListComboDetalle(comboo.datosDescontar);

        controlleresCombosDetalle[0].text = comboo.nombre;
        pintarDetalle();
      }
    });
  }

  pintarDetalle() {
    for (var i = 0; i < combosDetalleAux.length; i++) {
      controlleresCombosDetalle[i + 1].text =
          quitarDecimales(combosDetalleAux[i].cantidad);
    }
    update();
  }

  cambiarSeleccionarCrear() {
    limpiarDetalles();
    seleccionarCrear.value = !seleccionarCrear.value;
  }

  limpiarDetalles() {
    controlleresCombosDetalle[0].clear();
    for (var i = 0; i < controlleresCombosDetalle.length; i++) {
      controlleresCombosDetalle[i].text = '';
    }
    var controller0 = controlleresCombosDetalle[0];
    controlleresCombosDetalle = [controller0];
    nuevoEditar.value = true;
    combosDetalleAux.clear();
    update();
  }

  crearOEditarCombo() {
    detalleCombosNombresCombos.value = !detalleCombosNombresCombos.value;

    tituloCombos.value =
        (tituloCombos.value == 'Editar Combo') ? 'Crear Combo' : 'Editar Combo';
  }

  agregarProducto(value) {
    controlleresCombosDetalle.add(TextEditingController(text: 1.toString()));
    combosDetalleAux.add(CombosDetalle.toProducto(value));
    detalleCombosNombresCombos.value = false;
    update();
  }

  eliminarUnProducto(int index) {
    combosDetalleAux.removeAt(index);
    controlleresCombosDetalle.removeAt(index + 1);
    update();
  }

  eliminarCombo() {
    EstadoCombos estadoCombos = Get.find();
    ComboDB.eliminar(estadoCombos.comboConsultado).then((value) => update());
  }

  filtrarCombos(String texto) {
    ComboDB.getParametro(texto).then(
      (value) {
        if (value != null) {
          listaCombosFiltrados = Combos.fromMapList(value);
          update();
        }
      },
    );
  }
}
