import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/voucher_provider.dart';
import '../../../../di_container.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

class ChooseVoucherController extends GetxController {
  // khai bao api
  final VoucherProvider voucherProvider = GetIt.I.get<VoucherProvider>();
  final RefreshController refreshController = RefreshController();
  final sharePrerence = sl<SharedPreferenceHelper>();
  // khai báo biến
  List<VoucherResponse> listVoucher = [];
  int page = 1;
  int limitPage = 10;
  int? code;
  String userId = '';
  double totalPrice = 0;
  // Rx<VoucherResponse> voucher = VoucherResponse().obs;
  ValueNotifier<VoucherResponse> voucher = ValueNotifier(VoucherResponse());
  String? id;
  @override
  void onInit() {
    // if (!IZIValidate.nullOrEmpty(Get.arguments)) {
    //   Get.arguments['typeQuestion'];
    //         Get.arguments['index'];

    // }
    final arg = Get.arguments;
    if (arg != null) {
      if (arg is String) {
        id = arg.toString();
      } else {
        if (!IZIValidate.nullOrEmpty(arg['voucher'])) {
          voucher.value = arg['voucher'] as VoucherResponse;
        }
        if (!IZIValidate.nullOrEmpty(arg['total'])) {
          totalPrice = IZINumber.parseDouble(arg['total'].toString());
        }
      }
    }

    // if (Get.arguments != null) {
    //   totalPrice = IZINumber.parseDouble(Get.arguments['total']);
    //   voucher.value = Get.arguments['voucher'] as VoucherResponse;
    // }
    userId = sharePrerence.getProfile;
    _getVouchers(isRefresh: true);

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    voucher.dispose();
  }

  ///
  /// onLoading
  ///
  void onLoadingData() {
    refreshController.resetNoData();
    _getVouchers(isRefresh: true);
  }

  ///
  ///onRefresh
  ///
  void onRefreshData() {
    refreshController.refreshCompleted();

    _getVouchers(isRefresh: true);
  }

  ///
  /// Search vouchers.
  ///
  void searchVoucherByCode() {
    _getVouchers(isRefresh: true);
  }

  ///
  ///getdataVoucher
  ///
  void _getVouchers({required bool isRefresh}) {
    if (isRefresh) {
      page = 1;
      listVoucher.clear();
    } else {
      page++;
    }
    voucherProvider.paginate(
      page: page,
      limit: limitPage,
      filter:
          '${code != null ? '&code=$code' : ''}&populate=users,categories,products&toDate>=${DateTime.now().millisecondsSinceEpoch}&users=$userId',
      onSuccess: (vouchers) {
        listVoucher.addAll(vouchers);

        if (isRefresh) {
          refreshController.resetNoData(); // data đã làm mới lại
          refreshController.refreshCompleted(); // data đã hoàn thành
        } else {
          refreshController.loadNoData();
          refreshController.loadComplete();
        }

        update();
      },
      onError: (onError) {
        debugPrint("An error occurred while get vouchers $onError");
      },
    );
  }

  ///
  /// Select the voucher.
  ///
  /// If selected voucher then unselect voucher.
  ///
  void selectVoucher({required VoucherResponse voucher}) {
    if (conditionApplyVoucher(voucher: voucher)) {
      return;
    }
    if (this.voucher.value.id != voucher.id) {
      this.voucher.value = voucher;
    } else {
      this.voucher.value = VoucherResponse();
    }
  }

  ///
  /// Condition apply voucher.
  ///
  /// @return true if order not condition applied.
  ///
  bool conditionApplyVoucher({required VoucherResponse voucher}) {
    return IZINumber.parseDouble(voucher.minOrderAmount) > totalPrice;
  }

  ///
  /// Function apply voucher for the order.
  ///
  void onApplyVoucher() {
    // voucher.value.discountPercent = 80;
    // voucher.value.maxDiscountAmount = 23180;
    Get.back(result: voucher.value);
  }
}
