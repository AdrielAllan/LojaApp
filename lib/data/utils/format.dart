String formatDateTime(String dateTimeString) {
  // Converte a string para DateTime
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Extrai as partes da data e hora
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');

  // Formata a data e hora no formato desejado
  return "$day/$month/$year $hour:$minute";
}
