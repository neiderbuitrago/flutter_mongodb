import 'package:flutter/material.dart';

import '../../estado_getx/identificadores.dart';
import '../../funciones_generales/response.dart';
import '../widget.dart';

class ListaIdentificador extends StatelessWidget {
  const ListaIdentificador({
    Key? key,
    required this.estadoIdentificador,
    required this.medidas,
  }) : super(key: key);

  final EstadoIdentificador estadoIdentificador;
  final AnchoDePantalla medidas;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ((estadoIdentificador.datosIdentificador.length * 65).toDouble() <
              medidas.alto * 0.9 -
                  253 -
                  MediaQuery.of(context).viewInsets.bottom)
          ? (estadoIdentificador.datosIdentificador.length * 67).toDouble()
          : medidas.alto * 0.9 - 253 - MediaQuery.of(context).viewInsets.bottom,
      width: medidas.anchoLista - 1,
      child: ListView(
        reverse: true,
        // shrinkWrap: true,
        children: estadoIdentificador.datosIdentificador.values
            .map(
              (identificador) => ListTile(
                // index del identificador

                title: Text(
                  identificador.identificador,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                subtitle: Text(identificador.nombre),
                trailing: Text(
                  identificador.cantidad.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
                onTap: () {
                  estadoIdentificador.editarIdentificador(identificador);
                  print(' codigo ${identificador.id}');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.primaries[estadoIdentificador
                        .datosIdentificador.values
                        .toList()
                        .indexOf(identificador)],
                    width: 1,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
