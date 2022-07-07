// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/marcas_mongo.dart';
import 'package:flutter_mongodb/estado_getx/grupos_getx%20.dart';
import 'package:flutter_mongodb/estado_getx/marcas_getx.dart';
import 'package:flutter_mongodb/modelos/marcas.dart';
import 'package:get/get.dart';

import '../../db/grupos_mongo.dart';
import '../widget.dart';

class ListaMarcasGrupos extends StatelessWidget {
  const ListaMarcasGrupos({
    Key? key,
    required this.controlador,
    required this.texto,
    required this.redibujarLista,
  }) : super(key: key);

  final String texto;
  final Function redibujarLista;
  final List<TextEditingController> controlador;

  @override
  Widget build(BuildContext context) {
    EstadoMarcas estadoMarcas = Get.find<EstadoMarcas>();
    EstadoGrupos estadoGrupos = Get.find<EstadoGrupos>();
    return FutureBuilder(
        future: (texto == "la Marca")
            ? MarcaDB.getParametro(estadoMarcas.controlador[0].text)
            : GruposDB.getParametro(estadoGrupos.controlador[0].text),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8 - 150,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      hoverColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: Colors.blue.withOpacity(0.1),
                          width: 2,
                        ),
                      ),
                      title: Text(
                        snapshot.data[index]["nombre"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        strutStyle: const StrutStyle(
                          forceStrutHeight: true,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await confirmacionEliminar(
                                  context: context,
                                  valor: snapshot.data[index]["nombre"],
                                  texto: '¿Esta seguro de eliminar $texto?')
                              .then((value) {
                            if (value ?? false) {
                              (texto == "la Marca")
                                  ? MarcaDB.eliminar(MarcasGrupos.fromMap(
                                          snapshot.data[index]))
                                      .then((value) {
                                      redibujarLista();
                                      estadoMarcas.controlador[0].clear();
                                      estadoMarcas.nuevoEditar.value = true;
                                    })
                                  : GruposDB.eliminar(MarcasGrupos.fromMap(
                                          snapshot.data[index]))
                                      .then((value) {
                                      redibujarLista();
                                      estadoGrupos.controlador[0].clear();
                                      estadoGrupos.nuevoEditar.value = true;
                                    });
                            }
                          });
                        },
                        icon: Icon(Icons.delete_outline_rounded,
                            color: Colors.primaries
                                .elementAt(index)
                                .withAlpha(180),
                            size: 30),
                      ),
                      onTap: () {
                        if (texto == "la Marca") {
                          estadoMarcas.nuevoEditar.value = false;
                          estadoMarcas.marca =
                              MarcasGrupos.fromMap(snapshot.data[index]);
                        } else {
                          estadoGrupos.nuevoEditar.value = false;
                          estadoGrupos.grupo =
                              MarcasGrupos.fromMap(snapshot.data[index]);
                        }

                        controlador[0].text = snapshot.data[index]["nombre"];
                      },
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
