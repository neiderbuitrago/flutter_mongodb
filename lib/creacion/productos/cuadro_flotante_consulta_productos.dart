// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/productos_mongo.dart';
import 'package:flutter_mongodb/modelos/marcas.dart';
import 'package:flutter_mongodb/modelos/productos.dart';
import 'package:get/get.dart';

import '../../db/grupos_mongo.dart';
import '../../db/marcas_mongo.dart';
import '../../db/presentacion.dart';
import '../../db/tarifa_impuestos_mongo.dart';
import '../../estado_getx/productos_getx.dart';
import '../../funciones_generales/response.dart';
import '../lista_seleccion.dart';

Future<dynamic> listaFlotanteConsulta({
  required BuildContext context,
  required String coleccion,
  int? index,
  bool? esProducto = false,
  String? letrasparaBuscar = '',
  final TextEditingController? controladorBuscar,
}) {
  print('letras para buscar: $letrasparaBuscar');
  return showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(230, 255, 255, 255),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ListaSeleccion(
              coleccion: coleccion,
              index: index,
              esProducto: esProducto,
              letrasparaBuscar: letrasparaBuscar,
              controladorBuscar: controladorBuscar,
            ),
          ),
        );
      });
}

class ListaSeleccion extends StatefulWidget {
  const ListaSeleccion({
    Key? key,
    required this.coleccion,
    this.index,
    this.esProducto,
    this.letrasparaBuscar,
    this.controladorBuscar,
  }) : super(key: key);

  final String coleccion;
  final int? index;
  final bool? esProducto;
  final String? letrasparaBuscar;
  final TextEditingController? controladorBuscar;

  @override
  State<ListaSeleccion> createState() => _ListaSeleccionState();
}

class _ListaSeleccionState extends State<ListaSeleccion> {
  TextEditingController controladorEncFiltro = TextEditingController();

  EstadoProducto estadoProductos = Get.find<EstadoProducto>();
  String _letrasFiltro = '';
  bool llenarDatoTraido = true;

  filtrarValores() {
    print('teclado abierto ${MediaQuery.of(context).viewInsets.bottom}');

    estadoProductos.marcasFiltradas.clear();

    if (widget.esProducto == true) {
      ProductosDB.getnombre(_letrasFiltro).then((value) {
        if (value != null) {
          value.forEach((element) async {
            final marca = await MarcaDB.getId(element['marcaId']);
            if (marca != null) {
              Map<String, dynamic> producto =
                  Productos.fromMap(element).toMap();
              producto.addAll({"nombreMarca": marca[0]['nombre']});
              estadoProductos.marcasFiltradas.add(producto);
            }
          });
        }
      });
    } else {
      widget.coleccion == 'Marca'
          ? MarcaDB.getParametro(_letrasFiltro).then((value) {
              if (value != null) {
                value.forEach((element) {
                  estadoProductos.marcasFiltradas.add(element);
                });
              }
            })
          : widget.coleccion == "Grupo"
              ? GruposDB.getParametro(_letrasFiltro).then((value) {
                  if (value != null) {
                    value.forEach((element) {
                      estadoProductos.marcasFiltradas.add(element);
                    });
                  }
                })
              : widget.coleccion == "Impuesto"
                  ? TarifaImpuestosDB.getParametro(_letrasFiltro).then((value) {
                      if (value != null) {
                        value.forEach((element) {
                          estadoProductos.marcasFiltradas.add(element);
                        });
                      }
                    })
                  : widget.coleccion == "Presentacion"
                      ? PresentacionDB.getParametro(_letrasFiltro)
                          .then((value) {
                          if (value != null) {
                            value.forEach((element) {
                              if (element["visible"]) {
                                estadoProductos.marcasFiltradas.add(element);
                              }
                            });
                          }
                        })
                      : null;
    }
  }

  @override
  initState() {
    super.initState();
    controladorEncFiltro.value.copyWith(text: widget.letrasparaBuscar);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.letrasparaBuscar != null && llenarDatoTraido) {
      ///si se trae un dato de una pantalla anterior
      llenarDatoTraido = false;
      _letrasFiltro = widget.letrasparaBuscar ?? '';
    }

    AnchoDePantalla medidas = anchoPantalla(context);

    filtrarValores();
    print("""${medidas.anchoLista}
    ${medidas.alto * 0.6}""");

    return SizedBox(
      width: medidas.anchoLista,
      height: medidas.alto * 0.7,
      child: Column(
        children: [
          Text(
            ' ${widget.coleccion}',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              SizedBox(
                width: medidas.anchoLista - 100,
                child: TextField(
                  autofocus: true,
                  controller: widget.controladorBuscar ?? controladorEncFiltro,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Buscar',
                  ),
                  onChanged: (value) {
                    _letrasFiltro = value;
                    filtrarValores();
                  },
                ),
              ),
            ],
          ),
          (widget.esProducto == true)
              ? Row(
                  children: const [
                    // botonFiltradoGrupoMarcas(
                    //   context: context,
                    //   nombre: 'Marca',
                    //   icono: const Icon(Icons.local_offer),
                    // ),
                    // botonFiltradoGrupoMarcas(
                    //   context: context,
                    //   nombre: 'Grupo',
                    //   icono: const Icon(Icons.schema_outlined),
                    // ),
                  ],
                )
              : const SizedBox(),
          listaMarcaGrupoImpuesto(widget.esProducto ?? false)
        ],
      ),
    );
  }

  //filtro de grupos y marcas
  Padding botonFiltradoGrupoMarcas({
    required BuildContext context,
    required String nombre,
    required Icon icono,
  }) {
    AnchoDePantalla medidas = anchoPantalla(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: SizedBox(
        width: medidas.anchoLista * 0.47,
        child: FloatingActionButton.extended(
          onPressed: (() {
            listaFlotanteConsulta(
              context: context,
              coleccion: nombre,
              esProducto: false,
            ).then(
              (value) {
                if (value != null) {
                  print(value);
                  (nombre == 'Marca')
                      ? estadoProductos.marcaSeleccionada = value
                      : estadoProductos.grupoSeleccionado = value;
                }
              },
            );
          }),
          label: Row(
            children: [
              (nombre == 'Marca')
                  ? (estadoProductos.marcaSeleccionada.isEmpty())
                      ? const Text('Marca')
                      : Text(estadoProductos.marcaSeleccionada.nombre)
                  : (estadoProductos.grupoSeleccionado.isEmpty())
                      ? const Text('Grupo')
                      : Text(estadoProductos.grupoSeleccionado.nombre),
              IconButton(
                onPressed: () {
                  (nombre == 'Marca')
                      ? estadoProductos.marcaSeleccionada =
                          MarcasGrupos.defecto()
                      : estadoProductos.grupoSeleccionado =
                          MarcasGrupos.defecto();
                  filtrarValores();
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
          icon: icono,
        ),
      ),
    );
  }
}
