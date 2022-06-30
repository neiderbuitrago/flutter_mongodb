// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/crear_fracciones/widget_fracciones.dart';
import 'package:flutter_mongodb/db/fracciones.dart';
import 'package:flutter_mongodb/estado_getx/getx_productos.dart';
import 'package:get/get.dart';

import '../../estado_getx/fracciones_getx.dart';
import '../../funciones_generales/response.dart';
import '../../modelos/fracciones.dart';

Future<dynamic> listaFlotanteFracciones({required BuildContext context}) {
  return showDialog(
    barrierColor: Colors.black.withOpacity(0.2),
    context: context,
    builder: (context) {
      return const Dialog(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: ListaSeleccion(),
        ),
      );
    },
  );
}

class ListaSeleccion extends StatefulWidget {
  const ListaSeleccion({
    Key? key,
  }) : super(key: key);

  @override
  State<ListaSeleccion> createState() => _ListaSeleccionState();
}

class _ListaSeleccionState extends State<ListaSeleccion> {
  late EstadoVentaFraccionada estadoVentaFraccionada =
      Get.find<EstadoVentaFraccionada>();
  late EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  late List<FocusNode> focofracciones = [];
  late List<List<Widget>> listaDewidgetParaCard = [];

  @override
  void initState() {
    focofracciones = [for (var i = 0; i < 23; i++) FocusNode()];
    if (!estadoProducto.nuevoEditar.value) {
      FraccionesDB.getId(estadoProducto.productoConsultado.id).then((value) {
        if (value != null) {
          estadoVentaFraccionada.fraccionesConsultadas =
              Fracciones.fromMap(value);
        }
      });
    }
    super.initState();
  }

  Row encabezado(
    contexto1,
    double anchoLista,
  ) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(contexto1).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        SizedBox(
          width: anchoLista - 100,
          child: Column(
            children: const [
              Text(
                'Venta Fraccionada ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  llenaListaWidget() {
    // si la lista esta vacia llenarla con los datos
    listaDewidgetParaCard.clear();
    int largoLista = estadoVentaFraccionada.camposTitulo.length;
    List<Widget> listaWidget = [];
    List<int> listaDeIndex = [0, 4, 8, 12];
    for (int i = 0; i < listaDeIndex.length; i++) {
      for (var y = 0; y < largoLista; y++) {
        listaWidget.add(
          TexfieldFracciones(
            focofracciones: focofracciones,
            labelText: '${estadoVentaFraccionada.camposTitulo[y]} ',
            index: listaDeIndex[i] + y + 1,
          ),
        );
      }
      listaDewidgetParaCard.add(listaWidget);
      listaWidget = [];
    }
  }

  Wrap listWrap(AnchoDePantalla medidas) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        CantidadesBodega1(
          focofracciones: focofracciones,
          medidas: medidas,
        ),
        Cardgeneral(
          children: listaDewidgetParaCard[0],
          colorbordes: const Color.fromARGB(255, 4, 157, 217),
        ),
        Cardgeneral(
          children: listaDewidgetParaCard[1],
          colorbordes: const Color.fromARGB(255, 11, 217, 4),
        ),
        Cardgeneral(
          children: listaDewidgetParaCard[2],
          colorbordes: const Color.fromARGB(255, 210, 217, 4),
        ),
        Cardgeneral(
          children: listaDewidgetParaCard[3],
          colorbordes: const Color.fromARGB(255, 242, 19, 19),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    llenaListaWidget();
    estadoVentaFraccionada.calcularGanancias(index: 3);
    estadoVentaFraccionada.calcularGanancias(index: 7);
    estadoVentaFraccionada.calcularGanancias(index: 11);
    estadoVentaFraccionada.calcularGanancias(index: 15);
    AnchoDePantalla medidas = anchoPantalla(context);

    return SizedBox(
      width: medidas.anchoLista,
      height: medidas.alto * 0.8 - MediaQuery.of(context).viewInsets.bottom,
      child: Column(
        children: [
          encabezado(context, medidas.anchoLista),
          SizedBox(
            child: TexfieldFracciones(
              focofracciones: focofracciones,
              labelText: 'Cantidad por Empaque',
              index: 0,
            ),
          ),
          Expanded(
            child: SizedBox(
              width: medidas.anchoLista,
              height: medidas.alto * 0.8 -
                  112 -
                  MediaQuery.of(context).viewInsets.bottom,
              child: ListView(
                children: [
                  listWrap(medidas),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
