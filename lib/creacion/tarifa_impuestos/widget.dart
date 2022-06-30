// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mongodb/estado_getx/getx_tarifa_impuesto.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../db/tarifa_impuestos_mongo.dart';
import '../../funciones_generales/numeros.dart';
import '../../modelos/tarifa_impuestos.dart';
import '../widget.dart';

class TextFormFieldTarifa extends StatelessWidget {
  @override
  const TextFormFieldTarifa({
    Key? key,
    required this.labelText,
    required this.index,
  }) : super(key: key);

  final String labelText;
  final int index;
  @override
  Widget build(BuildContext context) {
    EstadoTarImpuestos estadoTarImpuestos = Get.find<EstadoTarImpuestos>();

    estadoTarImpuestos.controlador[0].addListener(() {
      estadoTarImpuestos.controlador[0].value =
          estadoTarImpuestos.controlador[0].value.copyWith(
              text: estadoTarImpuestos.controlador[0].value.text.toUpperCase());
    });

    return TextField(
      focusNode: estadoTarImpuestos.focusNode[index],
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      // textCapitalization: TextCapitalization.characters,
      onEditingComplete: () {
        estadoTarImpuestos.focusNode[index + 1].requestFocus();
      },
      inputFormatters: (index == 1)
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9-.]'))]
          : [],
      controller: estadoTarImpuestos.controlador[index],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          gapPadding: 5,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
        // cancelar el texto
        suffixIcon: IconButton(
          padding: const EdgeInsets.only(right: 10),
          icon: const Icon(Icons.clear),
          onPressed: () {
            estadoTarImpuestos.limpiarCampos();
          },
        ),
      ),
    );
  }
}

Padding elevatedButtonGuardar({
  required BuildContext context,
}) {
  EstadoTarImpuestos estadoTarImpuestos = Get.find<EstadoTarImpuestos>();
  onPressed() async {
    estadoTarImpuestos.nuevoEditar.value;

    //
    bool nuevoEditar = estadoTarImpuestos.nuevoEditar.value;
    Impuesto impuesto = Impuesto(
      id: (nuevoEditar) ? ObjectId() : estadoTarImpuestos.impuesto.id,
      nombre: estadoTarImpuestos.controlador[0].text.trim().toUpperCase(),
      valor: numeroDecimal(estadoTarImpuestos.controlador[1].text.trim()),
      sincronizado: "",
    );
    if (nuevoEditar) {
      TarifaImpuestosDB.insertar(impuesto)
          .then((value) => estadoTarImpuestos.getFilterList(""));
    } else {
      await TarifaImpuestosDB.actualizar(impuesto)
          .then((value) => estadoTarImpuestos.getFilterList(""));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: (nuevoEditar)
            ? Text('  Grupo guardado ${impuesto.nombre} ')
            : Text('  Grupo actualizado ${impuesto.nombre} '),
      ),
    );

    //linpiar el formulario
    estadoTarImpuestos.limpiarCampos();
  }

  return elevatedButtonGuardar1(
    context: context,
    onPressed: onPressed,
    focusNode: estadoTarImpuestos.focusNode[2],
  );
}

class ListaImpuestos extends StatelessWidget {
  const ListaImpuestos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EstadoTarImpuestos estadoTarImpuestos = Get.find<EstadoTarImpuestos>();

    return Expanded(
      child: SizedBox(
        height: 800,
        child: Obx(
          () => ListView.builder(
            itemCount: estadoTarImpuestos.listaImpuestos.length,
            itemBuilder: (context, index) {
              Impuesto valor =
                  Impuesto.fromMap(estadoTarImpuestos.listaImpuestos[index]);
              //
              Text text(String texto) => Text(
                    texto,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    strutStyle: const StrutStyle(
                      forceStrutHeight: true,
                    ),
                  );

              Future alertaAnulacion() async {
                await confirmacionEliminar(
                        context: context,
                        valor: valor.nombre,
                        texto: '¿Esta seguro de eliminar?')
                    .then(
                  (value) {
                    if (value ?? false) {
                      TarifaImpuestosDB.eliminar(valor).then((value) {
                        estadoTarImpuestos.limpiarCampos();
                        estadoTarImpuestos.getFilterList("");
                      });
                    }
                  },
                );
              }

              return ListTile(
                  hoverColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: Colors.blue.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        child: text(valor.nombre.toString()),
                      ),
                      text(valor.valor.toString()),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      alertaAnulacion();
                    },
                    icon: Icon(Icons.delete_outline_rounded,
                        color: Colors.primaries.elementAt(index).withAlpha(180),
                        size: 30),
                  ),
                  onTap: () {
                    estadoTarImpuestos.controlador[0].text = valor.nombre;
                    estadoTarImpuestos.controlador[1].text =
                        valor.valor.toString();
                    estadoTarImpuestos.nuevoEditar.value = false;
                    estadoTarImpuestos.impuesto = valor;
                  });
            },
          ),
        ),
      ),
    );
  }
}
