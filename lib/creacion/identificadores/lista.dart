// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../estado_getx/identificadores.dart';
import '../../funciones_generales/response.dart';

Widget listaIdentificador(
    {required AnchoDePantalla medidas, required BuildContext context}) {
  // EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();

  return SizedBox(
    height: ((estadoIdentificador.mapIdentificador.length * 65).toDouble() <
            medidas.alto * 0.9 - 253 - MediaQuery.of(context).viewInsets.bottom)
        ? (estadoIdentificador.mapIdentificador.length * 67).toDouble()
        : medidas.alto * 0.9 - 253 - MediaQuery.of(context).viewInsets.bottom,
    width: medidas.anchoLista - 1,
    child: ListView.builder(
      itemCount: estadoIdentificador.mapIdentificador.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            estadoIdentificador.mapIdentificador[index].identificador,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(estadoIdentificador.mapIdentificador[index].nombre),
          trailing: Text(
            estadoIdentificador.mapIdentificador[index].cantidad.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          onTap: () {
            estadoIdentificador.editarIdentificador(
                estadoIdentificador.mapIdentificador[index]);
            print(' codigo ${estadoIdentificador.mapIdentificador[index].id}');
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.primaries[index % Colors.primaries.length],
              width: 1,
            ),
          ),
        );
      },
    ),
  );
}
