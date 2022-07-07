// ignore_for_file: file_names

import 'package:flutter/material.dart';

campoEnMayusculas({required TextEditingController controller}) {
  controller.addListener(() {
    final String text = controller.text.toUpperCase();
    controller.value = controller.value.copyWith(text: text);
  });
}
