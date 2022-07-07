// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter_mongodb/creacion/identificadores/textfild_identificador.dart';
import 'package:flutter_mongodb/creacion/identificadores/widget.dart';
import 'package:flutter_mongodb/db/identificadores.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../estado_getx/identificadores.dart';
import '../../funciones_generales/response.dart';
import '../../funciones_generales/strings.dart';
import '../venta_x_cantidad/widget.dart';

import 'lista.dart';

Future<dynamic> listaIdentificadores({
  required BuildContext context,
}) {
  return showDialog(
    barrierColor: Colors.black.withOpacity(0.2),
    context: context,
    builder: (context) {
      return const Dialog(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: ListaIdentificadores(),
        ),
      );
    },
  );
}

class ListaIdentificadores extends StatefulWidget {
  const ListaIdentificadores({super.key});

  @override
  _ListaIdentificadoresState createState() => _ListaIdentificadoresState();
}

class _ListaIdentificadoresState extends State<ListaIdentificadores> {
  @override
  void initState() {
    consultarDatos(actualizar);
    super.initState();
  }

  actualizar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    EstadoIdentificador estadoIdentificador = Get.find<EstadoIdentificador>();

    AnchoDePantalla medidas = anchoPantalla(context);

    campoEnMayusculas(
        controller: estadoIdentificador.controllerIdentificador[0]);
    campoEnMayusculas(
        controller: estadoIdentificador.controllerIdentificador[1]);

    var floatingActionButton = FloatingActionButton.extended(
      onPressed: () {
        estadoIdentificador.controllerIdentificador[1].clear();
        estadoIdentificador.controllerIdentificador[2].clear();
        estadoIdentificador.nuevoEditar.value = true;
        IdentificadorDB.eliminar(estadoIdentificador.identificadorConsultado);
        consultarDatos(actualizar);
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 25,
      ),
      label: const Text(
        'Eliminar',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return SizedBox(
      width: medidas.anchoLista,
      height: medidas.alto * 0.9 - MediaQuery.of(context).viewInsets.bottom,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                encabezadoSencillo(
                  context: context,
                  anchoLista: medidas.anchoLista,
                  titulo: 'Identificadores',
                ),
                textfildIdentificador(
                    labelText: 'Nombre', index: 0, actualizar: actualizar),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: medidas.anchoLista * 0.49,
                        child: textfildIdentificador(
                            labelText: 'Identificador',
                            index: 1,
                            actualizar: actualizar)),
                    SizedBox(
                      width: medidas.anchoLista * 0.49,
                      child: textfildIdentificador(
                          labelText: 'Cantidad',
                          index: 2,
                          actualizar: actualizar),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: medidas.anchoLista * 0.49,
                        child: guardar(context, actualizar)),
                    SizedBox(
                      width: medidas.anchoLista * 0.49,
                      child: floatingActionButton,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Identificadores: ${estadoIdentificador.mapIdentificador.length}           Suma Total: ${estadoIdentificador.sumaTotales()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // FloatingActionButton.small(onPressed: () {
                //   consultarDatos(actualizar);
                // })
              ],
            ),
          ),
          listaIdentificador(medidas: medidas, context: context),
        ],
      ),
    );
  }
}
