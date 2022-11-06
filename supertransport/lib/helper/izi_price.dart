import 'package:intl/intl.dart';

///
/// Convert currency
///
mixin IZIPrice{
  static String currencyConverterVND(double value, {String? locale = 'vi-VN'}) {
    return NumberFormat.currency(name: "", decimalDigits: 0, locale: locale).format(value).replaceAll(',', '.');
  }
}


