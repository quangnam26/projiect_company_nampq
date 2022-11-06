import 'package:intl/intl.dart';
import 'package:template/helper/izi_validate.dart';
///
/// Format datetime
///
mixin IZIDate {
  static String formatDate(DateTime dateTime, {String format = "dd-MM-yyyy"}) {
    /// yyyy-MM-dd hh:mm:ss
    /// HH:mm dd-MM-yyyy
    /// dd MMM yyyy
    /// dd-MM-yyyy
    /// dd/MM/yyyy
    /// hh:mm
    /// yyyy-MM-dd
    return DateFormat(format).format(dateTime);
  }

  static DateTime parse(String dateTime) {
    if(!IZIValidate.nullOrEmpty(dateTime)){
      return DateTime.parse(dateTime);
    }
    return DateTime(1970);
  }


  static int differenceDate({required DateTime startDate, required DateTime endDate}) {
    return endDate.difference(startDate).inDays;
  }

  static int toTimeStamp(DateTime dateTime) {
    return int.parse(dateTime.millisecondsSinceEpoch.toStringAsFixed(0));
  }

}
