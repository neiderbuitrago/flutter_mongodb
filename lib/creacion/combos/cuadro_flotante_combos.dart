// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/combos/widget.dart';
import 'package:get/get.dart';

import '../../estado_getx/combos_getx.dart';
import '../../funciones_generales/response.dart';
import '../../funciones_generales/strings.dart';
import 'crear_combos.dart';

Future<dynamic> listaFlotanteCombos({
  required BuildContext context,
}) {
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
          padding: EdgeInsets.all(8),
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
  final EstadoCombos estadoCombos = Get.find<EstadoCombos>();

  //bool detalleCombosNombresCombos = true;

  @override
  void initState() {
    super.initState();
    estadoCombos.filtrarCombos("");
    campoEnMayusculas(controller: estadoCombos.controlleresCombosDetalle[0]);
  }

  @override
  Widget build(BuildContext context) {
    AnchoDePantalla medidas = anchoPantalla(context);
    print(medidas.anchoLista);
    print(medidas.alto * 0.8 - MediaQuery.of(context).viewInsets.bottom);

    return SizedBox(
      width: medidas.anchoLista,
      height:
          medidas.alto * 0.8 - 112 - MediaQuery.of(context).viewInsets.bottom,
      // width: 450,
      // height: 400,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            encabezado(
              context: context,
              anchoLista: medidas.anchoLista,
            ),
            Expanded(
                child: SizedBox(
              width: medidas.anchoLista,
              height: medidas.alto * 0.8 -
                  112 -
                  MediaQuery.of(context).viewInsets.bottom,
              // width: 400,
              // height: 400,
              child: Obx(
                () => estadoCombos.seleccionarCrear.value
                    ? ListView(
                        //  scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(height: 12),
                          TexfildFiltro(
                            cambiarLaVista: () {},
                          ),
                        ],
                      )
                    : ListView(
                        children: [
                          CrearCombo(),
                        ],
                      ),
              ),
            )),
            if (estadoCombos.seleccionarCrear.value)
              buttonIconTexto(
                texto: 'Crear Combo',
                onPressed: () {
                  estadoCombos.cambiarSeleccionarCrear();
                },
              ),
          ],
        ),
      ),
    );
  }
}
