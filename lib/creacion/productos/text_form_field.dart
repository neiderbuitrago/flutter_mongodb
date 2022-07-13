// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mongodb/db/productos_mongo.dart';
import 'package:get/get.dart';
import '../../estado_getx/combos_getx.dart';
import '../../estado_getx/fracciones_getx.dart';
import '../../estado_getx/productos_getx.dart';
import '../../estado_getx/identificadores.dart';
import '../../estado_getx/multicodigo_getx.dart';
import '../../estado_getx/venta_x_cantidad_getx.dart';
import '../../funciones_generales/strings.dart';
import '../../modelos/combo.dart';
import '../combos/cuadro_flotante_combos.dart';
import '../fracciones/cuadro_flotante_venta_fraccionada.dart';
import '../identificadores/creacion_identificador.dart';
import '../multicodigos/creacion_multicodigos.dart';
import '../venta_x_cantidad/cuadro_flotante_venta_x_cantidad.dart';
import '../widget.dart';
import 'cuadro_flotante_consulta_productos.dart';
import 'llenar_datos.dart';
import 'widget.dart';

//CONSTRUIR UN FUTURE BUILDER PARA LA CONSULTA DE PRODUCTOS

class TextFormFieldProducto extends StatefulWidget {
  @override
  const TextFormFieldProducto({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<TextFormFieldProducto> createState() => _TextFormFieldProductoState();
}

class _TextFormFieldProductoState extends State<TextFormFieldProducto> {
  final EstadoCombos estadoCombos = Get.find<EstadoCombos>();
  final EstadoVentaFraccionada estadoVentaFraccionada =
      Get.find<EstadoVentaFraccionada>();
  final EstadoIdentificador estadoIdentificador =
      Get.find<EstadoIdentificador>();
  final EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  late String _texto = '';

  bool comprovarSiHayValores(
    int cuantosCamposExaminara,
    List listaControles,
  ) {
    bool devolver = true;
    for (var i = 0; i < cuantosCamposExaminara; i++) {
      if (listaControles[i].text.isEmpty) {
        devolver = false;
        break;
      }
    }
    return devolver;
  }

  @override
  initState() {
    super.initState();
    nuevoCodigostring().then((value) {
      _texto = value.toString();
    });

    campoEnMayusculas(controller: estadoProducto.controladores[0]);
    campoEnMayusculas(controller: estadoProducto.controladores[1]);
  }

  actualizar() {
    setState(() {});
  }

//Mostrar alerta informado que debe tener un producto seleccionado
  mostrarAlerta(Function abrirVentana) {
    EstadoProducto estadoProducto = Get.find<EstadoProducto>();
    if (estadoProducto.controladores[0].text.isEmpty) {
      informarInferior(
        titleText: 'Advertencia',
        messageText: 'Debe seleccionar un producto primero',
      );
    } else {
      ProductosDB.getcodigo(estadoProducto.controladores[0].text.toUpperCase())
          .then((value) {
        if (value != null) {
          abrirVentana();
        } else {
          informarInferior(
            titleText: 'Advertencia',
            messageText: 'Debe seleccionar un producto primero',
          );
        }
      });
    }
    print(estadoProducto.controladores[0].text.isEmpty);
    // estadoProducto.productoConsultado.isEmpty().then((value) {
    //   if (value != null) {
    //     abrirVentana();
    //   } else {
    //     informarInferior(
    //       titleText: 'Advertencia',
    //       messageText: 'Debe seleccionar un producto primero',
    //     );
    //   }
    // }
    //);
  }

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width;

    final ancho = (anchoPantalla < 600) ? anchoPantalla : anchoPantalla * 0.5;

    return Obx(
      () => Visibility(
        visible: (widget.index > 6 && widget.index < 12)
            ? estadoVentaFraccionada.listaBodegasVisibles.value
            : true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: SizedBox(
            width: ancho - 12,
            child: Row(
              children: [
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(189, 233, 231, 231),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  width: (widget.index == 1 ||
                          widget.index == 6 ||
                          widget.index > 21 && widget.index <= 28)
                      ? ancho - 71
                      : ancho - 12,
                  child: (widget.index < 22)
                      ? texfieldFormFieldProductos(context)
                      : botonNuevaVentanas(),
                ),
                if (widget.index == 1)
                  IconButton(
                    icon: const Icon(
                      Icons.search_outlined,
                      size: 40,
                    ),
                    onPressed: () {
                      listaFlotanteConsulta(
                        context: context,
                        coleccion: "Productos",
                        esProducto: true,
                        letrasparaBuscar: estadoProducto.controladores[1].text,
                      ).then(
                        (value) {
                          if (value != null) {
                            //   estadoProducto.controladores[1].text = value.nombre;
                            llenarDatos(
                              codigo: value.codigo,
                            );
                          }
                        },
                      );
                    },
                  ),
                if (widget.index == 6)
                  Obx(
                    () => IconButton(
                        tooltip: (estadoVentaFraccionada
                                    .listaBodegasVisibles.value ==
                                true)
                            ? 'Deshabilitar Bodegas'
                            : 'Habilitar Bodegas',
                        icon: Icon(
                            (estadoVentaFraccionada
                                        .listaBodegasVisibles.value ==
                                    true)
                                ? Icons.playlist_remove
                                : Icons.playlist_add,
                            size: 40),
                        onPressed: () {
                          estadoVentaFraccionada.listaBodegasVisibles.value =
                              !estadoVentaFraccionada
                                  .listaBodegasVisibles.value;
                        }),
                  ),
                if (widget.index > 21 && widget.index <= 28)
                  switchVerdaderoFalso(index: widget.index),
                (estadoVentaFraccionada.listaBodegasVisibles.value)
                    ? const SizedBox(
                        height: 0,
                      )
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField texfieldFormFieldProductos(BuildContext context) {
    var textFormField2 = TextFormField(
      maxLines: null,
      autocorrect: true,
      onTap: (widget.index == 0)
          ? () {
              nuevoCodigostring().then((value) {});
            }
          : (widget.index == 1)
              ? () {
                  if (estadoProducto.controladores[0].text.isEmpty) {
                    nuevoCodigostring().then((value) {
                      return estadoProducto.controladores[0].text =
                          (value).toString();
                    });
                  } else {
                    if (estadoProducto.controladores[1].text.isEmpty) {
                      llenarDatos(
                        codigo: estadoProducto.controladores[0].text,
                      );
                    }
                  }
                }
              : (widget.index >= 2 && widget.index <= 4)
                  ? () {
                      listaFlotanteConsulta(
                        context: context,
                        coleccion: (widget.index == 2)
                            ? "Marca"
                            : (widget.index == 3)
                                ? "Grupo"
                                : "Impuesto",
                        index: widget.index,
                      ).then(
                        (value) {
                          print(value);
                          if (value != null) {
                            estadoProducto.guardarIdMarcaGrupoImpuesto(
                                index: widget.index, value: value);
                          }
                        },
                      );
                    }
                  : (widget.index == 17)
                      ? () {
                          listaFlotanteConsulta(
                            context: context,
                            coleccion: "Presentacion",
                            index: widget.index,
                          ).then(
                            (value) {
                              print(value);
                              if (value != null) {
                                estadoProducto.guardarIdPresentacion(
                                    index: widget.index, value: value);
                              }
                            },
                          );
                        }
                      : () {
                          print(widget.index);
                        },
      focusNode: estadoProducto.focusNode[widget.index],
      keyboardType:
          (widget.index >= 5 && widget.index != 21 && widget.index != 17)
              ? TextInputType.number
              : TextInputType.text,
      inputFormatters:
          (widget.index >= 5 && widget.index != 21 && widget.index != 17)
              ? [FilteringTextInputFormatter.allow(RegExp('[0-9-.]'))]
              : [],
      onEditingComplete: () {
        if (widget.index == 0) {
          if (estadoProducto.controladores[0].text.isEmpty) {
            estadoProducto.controladores[widget.index].text = _texto;
          } else {
            llenarDatos(
                codigo: estadoProducto.controladores[0].text.toUpperCase());
          }
        }

        if (widget.index == 6 &&
            !estadoVentaFraccionada.listaBodegasVisibles.value) {
          FocusScope.of(context).requestFocus(estadoProducto.focusNode[12]);
        } else {
          FocusScope.of(context).requestFocus(estadoProducto.focusNode[
              (widget.index < estadoProducto.focusNode.length)
                  ? widget.index + 1
                  : 0]);
          if (widget.index == 1 || widget.index == 2 || widget.index == 3) {
            listaFlotanteConsulta(
              context: context,
              coleccion: (widget.index == 1)
                  ? "Marca"
                  : (widget.index == 2)
                      ? "Grupo"
                      : "Impuesto",
              index: widget.index + 1,
            ).then(
              (value) {
                print(value);
                if (value != null) {
                  estadoProducto.guardarIdMarcaGrupoImpuesto(
                      index: widget.index + 1, value: value);
                }
              },
            );
          }
        }
      },
      controller: estadoProducto.controladores[widget.index],
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 111, 40, 226), width: 1),
          // Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.blueAccent,
              width: 2.0,
            )),
        labelText: estadoProducto.campos[widget.index],
        hintText: (widget.index == 0) ? _texto : "",
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 117, 115, 115),
          fontSize: 20,
        ),
        hintStyle: const TextStyle(fontSize: 15, color: Colors.blue),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      ),
      scrollPadding: const EdgeInsets.all(30),
    );
    var textFormField = textFormField2;
    return textFormField;
  }

//boton
  FloatingActionButton botonNuevaVentanas() {
    EstadoVentaXCantidad estadoVentaXCantidad =
        Get.find<EstadoVentaXCantidad>();
    return FloatingActionButton.extended(
      focusNode: estadoProducto.focusNode[widget.index],
      backgroundColor: const Color.fromARGB(255, 162, 132, 242),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: Colors.white,
        ),
      ),
      label: (widget.index == 25)
          ? (!estadoProducto.manejaCombos.value)
              ? Text(
                  estadoProducto.campos[widget.index],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Open Sans',
                  ),
                )
              : Obx(() => ColocarTextoAdicional(
                    primerTexto: estadoProducto.campos[widget.index],
                    segundoTexto: estadoProducto.nombreComboSeleccionado.value,
                  ))
          : (widget.index == 28)
              ? ColocarTextoAdicional(
                  primerTexto: estadoProducto.campos[widget.index],
                  segundoTexto: estadoProducto.seleccionTipoProducto.value,
                )
              : Text(
                  estadoProducto.campos[widget.index],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Open Sans',
                  ),
                ),
      onPressed: (widget.index == 22)
          ? () {
              mostrarAlerta(
                () {
                  print(widget.index);
                  estadoVentaFraccionada.costoGeneralProducto.value =
                      estadoProducto.controladores[5].text;
                  if (!estadoProducto.manejaVentaFraccionada.value) {
                    estadoProducto.funtionHabilitar(index: widget.index);
                  }
                  listaFlotanteFracciones(
                    context: context,
                  ).then((value) {
                    print('El valor que se recupero es $value');

                    if (!comprovarSiHayValores(
                        5, estadoVentaFraccionada.controladoresFraccion)) {
                      estadoProducto.funtionHabilitar(index: widget.index);
                    }
                    print('este es el valor $value');
                  });
                },
              );
            }
          : (widget.index == 23)
              ? () {
                  mostrarAlerta(
                    () {
                      if (!estadoProducto.manejaVentaXCantidad.value) {
                        estadoProducto.funtionHabilitar(index: widget.index);
                      }
                      listaFlotanteVentaXCantidad(
                        context: context,
                      ).then((value) {
                        print('El valor que se recupero es $value');

                        if (!comprovarSiHayValores(
                          4,
                          estadoVentaXCantidad.controladoresVentaXCantidad,
                        )) {
                          estadoProducto.funtionHabilitar(index: widget.index);
                        }
                        print('este es el valor $value');
                      });
                    },
                  );
                }
              : (widget.index == 24)
                  ? () {
                      mostrarAlerta(
                        () {
                          if (!estadoProducto.manejaIdentificador.value) {
                            estadoProducto.funtionHabilitar(
                                index: widget.index);
                          }
                          listaIdentificadores(
                            context: context,
                          ).then(
                            (value) {
                              if (estadoIdentificador
                                  .mapIdentificador.isEmpty) {
                                estadoProducto.funtionHabilitar(
                                    index: widget.index);
                              } else {}
                            },
                          );
                        },
                      );
                    }
                  : (widget.index == 25)
                      ? () {
                          if (!estadoProducto.manejaCombos.value) {
                            estadoProducto.funtionHabilitar(
                                index: widget.index);
                          }
                          listaFlotanteCombos(context: context).then(
                            (value) {
                              if (value != null) {
                                estadoProducto.comboSeleccionado = value;
                                estadoProducto.nombreComboSeleccionado.value =
                                    value.nombre;
                              } else {
                                estadoProducto.funtionHabilitar(
                                    index: widget.index);
                                estadoProducto.comboSeleccionado =
                                    Combos.defecto();

                                estadoProducto.nombreComboSeleccionado.value =
                                    '';
                              }
                              actualizar();
                            },
                          );
                        }
                      : (widget.index == 26)
                          ? () {
                              mostrarAlerta(
                                () {
                                  EstadoMulticodigos estadoMulticodigos =
                                      Get.find<EstadoMulticodigos>();
                                  // colocar el texto en nombre principal
                                  estadoMulticodigos.nombreProducto.value =
                                      estadoProducto.controladores[1].text
                                          .toUpperCase();

                                  //Colocar el id del producto principal en el estado
                                  // estadoMulticodigos.idProducto =
                                  //     estadoProducto.productoConsultado.id;
                                  if (!estadoProducto
                                      .manejaMulticodigos.value) {
                                    estadoProducto.funtionHabilitar(
                                        index: widget.index);
                                  }

                                  listaFlotanteMulticodigos(context: context)
                                      .then(
                                    (value) {
                                      if (estadoMulticodigos
                                          .listaMulticodigos.isEmpty) {
                                        estadoProducto.funtionHabilitar(
                                            index: widget.index);
                                      }
                                    },
                                  );
                                },
                              );
                            }
                          : (widget.index == 27)
                              ? () {
                                  mostrarAlerta(() {
                                    estadoProducto.funtionHabilitar(
                                        index: widget.index);
                                  });
                                }
                              : (widget.index == 28)
                                  ? () {
                                      mostrarAlerta(() {
                                        estadoProducto.cambiarTipoProducto();

                                        if (estadoProducto
                                            .cambiarSwitch.value) {
                                          estadoProducto.funtionHabilitar(
                                              index: widget.index);
                                        }
                                      });
                                    }
                                  : () {},
    );
  }
}
