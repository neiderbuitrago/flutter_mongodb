import 'package:flutter/material.dart';
import 'package:flutter_mongodb/estado_getx/vantas_getx.dart';
import 'package:flutter_mongodb/funciones_generales/numeros.dart';
import 'package:flutter_mongodb/funciones_generales/response.dart';
import 'package:get/get.dart';

import '../funciones_generales/strings.dart';
import '../modelos/ventas.dart';
import 'stilo_de_pantalla.dart';

class ListaProductosVenta extends GetView<EstadoVentas> {
  const ListaProductosVenta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnchoDePantalla medidas = anchoPantalla(context);

    return GetBuilder<EstadoVentas>(
      builder: (_) {
        List<ProductosEnVenta> listarevez =
            _.productoEnFacturacion.reversed.toList();

        return (_.productoEnFacturacion.isNotEmpty)
            ? SizedBox(
                height: 500,
                child: ListView(
                  children: [
                    lineaDivisora(),
                    for (int i = 0; i < _.productoEnFacturacion.length; i++)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.00),
                            child: GestureDetector(
                                child: Row(
                                  children: [
                                    if (listarevez[i].ventaDeFracciones)
                                      const Icon(
                                        Icons.widgets_outlined,
                                        color: Colors.green,
                                      ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 170,
                                        child: Text(
                                          " ${listarevez[i].producto.nombre}",
                                          style: const TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    for (int ii = 0; ii < 3; ii++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        child: Container(
                                          alignment: const Alignment(0.0, 0.0),
                                          width: ii == 0
                                              ? medidas.ancho * 0.14
                                              : ii == 1
                                                  ? medidas.ancho * 0.18
                                                  : medidas.ancho * 0.20,
                                          height: 39,
                                          decoration:
                                              boxdecorationParaContainer(
                                                  borderRadius: 30,
                                                  color1: Colors.grey),
                                          //cuadros de texto para el contenido cantidad valor unitario
                                          child: texFieldParaTablaProductos(
                                            i,
                                            ii,
                                            30,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                onTap: ()
                                    //onHorizontalDragStart:
                                    //   (DragStartDetails details)
                                    {
                                  _.indexProductoSelecc.value = indicerevez(
                                      i, _.productoEnFacturacion.length);

                                  _.cargarParametros(listarevez[i].producto);
                                  // dialogoEliminacion(context, i, listarevez)
                                  //     .then(
                                  //   (value) {
                                  //     if (value != null) {
                                  //       if (value == "todo") {
                                  //         // insertarEnVenta(value, true, 10000);

                                  //         // ignore: avoid_print
                                  //         print(listarevez.length);
                                  //       } else {
                                  //         // insertarEnVenta(value, true, value);
                                  //       }
                                  //     }
                                  //   },
                                  // );
                                }),
                          ),
                          lineaDivisora()
                        ],
                      ),
                  ],
                ),
              )
            : const Center(
                child: Text("No hay productos en la facturacion"),
              );
      },
    );
  }
}
//  else {
//   var opacity1 = 0.08;
//   return Flexible(
//     child: AnimatedOpacity(
//       child: Image.asset("assets/sinProductos.gif"),
//       duration: const Duration(seconds: 5),
//       opacity: opacity1,
//     ),
//   );
// }

TextField texFieldParaTablaProductos(
  int i,
  int ii,
  double borderRadius,
) {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();
  double borderRadius = 30;
  return TextField(
    controller: estadoVentas.controladores[(i == 0) ? i + ii : i * 3 + ii],
    keyboardType: TextInputType.number,

    textAlign: TextAlign.center,
    readOnly: ii == 2 ? true : false,
    decoration: InputDecoration(
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius)),
      contentPadding: EdgeInsets.zero,
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        borderSide: const BorderSide(
          color: Colors.orangeAccent,
          width: 2,
        ),
      ),
    ),

    // onSubmitted: (String textofinal) {
    //   actualizarSubtotalTotal(i);
    // },
    onChanged: (value) {
      // actualizarSubtotalTotal(i);
    },
  );
}

Flexible formularioCliente(
  BuildContext context,
  List campos,
  controldatos,
) {
  return Flexible(
    child: ListView(
      children: [
        //lineaDivisora(),
        for (int i = 0; i < campos.length; i++)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.00),
                child: GestureDetector(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: Container(
                            alignment: const Alignment(0.0, 0.0),
                            width: 180,
                            height: 40,
                            decoration: boxdecorationParaContainer(
                                borderRadius: 8, color1: Colors.grey),
                            //cuadros de texto para el contenido cantidad valor unitario
                            child: TextField(
                              controller: controldatos[i],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                labelText: "${campos[i]}",
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                // actualizarSubtotalTotal(i);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {}),
              ),
              // lineaDivisora()
            ],
          ),
      ],
    ),
  );
}
