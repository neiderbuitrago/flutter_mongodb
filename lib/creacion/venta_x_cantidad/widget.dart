// ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../estados_getX/getx_combos.dart';

// Row encabezadoSencillo({
//   required BuildContext context,
//   required double anchoLista,
//   required String titulo,
// }) {
//   return Row(
//     children: [
//       IconButton(
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         icon: const Icon(Icons.arrow_back_ios),
//       ),
//       SizedBox(
//         width: anchoLista - 100,
//         child: Column(
//           children: [
//             Text(
//               titulo,
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

// Container encabezado({
//   required BuildContext context,
//   required double anchoLista,
//   // required Function cambioDetalleNombre,
//   required VariablesFunciones variablesFunciones,
// }) {
//   EstadoProducto estadoProducto = Get.find<EstadoProducto>();
//   late EstadoCombos estadoCombos = Get.find<EstadoCombos>();
//   return Container(
//     decoration: BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: const Color.fromARGB(255, 156, 156, 156).withOpacity(0.1),
//           blurRadius: 10,
//           spreadRadius: 5,
//         )
//       ],
//       color: Colors.white,
//       borderRadius: const BorderRadius.vertical(
//         top: Radius.circular(20),
//       ),
//     ),
//     child: Row(
//       children: [
//         IconButton(
//           onPressed: () {
//             if (estadoCombos.seleccionarCrear.value) {
//               Navigator.of(context).pop();
//             } else {
//               estadoCombos.cambiarSeleccionarCrear();
//             }
//             estadoCombos.tituloCombos.value = 'Crear Combo';
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         SizedBox(
//           width: anchoLista - 100,
//           child: Column(
//             children: [
//               Obx(
//                 () => Text(
//                   estadoCombos.seleccionarCrear.value
//                       ? 'Seleccionar Combo'
//                       : 'Crear o Editar',
//                   style: const TextStyle(
//                       fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Text(
//                 estadoProducto.controladores[1].text,
//                 style: const TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(155, 55, 54, 54)),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// SizedBox cardgeneral(
//     {required List<Widget> children, required Color colorbordes}) {
//   return SizedBox(
//     height: 200,
//     width: 300,
//     child: Card(
//       shadowColor: colorbordes,
//       elevation: 10,
//       shape: RoundedRectangleBorder(
//         borderRadius: const BorderRadius.all(
//           Radius.circular(20.0),
//         ),
//         side: BorderSide(
//           color: colorbordes,
//           width: 2,
//         ),
//       ),
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: children,
//       ),
//     ),
//   );
// }

// calcularGanancias({
//   required int index,
// }) {
//   final EstadoVentaXCantidad estadoVentaXCantidad =
//       Get.find<EstadoVentaXCantidad>();
//   final EstadoProducto estadoProducto = Get.find<EstadoProducto>();
//   double costo = comprovarSihayNumero(estadoProducto.controladores[5].text);
//   double desde = comprovarSihayNumero(
//       estadoVentaXCantidad.controladoresVentaXCantidad[index - 2].text);
//   double hasta = comprovarSihayNumero(
//       estadoVentaXCantidad.controladoresVentaXCantidad[index - 1].text);
//   double precio = comprovarSihayNumero(
//       estadoVentaXCantidad.controladoresVentaXCantidad[index].text);

//   if (desde != 0 && hasta != 0 && precio != 0) {
//     double utilidadPesos = (precio - costo);
//     double porcentaje = (utilidadPesos / costo);
//     estadoVentaXCantidad.controladoresVentaXCantidad[index + 1].text =
//         (porcentaje * 100).toString();
//   }
// }

// double comprovarSihayNumero(String valor) {
//   return (valor == "") ? 0.00 : double.parse(valor);
// }

// validarRangos({required VariablesFunciones variablesFunciones}) {
//   final EstadoVentaXCantidad estadoVentaXCantidad =
//       Get.find<EstadoVentaXCantidad>();
//   valor(index1) {
//     String valor =
//         estadoVentaXCantidad.controladoresVentaXCantidad[index1].text;
//     return (valor == "") ? 0.00 : double.parse(valor);
//   }

//   List<int> listaDeIndex = [1, 4, 5, 8, 9, 12, 13];

//   for (int i = 0; i < listaDeIndex.length; i++) {
//     int index = listaDeIndex[i];

//     bool continuar = true;
//     estadoVentaXCantidad.datosValidosVentaXCantidad.forEach((key, value) {
//       print('key $key value $value');
//       if (key < index) {
//         if (value == false) {
//           continuar = false;
//         }
//       }
//     });

//     if (continuar) {
//       if (index == 4 || index == 8 || index == 12) {
//         estadoVentaXCantidad.changeValue(
//             index, (valor(index) > valor(index - 3)));
//       }
//       estadoVentaXCantidad.changeValue(
//           index, (valor(index) > valor(index - 1)));
//     } else {
//       estadoVentaXCantidad.changeValue(index, false);
//     }
//   }
//   estadoVentaXCantidad.datosValidosVentaXCantidad.forEach((key, value) {
//     print('key $key value $value');
//   });
// }
