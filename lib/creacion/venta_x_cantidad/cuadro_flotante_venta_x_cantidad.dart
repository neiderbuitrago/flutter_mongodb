import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/venta_x_cantidad/widget.dart';
import 'package:get/get.dart';

import '../../estado_getx/venta_x_cantidad_getx.dart';
import '../../funciones_generales/response.dart';
import 'text_from_fiel_venta_x_cantidad.dart';

Future<dynamic> listaFlotanteVentaXCantidad({
  required BuildContext context,
}) {
  calcularGanancias(index: 2);
  calcularGanancias(index: 6);
  calcularGanancias(index: 10);
  calcularGanancias(index: 14);
  return showDialog(
    barrierColor: Colors.black.withOpacity(0.2),
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListaSeleccion(
            context: context,
          ),
        ),
      );
    },
  );
}

class ListaSeleccion extends StatefulWidget {
  const ListaSeleccion({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  State<ListaSeleccion> createState() => _ListaSeleccionState();
}

class _ListaSeleccionState extends State<ListaSeleccion> {
  final EstadoVentaXCantidad estadoVentaXCantidad =
      Get.find<EstadoVentaXCantidad>();

  List<List<Widget>> listaDewidgetParaCard = [];
  bool datoValido = false;

  @override
  void initState() {
    super.initState();
    estadoVentaXCantidad.focusNode = [for (var i = 0; i < 17; i++) FocusNode()];
  }

  llenarListaWidget() {
    int lontudLista = estadoVentaXCantidad.camposTitulo.length;
    List<Widget> listaWidget = [];
    List<int> listaDeIndex = [0, 4, 8, 12];

    for (int i = 0; i < 4; i++) {
      int numeroInicial = listaDeIndex[i];
      for (var y = 1; y < lontudLista; y++) {
        listaWidget.add(
          (y == 1)
              ? Row(children: [
                  Expanded(
                    child: TexfieldVentaXCantidad(
                      labelText: '${estadoVentaXCantidad.camposTitulo[y - 1]} ',
                      index: numeroInicial + y - 1,
                      validarRangos: validarRangos,
                    ),
                  ),
                  Expanded(
                    child: TexfieldVentaXCantidad(
                      labelText: '${estadoVentaXCantidad.camposTitulo[y]} ',
                      index: numeroInicial + y,
                      validarRangos: validarRangos,
                    ),
                  ),
                ])
              : TexfieldVentaXCantidad(
                  labelText: '${estadoVentaXCantidad.camposTitulo[y]} ',
                  index: numeroInicial + y,
                  validarRangos: validarRangos,
                ),
        );
      }
      listaDewidgetParaCard.add(listaWidget);
      listaWidget = [];
    }
  }

  Wrap wrapDecard() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        if (listaDewidgetParaCard.isNotEmpty)
          cardgeneral(
            children: listaDewidgetParaCard[0],
            colorbordes: const Color.fromARGB(255, 4, 157, 217),
          ),
        cardgeneral(
          children: listaDewidgetParaCard[1],
          colorbordes: const Color.fromARGB(255, 11, 217, 4),
        ),
        cardgeneral(
          children: listaDewidgetParaCard[2],
          colorbordes: const Color.fromARGB(255, 210, 217, 4),
        ),
        cardgeneral(
          children: listaDewidgetParaCard[3],
          colorbordes: const Color.fromARGB(255, 242, 19, 19),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    validarRangos();
    llenarListaWidget();
    AnchoDePantalla medidas = anchoPantalla(context);
    return SizedBox(
      width: medidas.anchoLista,
      height: medidas.alto * 0.8 - MediaQuery.of(context).viewInsets.bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          encabezadoSencillo(
            context: context,
            anchoLista: medidas.anchoLista,
            titulo: 'Venta X Cantidad',
          ),
          Expanded(
            child: SizedBox(
              width: medidas.anchoLista,
              height: medidas.alto * 0.8 -
                  112 -
                  MediaQuery.of(context).viewInsets.bottom,
              child: ListView(
                // scrollDirection: Axis.horizontal,
                children: [
                  wrapDecard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
