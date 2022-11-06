import 'package:template/data/model/orders/order_response.dart';
import 'package:template/helper/izi_validate.dart';

class OrderRequest extends OrderResponse {
  OrderRequest();

  OrderRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    if (!IZIValidate.nullOrEmpty(voucher?.id)) data['voucher'] = voucher?.id;
    if (!IZIValidate.nullOrEmpty(user?.id)) data['user'] = user?.id;
    if (!IZIValidate.nullOrEmpty(user)) data['user'] = user?.id;
    if (!IZIValidate.nullOrEmpty(items)) data['items'] = items?.map((e) => e.toJson()).toList();
    if (!IZIValidate.nullOrEmpty(shippingHistories)) data['shippingHistories'] = shippingHistories?.map((e) => e.toJson()).toList();
    return data;
  }
}
