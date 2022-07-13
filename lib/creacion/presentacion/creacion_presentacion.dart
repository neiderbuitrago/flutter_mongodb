//ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../estado_getx/presentacion_getx.dart';
import '../../funciones_generales/response.dart';
import 'lista_presentacion.dart';
import 'widget_presentacion.dart';

class CreacionPresentacion extends StatefulWidget {
  const CreacionPresentacion({Key? key}) : super(key: key);

  @override
  _CreacionPresentacionState createState() => _CreacionPresentacionState();
}

class _CreacionPresentacionState extends State<CreacionPresentacion> {
  final EstadoPresentacion estado = Get.put(EstadoPresentacion());

  final formKey = GlobalKey<FormState>();

  Padding guardar(BuildContext context) {
    return elevatedButtonGuardar(
      redibujarLista: redibujarLista,
      context: context,
    );
  }

  ListaPresentacion lista() {
    return ListaPresentacion(
      controlador: estado.controlador,
      texto: 'la Presentación',
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
    AnchoDePantalla medidas = anchoPantalla(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Presentación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: medidas.ancho * 0.5,
                    child: textfieldPresentacion(
                      context: context,
                      redibujarLista: redibujarLista,
                      labelText: "Presentación",
                      index: 0,
                      focusNode: estado.focusNode,
                    ),
                  ),
                  SizedBox(
                      width: medidas.ancho * 0.3,
                      child: textfieldPresentacion(
                        context: context,
                        redibujarLista: redibujarLista,
                        labelText: "Siglas",
                        index: 1,
                        focusNode: estado.focusNode,
                      )),
                  Column(
                    children: [
                      Obx(
                        () => Checkbox(
                          focusNode: estado.focusNode[2],
                          value: estado.check.value,
                          onChanged: (bool? value) {
                            estado.check.value = (value == true);
                            FocusScope.of(context)
                                .requestFocus(estado.focusNode[3]);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const Text(
                        'Visible',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              guardar(context),
              lista(),
            ],
          ),
        ),
      ),
    );
  }
}
