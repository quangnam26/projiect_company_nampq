import 'package:template/data/model/banner/banner_response.dart';

class BannerRequest extends BannerResponse{
  
  BannerRequest.fromJson(Map<String, dynamic> json):super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = super.toJson();
    return data;
  }
}