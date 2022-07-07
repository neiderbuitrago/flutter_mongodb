// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../estado_getx/productos_getx.dart';
import '../widget.dart';

//import 'package:hive6/modelo_datos/productos_identificador_detalle.dart';

// exprecion regular para permitir numeros decimales y enteros
validanumeros(String value) {
  if (RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
    print('es numero $value');
    return true;
  } else {
    return false;
  }
}

// buscarProductos({required String codigo, required Box box}) {
//   var producto = box.get(codigo);
//   if (producto != null) {
//     print('${producto.codigo} ${producto.nombre} ${producto.precioVenta1}');
//   } else {
//     print("No se encontro el producto");
//   }
//   // return producto;
// }

// buscarNombre({required String value, required Box box}) {
//   print(box.keys.toList());
//   //print(box.get('001').nombre);
//   //print(value);
//   var producto = box.values.toList();
//   for (var i = 0; i < producto.length; i++) {
//     var producto1 = producto[i].nombre.toLowerCase();
//     print('$producto1  este es el producto a buscar');
//     if (producto1.contains(value.toLowerCase())) {
//       print(
//           '${producto[i].codigo} ${producto[i].nombre} ${producto[i].precioVenta1}');
//     }
//   }
// }

//crear un suiche para cambiar de pantalla
switchVerdaderoFalso({required int index}) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  return Switch(
    value: (index == 22)
        ? estadoProducto.manejaVentaFraccionada.value
        : (index == 23)
            ? estadoProducto.manejaVentaXCantidad.value
            : (index == 24)
                ? estadoProducto.manejaIdentificador.value
                : (index == 25)
                    ? estadoProducto.manejaCombos.value
                    : (index == 26)
                        ? estadoProducto.manejaMulticodigos.value
                        : (index == 27)
                            ? estadoProducto.manejaVentaXPeso.value
                            : (index == 28)
                                ? estadoProducto.estadoDelProducto.value
                                : false,
    onChanged: (value) {
      if (estadoProducto.nuevoEditar.value) {
        if (index != 26) {
          if (index != 28) {
            estadoProducto.funtionHabilitar(index: index);
          }
        }
      } else {
        const InformeFlotanteInferior(
          titleText: 'Advertencia',
          messageText: 'Debe seleccionar un producto primero',
        );
      }
    },
  );
}

class ColocarTextoAdicional extends StatelessWidget {
  const ColocarTextoAdicional({
    Key? key,
    required this.primerTexto,
    required this.segundoTexto,
  }) : super(key: key);

  final String primerTexto;
  final String segundoTexto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          primerTexto,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Open Sans',
          ),
        ),
        Text(
          segundoTexto,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: 'Open Sans',
          ),
        ),
      ],
    );
  }
}
