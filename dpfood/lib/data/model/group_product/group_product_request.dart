import 'package:template/data/model/group_product/group_product_response.dart';

class GroupProductRequest extends GroupProductResponse{

  @override
  GroupProductRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
