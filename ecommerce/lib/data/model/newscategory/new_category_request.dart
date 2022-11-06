import 'package:template/data/model/newscategory/news_category_response.dart';

class NewsCategoryRequest extends NewsCategoryResponse{
  
  NewsCategoryRequest.fromJson(Map<String, dynamic> json):super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}