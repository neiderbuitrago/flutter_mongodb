// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/presentacion.dart';
import 'package:get/get.dart';
import '../../estado_getx/presentacion_getx.dart';
import '../../modelos/presentacion.dart';
import '../widget.dart';

class ListaPresentacion extends StatelessWidget {
  const ListaPresentacion({
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
    EstadoPresentacion estado = Get.find<EstadoPresentacion>();
    return FutureBuilder(
        future: PresentacionDB.getParametro(estado.controlador[0].text),
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
                        trailing: SizedBox(
                          width: 80,
                          height: 50,
                          child: Row(
                            children: [
                              (snapshot.data[index]["visible"])
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 40,
                                    )
                                  : const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                              IconButton(
                                onPressed: () async {
                                  await confirmacionEliminar(
                                          context: context,
                                          valor: snapshot.data[index]["nombre"],
                                          texto:
                                              '¿Esta seguro de eliminar $texto?')
                                      .then((value) {
                                    if (value ?? false) {
                                      PresentacionDB.eliminar(
                                              Presentacion.fromMap(
                                                  snapshot.data[index]))
                                          .then((value) {
                                        redibujarLista();
                                        estado.controlador[0].clear();
                                        estado.nuevoEditar.value = true;
                                      });
                                    } else {
                                      estado.controlador[0].clear();
                                      estado.controlador[1].clear();
                                      estado.nuevoEditar.value = true;
                                      redibujarLista();
                                    }
                                  });
                                },
                                icon: Icon(Icons.delete_outline_rounded,
                                    color: Colors.primaries
                                        .elementAt(index)
                                        .withAlpha(180),
                                    size: 35),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          estado.editar(snapshot.data[index]);
                        });
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
