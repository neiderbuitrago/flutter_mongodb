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
            _.productosEnFacturacion.reversed.toList();

        return (_.productosEnFacturacion.isNotEmpty)
            ? Expanded(
                child: SizedBox(
                  //menos el tamaño del cuadro de busqueda y encabezado
                  height: (medidas.alto * 0.71),
                  child: ListView(
                    children: [
                      lineaDivisora(),
                      for (int i = 0; i < _.productosEnFacturacion.length; i++)
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.00),
                              child: GestureDetector(
                                  child: Row(
                                    children: [
                                      if (listarevez[i].ventaDeFracciones)
                                        const Icon(
                                          Icons.widgets_outlined,
                                          color: Colors.green,
                                        ),
                                      if (listarevez[i].identificadorVenta !=
                                          null)
                                        const Icon(
                                          Icons.polyline_outlined,
                                          color: Colors.green,
                                        ),
                                      Expanded(
                                        child: SizedBox(
                                          width: 170,
                                          child: Text(
                                            (listarevez[i].ventaDeFracciones)
                                                ? " ${listarevez[i].fracciones!.nombre}"
                                                : (listarevez[i]
                                                            .identificadorVenta !=
                                                        null)
                                                    ? " ${listarevez[i].producto.nombre} ${listarevez[i].identificadorVenta?.identificador} "
                                                    : " ${listarevez[i].producto.nombre}",
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
                                            alignment:
                                                const Alignment(0.0, 0.0),
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
                                              listarevez,
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
                                        i, _.productosEnFacturacion.length);

                                    _.cargarParametros(listarevez[i].producto);
                                    var produ = _.productosEnFacturacion[i];
                                    print(produ.producto.nombre);
                                  }),
                            ),
                            lineaDivisora()
                          ],
                        ),
                    ],
                  ),
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
  List<ProductosEnVenta> listarevez,
) {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();
  double borderRadius = 30;
  int index = (i == 0) ? i + ii : i * 3 + ii;
  estadoVentas.controladores[index].text = (ii == 0)
      ? quitarDecimales(listarevez[i].cantidad)
      : (ii == 1)
          ? quitarDecimales(listarevez[i].precioUnd)
          : puntosDeMil(quitarDecimales(listarevez[i].subtotal));
  return TextField(
    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
    controller: estadoVentas.controladores[index],
    focusNode: estadoVentas.focusNode[index],
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
    onEditingComplete: () {
      if (ii == 1) {
        FocusScope.of(estadoVentas.context)
            .requestFocus(estadoVentas.focusBuscar);
      } else {
        FocusScope.of(estadoVentas.context)
            .requestFocus(estadoVentas.focusNode[index + 1]);
      }
    },
    onChanged: (value) {
      int indiceRev = indicerevez(i, listarevez.length);
      bool esFraccion =
          estadoVentas.productosEnFacturacion[indiceRev].ventaDeFracciones;
      bool esIdentificador =
          estadoVentas.productosEnFacturacion[indiceRev].identificadorVenta !=
              null;

      if (ii == 0) {
        estadoVentas.productosEnFacturacion[indiceRev].cantidad =
            numeroDecimal(value);
        if (esFraccion) {
          estadoVentas.productosEnFacturacion[indiceRev].fracciones!
              .temCantidad = numeroDecimal(value);
        }
        //si es identificador se actualiza la cantida del identificador
        if (esIdentificador) {
          estadoVentas.productosEnFacturacion[indiceRev].identificadorVenta!
              .temCantidad = numeroDecimal(value);
        }
      } else if (ii == 1) {
        estadoVentas.productosEnFacturacion[indiceRev].precioUnd =
            numeroDecimal(value);
        if (esFraccion) {
          estadoVentas.productosEnFacturacion[indiceRev].fracciones!
              .temPrecioVenta = numeroDecimal(value);
        }
      }
      estadoVentas.actualizarsubtotal(indexOri: i);
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
