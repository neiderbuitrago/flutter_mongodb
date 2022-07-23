// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../estado_getx/grupos_getx.dart';
import '../marcas/lista.dart';
import '../marcas/widget.dart';

class CreacionGrupo extends StatefulWidget {
  const CreacionGrupo({Key? key}) : super(key: key);

  @override
  _CreacionGrupoState createState() => _CreacionGrupoState();
}

class _CreacionGrupoState extends State<CreacionGrupo> {
  final EstadoGrupos estadoGrupos = Get.find<EstadoGrupos>();

  final formKey = GlobalKey<FormState>();

  TextField entradaTexto(Function redibujarLista) {
    return textFormFieldGeneral(
      context: context,
      redibujarLista: redibujarLista,
      labelText: 'Grupo',
      esMarca: false,
      focusNode: estadoGrupos.focusNode,
    );
  }

  Padding guardar(BuildContext context) {
    return elevatedButtonGuardar(
      context: context,
      formKey: formKey,
      redibujarLista: redibujarLista,
      esmarca: false,
      controlador: estadoGrupos.controlador[0],
      focusNode: estadoGrupos.focusNode,
    );
  }

  ListaMarcasGrupos lista() {
    return ListaMarcasGrupos(
      controlador: estadoGrupos.controlador,
      texto: 'el Grupo',
      redibujarLista: redibujarLista,
    );
  }

  redibujarLista() {
    setState(
      () {
        lista();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creacion de Grupos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              entradaTexto(redibujarLista),
              guardar(context),
              lista(),
            ],
          ),
        ),
      ),
    );
  }
}
