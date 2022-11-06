import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/base_widget/animated_custom_dialog.dart';
import 'package:template/base_widget/my_dialog_alert_done.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/data/model/cart/cart_response.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/cart_provider.dart';
import 'package:template/routes/route_path/cart_router.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/images_path.dart';

class CartController extends GetxController {
  final CartProvider cartProvider = GetIt.I.get<CartProvider>();
  CartRequest cartRequest = CartRequest();

  double sumTotalPrice = 0.0;
  ValueNotifier<CartResponse> cart = ValueNotifier<CartResponse>(CartResponse());
  ValueNotifier<bool> loading = ValueNotifier<bool>(true);

  @override
  void onInit() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      final data = Get.arguments;
    }

    super.onInit();
    if (!IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getProfile)) {
      _getListCart();
    } else {
      loading.value = false;
      // update();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    if (!IZIValidate.nullOrEmpty(cart.value.itemsOption)) {
      for (final element in cart.value.itemsOption!) {
        element.controller?.dispose();
      }
    }
    cart.dispose();
    loading.dispose();
  }

  ///
  /// Hiển thị List Cart
  ///
  void _getListCart() {
    cartProvider.paginate(
      limit: 1,
      page: 1,
      filter: "&user=${sl<SharedPreferenceHelper>().getProfile}&populate=items.product",
      onSuccess: (cartList) {
        if (cartList.isNotEmpty) {
          if (cartList.first.itemsOption != null) {
            for (final element in cartList.first.itemsOption!) {
              element.controller = TextEditingController(text: element.quantityPrices!.quantity.toString());
            }
          }

          cart.value = cartList.first;

          toTalPrice();
        }
        loading.value = false;
      },
      onError: (err) {
        debugPrint("An error occurred while retrieving cart list from server $err");
      },
    );
  }

  ///
  ///Số lượng quantity của một Product trong Cart
  ///
  int showQuantityProductAddedCart(ItemsOptionResponse itemsOptionResponse) {
    return itemsOptionResponse.quantityPrices!.quantity!;
  }

  ///
  /// OnGoToPage
  ///
  void onGoToPayMent() {
    if (cart.value.itemsOption!.firstWhereOrNull((element) => element.isSelected == true) == null) {
      IZIAlert.error(message: "Vui lòng chọn sản phẩm");
      return;
    }
    final List<ItemsOptionResponse>? products =
        cart.value.itemsOption?.where((element) => element.isSelected == true).toList();
    Get.toNamed(CartRoutes.PAYMENT, arguments: products)?.then((_) {
      loading.value = true;
      cart.value = CartResponse();
      _getListCart();
      Get.back();
    });
  }

  ///
  /// Tick chọn sản phẩm muốn thanh toán
  ///
  void selectedProduct(ItemsOptionResponse itemOption) {
    itemOption.isSelected = !itemOption.isSelected!;
    update();
  }

  ///
  /// Thay đổi số lượng sản phẩm
  ///
  void onChangeQuantity(ItemsOptionResponse itemsOptionResponse, String newQuantity) {
    itemsOptionResponse.quantityPrices!.quantity = int.parse(newQuantity.toString());
    update();
  }

  ///
  /// Tổng giá
  ///
  double toTalPrice() {
    sumTotalPrice = 0;
    for (final product in cart.value.itemsOption!.where((element) => element.isSelected == true)) {
      final double promotion = IZINumber.parseDouble(product.idProduct!.price) *
          IZINumber.parseDouble(product.idProduct!.discountPercent) /
          100;
      sumTotalPrice += (IZINumber.parseDouble(product.idProduct!.price) - promotion) *
          IZINumber.parseInt(product.quantityPrices?.quantity);
    }
    return sumTotalPrice;
  }

  ///
  ///Hiển thị giá tiền theo Số lượng quantity của một Product
  ///(giá tiền * số lượng )
  ///

  double showPriceFollowQuantity(ItemsOptionResponse itemOpt) {
    final double promotion = IZINumber.parseDouble(itemOpt.idProduct!.price) -
        (IZINumber.parseDouble(itemOpt.idProduct!.price) *
            IZINumber.parseDouble(itemOpt.idProduct!.discountPercent) /
            100);
    return promotion;
  }

  ///
  /// Get stock product.
  ///
  int? getStockProduct() {
    return cart.value.itemsOption![0].idProduct?.quantityPrices?.first.quantity!;
  }

  ///
  /// Delete
  ///
  void deleteItemDialog(BuildContext context, {required String productId}) {
    showAnimatedDialog(
      context,
      MyDialogAlertDone(
        icon: Icons.check,
        title: "Bạn có chắc chắn?",
        description: 'Xóa sản phẩm ra khỏi giỏ hàng.',
        imagesIcon: ImagesPath.status_warning,
        direction: Axis.vertical,
        textAlignDescription: TextAlign.center,
        onTapCancle: () {
          Get.back();
        },
        onTapConfirm: () {
          deleteItemCart(productId: productId);
          Get.back();
        },
      ),
    );
  }

  ///
  /// Add product to the cart of user.
  ///
  void deleteItemCart({required String productId}) {
    EasyLoading.show(status: "Đang xóa");

    // update
    final CartRequest cart = CartRequest();
    this.cart.value.itemsOption!.removeWhere((e) => e.id.toString() == productId);

    cart.itemsOption = [
      ...this.cart.value.itemsOption ?? [],
    ];

    cartProvider.update(
      data: cart,
      id: this.cart.value.id.toString(),
      onSuccess: (CartRequest cart) {
        this.cart.value = this.cart.value.copyWith(
              id: this.cart.value.id,
              itemsOption: this.cart.value.itemsOption ?? [],
              userResponse: this.cart.value.userResponse,
            );
        EasyLoading.showInfo("Đã Xóa");
        EasyLoading.dismiss();
      },
      onError: (onError) {
        EasyLoading.dismiss();
        debugPrint("An error occurred while updating the cart $onError");
      },
    );
  }

  ///
  /// Add product to the cart of user.
  ///
  void addProductToCart({required String productId, required String amount}) {
    // update
    final CartRequest cart = CartRequest();
    final val = this
        .cart
        .value
        .itemsOption!
        .firstWhere((e) => e.id.toString() == productId, orElse: () => ItemsOptionResponse());
    if (val.id != null) {
      val.quantityPrices?.quantity = IZINumber.parseInt(amount);
    }
    cart.itemsOption = [
      ...this.cart.value.itemsOption ?? [],
    ];

    cartProvider.update(
      data: cart,
      id: this.cart.value.id.toString(),
      onSuccess: (CartRequest cart) {
        // Add the product to the cart sucessfully.
        // this.cart.value = cart;
        if (IZINumber.parseInt(val.quantityPrices?.quantity) <= 0) {
          deleteItemCart(productId: val.id.toString());
          return;
        }
        update();
      },
      onError: (onError) {
        EasyLoading.dismiss();
        debugPrint("An error occurred while updating the cart $onError");
      },
    );
  }

  ///
  /// Get stock in product.
  ///
  double getMaxProduct(ItemsOptionResponse itemsOption) {
    double stockValue = 0;
    final val = itemsOption.idProduct?.quantityPrices?.firstWhere(
        (element) =>
            element.idColors == itemsOption.quantityPrices?.idColors &&
            element.idSize == itemsOption.quantityPrices?.idSize,
        orElse: () => QuantityPrices());
    if (val != null && val.id != null) {
      stockValue = IZINumber.parseDouble(val.quantity);
    }
    return stockValue;
  }
}
