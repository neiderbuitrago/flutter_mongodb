import 'package:flutter/material.dart';

SafeArea estiloPantalla(BuildContext context, List<Widget> listaDewiget,
    Widget inferior, double madidaTeclado, VoidCallback onPressed) {
  return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Center(
          heightFactor: 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120),
                      topLeft: Radius.circular(120),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: listaDewiget),
                  ),
                ),
              ),
              SizedBox(
                  height: madidaTeclado == 0.0 ? 70 : 5,
                  width: double.infinity,
                  child: inferior),
            ],
          ),
        ),
      ),
      // floatingActionButton: BotonFlotante(
      //   onPressed: onPressed,
      // ),
    ),
  );
}

BoxDecoration boxdecorationParaContainer({
  required double borderRadius,
  required Color color1,
  Color? backGround = Colors.white,
  Border? border,
}) {
  return BoxDecoration(
    border: border,
    color: backGround,
    boxShadow: [
      BoxShadow(
        spreadRadius: 2,
        color: color1,
        offset: const Offset(2, 2),
        blurRadius: 5,
        //  spreadRadius: 2
      )
    ],
    borderRadius: BorderRadius.circular(borderRadius),
  );
}
