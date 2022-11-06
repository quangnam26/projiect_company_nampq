import 'package:template/data/model/images/image_response.dart';

class ImageRequest extends ImageResponse {
  ImageRequest();
  ImageRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
