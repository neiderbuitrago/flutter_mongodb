// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mongodb/estado_getx/vantas_getx.dart';
import 'package:flutter_mongodb/modelos/productos.dart';
import 'package:get/get.dart';

import '../creacion/productos/cuadro_flotante_consulta_productos.dart';
import '../db/productos_mongo.dart';

class TextFieldBusqueda extends StatelessWidget {
  TextFieldBusqueda({super.key});
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        autofocus: true,
        textCapitalization: TextCapitalization.characters,
        onEditingComplete: () {
          ProductosDB.getcodigo(estadoVentas.controladorBuscar.text.toString())
              .then((value) {
            if (value != null) {
              // print(value);
              estadoVentas.agregarAVentas(
                  producto: Productos.fromMap(value[0]));
              estadoVentas.controladorBuscar.clear();
            } else {
              listaFlotanteConsulta(
                context: context,
                coleccion: "Productos",
                esProducto: true,
                letrasparaBuscar: estadoVentas.controladorBuscar.text,
                controladorBuscar: estadoVentas.controladorBuscar,
              ).then(
                (value) {
                  if (value != null) {
                    estadoVentas.agregarAVentas(producto: value);
                    estadoVentas.controladorBuscar.clear();
                    //   estadoProducto.controladores[1].text = value.nombre;
                    // llenarDatos(
                    //   codigo: value.codigo,
                    // );
                  }
                },
              );
            }
          });
        },
        controller: estadoVentas.controladorBuscar,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            gapPadding: 5,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Colors.lightBlueAccent,
              width: 2,
            ),
          ),

          labelText: "Buscar",
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          // cancelar el texto
          // suffix: GestureDetector(
          //   child: const Icon(
          //     Icons.search_sharp,
          //     color: Colors.grey,
          //     size: 30,
          //   ),
          // ),
        ),
        onChanged: (value) {},
      ),
    );
  }
}

texfieldFracciones({
  required String labelText,
  required int index,
  required context,
}) {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      autofocus: index == 0 ? true : false,
      textAlign: TextAlign.center,
      controller: estadoVentas.controlFracciones[index],
      focusNode: estadoVentas.focusFracciones[index],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          gapPadding: 5,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            color: Colors.lightBlueAccent,
            width: 2,
          ),
        ),
        // labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
      ),
      onEditingComplete: () {
        int cantidad = estadoVentas.focusFracciones.length;
        if (index + 1 < cantidad) {
          FocusScope.of(context)
              .requestFocus(estadoVentas.focusFracciones[index + 1]);
        } else {
          Navigator.of(context).pop();
        }
      },
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9-.]'))],
    ),
  );
}
