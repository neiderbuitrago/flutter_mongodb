import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/identificadores.dart';
import 'package:get/get.dart';

import '../estado_getx/productos_getx.dart';
import '../estado_getx/vantas_getx.dart';
import '../funciones_generales/numeros.dart';
import '../funciones_generales/response.dart';
import '../modelos/identificador.dart';
import '../modelos/ventas.dart';
import 'texfield.dart';

class ListaIdentificadores extends StatefulWidget {
  const ListaIdentificadores({
    Key? key,
    required this.coleccion,
  }) : super(key: key);

  final String coleccion;

  @override
  State<ListaIdentificadores> createState() => _ListaIdentificadoresState();
}

class _ListaIdentificadoresState extends State<ListaIdentificadores> {
  EstadoProducto estadoProductos = Get.find<EstadoProducto>();

  @override
  Widget build(BuildContext context) {
    AnchoDePantalla medidas = anchoPantalla(context);
    EstadoVentas estadoVentas = Get.find<EstadoVentas>();
    IdentificadorDB.getParametro(estadoVentas
            .productosEnFacturacion[estadoVentas.indexProductoSelecc.value]
            .producto
            .id)
        .then((value) {
      print(value);
    });

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
              Text("Identificador",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Cantidad",
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

  print(
      "identificador en venta ${estadoVentas.productosEnFacturacion[estadoVentas.indexProductoSelecc.value].identificadorVenta}");

  return FutureBuilder(
    future: IdentificadorDB.getParametro(estadoVentas
        .productosEnFacturacion[estadoVentas.indexProductoSelecc.value]
        .producto
        .id),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        //
        identificadorLista(snapshot.data);

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
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    snapshot.data[index].identificador,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Cant: ${quitarDecimales(snapshot.data[index].cantidad)}",
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              snapshot.data[index].nombre,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.only(left: 7),
                          //   child: Text(
                          //     "${snapshot.data[index].identificador}",
                          //     style: const TextStyle(
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                        ),
                        Expanded(
                          child: texfieldIdentificador(
                            index: index,
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
identificadorLista(List identificadores) {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();
  estadoVentas.listaMapIdentificador.clear();
  estadoVentas.focusIdentificadores.clear();
  estadoVentas.controlIdentificadores.clear();
  ProductosEnVenta producto = estadoVentas
      .productosEnFacturacion[estadoVentas.indexProductoSelecc.value];
  for (var element in identificadores) {
    //
    var identificadorEnVent = (producto.identificadorVenta?.id == element.id)
        ? estadoVentas
            .productosEnFacturacion[estadoVentas.indexProductoSelecc.value]
            .identificadorVenta
        : null;

    var identificadorVenta = IdentificadorVenta(
      temCantidad: identificadorEnVent?.temCantidad ?? 0,
    );

    identificadorVenta.llenarInstancia(element);

    // (Fracciones.fromMap(element)

    estadoVentas.listaMapIdentificador.add(identificadorVenta);
    estadoVentas.controlIdentificadores.add(
      TextEditingController(
          text: enBlancoSiEsCero(identificadorVenta.temCantidad)),
    );
    estadoVentas.focusIdentificadores.add(FocusNode());
  }
  producto.ventaDeFracciones = false;
  if (estadoVentas.focusFracciones.isNotEmpty) {
    estadoVentas.focusFracciones[0].requestFocus();
  }
}
