// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/combos/texfield.dart';
import 'package:get/get.dart';

import '../../estado_getx/combos_getx.dart';
import '../../funciones_generales/response.dart';
import '../../modelos/combo_detalle.dart';
import '../validation_function.dart';

class ListaDetalladoCombos extends StatefulWidget {
  const ListaDetalladoCombos({
    required this.listaDetalleCombos,
    required this.actualizar,
    Key? key,
  }) : super(key: key);

  // final List<Map<String, dynamic>> listaDetalleCombos;
  final List<CombosDetalle> listaDetalleCombos;
  final Function actualizar;

  @override
  State<ListaDetalladoCombos> createState() => _ListaDetalladoCombosState();
}

class _ListaDetalladoCombosState extends State<ListaDetalladoCombos> {
  @override
  Widget build(BuildContext context) {
    EstadoCombos estadoCombos = Get.find<EstadoCombos>();
    AnchoDePantalla medidas = anchoPantalla(context);

    eliminarUnProducto(int index) {
      estadoCombos.combosDetalleAux.removeAt(index);
      estadoCombos.controlleresCombosDetalle.removeAt(index + 1);
      setState(() {});
    }

    return (widget.listaDetalleCombos.isNotEmpty)
        ? SizedBox(
            height: medidas.alto * 0.8 -
                170 -
                MediaQuery.of(context).viewInsets.bottom,
            child: ListView.builder(
              itemCount: widget.listaDetalleCombos.length,
              itemBuilder: (context, index) {
                final combo = widget.listaDetalleCombos[index];
                return SizedBox(
                  child: ListTile(
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
                    title: Text(
                      combo.nombre,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Codigo: ${combo.id}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: TexfieldCombos(
                              labelText: 'Cantidad',
                              index: indiceReverse(index),
                              // cambioDetalleNombre: () {},
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              eliminarUnProducto(indiceReverse(index) - 1);
                              widget.actualizar();
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.primaries[indiceReverse(index) %
                                  Colors.primaries.length],
                            ),
                            padding: const EdgeInsets.all(0),
                            iconSize: 35,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).pop(marca);
                    },
                  ),
                );
              },
            ),
          )
        : SizedBox(
            height: medidas.alto * 0.8 -
                170 -
                MediaQuery.of(context).viewInsets.bottom,
            child: const Center(
              child: Text("No hay productos",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          );
    // ),
  }
}
