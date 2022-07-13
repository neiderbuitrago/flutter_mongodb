// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/ventas/texfield.dart';

class Ventas extends StatefulWidget {
  const Ventas({super.key});

  @override
  _VentasState createState() => _VentasState();
}

class _VentasState extends State<Ventas> {
  @override
 
    Row encabezadoBusqueda() {
    return Row(
      children: [
        GestureDetector(
          child: const Icon(
            Icons.qr_code_scanner,
            size: 50,
          ),
          onTap: () async {
            // codigoBarras = await FlutterBarcodeScanner.scanBarcode(
            //     "#004297", "Cancelar", true, ScanMode.BARCODE);
            // if (codigoBarras != "-1") {
            //   setState(() {
            //     consultarCodigo(codigoBarras, "P");
            //     controlador.text = codigoBarras;
            //   });
            // }
          },
        ),
        Expanded(
          flex: 5,
          child: TextFieldBusqueda(
              onTap: () {
                if (controlador.text.isNotEmpty) {
                  consultarCodigo(controlador.text.toUpperCase(), "P");
                }
              },
              controlador: controlador,
              onChanged: (value) {
                setState(() {
                  visible = true;
                  _consultarProductos();
                });
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  consultarCodigo(value.toUpperCase(), "P");
                }
              },
              labelText: "Buscar Producto"),
        ),

        //Agregar cliente
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GestureDetector(
            child: const Icon(
              Icons.person_add,
              size: 50,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => Clientes(app: widget.app),
                ),
              )
                  .then(
                (value) {
                  print(value);
                  if (value != null) {
                    print("es diferente a null");
                    mapcliente = value;
                    print(mapcliente);
                    setState(
                      () {
                        altoContenedor = 135.00;
                        altoParaCliente = 0.775;
                      },
                    );
                  } else {
                    mapcliente = {};
                    print(mapcliente);
                    print("el map fue borrado");
                    setState(() {
                      altoContenedor = 118;
                      altoParaCliente = 0.875;
                    });
                  }
                },
              );
            },
          ),
        ),

        const Expanded(flex: 1, child: SizedBox(width: 2)),
        textButtonGuardar(() {
          if (productosEnVentaLis.isNotEmpty) {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) =>
                    FormaPago(totalfacturaSinpuntos, formasPago),
              ),
            )
                .then(
              (value) {
                if (value != null) {
                  guardarFactura(
                    datosParaCaja(
                        value, formasPago, totalfacturaSinpuntos, mapcliente),
                  );
                }
              },
            );
          }
        }, "Guardar"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    anchoPantalla = MediaQuery.of(context).size.width;
    return PersistedAppState(
      storage: const JsonFileStorage(initialData: {
        "tab": 1,
      }),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                  child: Container(
                    height: altoContenedor,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [altoParaCliente, 0.1],
                        colors: const [
                          Colors.white,
                          Colors.lightBlueAccent,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: encabTotalNumero(
                                _error, _conteo, totalfacturaSinpuntos),
                          ),
                          encaBusqueda(),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                nombreCompleto(mapcliente),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                (visible)
                    ? tituloListaCoincidencias(() {
                        setState(() {
                          visible = false;
                        });
                      }, "Seleccionar Producto", context)
                    : tituloCuadroVenta(anchoPantalla),
                lineaDivisora(),
                Visibility(
                  visible: !visible,
                  child: tablaProductos(
                    context,
                    productosEnVentaLisreve,
                    controldatos,
                    actualizarSubtotalTotal,
                    dialogoEliminacion,
                    productosEnVentaLis,
                    insertarEnVentaLimpiar,
                    totalfacturaSinpuntos,
                    setState,
                    anchoPantalla,
                  ),
                ),
                Visibility(
                    visible: visible,
                    child: verlistaFiltrados(
                      productosFiltrados,
                      setState,
                      insertarEnVentaLimpiar,
                      false,
                      anchoPantalla,
                      () {},
                    )),
              ],
            ),
          ),
          floatingActionButton: BotonFlotante(
            onPressed: () {
              datosParaCaja(
                  "demo", formasPago, totalfacturaSinpuntos, mapcliente);
            },
          ),
        ),
      ),
    );
  }
}
}
