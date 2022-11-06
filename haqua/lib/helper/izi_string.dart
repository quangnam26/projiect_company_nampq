import 'package:html_unescape/html_unescape.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:tiengviet/tiengviet.dart';

///
/// handler string
///
class IZIString {
  static String cut(String text, {int length = 50}) {
    String content = text;
    if (text.length > length) {
      content = '${text.substring(0, length)}...';
      return content;
    }
    return content;
  }

  ///
  /// Dinh dang ten file da upload
  ///
  static String getFileNameFromUrl(String text) {
    if (text.isNotEmpty && text.toString() != 'null') {
      final arrayNameSplit = text.toString().split('/');
      return arrayNameSplit[arrayNameSplit.length - 1];
    }
    return '';
  }

  ///
  /// covert vietnames to Vietnamese tones
  ///
  static String toAscii(String str) {
    final _str = TiengViet.parse(str.toLowerCase()).toLowerCase();
    return _str;
  }

  ///
  /// Get the value price from string
  ///
  static String getNumberString(dynamic value) {
    if (value == null || value.toString().isEmpty || value.toString() == 'null' || (value is List && value.isEmpty == true)) return '0';
    final String result = value.toString().replaceAll('.', '').replaceAll(',', '').replaceAll('null', '');
    if (result == '') return '0';
    return result;
  }

  ///
  ///  A Dart library for unescaping HTML-encoded strings.
  ///
  String htmlUnescape(String htmlString) {
    if (!IZIValidate.nullOrEmpty(htmlString)) {
      final unescape = HtmlUnescape();
      return unescape.convert(htmlString);
    }
    return '';
  }
}
