import 'package:intl/intl.dart';

class Formatters {
  const Formatters._();

  static String score(double value) => value.toStringAsFixed(2);
  static String date(DateTime value) => DateFormat('dd MMM yyyy').format(value);
}
