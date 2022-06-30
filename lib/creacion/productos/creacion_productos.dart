// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/productos/text_form_field.dart';
import 'package:flutter_mongodb/db/marcas_mongo.dart';

import 'package:flutter_mongodb/estado_getx/getx_productos.dart';
import 'package:flutter_mongodb/estado_getx/venta_x_cantidad_getx.dart';
import 'package:get/get.dart';

import '../../estado_getx/identificadores.dart';
import '../../funciones_generales/response.dart';
import '../../modelos/marcas.dart';
import 'botonGuardar.dart';

class CreacionProductos extends StatefulWidget {
  const CreacionProductos({super.key});

  @override
  State<CreacionProductos> createState() => _CreacionProductosState();
}

class _CreacionProductosState extends State<CreacionProductos> {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  EstadoVentaXCantidad estadoVentaXCantidad = Get.put(EstadoVentaXCantidad());
  EstadoIdentificador estadoIdentificador = Get.put(EstadoIdentificador());
  @override
  Widget build(BuildContext context) {
    estadoProducto.marcaSeleccionada = MarcasGrupos.defecto();
    estadoProducto.grupoSeleccionado = MarcasGrupos.defecto();
    if (estadoProducto.controladores.isEmpty) {
      estadoProducto.controladores = [
        for (var i = 0; i < (estadoProducto.campos.length); i++)
          TextEditingController()
      ];

      // estadoVentaXCantidad.controladoresVentaXCantidad = [
      //   for (var i = 0; i < 16; i++) TextEditingController()
      // ];

      estadoProducto.focusNode = [
        for (int i = 0; i < (estadoProducto.campos.length + 1); i++) FocusNode()
      ];

      for (var i = 0; i < estadoProducto.campos.length; i + i++) {
        estadoProducto.listadeTexfromFieldPrincipal.add(
          TextFormFieldProducto(index: i),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creacion de Productos'),
      ),
      body: Form(
        key: estadoProducto.formKey.value,
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: (anchoPantalla(context).ancho < 600)
              ? ListView(
                  children: [
                    for (var i = 0;
                        i < estadoProducto.listadeTexfromFieldPrincipal.length;
                        i++)
                      estadoProducto.listadeTexfromFieldPrincipal[i],
                    // elevatedButtonGuardar(context),
                    const BotonGuardar(),
                  ],
                )
              : ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: anchoPantalla(context).ancho * 0.5,
                          child: Column(
                            children: [
                              for (var i = 0; i < 17; i++)
                                estadoProducto.listadeTexfromFieldPrincipal[i],
                            ],
                          ),
                        ),
                        SizedBox(
                          width: anchoPantalla(context).ancho * 0.5,
                          child: Column(
                            children: [
                              for (var i = 17;
                                  i <
                                      estadoProducto
                                          .listadeTexfromFieldPrincipal.length;
                                  i++)
                                estadoProducto.listadeTexfromFieldPrincipal[i],
                            ],
                          ),
                        )
                      ],
                    ),
                    const BotonGuardar(),
                    FloatingActionButton(
                      onPressed: () {
                        MarcaDB.getId(estadoProducto.marcaSeleccionada.id)
                            .then((value) => print(value[0]["nombre"]));
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
