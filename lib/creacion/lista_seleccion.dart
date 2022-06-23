import 'package:flutter/material.dart';

class ListaMarcaGrupoImpuesto extends StatelessWidget {
  const ListaMarcaGrupoImpuesto({
    Key? key,
    required this.marcasFiltradas,
    this.esProducto = false,
  }) : super(key: key);

  final List marcasFiltradas;
  final bool? esProducto;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          // shrinkWrap: true,
          itemCount: marcasFiltradas.length,
          itemBuilder: (context, index) {
            final marca = marcasFiltradas[index];
            return ListTile(
              hoverColor: Colors.white,
              focusColor: Colors.white,
              selectedTileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              title: (esProducto ?? false)
                  ? Text(
                      marca.nombre,
                      // ' -' +
                      // boxMarcas.getAt(marca.marcas).nombre,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      marca.nombre,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              subtitle: (esProducto ?? false)
                  ? Text(
                      marca.codigo +
                          '    Existe: ' +
                          marca.cantidad.toString() +
                          '    Marca: ',
                      //  boxMarcas.get(marca.marcas).nombre,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45,
                      ),
                    )
                  : null,
              trailing: (esProducto ?? false)
                  ? Text('\$' '${marca.precioVenta1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ))
                  : null,
              onTap: () {
                print('marca seleccionada: ${marca.codigo}');
                Navigator.of(context).pop(marca.codigo.toString());
              },
            );
          },
        ),
      ),
    );
  }
}
