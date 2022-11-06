import 'package:template/data/model/reviews/reviews_response.dart';

class ReviewsRequest extends ReviewsResponse {
  ReviewsRequest();

  @override
  ReviewsRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
