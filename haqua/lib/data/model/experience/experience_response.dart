import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class ExperienceResponse {
  String? fieldName;
  int? year;
  ExperienceResponse({
    this.fieldName,
    this.year,
  });

  ///
  /// From JSON
  ///
  ExperienceResponse.fromJson(Map<String, dynamic> json) {
    fieldName = !IZIValidate.nullOrEmpty(json['fieldName']) ? json['fieldName'].toString() : null;
    year = !IZIValidate.nullOrEmpty(json['year']) ? IZINumber.parseInt(json['year'].toString()) : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(fieldName)) data['fieldName'] = fieldName;
    if (!IZIValidate.nullOrEmpty(year)) data['year'] = year;
    return data;
  }

  @override
  String toString() => 'ExperienceResponse( fieldName: $fieldName, year: $year)';
}
