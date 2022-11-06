import 'package:template/data/model/category/category_response.dart';

class CategoryRequest extends CategoryResponse{

  @override
  CategoryRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
