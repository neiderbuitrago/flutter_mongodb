// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mongodb/creacion/venta_x_cantidad/widget.dart';
import 'package:get/get.dart';
import '../../estado_getx/productos_getx.dart';
import '../../estado_getx/venta_x_cantidad_getx.dart';

class TexfieldVentaXCantidad extends StatefulWidget {
  const TexfieldVentaXCantidad({
    Key? key,
    required this.labelText,
    required this.index,
    required this.validarRangos,
  }) : super(key: key);

  final String labelText;
  final int index;
  final Function validarRangos;

  @override
  _TexfieldVentaXCantidadState createState() => _TexfieldVentaXCantidadState();
}

class _TexfieldVentaXCantidadState extends State<TexfieldVentaXCantidad> {
  final EstadoVentaXCantidad estadoVentaXCantidad =
      Get.find<EstadoVentaXCantidad>();
  final EstadoProducto estadoProducto = Get.find<EstadoProducto>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // ignore: dead_code
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
          focusNode: estadoVentaXCantidad.focusNode[widget.index],
          controller:
              estadoVentaXCantidad.controladoresVentaXCantidad[widget.index],
          decoration: InputDecoration(
            suffix: (widget.index == 1 ||
                    widget.index == 4 ||
                    widget.index == 5 ||
                    widget.index == 8 ||
                    widget.index == 9 ||
                    widget.index == 12 ||
                    widget.index == 13)
                ? Obx(
                    () => (estadoVentaXCantidad
                                .datosValidosVentaXCantidad[widget.index] ==
                            true)
                        ? const Icon(
                            Icons.done,
                            color: Colors.greenAccent,
                          )
                        : const Icon(Icons.close, color: Colors.red),
                  )
                : null,
            suffixIconColor: Colors.black,
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
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9-.]'))
          ],
          onChanged: (widget.index == 2 ||
                  widget.index == 6 ||
                  widget.index == 10 ||
                  widget.index == 14)
              ? (value) {
                  calcularGananciasVentaXcantidad();
                }
              : (widget.index == 3 ||
                      widget.index == 7 ||
                      widget.index == 11 ||
                      widget.index == 15)
                  ? (value) {
                      print(value);
                      calcularPrecioVenta(value: value, index: widget.index);
                    }
                  : (widget.index == 0 ||
                          widget.index == 1 ||
                          widget.index == 4 ||
                          widget.index == 5 ||
                          widget.index == 8 ||
                          widget.index == 9 ||
                          widget.index == 12 ||
                          widget.index == 13)
                      ? (value) {
                          validarRangos();
                        }
                      : (value) {
                          print('cambios en el texto10  $value $widget.index');
                        },
          onTap: () {
            print('tap en el texto10  ${widget.index}');
          },
          onSubmitted: (value) {
            if (widget.index == 15) {
              FocusScope.of(context)
                  .requestFocus(estadoVentaXCantidad.focusNode[0]);
            } else {
              FocusScope.of(context).requestFocus(
                  estadoVentaXCantidad.focusNode[widget.index + 1]);
            }
          },
        ),
      ),
    );
  }
}
