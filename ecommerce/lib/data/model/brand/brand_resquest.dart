import 'package:template/data/model/brand/brand_response.dart';

class BrandResquest extends BrandResponse{
  
  BrandResquest.fromJson(Map<String, dynamic> json):super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}