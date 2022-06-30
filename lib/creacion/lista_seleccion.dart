import 'package:flutter/material.dart';
import 'package:flutter_mongodb/estado_getx/getx_productos.dart';
import 'package:get/get.dart';

listaMarcaGrupoImpuesto(bool esProducto) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  return Expanded(
    child: SizedBox(
      child: Obx(
        () => ListView.builder(
          // shrinkWrap: true,
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
                          marca["cantidad"].toString() +
                          '    Marca: ',
                      //  boxMarcas.get(marca.marcas).nombre,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45,
                      ),
                    )
                  : null,
              trailing: (esProducto)
                  ? Text('\$' '${marca.precioVenta1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ))
                  : null,
              onTap: () {
                Navigator.of(context).pop(marca);
              },
            );
          },
        ),
      ),
    ),
  );
}
