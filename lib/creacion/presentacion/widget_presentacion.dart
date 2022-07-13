// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/estado_getx/presentacion_getx.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../db/presentacion.dart';
import '../../funciones_generales/strings.dart';
import '../../modelos/presentacion.dart';
import '../widget.dart';

textfieldPresentacion({
  required BuildContext context,
  required Function redibujarLista,
  required String labelText,
  required int index,
  required List<FocusNode> focusNode,
}) {
  EstadoPresentacion estado = Get.put(EstadoPresentacion());
  FocusScope.of(context).requestFocus(focusNode[0]);

  campoEnMayusculas(controller: estado.controlador[0]);
  campoEnMayusculas(controller: estado.controlador[1]);

  return TextField(
    focusNode: focusNode[index],
    onEditingComplete: () {
      FocusScope.of(context).requestFocus(focusNode[index + 1]);
    },
    controller: estado.controlador[index],
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
          estado.limpiarCampos();
        },
      ),
    ),
    onChanged: (value) {
      if (index == 0) {
        redibujarLista();
      }
    },
    onTap: () => redibujarLista(),
  );
}

//
//
Padding elevatedButtonGuardar({
  required BuildContext context,
  required Function redibujarLista,
}) {
  EstadoPresentacion estado = Get.find<EstadoPresentacion>();

  onPressed() async {
    bool nuevoEditar = estado.nuevoEditar.value;

    //

    Presentacion presentacion = Presentacion(
      id: (nuevoEditar) ? ObjectId() : estado.presentacion.id,
      nombre: estado.controlador[0].text.trim().toUpperCase(),
      fecha: DateTime.now(),
      sincronizado: "",
      simbolo: estado.controlador[1].text.trim().toUpperCase(),
      visible: estado.check.value,
    );
    if (nuevoEditar) {
      await PresentacionDB.insertar(presentacion)
          .then((value) => redibujarLista);
    } else {
      await PresentacionDB.actualizar(presentacion)
          .then((value) => redibujarLista);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: (nuevoEditar)
            ? Text("Presentación guardado  ${presentacion.nombre} ")
            : Text("Presentación editado  ${presentacion.nombre} "),
      ),
    );

    //linpiar el formulario

    estado.limpiarCampos();
    redibujarLista();
  }

  return elevatedButtonGuardar1(
    context: context,
    onPressed: onPressed,
    focusNode: estado.focusNode[3],
  );
}
