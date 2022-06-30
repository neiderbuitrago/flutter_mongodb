// ignore_for_file: avoid_print

import 'package:flutter_mongodb/db/multicodigo.dart';
import 'package:flutter_mongodb/modelos/multicodigo.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../estado_getx/multicodigo_getx.dart';
import '../../funciones_generales/response.dart';
import '../venta_x_cantidad/widget.dart';
import '../widget.dart';
import 'widget.dart';

Future<dynamic> listaFlotanteMulticodigos({
  required BuildContext context,
}) {
  return showDialog(
    barrierColor: Colors.black.withOpacity(0.2),
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListaMulticodigo(),
        ),
      );
    },
  );
}

// ignore: use_key_in_widget_constructors
class ListaMulticodigo extends StatefulWidget {
  @override
  _ListaMulticodigoState createState() => _ListaMulticodigoState();
}

class _ListaMulticodigoState extends State<ListaMulticodigo> {
  EstadoMulticodigos estadoMulticodigos = Get.find<EstadoMulticodigos>();

  actualizar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    estadoMulticodigos.controllerMulticodigo[0].text =
        estadoMulticodigos.nombreProducto.value;

    AnchoDePantalla medidas = anchoPantalla(context);
    estadoMulticodigos.lista.clear();
    MulticodigoDB.getParametro(estadoMulticodigos.idProducto).then((value) {
      value.forEach((element) {
        estadoMulticodigos.lista.add(element);
      });
      actualizar();
    });

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
                  titulo: 'Multiples Códigos',
                ),
                const TextfildIdentificador(
                    labelText: 'Nombre Principal', index: 0),
                Row(
                  children: [
                    SizedBox(
                        width: medidas.anchoLista * 0.49,
                        child: const TextfildIdentificador(
                            labelText: 'Código ', index: 1)),
                    SizedBox(
                      width: medidas.anchoLista * 0.49,
                      child: const TextfildIdentificador(
                          labelText: 'Detalle adicional', index: 2),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: medidas.anchoLista * 0.49,
                        child: guardar(
                          context,
                          actualizar,
                        )),
                    SizedBox(
                      width: medidas.anchoLista * 0.49,
                      //botan eliminar un código
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          MulticodigoDB.eliminar(
                              estadoMulticodigos.multicodigo);
                          actualizar();
                        },
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: const Text(
                          'Eliminar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
              height: ((estadoMulticodigos.lista.length * 65).toDouble() <
                      medidas.alto * 0.9 -
                          253 -
                          MediaQuery.of(context).viewInsets.bottom)
                  ? (estadoMulticodigos.lista.length * 67).toDouble()
                  : medidas.alto * 0.9 -
                      253 -
                      MediaQuery.of(context).viewInsets.bottom,
              width: medidas.anchoLista - 1,
              child: (estadoMulticodigos.lista.isNotEmpty)
                  ? ListView(
                      reverse: true,
                      // shrinkWrap: true,
                      children: estadoMulticodigos.lista
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
                                '${codigo.detalle}   ${codigo.detalle}',
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
                                color: Colors.primaries[
                                    estadoMulticodigos.lista.indexOf(codigo)],
                              ),

                              onTap: () {
                                editarMulticodigo(codigo);
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
                                      estadoMulticodigos.lista.indexOf(codigo)],
                                  width: 1,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : null),
        ],
      ),
    );
  }
}

class TextfildIdentificador extends StatefulWidget {
  const TextfildIdentificador({
    Key? key,
    this.guardarLosCambios,
    required this.labelText,
    required this.index,
  }) : super(key: key);

  final bool? guardarLosCambios;
  final String labelText;
  final int index;

  @override
  _TextfildIdentificadorState createState() => _TextfildIdentificadorState();
}

class _TextfildIdentificadorState extends State<TextfildIdentificador> {
  @override
  Widget build(BuildContext context) {
    EstadoMulticodigos estadoMulticodigos = Get.find<EstadoMulticodigos>();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // ignore: dead_code
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        child: TextField(
          readOnly: (widget.index == 0) ? true : false,
          focusNode: estadoMulticodigos.focusnode[widget.index],
          autofocus: (widget.index == 1) ? true : false,
          controller: estadoMulticodigos.controllerMulticodigo[widget.index],
          decoration: InputDecoration(
            suffixIconColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: widget.labelText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          ),
          onChanged: (widget.index == 2)
              ? (value) {
                  estadoMulticodigos.controllerMulticodigo[0].text =
                      estadoMulticodigos.nombreProducto.value + ' ' + value;
                }
              : null,
          onSubmitted: (value) {
            //cambiar de foco
            if (widget.index == 3) {
              estadoMulticodigos.focusnode[1].requestFocus();
            } else {
              estadoMulticodigos.focusnode[widget.index + 1].requestFocus();
            }
          },
        ),
      ),
    );
  }
}

Padding guardar(
  BuildContext context,
  Function actualizar,
) {
  EstadoMulticodigos estadoMulticodigos = Get.find<EstadoMulticodigos>();
  return elevatedButtonGuardar1(
    context: context,
    focusNode: estadoMulticodigos.focusnode[3],
    onPressed: () {
      guardarMulticodigo();

      actualizar();
    },
  );
}
