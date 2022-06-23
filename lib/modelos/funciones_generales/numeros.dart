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
