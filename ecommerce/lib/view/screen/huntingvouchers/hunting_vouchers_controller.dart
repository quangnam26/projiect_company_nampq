import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ntp/ntp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/voucher/voucher_request.dart';
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/voucher_provider.dart';
import 'package:template/view/screen/dash_board/dash_board_controller.dart';
import '../../../di_container.dart';
import '../../../helper/izi_alert.dart';
import '../../../sharedpref/shared_preference_helper.dart';

class HuntingVouchersController extends GetxController {
// khai báo API
  final VoucherProvider voucherProvider = GetIt.I.get<VoucherProvider>();

  VoucherResponse voucherResponse = VoucherResponse();
  // Refresh
  RefreshController refreshController = RefreshController();
  //List
  List<VoucherResponse> listVoucherResponse = [];

  /// khai bao
  int page = 1;
  String idVoucher = '';
  bool isCkeckVoucher = false;
  bool isloading = false;
  bool isHotLoading = true;
  String userId = sl<SharedPreferenceHelper>().getProfile;
  bool data = false;
  bool isCkeck = false;

  @override
  void onInit() {
    isloading = true;
    _getDataVoucher(isRefresh: true);

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    // TODO: implement onClose

    refreshController.dispose();
  }

  /**
   * 20 Voucher.
   * 5 trang.1 trang 4 cai.
   * trang thu 1 -> voucher noi bat
   * 4 trang chua su dung. 16 cai voucher
   * 2 - 5.
   * 
   * 3 voucher
   * 1 trang - 3 cai
   * trang thu nhat - noi bat
   * 
   */

  ///
  ///onLoading
  ///
  void onLoadingData() {
    _getDataVoucher(isRefresh: false);
  }

  ///
  ///onRefresh
  ///
  void onRefreshData() {
    refreshController.resetNoData();
    _getDataVoucher(isRefresh: true);
  }

  ///
  ///Get Data Voucher.
  ///
//get data voucher tính theo ngày
  Future<void> _getDataVoucher({required bool isRefresh}) async {
    final DateTime startDate = await NTP.now();
    if (isRefresh) {
      page = 1;
      // listVoucherResponse.clear();
      listVoucherResponse.clear();
    } else {
      page++;
    }

    voucherProvider.paginate(
      page: page,
      limit: 7,
      filter:
          // '&populate=categories,products,users&isEnable=true&sort=discountPercent&fromDate>=1641574800000',
          // '&populate=categories,products,users&isEnable=true&sort=-discountPercent&fromDate>${startDate.millisecondsSinceEpoch}&toDate=${startDate.millisecondsSinceEpoch}',
          '&isEnable=true&sort=-discountPercent&fromDate<=${startDate.millisecondsSinceEpoch}&toDate>=${startDate.millisecondsSinceEpoch}&populate=products,categories',
      onSuccess: (List<VoucherResponse> vouchers) {
        listVoucherResponse.addAll(vouchers);
        print("UserId: $userId");
        for (int i = 0; i < vouchers.length; i++) {
          print("users bvvvvvvv: ${vouchers[i].users}");
          print("Status: ${vouchers[i].users?.contains(userId)}");
        }

        if (isRefresh) {
          Future.delayed(const Duration(milliseconds: 300), () {
            refreshController.resetNoData(); // data đã làm mới lại
            refreshController.refreshCompleted(); // data đã hoàn thành
            // làm mới dữ liệu
          });
        } else {
          refreshController.loadNoData();
          refreshController.loadComplete();
          // đã load thanh công
        }
        isloading = false;
        update();
      },
      onError: (onError) {
        print("ádsdsadas222 $onError");
      },
    );
  }

  ///
  ///updateVoucher
  ///
  void updateVoucher(String idVoucher) {
    final VoucherRequest voucherRequest = VoucherRequest();
    voucherRequest.userId = sl<SharedPreferenceHelper>().getProfile;
    voucherRequest.idVoucher = idVoucher;
    print('check data push $voucherRequest');
    voucherProvider.saveVoucher(
      data: voucherRequest,
      onSuccess: (onSuccess) {
        IZIAlert.success(message: "Lưu voucher thành công  ");
        print("ddd $onSuccess");

        update();
      },
      onError: (onError) {
        print("object12212$onError");
      },
    );
  }

  void ontapSave(VoucherResponse idVoucher) {
    if (idVoucher.users!.contains(userId)) {
      return;
    }
    if (IZIValidate.nullOrEmpty(userId) == isCkeckVoucher) {
      idVoucher.isCkeck = false;
      updateVoucher(idVoucher.id ?? "");
      idVoucher.users!.add(userId);
      update();
    } else {
      Get.find<DashBoardController>().checkLogin();
    }
  }
}
