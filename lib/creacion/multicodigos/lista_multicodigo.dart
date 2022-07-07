import 'package:flutter/material.dart';
import 'package:flutter_mongodb/estado_getx/multicodigo_getx.dart';
import 'package:get/get.dart';

import '../../funciones_generales/response.dart';

class ListaMulticodigo extends GetView<EstadoMulticodigos> {
  const ListaMulticodigo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnchoDePantalla medidas = anchoPantalla(context);
    return GetBuilder<EstadoMulticodigos>(
      builder: (_) {
        return SizedBox(
          height: ((_.listaMulticodigos.length * 65).toDouble() <
                  medidas.alto * 0.9 -
                      253 -
                      MediaQuery.of(context).viewInsets.bottom)
              ? (_.listaMulticodigos.length * 67).toDouble()
              : medidas.alto * 0.9 -
                  253 -
                  MediaQuery.of(context).viewInsets.bottom,
          width: medidas.anchoLista - 1,
          child: (_.listaMulticodigos.isNotEmpty)
              ? ListView(
                  reverse: true,
                  // shrinkWrap: true,
                  children: _.listaMulticodigos
                      .map(
                        (codigo) => ListTile(
                          // index del codigo

                          title: Text(
                            codigo.codigo,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          subtitle: Text(
                            '${codigo.detalle} ',
                          ),
                          // trailing: Text(
                          //   codigo.detalle,
                          //   style: const TextStyle(
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 20),
                          // ),
                          leading: Icon(
                            Icons.hub_outlined,
                            color: Colors
                                .primaries[_.listaMulticodigos.indexOf(codigo)],
                          ),

                          onTap: () {
                            _.editarMulticodigo(codigo);
                            print(""" 
                                    codigo ${codigo.codigo}
                                     detalle ${codigo.detalle}
                                     idProducto ${codigo.idProducto}
                                     sincronizado ${codigo.sincronizado}
                                     """);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: Colors.primaries[
                                  _.listaMulticodigos.indexOf(codigo)],
                              width: 1,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              : const Center(
                  child: Text("No hay Multicodigos",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
        );
      },
    );
  }
}
