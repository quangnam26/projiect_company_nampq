import 'package:template/data/model/product/product_response.dart';
import 'package:template/helper/izi_validate.dart';

class ProductRequest extends ProductResponse {

  ProductRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = super.toJson();
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser!.id;
    if (!IZIValidate.nullOrEmpty(idCategory)) data['idCategory'] = idCategory!.id;
    if (!IZIValidate.nullOrEmpty(idGroup)) data['idGroup'] = idGroup!.id;
    return data;
  }
}