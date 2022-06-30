// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../estado_getx/fracciones_getx.dart';
import '../../funciones_generales/numeros.dart';
import '../../funciones_generales/response.dart';
import '../../modelos/fracciones.dart';
import '../venta_x_cantidad/widget.dart';

class TexfieldFracciones extends StatefulWidget {
  const TexfieldFracciones({
    Key? key,
    required this.focofracciones,
    required this.labelText,
    required this.index,
  }) : super(key: key);
  final List<FocusNode> focofracciones;
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
            focusNode: widget.focofracciones[widget.index],
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
            onChanged: (widget.index == 3 ||
                    widget.index == 7 ||
                    widget.index == 11 ||
                    widget.index == 15)
                ? (value) {
                    estadoVentaFraccionada.calcularGanancias(
                      index: widget.index,
                    );
                  }
                : (widget.index == 4 ||
                        widget.index == 8 ||
                        widget.index == 12 ||
                        widget.index == 16)
                    ? (value) {
                        double pc = comprovarSihayNumero(
                            estadoVentaFraccionada.costoGeneralProducto.value);

                        double cxe = comprovarSihayNumero(estadoVentaFraccionada
                            .controladoresFraccion[0].text);
                        double cantidadDescontar = comprovarSihayNumero(
                            estadoVentaFraccionada
                                .controladoresFraccion[widget.index - 2].text);

                        double costoFraccion = (pc / cxe) * cantidadDescontar;

                        int precioVenta =
                            ((costoFraccion * comprovarSihayNumero(value)) /
                                        100 +
                                    costoFraccion)
                                .toInt();

                        estadoVentaFraccionada
                            .controladoresFraccion[widget.index - 1]
                            .text = (precioVenta.round()).toString();
                      }
                    : (value) {
                        print('cambios en el texto10  $value $widget.index');
                      },
            onSubmitted: (value) {
              if (widget.index == 0) {
                FocusScope.of(context)
                    .requestFocus(widget.focofracciones[widget.index + 17]);
              } else if (widget.index == 17 &&
                  estadoVentaFraccionada.listaBodegasVisibles.value) {
                FocusScope.of(context)
                    .requestFocus(widget.focofracciones[widget.index + 1]);
              } else if (widget.index == 17 &&
                  !estadoVentaFraccionada.listaBodegasVisibles.value) {
                printError(info: 'Pasando el foco a el 1');
                FocusScope.of(context).requestFocus(widget.focofracciones[1]);
              } else if (widget.index == 18) {
                FocusScope.of(context)
                    .requestFocus(widget.focofracciones[widget.index + 1]);
              } else if (widget.index == 22) {
                FocusScope.of(context).requestFocus(widget.focofracciones[1]);
              } else if (widget.index == 16) {
                FocusScope.of(context).requestFocus(widget.focofracciones[0]);
              } else {
                FocusScope.of(context)
                    .requestFocus(widget.focofracciones[widget.index + 1]);
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
      height: 250,
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

class CantidadesBodega1 extends StatelessWidget {
  const CantidadesBodega1({
    Key? key,
    required this.focofracciones,
    required this.medidas,
  }) : super(key: key);
  final List<FocusNode> focofracciones;
  final AnchoDePantalla medidas;

  @override
  Widget build(BuildContext context) {
    late EstadoVentaFraccionada estadoVentaFraccionada =
        Get.find<EstadoVentaFraccionada>();
    List<String> nombres = [
      'Cantidad',
      'Bodega1',
      'Bodega2',
      'Bodega3',
      'Bodega4',
      'Bodega5',
    ];

    return SizedBox(
      width: medidas.anchoLista,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          for (var i = 0; i < nombres.length; i++)
            SizedBox(
              child: (i == 0)
                  ? Obx(
                      () => SizedBox(
                        width:
                            (estadoVentaFraccionada.listaBodegasVisibles.value)
                                ? 300
                                : medidas.anchoLista,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              child: TexfieldFracciones(
                                focofracciones: focofracciones,
                                labelText: nombres[i],
                                index: i + 17,
                              ),
                            ),
                            Obx(
                              () => IconButton(
                                  icon: Icon(
                                      (estadoVentaFraccionada
                                              .listaBodegasVisibles.value)
                                          ? Icons.playlist_remove
                                          : Icons.playlist_add,
                                      size: 40),
                                  onPressed: () {
                                    estadoVentaFraccionada
                                            .listaBodegasVisibles.value =
                                        !estadoVentaFraccionada
                                            .listaBodegasVisibles.value;
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Obx(
                      () => Visibility(
                        visible:
                            estadoVentaFraccionada.listaBodegasVisibles.value,
                        child: SizedBox(
                          width: 300,
                          child: TexfieldFracciones(
                            focofracciones: focofracciones,
                            labelText: nombres[i],
                            index: i + 17,
                          ),
                        ),
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}

llanarDatos() {
  EstadoVentaFraccionada estadoFracciones = Get.find<EstadoVentaFraccionada>();

  Fracciones fracciones = estadoFracciones.fraccionesConsultadas;
  List controlador = estadoFracciones.controladoresFraccion;
  estadoFracciones.controladoresFraccion[0].text =
      quitarDecimales(fracciones.cantidad).toString();

  controlador[1].text = fracciones.nombre1;
  controlador[2].text = quitarDecimales(fracciones.cantidadDescontar1);
  controlador[3].text = quitarDecimales(fracciones.precio1);
  //
  controlador[5].text = fracciones.nombre2;
  controlador[6].text = quitarDecimales(fracciones.cantidadDescontar2);
  controlador[7].text = quitarDecimales(fracciones.precio2);
  //
  controlador[9].text = fracciones.nombre3;
  controlador[10].text = quitarDecimales(fracciones.cantidadDescontar3);
  controlador[11].text = quitarDecimales(fracciones.precio3);
  //
  controlador[13].text = fracciones.nombre4;
  controlador[14].text = quitarDecimales(fracciones.cantidadDescontar4);
  controlador[15].text = quitarDecimales(fracciones.precio4);
  //
  controlador[17].text = fracciones.cantidad;

  controlador[18].text = quitarDecimales(fracciones.bodega1);
  controlador[19].text = quitarDecimales(fracciones.bodega2);
  controlador[20].text = quitarDecimales(fracciones.bodega3);
  controlador[21].text = quitarDecimales(fracciones.bodega4);
  controlador[22].text = quitarDecimales(fracciones.bodega5);
}
