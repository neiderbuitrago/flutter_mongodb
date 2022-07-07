// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../estado_getx/combos_getx.dart';
import '../../estado_getx/productos_getx.dart';
import '../../estado_getx/venta_x_cantidad_getx.dart';
import '../../funciones_generales/numeros.dart';

Row encabezadoSencillo({
  required BuildContext context,
  required double anchoLista,
  required String titulo,
}) {
  return Row(
    children: [
      IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      SizedBox(
        width: anchoLista - 100,
        child: Column(
          children: [
            Text(
              titulo,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ],
  );
}

Container encabezado({
  required BuildContext context,
  required double anchoLista,
  // required Function cambioDetalleNombre,
}) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  late EstadoCombos estadoCombos = Get.find<EstadoCombos>();
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 156, 156, 156).withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 5,
        )
      ],
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () {
            if (estadoCombos.seleccionarCrear.value) {
              Navigator.of(context).pop();
            } else {
              estadoCombos.cambiarSeleccionarCrear();
            }
            estadoCombos.tituloCombos.value = 'Crear Combo';
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        SizedBox(
          width: anchoLista - 100,
          child: Column(
            children: [
              Obx(
                () => Text(
                  estadoCombos.seleccionarCrear.value
                      ? 'Seleccionar Combo'
                      : 'Crear o Editar',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                estadoProducto.controladores[1].text,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(155, 55, 54, 54)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

SizedBox cardgeneral(
    {required List<Widget> children, required Color colorbordes}) {
  return SizedBox(
    height: 200,
    width: 300,
    child: Card(
      shadowColor: colorbordes,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        side: BorderSide(
          color: colorbordes,
          width: 2,
        ),
      ),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    ),
  );
}

calcularGananciasVentaXcantidad() {
  final EstadoVentaXCantidad estadoVentaXCantidad =
      Get.find<EstadoVentaXCantidad>();
  final EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  for (var index in [2, 6, 10, 14]) {
    double costo = numeroDecimal(estadoProducto.controladores[5].text);
    double desde = numeroDecimal(
        estadoVentaXCantidad.controladoresVentaXCantidad[index - 2].text);
    double hasta = numeroDecimal(
        estadoVentaXCantidad.controladoresVentaXCantidad[index - 1].text);
    double precio = numeroDecimal(
        estadoVentaXCantidad.controladoresVentaXCantidad[index].text);

    if (desde != 0 && hasta != 0 && precio != 0) {
      double utilidadPesos = (precio - costo);
      double porcentaje = (utilidadPesos / costo);
      estadoVentaXCantidad.controladoresVentaXCantidad[index + 1].text =
          (porcentaje * 100).toString();
    }
  }
}

calcularPrecioVenta({required int index, required String value}) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  EstadoVentaXCantidad estadoVentaXCantidad = Get.find<EstadoVentaXCantidad>();
  double costo = numeroDecimal(estadoProducto.controladores[5].text);

  double desde = numeroDecimal(
      estadoVentaXCantidad.controladoresVentaXCantidad[index - 3].text);
  double hasta = numeroDecimal(
      estadoVentaXCantidad.controladoresVentaXCantidad[index - 2].text);

  print("$desde $hasta");

  if (desde != 0 && hasta != 0) {
    int precioVenta = ((costo * numeroDecimal(value)) / 100 + costo).toInt();
    estadoVentaXCantidad.controladoresVentaXCantidad[(index - 1)].text =
        (precioVenta.round()).toString();
  }
}

validarRangos() {
  final EstadoVentaXCantidad estadoVentaXCantidad =
      Get.find<EstadoVentaXCantidad>();
  valor(index1) {
    String valor =
        estadoVentaXCantidad.controladoresVentaXCantidad[index1].text;
    return (valor == "") ? 0.00 : double.parse(valor);
  }

  List<int> listaDeIndex = [1, 4, 5, 8, 9, 12, 13];

  for (int i = 0; i < listaDeIndex.length; i++) {
    int index = listaDeIndex[i];

    bool continuar = true;
    estadoVentaXCantidad.datosValidosVentaXCantidad.forEach((key, value) {
      print('key $key value $value');
      if (key < index) {
        if (value == false) {
          continuar = false;
        }
      }
    });

    if (continuar) {
      if (index == 4 || index == 8 || index == 12) {
        estadoVentaXCantidad.changeValue(
            index, (valor(index) > valor(index - 3)));
      }
      estadoVentaXCantidad.changeValue(
          index, (valor(index) > valor(index - 1)));
    } else {
      estadoVentaXCantidad.changeValue(index, false);
    }
  }
  estadoVentaXCantidad.datosValidosVentaXCantidad.forEach((key, value) {
    print('key $key value $value');
  });
}
