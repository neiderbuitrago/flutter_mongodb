// ignore_for_file: file_names

import 'package:flutter/material.dart';

campoEnMayusculas({required TextEditingController controller}) {
  controller.addListener(() {
    final String text = controller.text.toUpperCase();
    controller.value = controller.value.copyWith(text: text);
  });
}

Divider lineaDivisora() {
  return const Divider(
    height: 1,
    color: Colors.black54,
  );
}

//consultar si un string esta en la lista de strings
bool existe(String elemento, List lista) {
  for (String value in lista) {
    if (value == elemento) return true;
    break;
  }
  return false;
}
