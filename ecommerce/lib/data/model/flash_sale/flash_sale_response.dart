import 'package:template/data/model/product/product_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class FlashSaleResponse extends Options {
  bool? isShow;
  String? title;
  int? position;
  DateTime? startTime;
  DateTime? endTime;

  String? description;
  ProductResponse? productResponse;
  FlashSaleResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    isShow =
        IZIValidate.nullOrEmpty(json['isShow']) ? null : json['isShow'] as bool;
    title = IZIValidate.nullOrEmpty(json['title'])
        ? null
        : json['title'].toString();

    position = IZIValidate.nullOrEmpty(json['position'])
        ? null
        : IZINumber.parseInt(json['position']);
    startTime = IZIValidate.nullOrEmpty(json['startTime'])
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            IZINumber.parseInt(json['startTime']));
    endTime = IZIValidate.nullOrEmpty(json['endTime'])
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            IZINumber.parseInt(json['endTime']));

    description = IZIValidate.nullOrEmpty(json['description'])
        ? null
        : json['description'].toString();
    productResponse = IZIValidate.nullOrEmpty(json['product'])
        ? null
        : json['product'] is String
            ? ProductResponse(id: json['product'].toString())
            : ProductResponse.fromJson(json['product'] as Map<String, dynamic>);
  }

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = super.toJson();
    if (!IZIValidate.nullOrEmpty(isShow)) data['isShow'] = isShow;
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;
    if (!IZIValidate.nullOrEmpty(position)) data['position'] = position;
    if (!IZIValidate.nullOrEmpty(startTime)) {
      data['startTime'] = startTime;
    }
    if (!IZIValidate.nullOrEmpty(endTime)) {
      data['endTime'] = endTime;
    }
    if (!IZIValidate.nullOrEmpty(description)) {
      data['description'] = description;
    }
    if (!IZIValidate.nullOrEmpty(productResponse)) {
      data['product'] = productResponse;
    }
    return data;
  }
}
