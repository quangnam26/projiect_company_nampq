import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/transaction/transaction_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/transaction_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/%20transaction_details_routers.dart';
import 'package:template/routes/route_path/recharge_routers.dart';
import 'package:template/routes/route_path/withdraw_money_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/%20my_wallet/component/custom_izi_cart.dart';

class MyWalletController extends GetxController {
  /// Declare API.
  final TransactionProvider transactionProvider = GetIt.I.get<TransactionProvider>();
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  late RxMap<String, List<TransactionResponse>> historyTransactionMap = <String, List<TransactionResponse>>{}.obs;
  RxList<TransactionResponse> transactionModelList = <TransactionResponse>[].obs;
  Rx<UserResponse> userResponse = UserResponse().obs;

  /// Declare Data.
  bool isLoading = true;
  int page = 1;
  int limit = 20;
  RxString obscureCharacters = "************".obs;
  RxString accountBalance = "0".obs;
  RxString createAtTime = ''.obs;
  RxBool obscure = true.obs;
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();

    ///  Call API get data transaction.
    getDataTransaction(isRefresh: true);
  }

  @override
  void onClose() {
    historyTransactionMap.close();
    transactionModelList.close();
    userResponse.close();
    obscureCharacters.close();
    accountBalance.close();
    createAtTime.close();
    obscure.close();
    refreshController.dispose();
    super.onClose();
  }

  ///
  /// Call API get data transaction.
  ///
  void getDataTransaction({required bool isRefresh}) {
    if (isRefresh) {
      page = 0;
      transactionModelList.clear();
    } else {
      page++;
    }
    transactionProvider.paginate(
      page: page,
      limit: limit,
      filter: "&idUser=${sl<SharedPreferenceHelper>().getIdUser}",
      onSuccess: (modes) {
        if (modes.isEmpty) {
          refreshController.loadNoData();
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              refreshController.refreshCompleted();
            },
          );

          getInfoSurplus();
        } else {
          if (isRefresh) {
            transactionModelList.value = modes;
            refreshController.refreshCompleted();
          } else {
            transactionModelList.value = transactionModelList.toList() + modes;
            refreshController.loadComplete();
          }

          /// Sort history date.
          sortHistoryDate(
            history: transactionModelList,
          );
        }
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  /// Call API get info surplus.
  ///
  void getInfoSurplus() {
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (data) {
        userResponse.value = data;
        accountBalance.value = data.defaultAccount.toString();

        /// Just [update] first load [My wallet page].
        if (isLoading) {
          isLoading = false;
          update();
        }
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  /// Sort history date.
  ///
  void sortHistoryDate({required List<TransactionResponse> history}) {
    historyTransactionMap.clear();
    for (final e in history) {
      final String date = DateFormat('dd/MM/yyyy').format(DateTime.parse(e.createdAt!.toLocal().toString()));
      if (historyTransactionMap.containsKey(date) == false) {
        historyTransactionMap[date] = [];
      }
      historyTransactionMap[date]!.add(e);
    }

    /// Call API get info surplus.
    getInfoSurplus();
  }

  ///
  /// Change obscure my wallet.
  ///
  void onChangedIsVisible() {
    obscure.value = !obscure.value;
  }

  ///
  /// Go to [Recharge page].
  ///
  void goToRechargePage() {
    Get.toNamed(RechargeRouters.RECHARGE)!.then((value) {
      onRefresh();
    });
  }

  ///
  /// Go to [With draw money].
  ///
  void goWithDrawMoney() {
    Get.toNamed(WithDrawMoneyRouters.WITH_DRAW_MONEY)!.then((value) {
      onRefresh();
    });
  }

  ///
  /// Go to [Detail transaction page].
  ///
  void goToDetailTransaction(String idTransaction) {
    Get.toNamed(TransactionDetailsRouters.TRANSACTIONDETAILS, arguments: idTransaction)!.then((value) {
      onRefresh();
    });
  }

  ///
  /// Generate status transaction.
  ///
  IZIStatusTransaction genStatusPayment(String statusPayment) {
    if (statusPayment == WAITING_TRANSACTION) {
      return IZIStatusTransaction.AWAIT;
    }
    if (statusPayment == FAILED_TRANSACTION) {
      return IZIStatusTransaction.FAIL;
    }
    if (statusPayment == SUCCESS_TRANSACTION) {
      return IZIStatusTransaction.DONE;
    }

    return IZIStatusTransaction.DONE;
  }

  ///
  /// Generate status money.
  ///
  IZITypeTransaction genStatusMoney(String typeTransaction) {
    if (typeTransaction == "recharge") {
      return IZITypeTransaction.RECHARGE;
    }

    if (typeTransaction == WITHDRAW) {
      return IZITypeTransaction.DRAW;
    }

    return IZITypeTransaction.DRAW;
  }

  ///
  /// Generate method transaction.
  ///
  IZIMethodTransaction genMethodTransaction(String methodTransaction) {
    if (methodTransaction == MOMO) {
      return IZIMethodTransaction.MOMO;
    }

    if (methodTransaction == VIETTEL_PAY) {
      return IZIMethodTransaction.VIETTELL_PAY;
    }
    return IZIMethodTransaction.TRANSFER;
  }

  ///
  /// On Refresh data.
  ///
  Future<void> onRefresh() async {
    refreshController.resetNoData();

    /// Call API get data transaction.
    getDataTransaction(isRefresh: true);
  }

  ///
  /// On loading more data.
  ///
  Future<void> onLoading() async {
    ///  Call API get data transaction.
    getDataTransaction(isRefresh: false);
  }
}
