// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../estado_getx/fracciones_getx.dart';
import '../../funciones_generales/response.dart';
import '../../funciones_generales/strings.dart';

class TexfieldFracciones extends StatefulWidget {
  const TexfieldFracciones({
    Key? key,
    required this.labelText,
    required this.index,
  }) : super(key: key);

  final String labelText;
  final int index;

  @override
  _TexfieldFraccionesState createState() => _TexfieldFraccionesState();
}

class _TexfieldFraccionesState extends State<TexfieldFracciones> {
  EstadoVentaFraccionada estadoVentaFraccionada =
      Get.find<EstadoVentaFraccionada>();
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    bool stringDouble = (index == 2 || index == 3);
    if (stringDouble) {
      campoEnMayusculas(
          controller:
              estadoVentaFraccionada.controladoresFraccion[widget.index]);
    }
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        child: TextField(
            autofocus: (widget.index == 0) ? true : false,
            focusNode: estadoVentaFraccionada.focofracciones[widget.index],
            controller:
                estadoVentaFraccionada.controladoresFraccion[widget.index],
            decoration: InputDecoration(
              focusColor: Colors.blue,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              labelText: widget.labelText,
              hintStyle: TextStyle(
                fontSize: 15,
                color: Colors.grey[400],
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            ),
            inputFormatters: (!stringDouble)
                ? [FilteringTextInputFormatter.allow(RegExp('[0-9-.]'))]
                : [],
            onChanged: (widget.index == 5)
                ? (value) {
                    estadoVentaFraccionada.calcularGanancias();
                  }
                : (widget.index == 6)
                    ? (value) {
                        estadoVentaFraccionada.calcularPrecioVenta(
                            index: widget.index, value: value);
                      }
                    : (value) {
                        print('cambios en el texto10  $value $widget.index');
                      },
            onSubmitted: (value) {
              if (widget.index == 2) {
                estadoVentaFraccionada.consultarSiCodigoFraccionExiste(
                    value, context);
              }

              if (widget.index == 0) {
                FocusScope.of(context).requestFocus(
                    estadoVentaFraccionada.focofracciones[widget.index + 1]);
              } else if (widget.index == 1 &&
                  estadoVentaFraccionada.listaBodegasVisibles.value) {
                FocusScope.of(context)
                    .requestFocus(estadoVentaFraccionada.focofracciones[7]);
              } else if (widget.index == 11 &&
                  estadoVentaFraccionada.listaBodegasVisibles.value) {
                FocusScope.of(context)
                    .requestFocus(estadoVentaFraccionada.focofracciones[2]);
              } else if (widget.index == 6) {
                FocusScope.of(context)
                    .requestFocus(estadoVentaFraccionada.focofracciones[12]);
              } else {
                FocusScope.of(context).requestFocus(
                    estadoVentaFraccionada.focofracciones[widget.index + 1]);
              }
            },
            onTap: () {
              print(widget.index);
            }),
      ),
    );
  }
}

class Cardgeneral extends StatelessWidget {
  const Cardgeneral({
    Key? key,
    required this.children,
    required this.colorbordes,
  }) : super(key: key);
  final List<Widget> children;
  final Color colorbordes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Card(
        shadowColor: colorbordes,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          side: BorderSide(
            color: colorbordes,
            width: 2,
          ),
        ),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}

Widget cantidadFracciones({
  required AnchoDePantalla medidas,
}) {
  late EstadoVentaFraccionada estadoVentaFraccionada =
      Get.find<EstadoVentaFraccionada>();

  return SizedBox(
    child: Obx(
      () => SizedBox(
        width: (estadoVentaFraccionada.listaBodegasVisibles.value)
            ? 300
            : medidas.anchoLista,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 250,
              child: TexfieldFracciones(
                labelText: "Cantidad",
                index: 1,
              ),
            ),
            Obx(
              () => FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    (estadoVentaFraccionada.listaBodegasVisibles.value)
                        ? Icons.playlist_remove
                        : Icons.playlist_add,
                    size: tamanoIconos(estadoVentaFraccionada.context),
                  ),
                  onPressed: () {
                    estadoVentaFraccionada.listaBodegasVisibles.value =
                        !estadoVentaFraccionada.listaBodegasVisibles.value;
                  }),
            ),
          ],
        ),
      ),
    ),
  );
}
