// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/creacion/combos/widget.dart';
import 'package:get/get.dart';

import '../../estado_getx/combos_getx.dart';
import '../../funciones_generales/response.dart';
import 'crear_combos.dart';

Future<dynamic> listaFotanteCombos({
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

  List<FocusNode> focusNodeVXC = [];

  List<List<Widget>> listaDewidgetParaCard = [];
  bool datoValido = false;

  //bool detalleCombosNombresCombos = true;

  @override
  void initState() {
    super.initState();
    focusNodeVXC = [for (var i = 0; i < 17; i++) FocusNode()];
  }

  // cambioDetalleNombre(bool valor) {
  //   setState(() {
  //     detalleCombosNombresCombos = valor;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    AnchoDePantalla medidas = anchoPantalla(context);

    return SizedBox(
      width: medidas.anchoLista,
      height: medidas.alto * 0.8 - MediaQuery.of(context).viewInsets.bottom,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            encabezado(
              context: context,
              anchoLista: medidas.anchoLista,

              //   cambioDetalleNombre: cambioDetalleNombre,
            ),
            Obx(
              () => estadoCombos.seleccionarCrear.value
                  ? Expanded(
                      child: SizedBox(
                        width: medidas.anchoLista,
                        height: medidas.alto * 0.8 -
                            112 -
                            MediaQuery.of(context).viewInsets.bottom,
                        child: ListView(
                          // scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(height: 12),
                            TexfildFiltro(
                              cambiarLaVista: () {},
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: SizedBox(
                        width: medidas.anchoLista,
                        height: medidas.alto * 0.8 -
                            112 -
                            MediaQuery.of(context).viewInsets.bottom,
                        child: ListView(
                          children: [
                            CrearCombo(),
                          ],
                        ),
                      ),
                    ),
            ),
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
