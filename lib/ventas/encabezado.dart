// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_mongodb/estado_getx/vantas_getx.dart';
import 'package:flutter_mongodb/ventas/ventas.dart';
import 'package:get/get.dart';

import '../funciones_generales/numeros.dart';
import '../funciones_generales/response.dart';
import 'flotante_fracciones.dart';
import 'stilo_de_pantalla.dart';
import 'texfield.dart';

Row encabTotalNumero(conteo, totalfactura) {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();
  String codigoBarras = "";
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      //si la plataforma es android, se muestra el boton de escaner
      if (GetPlatform.isAndroid)
        GestureDetector(
          child: Icon(
            Icons.qr_code_scanner,
            size: tamanoIconos(estadoVentas.context),
          ),
          onTap: () async {
            codigoBarras = await FlutterBarcodeScanner.scanBarcode(
                "#004297", "Cancelar", true, ScanMode.BARCODE);
            if (codigoBarras != "-1") {
              //falta colocar el codigo de barras en el textfield152123121
            }
          },
        ),
      Expanded(child: TextFieldBusqueda()),
      Expanded(
        child: Text(
          "Doc # $conteo ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: tamanoletraMediano(estadoVentas.context),
          ),
          maxLines: 1,
        ),
      ),
      Expanded(
        child: Container(
          alignment: Alignment.center,
          decoration: boxdecorationParaContainer(
            borderRadius: 10,
            color1: Colors.lightBlueAccent.withOpacity(0.5),
            backGround: Colors.lightBlueAccent.withOpacity(0.2),
          ),
          child: Stack(
            children: [
              Text(
                "\$ ${puntosDeMil(totalfactura.toString())}",
                style: TextStyle(
                  fontSize: tamanoletraMediano(estadoVentas.context) + 5,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );
}

Row parmetrosEncabezado(context) {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      //Agregar cliente
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: GestureDetector(
          child: Column(
            children: [
              Icon(Icons.person_add, size: tamanoIconos(estadoVentas.context)),
              Text(
                "Clientes",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: tamanoletraPequeno(estadoVentas.context),
                ),
                maxLines: 1,
              ),
            ],
          ),
          onTap: () {
            Navigator.of(estadoVentas.context).push(
              MaterialPageRoute(
                builder: ((context) => Ventas()),
                // (context) => Clientes(app: widget.app),
              ),
            );
          },
        ),
      ),

      // .then(
      // (value) {
      //   print(value);
      //   if (value != null) {
      //     print("es diferente a null");
      //     mapcliente = value;
      //     print(mapcliente);
      //     setState(
      //       () {
      //         altoContenedor = 135.00;
      //         altoParaCliente = 0.775;
      //       },
      //     );
      //   } else {
      //     mapcliente = {};
      //     print(mapcliente);
      //     print("el map fue borrado");
      //     setState(() {
      //       altoContenedor = 118;
      //       altoParaCliente = 0.875;
      //     });
      //   }
      // },
      //);
      Obx(
        () => Text(
          "Existe: ${quitarDecimales(estadoVentas.cantidad.value)}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          maxLines: 1,
        ),
      ),

      //Agregar producto
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
          child: Column(
            children: [
              Icon(
                Icons.polyline_outlined,
                size: tamanoIconos(estadoVentas.context),
              ),
              Text(
                "Identificadores",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: tamanoletraPequeno(estadoVentas.context),
                ),
                maxLines: 1,
              ),
            ],
          ),
          onTap: () {
            Navigator.of(estadoVentas.context).push(
              MaterialPageRoute(
                builder: ((context) => Ventas()),
                // (context) => Clientes(app: widget.app),
              ),
            );
          },
        ),
      ),
      Obx(
        () => Visibility(
          visible: (estadoVentas.productoEnFacturacion.isEmpty)
              ? false
              : estadoVentas
                  .productoEnFacturacion[estadoVentas.indexProductoSelecc.value]
                  .producto
                  .manejaFracciones,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              child: Column(
                children: [
                  Icon(
                    Icons.widgets_outlined,
                    size: tamanoIconos(estadoVentas.context),
                  ),
                  Text(
                    "Fracciones",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: tamanoletraPequeno(estadoVentas.context),
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
              onTap: () {
                listaFlotante(
                  context: estadoVentas.context,
                  coleccion: "fracciones",
                ).then((value) {
                  estadoVentas.colocarValoresDeFracciones();
                });
              },
            ),
          ),
        ),
      )
    ],
  );
}
