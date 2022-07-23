import 'package:flutter/material.dart';
import 'package:flutter_mongodb/estado_getx/productos_getx.dart';
import 'package:get/get.dart';

import '../../db/fracciones.dart';
import '../../estado_getx/fracciones_getx.dart';
import '../../funciones_generales/numeros.dart';
import '../../funciones_generales/response.dart';
import '../../funciones_generales/strings.dart';
import '../../modelos/fracciones.dart';

class ListaFracciones extends GetView<EstadoVentaFraccionada> {
  const ListaFracciones({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EstadoVentaFraccionada>(
      builder: (_) {
        EstadoProducto estadoProducto = Get.find<EstadoProducto>();

        AnchoDePantalla medidas = anchoPantalla(context);
        return FutureBuilder(
            future:
                FraccionesDB.getIdPadre(estadoProducto.productoConsultado.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  _.fraccionesConsultadas.clear();
                  snapshot.data.forEach((element) {
                    _.fraccionesConsultadas.add(Fracciones.fromMap(element));
                  });
                  return ListView(
                    children: [
                      SizedBox(
                        width: medidas.anchoLista,
                        // height:
                        //     medidas.alto * 0.8 - MediaQuery.of(context).viewInsets.bottom,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            for (var i = 0;
                                i < _.fraccionesConsultadas.length;
                                i++)
                              widgetFraccion(_, i)
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  // ignore: prefer_const_constructors
                  return Center(
                    child: const Text(
                      'No hay fracciones',
                      style: TextStyle(),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
      },
    );
  }

  widgetFraccion(estado, index) {
    return GestureDetector(
      onTap: () {
        estado.editarFraccion(estado.fraccionesConsultadas[index]);
      },
      child: SizedBox(
        height: 180,
        width: 300,
        child: Card(
          margin: const EdgeInsets.all(10.0),
          elevation: 20,
          color: Colors.grey[200],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            side: BorderSide(
              color: Color.fromARGB(255, 8, 247, 199),
              width: 0.2,
              strokeAlign: StrokeAlign.outside,
            ),
          ),
          shadowColor: Colors.grey[200],
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color.fromARGB(255, 33, 229, 243),
                      Color.fromARGB(255, 1, 58, 105)
                    ],
                    stops: [
                      0.5,
                      4,
                      1
                    ]),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    estado.fraccionesConsultadas[index].nombre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  tituloValorRow(
                      titulo: "Código:  ",
                      valor: estado.fraccionesConsultadas[index].codigo),
                  tituloValorRow(
                      titulo: "Existencias: ",
                      valor: quitarDecimales(
                          estado.fraccionesConsultadas[index].cantidad)),
                  tituloValorRow(
                      titulo: "Cantidad por Empaque: ",
                      valor: quitarDecimales(estado
                          .fraccionesConsultadas[index].cantidadXEmpaque)),
                  tituloValorRow(
                      titulo: "precio:  \$ ",
                      valor: puntosDeMil(quitarDecimales(
                          estado.fraccionesConsultadas[index].precioUnd))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
