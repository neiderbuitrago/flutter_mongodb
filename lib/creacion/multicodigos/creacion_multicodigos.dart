import 'package:flutter_mongodb/creacion/multicodigos/widget.dart';
import 'package:flutter_mongodb/db/multicodigo.dart';
import 'package:flutter_mongodb/estado_getx/productos_getx.dart';
import 'package:flutter_mongodb/modelos/multicodigo.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../estado_getx/multicodigo_getx.dart';
import '../../funciones_generales/response.dart';
import '../../funciones_generales/strings.dart';
import '../venta_x_cantidad/widget.dart';
import '../widget.dart';
import 'lista_multicodigo.dart';

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
          child: Multicodigos(),
        ),
      );
    },
  );
}

// ignore: use_key_in_widget_constructors
class Multicodigos extends StatefulWidget {
  @override
  _MulticodigosState createState() => _MulticodigosState();
}

class _MulticodigosState extends State<Multicodigos> {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  EstadoMulticodigos estadoMulticodigos = Get.find<EstadoMulticodigos>();

  @override
  Widget build(BuildContext context) {
    campoEnMayusculas(controller: estadoMulticodigos.controllerMulticodigo[1]);
    campoEnMayusculas(controller: estadoMulticodigos.controllerMulticodigo[2]);
    estadoMulticodigos.nombreProducto.value =
        estadoProducto.controladores[1].text;

    AnchoDePantalla medidas = anchoPantalla(context);
    estadoMulticodigos.listaMulticodigos.clear();

    estadoMulticodigos.consultarMulticodigos("");
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
                const TextfildMulticodigo(
                    labelText: 'Nombre Principal', index: 0),
                Row(
                  children: [
                    SizedBox(
                        width: medidas.anchoLista * 0.49,
                        child: const TextfildMulticodigo(
                            labelText: 'Código ', index: 1)),
                    SizedBox(
                      width: medidas.anchoLista * 0.49,
                      child: const TextfildMulticodigo(
                          labelText: 'Detalle adicional', index: 2),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: medidas.anchoLista * 0.49,
                      child: elevatedButtonGuardar1(
                        context: context,
                        focusNode: estadoMulticodigos.focusnode[3],
                        onPressed: () {
                          if (estadoMulticodigos
                              .controllerMulticodigo[1].text.isNotEmpty) {
                            estadoMulticodigos.guardarMulticodigo();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: medidas.anchoLista * 0.49,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          estadoMulticodigos
                              .eliminar(estadoMulticodigos.multicodigo);
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
          const ListaMulticodigo()
        ],
      ),
    );
  }
}
