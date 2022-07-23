// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mongodb/db/fracciones.dart';
import 'package:flutter_mongodb/estado_getx/vantas_getx.dart';
import 'package:flutter_mongodb/modelos/fracciones.dart';
import 'package:flutter_mongodb/modelos/productos.dart';
import 'package:get/get.dart';

import '../creacion/productos/cuadro_flotante_consulta_productos.dart';
import '../db/productos_mongo.dart';
import '../funciones_generales/numeros.dart';

class TextFieldBusqueda extends StatelessWidget {
  TextFieldBusqueda({super.key});
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: estadoVentas.controladorBuscar,
        focusNode: estadoVentas.focusBuscar,
        autofocus: true,
        textCapitalization: TextCapitalization.characters,
        onSubmitted: (value) {
          (value.isEmpty || value.trim() == "")
              ? cuadroFlotanteBusqueda(context)
              : {
                  //     print("buscando + ${estadoVentas.controladorBuscar.text}");
                  ProductosDB.getcodigo(
                          estadoVentas.controladorBuscar.text.toString())
                      .then(
                    (value) {
                      if (value != null) {
                        estadoVentas.agregarAVentas(
                            producto: Productos.fromMap(value[0]));
                        estadoVentas.controladorBuscar.clear();
                        //consultar si el codigo de barras esta en fracciones
                      } else {
                        Fracciones fraccionConsulta;
                        FraccionesDB.getCodigo(estadoVentas
                                .controladorBuscar.text
                                .toString()
                                .trim())
                            .then(
                          (value) {
                            if (value != null) {
                              fraccionConsulta = Fracciones.fromMap(value[0]);
                              ProductosDB.getId(fraccionConsulta.idProducto)
                                  .then((value) {
                                if (value != null) {
                                  //agregando la fraccion a producto en ventas
                                  FraccionesEnVenta fraccion =
                                      FraccionesEnVenta(
                                    temCantidad: 1,
                                    temPrecioVenta: fraccionConsulta.precioUnd,
                                    temSubtotal: fraccionConsulta.precioUnd,
                                  );
                                  fraccion.llenarInstancia(fraccionConsulta);

                                  estadoVentas.agregarAVentas(
                                      producto: Productos.fromMap(value[0]),
                                      ventaDeFracciones: true,
                                      precioVenta: fraccionConsulta.precioUnd,
                                      fracciones: fraccion);

                                  estadoVentas.controladorBuscar.clear();
                                }
                              });
                              //abrir el campo flotante de busqueda de productos
                            } else {
                              cuadroFlotanteBusqueda(context);
                            }
                          },
                        );
                      }
                    },
                  )
                };
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            gapPadding: 5,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Colors.lightBlueAccent,
              width: 2,
            ),
          ),

          labelText: "Buscar",
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          // cancelar el texto
          // suffix: GestureDetector(
          //   child: const Icon(
          //     Icons.search_sharp,
          //     color: Colors.grey,
          //     size: 30,
          //   ),
          // ),
        ),
        onChanged: (value) {},
      ),
    );
  }

  cuadroFlotanteBusqueda(BuildContext context) {
    listaFlotanteConsulta(
      context: context,
      coleccion: "Productos",
      esProducto: true,
      letrasparaBuscar: estadoVentas.controladorBuscar.text,
      controladorBuscar: estadoVentas.controladorBuscar,
    ).then(
      (value) {
        if (value != null) {
          estadoVentas.agregarAVentas(producto: value);
          estadoVentas.controladorBuscar.clear();
        }
      },
    );
  }
}

texfieldFracciones({
  required int index,
  required context,
}) {
  EstadoVentas estadoVentas = Get.find<EstadoVentas>();
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      autofocus: index == 0 ? true : false,
      textAlign: TextAlign.center,
      controller: estadoVentas.controlFracciones[index],
      focusNode: estadoVentas.focusFracciones[index],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          gapPadding: 5,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            color: Colors.lightBlueAccent,
            width: 2,
          ),
        ),
      ),
      onEditingComplete: () {
        int cantidad = estadoVentas.focusFracciones.length;
        if (index + 1 < cantidad) {
          if (index / 2 != 0 &&
              estadoVentas.controlFracciones[index - 1].text.isNotEmpty) {
            Navigator.of(context).pop();
          }
          FocusScope.of(context)
              .requestFocus(estadoVentas.focusFracciones[index + 1]);
        } else {
          Navigator.of(context).pop();
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          if (index % 2 == 0) {
            estadoVentas.listafracciones[indexFraccion(index)].temCantidad =
                numeroDecimal(value);
          } else {
            estadoVentas.listafracciones[indexFraccion(index)].temPrecioVenta =
                numeroDecimal(value);
            print(
                "precio venta ${estadoVentas.listafracciones[indexFraccion(index)].temPrecioVenta}");
          }
        }
      },
      onTap: (() => print(indexFraccion(index))),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9-.]'))],
    ),
  );
}

indexFraccion(int index) {
  if (index == 0 || index == 1) {
    return 0;
  } else {
    if (index % 2 == 0) {
      return (index / 2).round();
    } else {
      return ((index - 1) / 2).round();
    }
  }
}
