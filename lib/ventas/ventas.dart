// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/estado_getx/vantas_getx.dart';
import 'package:flutter_mongodb/ventas/encabezado.dart';

import 'package:get/get.dart';

import '../funciones_generales/response.dart';
import 'tabla_productos.dart';

class Ventas extends StatefulWidget {
  const Ventas({super.key});

  @override
  _VentasState createState() => _VentasState();
}

class _VentasState extends State<Ventas> {
  EstadoVentas estadoVentas = Get.put(EstadoVentas());

  @override
  Widget build(BuildContext context) {
    estadoVentas.context = context;

    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              child: Container(
                height: altoencabezadoVentas(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [30, 0.1],
                    colors: [
                      Colors.white,
                      Colors.lightBlueAccent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: encabTotalNumero(1),
                      ),
                      parmetrosEncabezado(context),
                      const Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            "nombreCompleto(mapcliente),",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const ListaProductosVenta(),
          ],
        ),
      )
          // floatingActionButton: BotonFlotante(
          //   onPressed: () {
          //     datosParaCaja(
          //         "demo", formasPago, totalfacturaSinpuntos, mapcliente);
          //   },
          // )

          ),
    );
  }
}
