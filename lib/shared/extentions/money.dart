import 'package:intl/intl.dart';

extension Money on int {
  formatRupiah() {
    return NumberFormat.currency(
      locale: 'id',
      name: 'Rp. ',
      decimalDigits: 0,
    ).format(this);
  }
}
