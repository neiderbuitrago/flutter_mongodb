import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../estado_getx/combos_getx.dart';
import '../../funciones_generales/response.dart';
import '../validation_function.dart';

class ListaCombos extends GetView<EstadoCombos> {
  const ListaCombos({Key? key, required this.esEditable}) : super(key: key);
  final bool esEditable;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EstadoCombos>(
      builder: (_) {
        return SizedBox(
          width: anchoPantalla(context).anchoLista,
          height: anchoPantalla(context).alto * 0.6,
          child: ListView.builder(
            itemCount: _.listaCombosFiltrados.length,
            itemBuilder: (context, index) {
              var combo = _.listaCombosFiltrados[index];
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
                    _.editarCombo(combo);
                    _.detalleCombosNombresCombos.value = false;
                  } else {
                    Navigator.of(context).pop(combo);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

    

//     SizedBox(
//       height: 420,
//       child: (estadoCombos.listaCombosFiltrados.isNotEmpty)
//           ? 
//           : const Center(
//               child: Text("No hay Combos",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             ),
//     );
//   }
// }
