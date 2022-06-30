// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/combo.dart';
import 'package:get/get.dart';
import '../../estado_getx/combos_getx.dart';
import '../../estado_getx/getx_productos.dart';
import '../../funciones_generales/response.dart';
import '../../modelos/combo.dart';
import '../../modelos/combo_detalle.dart';
import '../productos/cuadro_flotante_consulta_productos.dart';
import 'lista_seleccionar.dart';

//import '../../modelo_datos/detalle_combo.dart';
//import '../../modelo_datos/productos_combos_detalle.dart';

class TexfildFiltro extends StatefulWidget {
  const TexfildFiltro({
    Key? key,
    required this.cambiarLaVista,
    this.index,
    this.esProducto,
    this.letrasparaBuscar,
  }) : super(key: key);

  final Function cambiarLaVista;

  final int? index;
  final bool? esProducto;
  final String? letrasparaBuscar;

  @override
  State<TexfildFiltro> createState() => _TexfildFiltroState();
}

class _TexfildFiltroState extends State<TexfildFiltro> {
  String _letrasFiltro = '';

  bool llenarDatoTraido = true;

  List<dynamic> marcasFiltradas = [];
  TextEditingController controllerFiltro = TextEditingController();
  List<dynamic> datosFiltrados = [];
  llamandoFiltrarValores() async {
    datosFiltrados = await ComboDB.getParametro(widget.letrasparaBuscar ?? "");
  }

  @override
  Widget build(BuildContext context) {
    String letrasparaBuscar = widget.letrasparaBuscar ?? '';

    return ListView.builder(itemBuilder: (context, index) {
      datosFiltrados.length;

      llamandoFiltrarValores();

      if (letrasparaBuscar != '' && llenarDatoTraido) {
        ///si se trae un dato de una pantalla anterior
        llenarDatoTraido = false;
        _letrasFiltro = letrasparaBuscar;
        controllerFiltro.text = letrasparaBuscar;
      }
      AnchoDePantalla medidas = anchoPantalla(context);
      return SizedBox(
        width: medidas.anchoLista,
        // height: medidas.alto * 0.6,
        child: Column(
          children: [
            SizedBox(
              width: medidas.anchoLista,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: medidas.anchoLista - 120,
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: 'Buscar',
                      ),
                      controller: controllerFiltro,
                      onChanged: (value) {
                        setState(() {
                          _letrasFiltro = value;
                          llamandoFiltrarValores();
                        });
                      },
                      onSubmitted: (value) {
                        listaFlotanteConsulta(
                          context: context,
                          coleccion: "Procustos",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const ListaCombos(
              esEditable: false,
              // cambioDetalleNombre: () {},
            )
          ],
        ),
      );
    });
  }
}

FloatingActionButton buttonIconTexto({
  required String texto,
  required onPressed,
}) {
  return FloatingActionButton.extended(
    onPressed: onPressed,
    icon: const Icon(
      Icons.add,
      color: Colors.white,
    ),
    label: Text(texto,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
  );
}

Container encabezado({
  required BuildContext context,
  required double anchoLista,
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
