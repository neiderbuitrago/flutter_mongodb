// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../estado_getx/combos_getx.dart';
import '../../estado_getx/productos_getx.dart';
import '../../funciones_generales/response.dart';
import '../../funciones_generales/strings.dart';
import 'lista_seleccionar.dart';

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
  EstadoCombos estadoCombos = Get.find<EstadoCombos>();
  bool llenarDatoTraido = true;

  @override
  Widget build(BuildContext context) {
    campoEnMayusculas(controller: estadoCombos.controllerFiltro);
    estadoCombos.controllerFiltro.text = widget.letrasparaBuscar ?? '';
    AnchoDePantalla medidas = anchoPantalla(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
              hintText: 'Buscar',
            ),
            controller: estadoCombos.controllerFiltro,
            onChanged: (value) {
              estadoCombos.filtrarCombos(value);
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: medidas.anchoLista,
          height: medidas.alto * 0.6,
          child: const ListaCombos(
            esEditable: false,
          ),
        )
      ],
    );
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
