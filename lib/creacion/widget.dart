// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/productos_mongo.dart';

import 'package:get/get.dart';

// class TextFormField1 extends StatelessWidget {
//   @override
//   const TextFormField1({
//     Key? key,
//     required this.focusNode,
//     required this.controller,
//     required this.box,
//     required this.idEdicion,
//     required this.redibujasLista,
//     required this.labelText,
//     required this.index,
//   }) : super(key: key);

//   final List<FocusNode> focusNode;
//   final List<TextEditingController> controller;
//   final Box box;
//   final Function idEdicion, redibujasLista;

//   final String labelText;
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       focusNode: focusNode[index],
//       // keyboardType: TextInputType.text,
//       // textCapitalization: TextCapitalization.characters,
//       onEditingComplete: () {
//         FocusScope.of(context).requestFocus(focusNode[index + 1]);
//       },
//       controller: controller[index],
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           gapPadding: 5,
//         ),
//         labelText: labelText,
//         labelStyle: const TextStyle(
//           color: Colors.black,
//           fontSize: 25,
//         ),
//         // cancelar el texto
//         suffixIcon: IconButton(
//           padding: const EdgeInsets.only(right: 10),
//           icon: const Icon(Icons.clear),
//           onPressed: () {
//             idEdicion();
//             controller[index].clear();
//           },
//         ),
//       ),
//       validator: (value) {
//         if (value?.isEmpty ?? true) {
//           return 'Por favor ingrese ${(labelText == "Marca") ? "la" : "el"} $labelText)';
//         }
//         return null;
//       },
//       onChanged: (value) {
//         redibujasLista();
//         //filtrarDatosString(box: box, letra: value);
//       },
//     );
//   }
// }

// //craar una funcion para consultar el codigo de la marca
// nuevoCodigo(Box box) {
//   int codigo = 1;
//   bool codigoasignado = false;

//   if (box.length > 0) {
//     List codigos = box.keys.toList();
//     for (int i = 1; i <= codigos.length; i++) {
//       // print('${codigos[i] is int}');
//       if (codigos[i - 1] != i) {
//         codigo = i;
//         codigoasignado = true;
//         break;
//       }
//       if (codigoasignado == false) {
//         codigo = box.length + 1;
//       }
//     }
//   } else {
//     codigo = 1;
//   }
//   return codigo;
// }

Future<int> nuevoCodigostring() async {
  int codigo = 1;
  bool codigoasignado = false;
  var codigos = await ProductosDB.getcodigoAll();
  print(codigos);
  if (codigos != null) {
    for (int i = 1; i <= codigos.length; i++) {
      if (!codigos.contains(i.toString())) {
        codigo = i;
        codigoasignado = true;
        break;
      }
      if (codigoasignado == false) {
        codigo = codigos.length + 1;
      }
    }
  } else {
    codigo = 1;
  }
  return codigo;
}

// // filtrarDatosString({required Box box, required String letra}) {
// //   var producto = box.values.toList();
// //   for (var item in producto) {
// //     if (item.nombre.toString().startsWith(letra)) {
// //       print(item.nombre);
// //     }
// //   }
// //}

// //validar nombre de la marca
// validarNombresCreados({
//   required String nombre,
//   required Box box,
// }) {
//   List _value = box.values.toList();
//   if (_value.isNotEmpty) {
//     for (var item in _value) {
//       if (item.nombre.toString().toLowerCase() == nombre.toLowerCase()) {
//         //retornar un json

//         return {"valor": true, "codigo": item.codigo};
//       }
//     }
//   }
//   return null;
// }

// estaCreadoImpuesto({
//   required List<TextEditingController> nombre,
//   required Box box,
// }) {
//   List _value = box.values.toList();
//   for (var item in _value) {
//     if (item.nombre.toString().toLowerCase() == nombre[0].text.toLowerCase() &&
//         item.valor == double.parse(nombre[1].text)) {
//       //retornar un json

//       return {"valor": true, "codigo": item.codigo};
//     }
//   }
//   return null;
// }

// // editarMarca(Marca marca, TextEditingController controlador) {
// //   controlador.text = marca.nombre;
// // }

// Padding elevatedButtonGuardar({
//   required BuildContext context,
//   required Box box,
//   required Box boxEmpresa,
//   required Box boxBitacora,
//   required TextEditingController controlador,
//   required List<FocusNode> focusNode,
//   required int id,
//   required Function idEdicion,
//   required formKey,
//   required String coleccion,
// }) {
//   String _operacion = "INSERT";
//   String _sincronizado = "";
//   onPressed2() {
//     if (formKey.currentState!.validate()) {
//       var comprovar = validarNombresCreados(box: box, nombre: controlador.text);
//       late int codigo1;
//       Marca marcaOriginal = (id != 0)
//           ? box.get(id)
//           : Marca(
//               codigo: 0,
//               nombre: '',
//               sincronizado: "",
//             );
//       // Colocar el codigo de la marca si se esta editando
//       codigo1 = (id == 0) ? nuevoCodigo(box) : id;
//       _operacion = (id == 0) ? "INSERT" : "UPDATE";

//       _sincronizado = (id != 0) ? box.get(id).sincronizado : '';

//       //cambiar el codigo a guardar si es encontrado en la base de datos
//       if (comprovar != null) {
//         codigo1 = comprovar['codigo'];
//         _operacion = "UPDATE";
//         _sincronizado = box.get(codigo1).sincronizado;
//         // idEdicion(comprobar['codigo']);
//       }
//       if (comprovar != null) {
//         marcaOriginal = box.get(codigo1);
//       }

//       if (controlador.text ==
//           ((comprovar != null) ? box.get(codigo1).nombre : '')) {
//         print('no se modifico');
//       } else {
//         Marca marcaGuardar = Marca(
//           codigo: codigo1,
//           nombre: controlador.text,
//           sincronizado: _sincronizado,
//         );
//         box.put(codigo1, marcaGuardar).toString();
//         Empresa empresa = boxEmpresa.get('empresa');
//         int _numeroBitacora = empresa.numeroBitacoraLocal;
//         Marca marcaGuardarBitacora = Marca(
//           codigo: codigo1,
//           nombre: controlador.text,
//           sincronizado: "",
//         );
//         var datosmarca = marcaGuardarBitacora.toMap();

//         print(datosmarca);

//         Bitacora bitacora = Bitacora(
//             id: _numeroBitacora,
//             operacion: _operacion,
//             coleccion: coleccion,
//             idObjetoCambio: codigo1.toString(),
//             //combertir un objeto a map para poder enviarlo
//             datosOriginales:
//                 (_operacion == "UPDATE") ? (marcaOriginal).toMap() : null,
//             datosNuevos: datosmarca,
//             usuario: "",
//             fecha: DateTime.now().toString(),
//             sincronizado: false);

//         boxBitacora.put(_numeroBitacora, bitacora);
//         incrementarNumeroBitacoraLocal(boxEmpresa: boxEmpresa);

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: (id == 0)
//                 ? Text('Marca guardada $codigo1 ')
//                 : Text('Marca editada $codigo1'),
//           ),
//         );
//       }
//       //linpiar el formulario
//       controlador.clear();

//       //retornar el foco al primer campo
//       focusNode[0].requestFocus();
//       idEdicion(0);
//       cargarCambios();
//     }
//   }

//   return elevatedButtonGuardar1(
//     context: context,
//     onPressed: onPressed2,
//     focusNode: focusNode[1],
//   );
//   //  Padding(
//   //   padding: const EdgeInsets.all(8.0),
//   //   child: FloatingActionButton.extended(
//   //     focusNode: focusNode[1],
//   //     onPressed: onPressed2,
//   //     label: const Text('Guardar',
//   //         style: TextStyle(
//   //           color: Colors.white,
//   //           fontSize: 20,
//   //           fontFamily: 'Roboto',
//   //           fontWeight: FontWeight.bold,
//   //         )),
//   //   ),
//   // );
// }

// Padding elevatedButtonGuardarImpuesto({
//   required BuildContext context,
//   required Box box,
//   required List<TextEditingController> controlador,
//   required List<FocusNode> focusNode,
//   required int id,
//   required Function idEdicion,
//   required formKey,
// }) {
//   onPressed2() {
//     String _operacion = "INSERT";
//     String _sincronizado = "";
//     if (formKey.currentState!.validate()) {
//       var comprobar = estaCreadoImpuesto(box: box, nombre: controlador);
//       late int codigo1;
//       Impuesto impuestoOriginal = (id != 0)
//           ? box.get(id)
//           : Impuesto(
//               codigo: 0,
//               nombre: '',
//               valor: 0,
//               sincronizado: "",
//             );

//       // Colocar el codigo del impuesto si se esta editando
//       codigo1 = (id == 0) ? nuevoCodigo(box) : id;
//       _operacion = (id == 0) ? "INSERT" : "UPDATE";
//       _sincronizado = (id != 0) ? box.get(id).sincronizado : '';

//       // controlador[0].text == box.get(codigo1).nombre &&
//       //     double.parse(controlador[1].text) == box.get(codigo1).valor

//       //cambiar el codigo a guardar si es encontrado en la base de datos
//       if (comprobar != null) {
//         codigo1 = comprobar['codigo'];
//         _operacion = "UPDATE";
//         _sincronizado = box.get(codigo1).sincronizado;
//       }

//       Impuesto guardar = Impuesto(
//         codigo: codigo1,
//         nombre: controlador[0].text,
//         valor: double.parse(controlador[1].text),
//         sincronizado: _sincronizado,
//       );
//       box.put(codigo1, guardar).toString();

//       Empresa empresa = boxEmpresa.get('empresa');
//       int _numeroBitacora = empresa.numeroBitacoraLocal;

//       Impuesto impuestoGuardarBitacora = Impuesto(
//         codigo: codigo1,
//         nombre: controlador[0].text,
//         valor: double.parse(controlador[1].text),
//         sincronizado: "",
//       );
//       var datosimpuesto = impuestoGuardarBitacora.toMap();
//       Bitacora bitacora = Bitacora(
//           id: _numeroBitacora,
//           operacion: _operacion,
//           coleccion: 'impuestos',
//           idObjetoCambio: codigo1.toString(),
//           //combertir un objeto a map para poder enviarlo
//           datosOriginales: (_operacion == "UPDATE")
//               ? (impuestoOriginal).toMap()
//               : impuestoOriginal,
//           datosNuevos: datosimpuesto,
//           usuario: "",
//           fecha: DateTime.now().toString(),
//           sincronizado: false);

//       boxBitacora.put(_numeroBitacora, bitacora);
//       incrementarNumeroBitacoraLocal(boxEmpresa: boxEmpresa);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: (id == 0)
//               ? Text('Impueato Guardado  $codigo1 ')
//               : Text('Impuesto Editado $codigo1'),
//         ),
//       );

//       //linpiar el formulario
//       for (var item in controlador) {
//         item.clear();
//       }
//       //retornar el foco al primer campo
//       focusNode[0].requestFocus();
//       idEdicion(0);
//       cargarCambios();
//     }
//   }

//   return elevatedButtonGuardar1(
//     context: context,
//     onPressed: onPressed2,
//     focusNode: focusNode[2],
//   );
// }

Future<dynamic> confirmacionEliminar({
  required BuildContext context,
  required String valor,
  required String texto,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: 350,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                textos('¿Esta seguro?'),
                const SizedBox(
                  height: 10,
                ),
                textos(texto),
                textos(valor),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton.extended(
                      label: const Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    FloatingActionButton.extended(
                      label: const Text('Aceptar'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Text textos(String texto) {
  return Text(
    texto,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

// comprobarEmpresa(Box boxEmpresa) {
//   //comprobar y crear empresa
//   if (boxEmpresa.get('empresa') == null) {
//     guardarDatosEmpresa(boxEmpresa: boxEmpresa, datos: datosBasicosEmpresa());
//     print('empresa creada con datos basicos');
//   } else {
//     print('empresa ya existe');
//   }
// }

// datosBasicosEmpresa() {
//   return {
//     'nit': '00',
//     'nombre': 'Su Empresa',
//     'direccion': 'Su Direccion',
//     'ciudad': 'Su Ciudad',
//     'telefono': 'Su Telefono',
//     'email': 'Su Email',
//     'eslogan': 'Su Eslogan',
//     'propietario': 'Su Propietario',
//     'mensaje': 'Su Mensaje en factura',
//     'numeroSalidas1': 0,
//     'numeroSalidas2': 0,
//     'numeroSalidas3': 0,
//     'nombreDocumento1': 'Factura',
//     'nombreDocumento2': 'Remision',
//     'nombreDocumento3': 'Recibo',
//     'numeroEntradas': 0,
//     'notaCredito': 0,
//     'notaDebito': 0,
//     'numeroBitacora': 0,
//     'numeroBitacoraLocal': 0,
//   };
// }

// guardarBitacoraEliminacion({
//   required Box box,
//   required int id,
//   required String coleccion,
// }) {
//   //guardar bitacora de eliminacion
//   Bitacora bitacora = Bitacora(
//       id: boxEmpresa.get('empresa').numeroBitacoraLocal,
//       operacion: "DELETE",
//       coleccion: coleccion,
//       idObjetoCambio: id.toString(),
//       datosOriginales: box.get(id).toMap(),
//       datosNuevos: box.get(id).toMap(),
//       usuario: "",
//       fecha: DateTime.now().toString(),
//       sincronizado: false);
//   boxBitacora.put(bitacora.id, bitacora).toString();
//   box.delete(id);
//   cargarCambios();
// }

// anchoPantalla(context) {
//   double ancho = MediaQuery.of(context).size.width;
//   double alto = MediaQuery.of(context).size.height;
//   AnchoDePantalla anchoDePantalla = AnchoDePantalla(
//     context: context,
//     ancho: ancho,
//     alto: alto,
//     altoteclado: MediaQuery.of(context).viewInsets.bottom,
//     anchoLista: (ancho <= 500)
//         ? ancho - 100
//         : (ancho > 500 && ancho < 800)
//             ? 450
//             : (ancho > 800 && ancho < 1200)
//                 ? 600
//                 : 750,
//   );
//   return anchoDePantalla;
// }

Padding elevatedButtonGuardar1({
  required BuildContext context,
  required onPressed,
  required FocusNode focusNode,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FloatingActionButton.extended(
      focusNode: focusNode,
      onPressed: onPressed,
      label: const Text(
        'Guardar',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: const Icon(
        Icons.save,
        color: Colors.white,
      ),
    ),
  );
}

class InformeFlotanteInferior extends StatelessWidget {
  const InformeFlotanteInferior({
    Key? key,
    required this.titleText,
    required this.messageText,
  }) : super(key: key);
  final String titleText;
  final String messageText;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content:
            informarInferior(titleText: titleText, messageText: messageText));
  }
}

informarInferior({required String titleText, required String messageText}) {
  Get.snackbar(
    '',
    '',
    titleText: Text(
      titleText,
      style: const TextStyle(color: Colors.black, fontSize: 20),
    ),
    messageText: Text(
      messageText,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    icon: const Icon(Icons.error),
    backgroundColor: const Color.fromARGB(255, 185, 243, 253),
    colorText: Colors.black,
    borderRadius: 20,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(100),
    duration: const Duration(seconds: 2),
    borderColor: Colors.black,
    borderWidth: 1,
    forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
    boxShadows: [
      BoxShadow(
        blurRadius: 20,
        // spreadRadius: 5.0,
        offset: const Offset(0, 48),
        color: Colors.black.withOpacity(0.2),
      ),
    ],
  );
}

// nuevoCodigosMap(EstadoIdentificador estadoIdentificador) {
//   int codigo = 1;
//   bool codigoasignado = false;
//   //List codigos = box.keys.toList();
//   List codigos = estadoIdentificador.datosIdentificador.keys.toList();
//   print(codigos);
//   if (codigos.isNotEmpty) {
//     for (int i = 1; i <= codigos.length; i++) {
//       //  print('${codigos[i - 1] is String}');
//       if (!codigos.contains(i)) {
//         codigo = i;
//         codigoasignado = true;
//         break;
//       }
//       if (codigoasignado == false) {
//         codigo = codigos.length + 1;
//       }
//     }
//   } else {
//     codigo = 1;
//   }
//   return codigo;
// }

// bool losDatosCambiaron({required Map objetoAGuardarMap, required Box box}) {
//   EstadoProducto estadoProducto = Get.find<EstadoProducto>();
//   estadoProducto.datosNuevosBitacora.clear();

//   bool _permitirGuardarBitacora = true;

//   if (box.containsKey(estadoProducto.controladores[0].text)) {
//     _permitirGuardarBitacora = false;
//     Map datosGuardados = box.get(estadoProducto.controladores[0].text).toMap();
//     datosGuardados.map((key, value) {
//       if (objetoAGuardarMap[key] != value) {
//         _permitirGuardarBitacora = true;
//         print("""Key: $key
//               Guardado: $value
//               Aguardar: ${objetoAGuardarMap[key]}""");
//         estadoProducto.datosNuevosBitacora.addAll({key: value});
//       }
//       return MapEntry(
//         key,
//         value,
//       );
//     });
//   } else {
//     estadoProducto.datosNuevosBitacora.addAll(objetoAGuardarMap);
//   }
//   return _permitirGuardarBitacora;
// }
