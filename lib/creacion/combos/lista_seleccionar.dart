import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../estado_getx/combos_getx.dart';
import '../validation_function.dart';

class ListaCombos extends StatelessWidget {
  const ListaCombos({
    Key? key,
    required this.esEditable,
    this.actualizar,
  }) : super(key: key);

  final bool esEditable;
  final Function? actualizar;

  //final Function cambioDetalleNombre;

  @override
  Widget build(BuildContext context) {
    EstadoCombos estadoCombos = Get.find<EstadoCombos>();
    return SizedBox(
      height: 420,
      child: (estadoCombos.listaCombosFiltrados.isNotEmpty)
          ? ListView.builder(
              itemCount: estadoCombos.listaCombosFiltrados.length,
              itemBuilder: (context, index) {
                var combo = estadoCombos.listaCombosFiltrados[index];
                return ListTile(
                  hoverColor: Colors.white,
                  focusColor: Colors.white,
                  selectedTileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                        color: Colors.primaries[
                            indiceReverse(index) % Colors.primaries.length],
                        width: 1),
                  ),
                  leading: Icon(
                    (esEditable)
                        ? Icons.drive_file_rename_outline_outlined
                        : Icons.done_outline_rounded,
                    color: Colors.primaries[
                        indiceReverse(index) % Colors.primaries.length],
                  ),
                  title: Text(
                    combo.nombre,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    if (esEditable) {
                      estadoCombos.editarCombo(combo.id);
                      estadoCombos.detalleCombosNombresCombos.value = false;
                      actualizar!();
                    } else {
                      Navigator.of(context).pop(combo);
                    }
                  },
                );
              },
            )
          : const Center(
              child: Text("No hay Combos",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
    );
  }
}
