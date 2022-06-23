// ignore_for_file: avoid_print

// import 'text_from_fiel_venta_x_cantidad.dart';

// Future<dynamic> listaFlotanteVentaXCantidad({
//   required VariablesFunciones variablesFunciones,
// }) {
//   calcularGanancias(index: 2);
//   calcularGanancias(index: 6);
//   calcularGanancias(index: 10);
//   calcularGanancias(index: 14);
//   return showDialog(
//     barrierColor: Colors.black.withOpacity(0.2),
//     context: variablesFunciones.context,
//     builder: (context) {
//       return Dialog(
//         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20.0)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: ListaSeleccion(
//             variablesFunciones: variablesFunciones,
//           ),
//         ),
//       );
//     },
//   );
// }

// class ListaSeleccion extends StatefulWidget {
//   const ListaSeleccion({
//     Key? key,
//     required this.variablesFunciones,
//   }) : super(key: key);

//   final VariablesFunciones variablesFunciones;

//   @override
//   State<ListaSeleccion> createState() => _ListaSeleccionState();
// }

// class _ListaSeleccionState extends State<ListaSeleccion> {
//   final EstadoVentaXCantidad estadoVentaXCantidad =
//       Get.find<EstadoVentaXCantidad>();
//   List<FocusNode> focusNodeVXC = [];

//   List<String> camposTitulo = [
//     'Desde',
//     'Hasta',
//     'Precio unitario',
//     'Utilidad % ',
//   ];

//   List<List<Widget>> listaDewidgetParaCard = [];
//   bool datoValido = false;

//   @override
//   void initState() {
//     super.initState();
//     focusNodeVXC = [for (var i = 0; i < 17; i++) FocusNode()];
//   }

//   llenarListaWidget() {
//     int lontudLista = camposTitulo.length;
//     List<Widget> listaWidget = [];
//     List<int> listaDeIndex = [0, 4, 8, 12];

//     for (int i = 0; i < 4; i++) {
//       int numeroInicial = listaDeIndex[i];
//       for (var y = 1; y < lontudLista; y++) {
//         listaWidget.add(
//           (y == 1)
//               ? Row(children: [
//                   Expanded(
//                     child: TexfieldVentaXCantidad(
//                       labelText: '${camposTitulo[y - 1]} ',
//                       index: numeroInicial + y - 1,
//                       validarRangos: validarRangos,
//                       variablesFunciones: widget.variablesFunciones,
//                       focusNode: focusNodeVXC,
//                     ),
//                   ),
//                   Expanded(
//                     child: TexfieldVentaXCantidad(
//                       labelText: '${camposTitulo[y]} ',
//                       index: numeroInicial + y,
//                       validarRangos: validarRangos,
//                       variablesFunciones: widget.variablesFunciones,
//                       focusNode: focusNodeVXC,
//                     ),
//                   ),
//                 ])
//               : TexfieldVentaXCantidad(
//                   labelText: '${camposTitulo[y]} ',
//                   index: numeroInicial + y,
//                   validarRangos: validarRangos,
//                   variablesFunciones: widget.variablesFunciones,
//                   focusNode: focusNodeVXC,
//                 ),
//         );
//       }
//       listaDewidgetParaCard.add(listaWidget);
//       listaWidget = [];
//     }
//   }

//   Wrap wrapDecard() {
//     return Wrap(
//       crossAxisAlignment: WrapCrossAlignment.center,
//       runAlignment: WrapAlignment.center,
//       alignment: WrapAlignment.center,
//       children: [
//         if (listaDewidgetParaCard.isNotEmpty)
//           cardgeneral(
//             children: listaDewidgetParaCard[0],
//             colorbordes: const Color.fromARGB(255, 4, 157, 217),
//           ),
//         cardgeneral(
//           children: listaDewidgetParaCard[1],
//           colorbordes: const Color.fromARGB(255, 11, 217, 4),
//         ),
//         cardgeneral(
//           children: listaDewidgetParaCard[2],
//           colorbordes: const Color.fromARGB(255, 210, 217, 4),
//         ),
//         cardgeneral(
//           children: listaDewidgetParaCard[3],
//           colorbordes: const Color.fromARGB(255, 242, 19, 19),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     validarRangos(
//       variablesFunciones: widget.variablesFunciones,
//     );
//     llenarListaWidget();
//     AnchoDePantalla medidas = anchoPantalla(context);
//     return SizedBox(
//       width: medidas.anchoLista,
//       height: medidas.alto * 0.8 - MediaQuery.of(context).viewInsets.bottom,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           encabezadoSencillo(
//             context: context,
//             anchoLista: medidas.anchoLista,
//             titulo: 'Venta X Cantidad',
//           ),
//           Expanded(
//             child: SizedBox(
//               width: medidas.anchoLista,
//               height: medidas.alto * 0.8 -
//                   112 -
//                   MediaQuery.of(context).viewInsets.bottom,
//               child: ListView(
//                 // scrollDirection: Axis.horizontal,
//                 children: [
//                   wrapDecard(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
