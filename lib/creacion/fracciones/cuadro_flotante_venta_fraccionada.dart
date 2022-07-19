// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/fracciones/widget_fracciones.dart';

import 'package:flutter_mongodb/creacion/productos/llenar_datos.dart';
import 'package:flutter_mongodb/estado_getx/productos_getx.dart';
import 'package:get/get.dart';
import '../../estado_getx/fracciones_getx.dart';
import '../../funciones_generales/response.dart';
import '../widget.dart';

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

  late List<List<Widget>> listaDewidgetParaCard = [];

  @override
  void initState() {
    llenarFracciones(estadoProducto.productoConsultado.id);

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
    List<Widget> listaWidget = [];
    List listaBodegas = ['Bodega1', 'Bodega2', 'Bodega3', 'Bodega4', 'Bodega5'];
    for (var y = 0; y < listaBodegas.length; y++) {
      listaWidget.add(
        TexfieldFracciones(
          labelText: '${estadoVentaFraccionada.camposTitulo[y]} ',
          index: y + 2,
        ),
      );
    }
    listaDewidgetParaCard.add(listaWidget);
    listaWidget = [];

    for (var y = 0; y < listaBodegas.length; y++) {
      listaWidget.add(
        TexfieldFracciones(
          labelText: listaBodegas[y],
          index: y + 7,
        ),
      );
    }
    listaDewidgetParaCard.add(listaWidget);
    listaWidget = [];
  }

  Wrap listWrap(AnchoDePantalla medidas) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Obx(
          () => Visibility(
            visible: estadoVentaFraccionada.listaBodegasVisibles.value,
            child: Cardgeneral(
              colorbordes: const Color.fromARGB(255, 252, 32, 16),
              children: listaDewidgetParaCard[1],
            ),
          ),
        ),
        Cardgeneral(
          colorbordes: const Color.fromARGB(255, 16, 186, 253),
          children: listaDewidgetParaCard[0],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    llenaListaWidget();

    estadoVentaFraccionada.calcularGanancias();
    AnchoDePantalla medidas = anchoPantalla(context);

    return SizedBox(
      width: medidas.anchoLista,
      height: medidas.alto * 0.8 - MediaQuery.of(context).viewInsets.bottom,
      child: Column(
        children: [
          encabezado(context, medidas.anchoLista),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 160,
                child: TexfieldFracciones(labelText: 'Can X Empaque', index: 0),
              ),
              //boton de guardar
              elevatedButtonGuardar1(
                  context: context,
                  focusNode: estadoVentaFraccionada.focofracciones[12],
                  onPressed: () {
                    estadoVentaFraccionada.guardarFracciones(
                        context, estadoProducto.productoConsultado.id);
                  }),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: medidas.anchoLista,
              height: medidas.alto * 0.8 -
                  112 -
                  MediaQuery.of(context).viewInsets.bottom,
              child: ListView(
                children: [
                  cantidadFracciones(medidas: medidas),
                  listWrap(medidas),
                ],
              ),
            ),
          ),
          Column(children: const [])
        ],
      ),
    );
  }
}
