// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/combos/texfield.dart';
import 'package:flutter_mongodb/db/combo.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../estado_getx/combos_getx.dart';

import '../../modelos/combo.dart';
import '../productos/cuadro_flotante_consulta_productos.dart';
import '../widget.dart';
import 'lista_detalle_combo.dart';
import 'lista_seleccionar.dart';

class CrearCombo extends StatelessWidget {
  CrearCombo({super.key});

  EstadoCombos estadoCombos = Get.find<EstadoCombos>();
  bool nombreDetalle = true;

  IconButton deleteProduct() {
    return IconButton(
      icon: const Icon(
        Icons.delete_sweep_outlined,
        size: 35,
        color: Colors.redAccent,
      ),
      tooltip: 'Eliminar Combo',
      onPressed: () {
        if (!estadoCombos.nuevoEditar.value) {
          estadoCombos.eliminarCombo();
        } else {
          Get.snackbar('Error', 'No hay datos para eliminar',
              titleText: const Text(
                'Error',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              messageText: const Text(
                'No hay datos para eliminar.',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color.fromARGB(255, 249, 127, 127),
              colorText: Colors.white,
              borderRadius: 20,
              margin: const EdgeInsets.all(30),
              borderColor: Colors.redAccent,
              borderWidth: 1);
        }
      },
    );
  }

  IconButton addProduct(BuildContext context) {
    return IconButton(
      onPressed: () {
        listaFlotanteConsulta(
          context: context,
          coleccion: "productos",
          esProducto: true,
          letrasparaBuscar: '',
        ).then((value) {
          if (value != null) {
            estadoCombos.agregarProducto(value);
            // estadoCombos.pintarDetalle();
          }
        });
      },
      icon: const Icon(
        Icons.dashboard_customize_outlined,
        color: Colors.greenAccent,
        size: 35,
      ),
      tooltip: 'Agregar producto',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 156, 156, 156).withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                )
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            height: (!estadoCombos.detalleCombosNombresCombos.value) ? 114 : 65,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                const TexfieldCombos(
                  labelText: 'Nombre del combo',
                  index: 0,
                ),
                Obx(
                  () => Visibility(
                    visible: !estadoCombos.detalleCombosNombresCombos.value,
                    child: Positioned(
                      bottom: 0.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          addProduct(context),
                          const SizedBox(
                            width: 10,
                          ),
                          guardar(context),
                          deleteProduct(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          (estadoCombos.detalleCombosNombresCombos.value)
              ? const SizedBox(
                  height: 500,
                  child: ListaCombos(
                    esEditable: true,
                  ),
                )
              : const ListaDetalladoCombos(),
        ],
      ),
    );
  }
}

Padding guardar(
  BuildContext context,
) {
  EstadoCombos estadoCombos = Get.find<EstadoCombos>();
  return elevatedButtonGuardar1(
    focusNode: FocusNode(),
    context: context,
    onPressed: () {
      if (estadoCombos.controlleresCombosDetalle[0].text.isNotEmpty &&
          estadoCombos.combosDetalleAux.isNotEmpty) {
        Combos comboGuardar = Combos(
          id: estadoCombos.nuevoEditar.value
              ? ObjectId()
              : estadoCombos.comboConsultado.id,
          nombre: estadoCombos.controlleresCombosDetalle[0].text,
          datosDescontar:
              Combos.toListCombos(estadoCombos.combosDetalleAux.toList()),
          sincronizado: '',
        );
        if (estadoCombos.nuevoEditar.value) {
          ComboDB.insertar(comboGuardar).then((value) {
            estadoCombos.limpiarDetalles();
            estadoCombos.filtrarCombos("");
          });
        } else {
          ComboDB.actualizar(comboGuardar).then((value) {
            estadoCombos.limpiarDetalles();
            estadoCombos.filtrarCombos("");
          });
        }

        for (var i = 2;
            i < estadoCombos.controlleresCombosDetalle.length;
            i++) {
          estadoCombos.controlleresCombosDetalle.removeAt(i);
        }
        estadoCombos.controlleresCombosDetalle = [TextEditingController()];

        estadoCombos.tituloCombos.value = 'Crear Combo';
        estadoCombos.nuevoEditar.value = true;
      }
    },
  );
}
