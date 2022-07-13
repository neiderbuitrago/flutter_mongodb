double numeroDecimal(String valor) {
  //esta funcion controla que no se inserte multiples puntos decimales
  String value = (valor.isEmpty) ? "0" : valor;
  double numero = 0.0;
  if (value.contains('.')) {
    List a = value.split('.');
    value = (a[0].toString().isEmpty) ? "0" : a[0] + "." + a[1];
    numero = double.parse(value);
  } else {
    numero = double.parse(value);
  }
  return numero;
}

String quitarDecimales(double numero) {
  double decimal = numero - numero.truncate();
  return (decimal == 0) ? numero.truncate().toString() : numero.toString();
}

String enBlancoSiEsCero(double valor) {
  double decimal = valor - valor.truncate();
  var resultado = (decimal == 0) ? valor.truncate() : valor;
  return (valor == 0) ? "" : resultado.toString();
}

puntosDeMil(String value) {
  String result = value.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.');
  return result.toString();
}
