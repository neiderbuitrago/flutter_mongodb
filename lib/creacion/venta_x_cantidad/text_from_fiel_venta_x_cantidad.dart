// ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive6/creacion/Productos/widget.dart';
// import 'package:hive6/creacion/venta_x_cantidad/widget.dart';

// import '../estados_getX/getx_productos.dart';

// class TexfieldVentaXCantidad extends StatefulWidget {
//   const TexfieldVentaXCantidad({
//     Key? key,
//     required this.variablesFunciones,
//     required this.labelText,
//     required this.index,
//     required this.validarRangos,
//     required this.focusNode,
//   }) : super(key: key);

//   final VariablesFunciones variablesFunciones;
//   final String labelText;
//   final int index;
//   final Function validarRangos;
//   final List<FocusNode> focusNode;

//   @override
//   _TexfieldVentaXCantidadState createState() => _TexfieldVentaXCantidadState();
// }

// class _TexfieldVentaXCantidadState extends State<TexfieldVentaXCantidad> {
//   final EstadoVentaXCantidad estadoVentaXCantidad =
//       Get.find<EstadoVentaXCantidad>();
//   final EstadoProducto estadoProducto = Get.find<EstadoProducto>();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           // ignore: dead_code
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               spreadRadius: 1,
//             )
//           ],
//         ),
//         child: TextField(
//           autofocus: (widget.index == 0) ? true : false,
//           focusNode: widget.focusNode[widget.index],
//           controller:
//               estadoVentaXCantidad.controladoresVentaXCantidad[widget.index],
//           decoration: InputDecoration(
//             suffix: (widget.index == 1 ||
//                     widget.index == 4 ||
//                     widget.index == 5 ||
//                     widget.index == 8 ||
//                     widget.index == 9 ||
//                     widget.index == 12 ||
//                     widget.index == 13)
//                 ? Obx(
//                     () => (estadoVentaXCantidad
//                                 .datosValidosVentaXCantidad[widget.index] ==
//                             true)
//                         ? const Icon(
//                             Icons.done,
//                             color: Colors.greenAccent,
//                           )
//                         : const Icon(Icons.close, color: Colors.red),
//                   )
//                 : null,
//             suffixIconColor: Colors.black,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//             ),
//             labelText: widget.labelText,
//             hintStyle: TextStyle(
//               fontSize: 15,
//               color: Colors.grey[400],
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
//           ),
//           onChanged: (widget.index == 2 ||
//                   widget.index == 6 ||
//                   widget.index == 10 ||
//                   widget.index == 14)
//               ? (value) {
//                   calcularGanancias(
//                     index: widget.index,
//                   );
//                 }
//               : (widget.index == 3 ||
//                       widget.index == 7 ||
//                       widget.index == 11 ||
//                       widget.index == 15)
//                   ? (value) {
//                       double costo = comprovarSihayNumero(
//                           estadoProducto.controladores[5].text);
//                       double desde = comprovarSihayNumero(estadoVentaXCantidad
//                           .controladoresVentaXCantidad[widget.index - 2].text);
//                       double hasta = comprovarSihayNumero(estadoVentaXCantidad
//                           .controladoresVentaXCantidad[widget.index - 1].text);

//                       if (desde != 0 && hasta != 0) {
//                         int precioVenta =
//                             ((costo * comprovarSihayNumero(value)) / 100 +
//                                     costo)
//                                 .toInt();
//                         estadoVentaXCantidad
//                             .controladoresVentaXCantidad[widget.index - 1]
//                             .text = (precioVenta.round()).toString();
//                       }
//                     }
//                   : (widget.index == 0 ||
//                           widget.index == 1 ||
//                           widget.index == 4 ||
//                           widget.index == 5 ||
//                           widget.index == 8 ||
//                           widget.index == 9 ||
//                           widget.index == 12 ||
//                           widget.index == 13)
//                       ? (value) {
//                           validarRangos(
//                             variablesFunciones: widget.variablesFunciones,
//                           );
//                         }
//                       : (value) {
//                           print('cambios en el texto10  $value $widget.index');
//                         },
//           onTap: () {
//             print('tap en el texto10  ${widget.index}');
//           },
//           onSubmitted: (value) {
//             if (widget.index == 15) {
//               FocusScope.of(context).requestFocus(widget.focusNode[0]);
//             } else {
//               FocusScope.of(context)
//                   .requestFocus(widget.focusNode[widget.index + 1]);
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
