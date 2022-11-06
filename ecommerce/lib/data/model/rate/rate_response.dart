import 'package:template/data/model/orders/order_response.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_number.dart';

import '../../../helper/izi_validate.dart';

class RateResponse {
  String? id;
  ProductResponse? product;
  UserResponse? user;
  OrderResponse? order;
  List<String>? image;
  String? content;
  List<String>? video;
  int? point;
  String? shopReply;

  String? createdAt;
  String? updatedAt;

  RateResponse(
      {this.id,
      this.product,
      this.user,
      this.image,
      this.video,
      this.point,
      this.shopReply,
      this.createdAt,
      this.updatedAt});

  RateResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    product = (json['product'] == null)
        ? null
        : json['product'] is String
            ? ProductResponse(id: json['product'].toString())
            : ProductResponse.fromJson(json['product'] as Map<String, dynamic>);
    user = json['user'] is String && json['user'].toString().length == 24
        ? UserResponse(id: json['user'].toString())
        : UserResponse.fromMap(json['user'] as Map<String, dynamic>);
    order = (json['order'] == null)
        ? null
        : json['order'] is String && json['order'].toString().length == 24
            ? OrderResponse(id: json['order'].toString())
            : OrderResponse.fromJson(json['order'] as Map<String, dynamic>);

    // user=
    // (json['user'] == null)
    //     ? null
    //     :json['user'].toString();
    image = !IZIValidate.nullOrEmpty(json['image'])
        ? (json['image'] as List<dynamic>).map((e) => e.toString()).toList()
        : [];
    video = !IZIValidate.nullOrEmpty(json['video'])
        ? (json['video'] as List<dynamic>).map((e) => e.toString()).toList()
        : [];
    point = IZIValidate.nullOrEmpty(json['point'])
        ? null
        : IZINumber.parseInt(json['point']);
    shopReply =
        (json['shopReply'] == null) ? null : json['shopReply'].toString();
    content = (json['content'] == null) ? null : json['content'].toString();
    createdAt =
        (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt =
        (json['updatedAt'] == null) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(product)) data['product'] = product!.id;
    if (!IZIValidate.nullOrEmpty(user)) data['user'] = user!.id;
    if (!IZIValidate.nullOrEmpty(order)) data['order'] = order!.id;

    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image ?? [];
    if (!IZIValidate.nullOrEmpty(video)) data['video'] = video ?? [];
    if (!IZIValidate.nullOrEmpty(point)) data['point'] = point;
    if (!IZIValidate.nullOrEmpty(shopReply)) data['shopReply'] = shopReply;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}
