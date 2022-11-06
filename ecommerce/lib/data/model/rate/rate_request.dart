import 'package:template/data/model/rate/rate_response.dart';

class RateRequest extends RateResponse {
  RateRequest() : super(image: [],video: []);

  RateRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
