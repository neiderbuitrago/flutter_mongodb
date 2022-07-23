// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/fracciones.dart';
import 'package:flutter_mongodb/estado_getx/vantas_getx.dart';
import 'package:flutter_mongodb/modelos/fracciones.dart';
import 'package:flutter_mongodb/modelos/productos.dart';
import 'package:flutter_mongodb/modelos/ventas.dart';
import 'package:flutter_mongodb/ventas/texfield.dart';
import 'package:get/get.dart';

import '../estado_getx/productos_getx.dart';
import '../funciones_generales/numeros.dart';
import '../funciones_generales/response.dart';

Future<dynamic> listaFlotante({
  required BuildContext context,
  required String coleccion,
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
          ),
        ),
      );
    },
  );
}

class ListaSeleccion extends StatefulWidget {
  const ListaSeleccion({
    Key? key,
    required this.coleccion,
  }) : super(key: key);

  final String coleccion;

  @override
  State<ListaSeleccion> createState() => _ListaSeleccionState();
}

class _ListaSeleccionState extends State<ListaSeleccion> {
  TextEditingController controladorEncFiltro = TextEditingController();

  EstadoProducto estadoProductos = Get.find<EstadoProducto>();

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
  print(estadoVentas
      .productosEnFacturacion[estadoVentas.indexProductoSelecc.value]
      .fracciones);

  return FutureBuilder(
    future: FraccionesDB.getIdPadre(estadoVentas
        .productosEnFacturacion[estadoVentas.indexProductoSelecc.value]
        .producto
        .id),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        fraccionEnLista(snapshot.data);

        return Expanded(
          child: SizedBox(
            child: ListView.builder(
              itemCount: snapshot.data.length,
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
                              snapshot.data[index]["nombre"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: texfieldFracciones(
                            index: index * 2,
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: texfieldFracciones(
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
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

//pintar fracciones para la venta
fraccionEnLista(List fracciones) {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();
  estadoVentas.listafracciones.clear();
  estadoVentas.focusFracciones.clear();
  estadoVentas.controlFracciones.clear();
  for (var element in fracciones) {
    ProductosEnVenta producto = estadoVentas
        .productosEnFacturacion[estadoVentas.indexProductoSelecc.value];
    //
    var fraEnVenta = (producto.fracciones?.id == element["_id"] &&
            producto.ventaDeFracciones)
        ? estadoVentas
            .productosEnFacturacion[estadoVentas.indexProductoSelecc.value]
            .fracciones
        : null;

    element.addAll({"temCantidad": 0, "temPrecioVenta": element["precioUnd"]});
    var fraccionVenta = FraccionesEnVenta(
      temCantidad: fraEnVenta?.temCantidad ?? 0,
      temPrecioVenta: fraEnVenta?.temPrecioVenta ?? element["temPrecioVenta"],
      temSubtotal: fraEnVenta?.temPrecioVenta ?? element["temPrecioVenta"],
    );
    // completa la fraccion con los datos par la venta.
    fraccionVenta.llenarInstancia(Fracciones.fromMap(element));
    estadoVentas.listafracciones.add(fraccionVenta);
    estadoVentas.controlFracciones.addAll([
      TextEditingController(text: enBlancoSiEsCero(fraccionVenta.temCantidad)),
      TextEditingController(
          text: enBlancoSiEsCero(fraccionVenta.temPrecioVenta))
    ]);
    estadoVentas.focusFracciones.addAll([FocusNode(), FocusNode()]);
  }
  if (estadoVentas.focusFracciones.isNotEmpty) {
    estadoVentas.focusFracciones[0].requestFocus();
  }
}

EstadoVentas estadoVentas = Get.find<EstadoVentas>();
