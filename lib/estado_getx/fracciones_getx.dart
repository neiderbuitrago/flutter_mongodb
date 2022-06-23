import 'package:flutter/material.dart';
import 'package:flutter_mongodb/funciones_generales/numeros.dart';
import 'package:get/get.dart';

class EstadoVentaFraccionada extends GetxController {
  var costoGeneralProducto = ''.obs;
  var listaBodegasVisibles = false.obs;
  late List<String> camposTitulo = [
    'Nombre Producto',
    'Cantidades a descontar',
    'Precio venta unitario',
    'Utilidad % ',
  ].obs;

  late List controladoresFraccion =
      [for (var i = 0; i < 23; i++) TextEditingController()].obs;

  // List listaDewidgetParaCard = [].obs;

  calcularGanancias({
    required int? index,
  }) {
    double cxe = numeroDecimal(controladoresFraccion[0].text);
    if (cxe != 0) {
      double pc = numeroDecimal(costoGeneralProducto.value);
      double cantidadDescontar =
          numeroDecimal(controladoresFraccion[(index! - 1)].text);
      double costoFraccion = (pc / cxe) * cantidadDescontar;
      if (controladoresFraccion[index].text != '') {
        double utilidadPesos =
            (numeroDecimal(controladoresFraccion[index].text) - costoFraccion);
        double porcentaje = (utilidadPesos / costoFraccion);
        controladoresFraccion[index + 1].text = (porcentaje * 100).toString();
      }
    }
  }
}
