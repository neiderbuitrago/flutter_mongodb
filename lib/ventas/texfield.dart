import 'package:flutter/material.dart';

class TextFieldBusqueda extends StatelessWidget {
  final TextEditingController controlador;
  final void Function(String) onChanged, onSubmitted;
  final void Function()? onTap;
  final String? labelText;

  const TextFieldBusqueda({
    Key? key,
    required this.controlador,
    required this.onChanged,
    required this.onSubmitted,
    required this.onTap,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 100,
      child: TextField(
        controller: controlador,
        //autofocus: true,
        keyboardType: TextInputType.text,
        onChanged: onChanged,

        autocorrect: true,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.orangeAccent,
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.blueAccent,
              width: 2,
            ),
          ),
          suffix: GestureDetector(
            child: Icon(
              Icons.search_sharp,
              color:
                  (labelText != "Buscar Cliente") ? Colors.grey : Colors.white,
              size: 30,
            ),
            onTap: onTap,
          ),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
