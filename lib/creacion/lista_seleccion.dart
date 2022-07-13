import 'package:flutter/material.dart';
import 'package:flutter_mongodb/estado_getx/productos_getx.dart';
import 'package:flutter_mongodb/modelos/productos.dart';
import 'package:get/get.dart';

import '../funciones_generales/numeros.dart';

listaMarcaGrupoImpuesto(bool esProducto) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  // MarcaDB.getParametro("");

  return Expanded(
    child: SizedBox(
      child: Obx(
        () => ListView.builder(
          itemCount: estadoProducto.marcasFiltradas.length,
          itemBuilder: (context, index) {
            final marca = estadoProducto.marcasFiltradas[index];
            return ListTile(
              hoverColor: Colors.white,
              focusColor: Colors.white,
              selectedTileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              title: (esProducto)
                  ? Text(
                      marca["nombre"],
                      // ' -' +
                      // boxMarcas.getAt(marca.marca)s).nombre,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      marca["nombre"],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              subtitle: (esProducto)
                  ? Text(
                      marca["codigo"] +
                          '    Existe: ' +
                          quitarDecimales(marca["cantidad"]).toString() +
                          '    Marca: ${marca["nombreMarca"]} ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    )
                  : null,
              trailing: (esProducto)

                  //colocar los puntos de miles y decimales

                  ? Text(
                      '\$'
                      '${puntosDeMil(quitarDecimales(marca["precioVenta1"]).toString())}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ))
                  : null,
              onTap: () {
                (esProducto)
                    ? Navigator.of(context).pop(Productos.fromMap(marca))
                    : Navigator.of(context).pop(marca);
              },
            );
          },
        ),
      ),
    ),
  );
}
