import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/transaction/transaction_response.dart';
import 'package:template/provider/transaction_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/account_routes.dart';
import '../../../data/model/user/user_response.dart';
import '../../../di_container.dart';
import '../../../helper/izi_date.dart';
import '../../../sharedpref/shared_preference_helper.dart';

class WalletMoneyController extends GetxController {
  //khai bao API
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final TransactionProvider transactionProvider =
      GetIt.I.get<TransactionProvider>();
  UserResponse userResponse = UserResponse();

  //refresh controller for load more refresh
  final RefreshController refreshController = RefreshController();
  // khai bao obscure so du
  TextEditingController moneyRechargeController = TextEditingController();

  //List
  List<TransactionResponse> transactionResponse = <TransactionResponse>[];
  final List<List<TransactionResponse>> lichSuViTien = [];
  final List<TransactionResponse> lichSuViTienResponse = [];

  // khai bao Amount to deposit
  String? erroTextAmountToDeposit;
  bool obscure = true;
  String obscureCharacters = "************";
  String accountBalance = "0";
  int pageMax = 1;
  int limitMax = 10;
  int number = 0;
  String? keyDate;
  bool isFirstValidateAmount = false;
  bool isEnabledValidateAmount = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getInfoSurplus();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    moneyRechargeController.dispose();
    refreshController.dispose();
    super.onClose();
  }

  ///
  /// số dư của ví tiền của tôi
  ///
  void _getInfoSurplus() {
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getProfile,
      onSuccess: (data) {
        userResponse = data;
        accountBalance = data.defaultAccount.toString();
        onGetDataWalletWithUser(isRefresh: true);
        // isLoading = false;
        update();
      },
      onError: (onError) {},
    );
  }

  void onGoReCharge() {
    Get.toNamed(AccountRoutes.RECHARGE, arguments: userResponse)
        ?.then((value) => {
              if (value == true)
                {onGetDataWalletWithUser(isRefresh: true), _getInfoSurplus()}
            });
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    //getWalletHistory
    // getInfoSurplus();
    onGetDataWalletWithUser(isRefresh: true);
    update();
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    onGetDataWalletWithUser(isRefresh: false);
  }

  ///
  ///onGetDataWalletWithUser
  ///
  void onGetDataWalletWithUser({required bool isRefresh}) {
    if (isRefresh) {
      pageMax = 1;
      number = 0;
      lichSuViTien.clear();
      lichSuViTienResponse.clear();
      refreshController.resetNoData();
    } else {
      pageMax++;
    }
    transactionProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter: '&idUser=${userResponse.id}',
        onSuccess: (data) {
          //check is not empty

          if (data.isEmpty) {
            if (isRefresh) {
              //reset noData
              refreshController.refreshCompleted();
            } else {
              refreshController.loadNoData();
            }
          } else {
            //isRefresh
            if (isRefresh) {
              print('isRefresh nnnnnnnnnnn');
              refreshController.refreshCompleted();
              lichSuViTienResponse.addAll(data);

              lichSuViTien.add([]);
              keyDate = IZIDate.formatDate(
                  IZIDate.parse(lichSuViTienResponse[0].createdAt!));
              for (int i = 0; i < lichSuViTienResponse.length; i++) {
                if (IZIDate.formatDate(
                        IZIDate.parse(lichSuViTienResponse[i].createdAt!))
                    .contains(keyDate!)) {
                  lichSuViTien[number].add(lichSuViTienResponse[i]);
                } else {
                  number++;
                  keyDate = IZIDate.formatDate(
                      IZIDate.parse(lichSuViTienResponse[i].createdAt!));
                  lichSuViTien.add([]);
                  lichSuViTien[number].add(lichSuViTienResponse[i]);
                }
              }
            } else {
              //is load more
              print('loading');
              final List<TransactionResponse> tempData = data;
              keyDate =
                  IZIDate.formatDate(IZIDate.parse(tempData[0].createdAt!));
              for (int i = 0; i < tempData.length; i++) {
                if (IZIDate.formatDate(IZIDate.parse(tempData[i].createdAt!))
                    .contains(keyDate!)) {
                  lichSuViTien[number].add(tempData[i]);
                } else {
                  number++;
                  keyDate =
                      IZIDate.formatDate(IZIDate.parse(tempData[i].createdAt!));
                  lichSuViTien.add([]);
                  lichSuViTien[number].add(tempData[i]);
                } 
              }
              refreshController.loadComplete();
            }
            update();
          }
        },
        onError: (error) => print(error));
  }

  ///
  ///Change obscure ví của tôi
  ///
  void onChangedIsVisible() {
    obscure = !obscure;
    update();
  }

  ///
  ///onGotozReCharge
  ///
  void onGotozReCharge() {
    Get.toNamed(AccountRoutes.RECHARGE);
  }
}
