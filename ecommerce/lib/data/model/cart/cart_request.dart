
import 'package:template/data/model/cart/cart_response.dart';


class CartRequest extends CartResponse {
  CartRequest();
  CartRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();

    return data;
  }
}

class ItemsOptionRequest extends ItemsOptionResponse {
  ItemsOptionRequest();
  ItemsOptionRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  Map<String, dynamic> toJson({bool check=true}) {
    final Map<String, dynamic> data = super.toJson();

    return data;
  }
}

// class CartRequest {
//   String? idUser;
//   List<ItemsOptionRequest> itemsOptionRequestList;

//   CartRequest({
//     this.idUser,
//     required this.itemsOptionRequestList,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       if (!IZIValidate.nullOrEmpty(idUser)) 'user': idUser,
//       // if (!IZIValidate.nullOrEmpty(itemsOptionRequestList))
//       'items': itemsOptionRequestList
//     };
//   }

//   factory CartRequest.fromMap(Map<String, dynamic> map) {
//     return CartRequest(
//       idUser: map['user'] != null ? map['user'] as String : null,
//       itemsOptionRequestList: map['items'] != null
//           ? (map['items'] as List)
//               .map(
//                   (e) => ItemsOptionRequest.fromJson(e as Map<String, dynamic>))
//               .toList()
//           : [],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CartRequest.fromJson(String source) =>
//       CartRequest.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// class ItemsOptionRequest {
//   // ProductRequest? productRequest;
//   ProductResponse? productResponse;
//   int? quantity;

//   ItemsOptionRequest({
//     // this.productRequest,
//     this.productResponse,
//     this.quantity,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       // if (!IZIValidate.nullOrEmpty(productRequest))
//       //   'product': productRequest!.id,
//       // if (!IZIValidate.nullOrEmpty(productRequest!.quantityPrices))
//       //   'quantityPrices': productRequest!.quantityPrices,
//       if (!IZIValidate.nullOrEmpty(productResponse))
//         'product': productResponse!.id,
//       if (!IZIValidate.nullOrEmpty(productResponse!.quantityPrices))
//         'quantityPrices': productResponse!.quantityPrices,
//       if (!IZIValidate.nullOrEmpty(quantity)) 'quantity': quantity,
//     };
//   }

//   factory ItemsOptionRequest.fromMap(Map<String, dynamic> map) {
//     return ItemsOptionRequest(
//       productResponse:
//           map['product'] != null ? map['product'] as ProductResponse : null,
//       quantity: map['quantity'] != null ? map['quantity'] as int : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ItemsOptionRequest.fromJson(String source) =>
//       ItemsOptionRequest.fromMap(json.decode(source) as Map<String, dynamic>);
// }
