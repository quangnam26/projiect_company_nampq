

import 'package:template/data/model/review/statitis_reviews_response.dart';

class StatitisReviewRequest extends StatitisReviewResponse{
  @override
  StatitisReviewRequest.fromJson(Map<String, dynamic> json):super.fromJson(json);
  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}