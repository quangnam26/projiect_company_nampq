import 'package:template/data/model/product/product_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class BannerResponse extends Options {
  bool? isShow;
  String? text;
  String? image;
  int? position;
  DateTime? promotionCountdown;
  String? link;
  String? type;
  BannerResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    isShow =
        IZIValidate.nullOrEmpty(json['isShow']) ? null : json['isShow'] as bool;
    text =
        IZIValidate.nullOrEmpty(json['text']) ? null : json['text'].toString();
    image = IZIValidate.nullOrEmpty(json['image'])
        ? null
        : json['image'].toString();
    position = IZIValidate.nullOrEmpty(json['position'])
        ? null
        : IZINumber.parseInt(json['position']);
    promotionCountdown = IZIValidate.nullOrEmpty(json['promotionCountdown'])
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            IZINumber.parseInt(json['promotionCountdown']));
    link =
        IZIValidate.nullOrEmpty(json['link']) ? null : json['link'].toString();

    type =
        IZIValidate.nullOrEmpty(json['type']) ? null : json['type'].toString();
  }

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = super.toJson();
    if (!IZIValidate.nullOrEmpty(isShow)) data['isShow'] = isShow;
    if (!IZIValidate.nullOrEmpty(text)) data['text'] = text;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    if (!IZIValidate.nullOrEmpty(position)) data['position'] = position;
    if (!IZIValidate.nullOrEmpty(promotionCountdown)) {
      data['promotionCountdown'] = promotionCountdown;
    }
    if (!IZIValidate.nullOrEmpty(link)) data['link'] = link;
    if (!IZIValidate.nullOrEmpty(type)) data['type'] = type;
    return data;
  }
}
