// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mongodb/db/combo.dart';

import 'package:flutter_mongodb/db/empresa_mongo.dart';
import 'package:flutter_mongodb/db/identificadores.dart';
import 'package:flutter_mongodb/db/multicodigo.dart';
import 'package:flutter_mongodb/estado_getx/getx_marcas.dart';
import 'package:flutter_mongodb/estado_getx/getx_productos.dart';

import 'package:get/get.dart';

import 'creacion/grupos/creacion_grupos.dart';
import 'creacion/marcas/creacion_marca.dart';
import 'creacion/productos/creacion_productos.dart';
import 'creacion/tarifa_impuestos/creacion_impuesto.dart';
import 'db/fracciones.dart';
import 'db/grupos_mongo.dart';
import 'db/marcas_mongo.dart';
import 'db/productos_mongo.dart';
import 'db/tarifa_impuestos_mongo.dart';
import 'estado_getx/combos_getx.dart';
import 'estado_getx/fracciones_getx.dart';
import 'estado_getx/getx_grupos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MarcaDB.conectar();
  await EmpresaDB.conectar();
  await GruposDB.conectar();
  await TarifaImpuestosDB.conectar();
  await ProductosDB.conectar();
  await MulticodigoDB.conectar();
  await ComboDB.conectar();
  await IdentificadorDB.conectar();
  await FraccionesDB.conectar();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final EstadoGrupos estadoGrupos = Get.put(EstadoGrupos());
  final EstadoMarcas estadoMarcas = Get.put(EstadoMarcas());
  final EstadoProducto estadoProductos = Get.put(EstadoProducto());
  final EstadoCombos estadoCombos = Get.put(EstadoCombos());
  final EstadoVentaFraccionada estadoVentaFraccionada =
      Get.put(EstadoVentaFraccionada());

  int _selectedIndex = 0;
  @override
  void initState() {
    EmpresaDB.comprobarEmpresa();
    super.initState();
  }

  @override
  void dispose() async {
    estadoGrupos.dispose();
    estadoMarcas.dispose();
    estadoProductos.dispose();
    estadoCombos.dispose();
    estadoVentaFraccionada.dispose();

    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    const CreacionProductos(),
    const CreacionMarca(),
    const CreacionGrupo(),
    const CreacionImpuestos(),
  ];

  @override
  Widget build(BuildContext context) {
    //  MaterialApp materialApp = MaterialApp(
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColorLight,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.widgets),
              label: 'Productos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Marcas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schema_outlined),
              label: 'Grupos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_outlined),
              label: 'Impuestos',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
    //return materialApp;
  }
}
