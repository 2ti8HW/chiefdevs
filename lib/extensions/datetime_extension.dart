import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String fullFormat() {
    final m = DateFormat('MMM').format(this);
    final d = DateFormat('d').format(this);
    final y = DateFormat('yyyy').format(this);
    final e = DateFormat('EEEE').format(this);
    return '$m ${d}th, $y, $e';
  }

  String format(String pattern) {
    return DateFormat(pattern).format(this);
  }
}
