import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/cart/cart_response.dart';
import 'package:template/data/model/orders/order_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/cart_provider.dart';
import 'package:template/routes/route_path/cart_router.dart';
import 'package:template/routes/route_path/payment_methods_routes.dart';
import 'package:template/routes/route_path/wallet_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/screen/paymentmethods/payment_methods_controller.dart';
import '../../../../data/model/address/address_response.dart';
import '../../../../provider/address_provider.dart';
import '../../../../provider/order_provider.dart';
import '../../../../provider/user_provider.dart';

class PaymentController extends GetxController {
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  final CartProvider cartProvider = GetIt.I.get<CartProvider>();
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final AddressProvider addressProvider = GetIt.I.get<AddressProvider>();

  final sharedPreferences = sl<SharedPreferenceHelper>();

  // Variables.
  String userId = '';
  ValueNotifier<VoucherResponse> voucher = ValueNotifier(VoucherResponse());
  ValueNotifier<PaymentMethod> paymentMethod = ValueNotifier(PaymentMethod.cash);
  ValueNotifier<AddressResponse> address = ValueNotifier(AddressResponse());

  String note = '';
  double transportsMethodPrice = 14000;

  // List
  List<ItemsOptionResponse> listCartPayment = [];
  @override
  void onInit() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      listCartPayment = Get.arguments as List<ItemsOptionResponse>;
    }
    userId = sharedPreferences.getProfile;
    print(userId);
    _getAddress();
    super.onInit();
  }

  @override
  void onClose() {
    voucher.dispose();
    address.dispose();
  }

  // ignore: avoid_setters_without_getters
  set setNote(String value) {
    note = value;
  }

  ///
  /// Get address.
  ///
  void _getAddress() {
    addressProvider.paginate(
      page: 1,
      limit: 1,
      filter: '&user=$userId&isDefault=true&populate=village,district,province',
      onSuccess: (address) {
        if (address.isNotEmpty) {
          this.address.value = address.first;
        }
      },
      onError: (onError) {
        debugPrint("An error occurred while paginating the address22222 $onError");
      },
    );
  }

  ///
  /// Get payment method.
  ///
  /// The @param [method] is [PaymentMethod].
  ///
  String getPaymentMethod({required PaymentMethod method}) {
    switch (method) {
      case PaymentMethod.cash:
        return 'Thanh toán khi nhận hàng';
      case PaymentMethod.app:
        return 'Thanh toán qua ví app';
      case PaymentMethod.atm:
        return 'Thanh toán qua thẻ ngân hàng';
      case PaymentMethod.momo:
        return 'Thanh toán qua momo';
      case PaymentMethod.visa:
        return 'Thanh toán qua thẻ visa';
    }
  }

  ///
  /// Selected payment method.
  ///
  void onSelectedPaymentMethod() {
    Get.toNamed(PaymentmethodsRoutes.PAYMENT_METHODS)?.then((value) {
      if (value != null) {
        paymentMethod.value = value as PaymentMethod;
      }
    });
  }

  ///
  /// Show price follow promotion.
  ///
  double showPriceFollowPromotion(ItemsOptionResponse itemOpt) {
    final double promotion = IZINumber.parseDouble(itemOpt.idProduct?.price) -
        (IZINumber.parseDouble(itemOpt.idProduct?.price) *
            IZINumber.parseDouble(itemOpt.idProduct?.discountPercent) /
            100);
    return promotion;
  }

  ///
  /// Get total price.
  ///
  double getTotalPrice() {
    double price = 0.0;
    // listCartPayment.forEach((element) {
    //   if (!IZIValidate.nullOrEmpty(element.quantityPrices)) {
    //     if (!IZIValidate.nullOrEmpty(element.quantityPrices!.quantity) && element.quantityPrices!.quantity! > 0) {
    //       price += IZINumber.parseDouble(element.quantityPrices!.price) * element.quantityPrices!.quantity!;
    //     }
    //   } else {
    //     price += IZINumber.parseDouble(element.quantityPrices!.price);
    //   }
    // });
    price = 0;
    for (final product in listCartPayment.where((element) => element.isSelected == true)) {
      final double promotion = IZINumber.parseDouble(product.idProduct!.price) *
          IZINumber.parseDouble(product.idProduct!.discountPercent) /
          100;
      price += (IZINumber.parseDouble(product.idProduct!.price) - promotion) *
          IZINumber.parseInt(product.quantityPrices?.quantity);
    }
    return price;
    // return listCartPayment.fold<double>(
    //     0, (val, element) => val += IZINumber.parseDouble(element.quantityPrices!.price));
  }

  ///
  /// Get total price payment.
  ///
  double getTotalPricePayment() {
    return getTotalPrice() + transportsMethodPrice - calulatorDiscountToCurrent();
  }

  // ///
  // /// Calulator discount money for the order.
  // ///
  // String calulatorDiscount() {
  //   if (IZIValidate.nullOrEmpty(voucher.value.id)) {
  //     return '-0';
  //   } else {
  //     final discountMoney = (getTotalPrice() * IZINumber.parseDouble(voucher.value.discountPercent)) / 100;
  //     // If [discountMoney] larger than maxDiscountAmount then get maxDiscountAmount.
  //     if (discountMoney > IZINumber.parseDouble(voucher.value.maxDiscountAmount)) {
  //       return '-${IZIPrice.currencyConverterVND(IZINumber.parseDouble(voucher.value.maxDiscountAmount))}';
  //     }
  //     return '-${IZIPrice.currencyConverterVND(discountMoney)}';
  //   }
  // }

  ///
  ///  Voucher.
  ///
  double calulatorDiscountToCurrent() {
    if (IZIValidate.nullOrEmpty(voucher.value.id)) {
      return 0;
    } else {
      final discountMoney = (getTotalPrice() * IZINumber.parseDouble(voucher.value.discountPercent)) / 100;
      // If [discountMoney] larger than maxDiscountAmount then get maxDiscountAmount.
      if (discountMoney > IZINumber.parseDouble(voucher.value.maxDiscountAmount)) {
        return IZINumber.parseDouble(voucher.value.maxDiscountAmount);
      }
      return discountMoney;
    }
  }

  void onPaymentMethod() {
    if (paymentMethod.value == PaymentMethod.momo) {
      Get.toNamed(WalletRouters.REQUIRED_RECHAGE, arguments: {
        'money': IZIPrice.currencyConverterVND(getTotalPrice()),
        'type': paymentMethod.value,
      })?.then((value) {
        if (value == true) {
          payment();
        }
      });
    } else {
      payment();
    }
  }

  ///
  /// Payment
  ///
  void payment() {
    final OrderRequest orderRequest = OrderRequest();
    orderRequest.user = UserResponse(id: userId);
    orderRequest.amountWithVoucher = 1;
    orderRequest.items = listCartPayment;
    orderRequest.amount = listCartPayment.length;
    orderRequest.status = 'Wait for confirmation';
    orderRequest.address = fullAddress(address: address.value);
    orderRequest.voucher = voucher.value;
    orderRequest.note = note;
    orderRequest.totalPayment = getTotalPricePayment();
    orderRequest.totalPrice = getTotalPrice();
    orderRequest.promotion = calulatorDiscountToCurrent(); //IZINumber.parseDouble(calulatorDiscount());
    orderRequest.totalShipping = transportsMethodPrice;

    orderProvider.add(
      data: orderRequest,
      onSuccess: (order) {
        IZIAlert.success(message: "Đã đặt hàng thành công");
        Get.back();
      },
      onError: (onError) {
        debugPrint("An error occurred while processing the order request $onError");
      },
    );
  }

  ///
  /// The order.
  ///
  void onPayment() {
    if (address.value.id == null) {
      IZIAlert.error(message: "Vui lòng chọn địa chỉ");
      return;
    }
    onPaymentMethod();
  }

  ///
  /// Remove product in cart when ordered successfully.
  ///
  void removeProductCart() {}

  ///
  /// Join address
  ///
  String fullAddress({required AddressResponse address}) {
    print(address.province?.toMap());
    final StringBuffer addressDelivery = StringBuffer();
    if (address.province?.name != null) {
      addressDelivery.write('${address.province?.name} - ');
    }
    if (address.district?.name != null) {
      addressDelivery.write('${address.district?.name} - ');
    }
    if (address.village?.name != null) {
      addressDelivery.write('${address.village?.name}');
    }
    if (address.addressDetail != null) {
      addressDelivery.write(' - ${address.addressDetail}');
    }
    print(addressDelivery.toString());
    return addressDelivery.toString();
  }

  ///
  /// OnGoToPage
  ///
  void onGoToAdressDelivery() {
    Get.toNamed(CartRoutes.ADDRESS_DELIVERY)?.then((value) {
      _getAddress();
    });
  }

  ///
  /// Go to voucher page.
  ///
  void gotoVoucher() {
    Get.toNamed(CartRoutes.CHOOSE_VOUCHER, arguments: {'total': getTotalPrice(), 'voucher': voucher.value})!.then(
      (value) {
        if (value != null) {
          voucher.value = VoucherResponse();
          voucher.value = value as VoucherResponse;
        }
      },
    );
  }
}
