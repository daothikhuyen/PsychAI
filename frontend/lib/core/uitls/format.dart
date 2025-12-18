String formatDateTypeOne(DateTime date) {
  final year = date.year.toString();
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');

  return '$day-$month\n$year';
}

String formatDateTypeTwo(DateTime date) {
  final year = date.year.toString();
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');

  return '$day-$month-$year';
}

String capitalize(String s){
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1);
}
