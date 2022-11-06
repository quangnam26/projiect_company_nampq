//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:template/helper/izi_validate.dart';

mixin IZIDate {
  static String parseDate(int time) {
    final parsed = DateTime.fromMillisecondsSinceEpoch(time, isUtc: true);

    print(time);

    print(parsed.toString());

    final formatted = DateFormat.yMd().add_jm().format(parsed).toString();

    print(formatted);

    return formatted;
  }

//DSSD

  static String bornController1111(int value) {
    final date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    final d12 = DateFormat('MM-dd-yyyy').format(date);
    return d12;
  }

  static String formatDate(DateTime dateTime,
      {String format = "dd-MM-yyyy", String local = "vi"}) {
    /// yyyy-MM-dd hh:mm:ss
    /// HH:mm dd-MM-yyyy
    /// dd MMM yyyy
    /// dd-MM-yyyy
    /// dd/MM/yyyy
    /// hh:mm
    /// yyyy-MM-dd
    return DateFormat(format, local).format(dateTime);
  }

  static String formatDate2(DateTime dateTime,
      {String format = "dd-MM-yyyy", String local = "vi"}) {
    /// yyyy-MM-dd hh:mm:ss
    /// HH:mm dd-MM-yyyy
    /// dd MMM yyyy
    /// dd-MM-yyyy
    /// dd/MM/yyyy
    /// hh:mm
    /// yyyy-MM-dd
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static DateTime parse(String dateTime) {
    if (!IZIValidate.nullOrEmpty(dateTime)) {
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

  static String dateFormatUtc(String dateTime) {
    final input = DateFormat('yyyy-MM-ddTHH:mm:ss', 'vi').parse(dateTime, true);
    // var dateLocal = input.toLocal();
    return DateFormat('dd/mm/yyyy', 'vi').format(input);
    // return DateFormat().p;
  }

  static String dateFormatDateTime(String dateTime) {
    final input = DateFormat('yyyy-MM-ddTHH:mm:ss', 'vi').parse(dateTime, true);
    // var dateLocal = input.toLocal();
    return DateFormat('dd/mm/yyyy HH:mm:ss ', 'vi').format(input);
    // return DateFormat().p;
  }

  static String formatTime24Hour(BuildContext context, DateTime dateTime) {
    return TimeOfDay.fromDateTime(dateTime).format(context);
  }
  
  static String dateFormatDateTime2(String dateTime) {
    final input = DateFormat('yyyy-MM-ddTHH:mm', 'vi').parse(dateTime, true);
    // var dateLocal = input.toLocal();
    return DateFormat('HH:mm dd/mm/yyyy ', 'vi').format(input);
    // return DateFormat().p;
  }

  static DateTime formatDateTime(String dateTime) {
    if (!IZIValidate.nullOrEmpty(dateTime)) {
      return DateFormat('dd-MM-yyyy').parse(dateTime);
    }
    return DateTime(1970);
  }
}
