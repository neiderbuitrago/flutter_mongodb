// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/validation_function.dart';
import 'package:flutter_mongodb/estado_getx/vantas_getx.dart';
import 'package:flutter_mongodb/ventas/texfield.dart';
import 'package:get/get.dart';

import '../estado_getx/productos_getx.dart';
import '../funciones_generales/response.dart';

Future<dynamic> listaFlotante({
  required BuildContext context,
  required String coleccion,
  int? index,
  bool? esProducto = false,
  String? letrasparaBuscar = '',
  final TextEditingController? controladorBuscar,
}) {
  return showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(230, 255, 255, 255),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ListaSeleccion(
              coleccion: coleccion,
              index: index,
              esProducto: esProducto,
              letrasparaBuscar: letrasparaBuscar,
              controladorBuscar: controladorBuscar,
            ),
          ),
        );
      });
}

class ListaSeleccion extends StatefulWidget {
  const ListaSeleccion({
    Key? key,
    required this.coleccion,
    this.index,
    this.esProducto,
    this.letrasparaBuscar,
    this.controladorBuscar,
  }) : super(key: key);

  final String coleccion;
  final int? index;
  final bool? esProducto;
  final String? letrasparaBuscar;
  final TextEditingController? controladorBuscar;

  @override
  State<ListaSeleccion> createState() => _ListaSeleccionState();
}

class _ListaSeleccionState extends State<ListaSeleccion> {
  TextEditingController controladorEncFiltro = TextEditingController();

  EstadoProducto estadoProductos = Get.find<EstadoProducto>();

  bool llenarDatoTraido = true;

  @override
  initState() {
    super.initState();
    controladorEncFiltro.value.copyWith(text: widget.letrasparaBuscar);
  }

  @override
  Widget build(BuildContext context) {
    AnchoDePantalla medidas = anchoPantalla(context);

    return SizedBox(
      width: medidas.anchoLista,
      height: medidas.alto * 0.7,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  ' ${widget.coleccion}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              )
            ],
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Nombre Fraccion",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Cantidad",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Precio",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          lista(context)
        ],
      ),
    );
  }
}

Widget lista(context) {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();

  fraccionEnLista();

  return Expanded(
    child: SizedBox(
      child: ListView.builder(
        itemCount: estadoVentas.listafracciones.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(108, 90, 90, 90),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Text(
                        estadoVentas.listafracciones[index]["nombre"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: texfieldFracciones(
                      labelText: "Cantidad",
                      index: index * 2,
                      context: context,
                    ),
                  ),
                  Expanded(
                    child: texfieldFracciones(
                      labelText: "Precio",
                      index: (index * 2) + 1,
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

fraccionEnLista() {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();
  estadoVentas.listafracciones.clear();
  estadoVentas.focusFracciones.clear();
  estadoVentas.controlFracciones.clear();

  var a = estadoVentas.fraccionesConsultadas;
  List lista = estadoVentas.listafracciones;

  // if (a.nombre1 != "" && a.cantidadDescontar1 != "" && a.precio1 != "") {
  //   lista.add({
  //     "nombre": a.nombre1,
  //     "fraccionesXPaquete": a.cantidadDescontar1,
  //     "cantidadPaquetes": 0,
  //     "precio": a.precio1,
  //   });
  //   addControladores(a.precio1);
  // }
  // if (a.nombre2 != "" && a.cantidadDescontar2 != "" && a.precio2 != "") {
  //   lista.add({
  //     "nombre": a.nombre2,
  //     "fraccionesXPaquete": a.cantidadDescontar2,
  //     "cantidadPaquetes": 0,
  //     "precio": a.precio2,
  //   });
  //   addControladores(a.precio2);
  // }
  // if (a.nombre3 != "" && a.cantidadDescontar3 != "" && a.precio3 != "") {
  //   lista.add({
  //     "nombre": a.nombre3,
  //     "fraccionesXPaquete": a.cantidadDescontar3,
  //     "cantidadPaquetes": 0,
  //     "precio": a.precio3,
  //   });
  //   addControladores(a.precio3);
  // }
  // if (a.nombre4 != "" && a.cantidadDescontar4 != "" && a.precio4 != "") {
  //   lista.add({
  //     "nombre": a.nombre4,
  //     "fraccionesXPaquete": a.cantidadDescontar4,
  //     "cantidadPaquetes": 0,
  //     "precio": a.precio4,
  //   });
  //   addControladores(a.precio4);
  // }
  if (estadoVentas.focusFracciones.isNotEmpty) {
    estadoVentas.focusFracciones[0].requestFocus();
  }
}

addControladores(double precio) {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();
  estadoVentas.controlFracciones.addAll([
    TextEditingController(),
    TextEditingController(text: quitarDecimales(precio).toString())
  ]);
  estadoVentas.focusFracciones.addAll([FocusNode(), FocusNode()]);
}
