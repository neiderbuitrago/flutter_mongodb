// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/productos/text_form_field.dart';
import 'package:flutter_mongodb/db/presentacion.dart';
import 'package:flutter_mongodb/estado_getx/combos_getx.dart';
import 'package:flutter_mongodb/estado_getx/multicodigo_getx.dart';
import 'package:flutter_mongodb/estado_getx/presentacion_getx.dart';

import 'package:flutter_mongodb/estado_getx/productos_getx.dart';
import 'package:flutter_mongodb/estado_getx/venta_x_cantidad_getx.dart';
import 'package:flutter_mongodb/modelos/combo.dart';
import 'package:get/get.dart';

import '../../estado_getx/identificadores.dart';
import '../../funciones_generales/response.dart';
import '../../modelos/marcas.dart';
import '../../modelos/presentacion.dart';
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
  EstadoMulticodigos estadoMulticodigos = Get.put(EstadoMulticodigos());
  EstadoCombos estadoCombos = Get.put(EstadoCombos());
  EstadoPresentacion estadoPresentacion = Get.put(EstadoPresentacion());
  @override
  void initState() {
    estadoProducto.marcaSeleccionada = MarcasGrupos.defecto();
    estadoProducto.grupoSeleccionado = MarcasGrupos.defecto();
    estadoProducto.comboSeleccionado = Combos.defecto();
    PresentacionDB.getUnidad("UNIDAD").then((value) {
      if (value != null) {
        estadoProducto.presentacionSeleccionada =
            Presentacion.fromMap(value[0]);
      } else {
        estadoProducto.presentacionSeleccionada = Presentacion.defecto();
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (estadoProducto.controladores.isEmpty) {
      estadoProducto.controladores = [
        for (var i = 0; i < (estadoProducto.campos.length); i++)
          TextEditingController()
      ];

      estadoProducto.focusNode = [
        for (int i = 0; i < (estadoProducto.campos.length + 1); i++) FocusNode()
      ];

      for (var i = 0; i < estadoProducto.campos.length; i + i++) {
        estadoProducto.listadeTexfromFieldPrincipal.add(
          TextFormFieldProducto(index: i),
        );
      }
      FocusScope.of(context).requestFocus(estadoProducto.focusNode[0]);
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
                    const SizedBox(
                      height: 8,
                    ),
                    for (var i = 0;
                        i < estadoProducto.listadeTexfromFieldPrincipal.length;
                        i++)
                      estadoProducto.listadeTexfromFieldPrincipal[i],
                    // elevatedButtonGuardar(context),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: BotonGuardar(),
                    ),
                  ],
                )
              : ListView(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 180),
                      child: BotonGuardar(),
                    ),
                    // FloatingActionButton(
                    //   onPressed: () {
                    //     MarcaDB.getId(estadoProducto.marcaSeleccionada.id)
                    //         .then((value) => print(value[0]["nombre"]));
                    //   },
                    //   child: const Icon(Icons.add),
                    // ),
                  ],
                ),
        ),
      ),
    );
  }
}
