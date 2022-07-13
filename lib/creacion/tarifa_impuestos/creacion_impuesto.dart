// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/estado_getx/tarifa_impuesto_getx.dart';
import 'package:get/get.dart';

import 'widget.dart';

class CreacionImpuestos extends StatefulWidget {
  const CreacionImpuestos({Key? key}) : super(key: key);

  @override
  _CreacionImpuestosState createState() => _CreacionImpuestosState();
}

class _CreacionImpuestosState extends State<CreacionImpuestos> {
  final EstadoTarImpuestos estadoImpuestos = Get.put(EstadoTarImpuestos());

  @override
  Widget build(BuildContext context) {
    estadoImpuestos.getFilterList(estadoImpuestos.controlador[0].text);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creacion de Marcas'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.49,
                      child: const TextFormFieldTarifa(
                          labelText: "Impuesto", index: 0)),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.39,
                      child: const TextFormFieldTarifa(
                          labelText: "Tarifa", index: 1)),
                ],
              ),
              elevatedButtonGuardar(
                context: context,
              ),
              const ListaImpuestos()
            ],
          )),
    );
  }
}
