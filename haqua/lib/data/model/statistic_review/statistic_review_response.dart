import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class StatisticReviewResponse {
  double? totalReputation;
  double? countReputation;
  double? totalRating;
  double? countRating;
  double? numberStatisfied;
  double? numberNotStatisfied;
  StatisticReviewResponse({
    this.totalReputation,
    this.countReputation,
    this.totalRating,
    this.countRating,
    this.numberStatisfied,
    this.numberNotStatisfied,
  });

  ///
  /// From JSON
  ///
  StatisticReviewResponse.fromJson(Map<String, dynamic> json) {
    totalReputation = !IZIValidate.nullOrEmpty(json['totalReputation']) ? IZINumber.parseDouble(json['totalReputation'].toString()) : null;
    countReputation = !IZIValidate.nullOrEmpty(json['countReputation']) ? IZINumber.parseDouble(json['countReputation'].toString()) : null;
    totalRating = !IZIValidate.nullOrEmpty(json['totalRating']) ? IZINumber.parseDouble(json['totalRating'].toString()) : null;
    countRating = !IZIValidate.nullOrEmpty(json['countRating']) ? IZINumber.parseDouble(json['countRating'].toString()) : null;
    numberStatisfied = !IZIValidate.nullOrEmpty(json['numberStatisfied']) ? IZINumber.parseDouble(json['numberStatisfied'].toString()) : null;
    numberNotStatisfied = !IZIValidate.nullOrEmpty(json['numberNotStatisfied']) ? IZINumber.parseDouble(json['numberNotStatisfied'].toString()) : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(totalReputation)) data['totalReputation'] = totalReputation;
    if (!IZIValidate.nullOrEmpty(countReputation)) data['countReputation'] = countReputation;
    if (!IZIValidate.nullOrEmpty(totalRating)) data['totalRating'] = totalRating;
    if (!IZIValidate.nullOrEmpty(countRating)) data['countRating'] = countRating;
    if (!IZIValidate.nullOrEmpty(numberStatisfied)) data['numberStatisfied'] = numberStatisfied;
    if (!IZIValidate.nullOrEmpty(numberNotStatisfied)) data['numberNotStatisfied'] = numberNotStatisfied;
    return data;
  }
}
