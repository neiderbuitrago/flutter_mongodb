// import 'package:get/get.dart';

// import 'estados_getX/getx_combos.dart';

// double numeroDecimal(String valor) {
//   //esta funcion controla que no se inserte multiples puntos decimales
//   double numero = 0.0;
//   if (valor.contains('.')) {
//     List a = valor.split('.');
//     valor = (a[0].toString().isEmpty) ? "0" : a[0] + "." + a[1];
//     numero = double.parse(valor);
//   } else {
//     numero = double.parse(valor);
//   }
//   return numero;
// }

// // tomar la parte decimal de un numero
// String quitarDecimales(double numero) {
//   double decimal = numero - numero.truncate();
//   return (decimal == 0) ? numero.truncate().toString() : numero.toString();
// }

// int indiceReverse(int index) {
//   final EstadoCombos estadoCombos = Get.find<EstadoCombos>();
//   return (estadoCombos.controlleresCombosDetalle.length - 1) - index;
// }
