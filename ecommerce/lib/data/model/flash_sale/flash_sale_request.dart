import 'package:template/data/model/flash_sale/flash_sale_response.dart';

class FlashSaleRequest extends FlashSaleResponse{
  
  FlashSaleRequest.fromJson(Map<String, dynamic> json):super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}