import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/combos/texfield.dart';
import 'package:flutter_mongodb/db/combo.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../estado_getx/combos_getx.dart';
import '../../modelos/combo.dart';
import '../../modelos/combo_detalle.dart';
import '../productos/cuadro_flotante_consulta_productos.dart';
import '../widget.dart';
import 'lista_detalle_combo.dart';
import 'lista_seleccionar.dart';

class CrearCombo extends StatelessWidget {
  CrearCombo({super.key});

  var estadoCombos = Get.find<EstadoCombos>();
  bool nombreDetalle = true;
  // List<Map<String, dynamic>> listaDetalleCombos = [];
  List<CombosDetalle> listaDetalleCombos = [];

  actualzar() {
    listaDetalleCombos = estadoCombos.combosDetalleAux.reversed.toList();
  }

  IconButton deleteProduct() {
    return IconButton(
      icon: const Icon(
        Icons.delete_sweep_outlined,
        size: 35,
        color: Colors.redAccent,
      ),
      tooltip: 'Eliminar Combo',
      onPressed: () {},
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
            estadoCombos.combosDetalleAux.add(CombosDetalle.fromMap(value));
            estadoCombos.controlleresCombosDetalle.add(TextEditingController());
            estadoCombos.detalleCombosNombresCombos.value = false;
            estadoCombos.pintarDetalle();
            actualzar();
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
                          guardar(context, estadoCombos, actualzar),
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
              ? SizedBox(
                  height: 500,
                  child: ListaCombos(
                    esEditable: true,
                    actualizar: actualzar,
                    // cambioDetalleNombre: widget.cambioDetalleNombre,
                  ),
                )
              : ListaDetalladoCombos(
                  listaDetalleCombos: listaDetalleCombos,
                  actualizar: actualzar),
        ],
      ),
    );
  }
}

Padding guardar(
  BuildContext context,
  EstadoCombos estadoCombos,
  Function actualizar,
) {
  return elevatedButtonGuardar1(
    focusNode: FocusNode(),
    context: context,
    onPressed: () {
      if (estadoCombos.controlleresCombosDetalle[0].text.isNotEmpty &&
          estadoCombos.combosDetalleAux.isNotEmpty) {
        Combos comboGuardar = Combos(
          id: estadoCombos.nuevoEditar.value
              ? ObjectId()
              : estadoCombos.codigoCombo.value,
          nombre: estadoCombos.controlleresCombosDetalle[0].text,
          datosDescontar: estadoCombos.combosDetalleAux.toList(),
          sincronizado: '',
        );

        if (estadoCombos.nuevoEditar.value) {
          ComboDB.insertar(comboGuardar).then((value) {});
        } else {
          ComboDB.actualizar(comboGuardar).then((value) {});
        }

        estadoCombos.combosDetalleAux.clear();

        for (var i = 2;
            i < estadoCombos.controlleresCombosDetalle.length;
            i++) {
          estadoCombos.controlleresCombosDetalle.removeAt(i);
        }

        estadoCombos.controlleresCombosDetalle = [TextEditingController()];

        actualizar();
        estadoCombos.tituloCombos.value = 'Crear Combo';
        estadoCombos.nuevoEditar.value = true;
      }
    },
  );
}
