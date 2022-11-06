import 'package:hive/hive.dart';
import 'package:template/data/model/category/category_response.dart';
import 'package:template/data/model/geocode/location.dart';
import 'package:template/data/model/group_product/group_product_response.dart';
import 'package:template/data/model/order/order_product/order_product.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/data/model/order/order_response.dart';
import 'package:template/data/model/product/options/options_size.dart';
import 'package:template/data/model/product/options/options_topping.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/data/model/review/shipper_reactions.dart';
import 'package:template/data/model/review/shop_reactions.dart';
import 'package:template/data/model/review/statitis_reviews_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/model/voucher/voucher_response.dart';

class HiveBox<T> {
  static const String ORDER_BOX_NAME = 'order_box';
  Future<void> instanceBox() async {
    _registerAdapter();
  }

  void _registerAdapter() {
    Hive.registerAdapter<OrderRequest>(OrderRequestAdapter());
    Hive.registerAdapter<OrderResponse>(OrderResponseAdapter());
    Hive.registerAdapter<OrderProduct>(OrderProductAdapter());
    Hive.registerAdapter<VoucherResponse>(VoucherResponseAdapter());
    Hive.registerAdapter<UserResponse>(UserResponseAdapter());
    Hive.registerAdapter<OptionsTopping>(OptionsToppingAdapter());
    Hive.registerAdapter<OptionsSize>(OptionsSizeAdapter());
    Hive.registerAdapter<CategoryResponse>(CategoryResponseAdapter());
    Hive.registerAdapter<StatitisReviewResponse>(StatitisReviewResponseAdapter());
    Hive.registerAdapter<GroupProductResponse>(GroupProductResponseAdapter());
    Hive.registerAdapter<ShopReactions>(ShopReactionsAdapter());
    Hive.registerAdapter<Location>(LocationAdapter());
    Hive.registerAdapter<ProductResponse>(ProductResponseAdapter());
    Hive.registerAdapter<ShipperReactions>(ShipperReactionsAdapter());
  }

  Future<Box<T>> getOpenBox(String nameBox) async {
    return Hive.openBox<T>(nameBox);
  }
}
