import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/transaction/transaction_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/transaction_provider.dart';
import 'package:template/provider/user_provider.dart';

import '../../../routes/route_path/wallet_money_routers.dart';

class V2WalletMoneyController extends GetxController {
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final TransactionProvider transactionProvider =
      GetIt.I.get<TransactionProvider>();

  //refresh controller for load more refresh
  final RefreshController refreshController = RefreshController();

  Rx<UserResponse> userResponse = UserResponse().obs;

  RxList<TransactionResponse> transactionResponse = <TransactionResponse>[].obs;

  RxBool visiable = false.obs;

  List<List<TransactionResponse>> lichSuViTien = [];
  List<TransactionResponse> lichSuViTienResponse = [];

  String? keyDate;
  int number = 0;

  int pageMax = 1;
  int limitMax = 10;

  String defaultAccount = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userResponse.value = Get.arguments as UserResponse;

    if (!IZIValidate.nullOrEmpty(userResponse)) {
      onGetDataUserById();
      onGetDataWalletWithUser(isRefresh: true);
    }
  }

  ///
  ///onGetDataUserById
  ///
  void onGetDataUserById() {
    userProvider.find(
        id: userResponse.value.id!,
        onSuccess: (data) {
          defaultAccount = data.defaultAccount.toString();
        },
        onError: (onError) => print(onError));
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    //getWalletHistory
    onGetDataWalletWithUser(isRefresh: true);
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    //getWalletHistory
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
        filter: '&idUser=${userResponse.value.id}',
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
              print('isRefresh');
              refreshController.refreshCompleted();
              lichSuViTienResponse = data;

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

  void onChange() {
    visiable.value = !visiable.value;
  }

  void onGoReCharge() {
    Get.toNamed(WalletMoneyRoutes.RECHARGE, arguments: userResponse.value.id)
        ?.then((value) => {
              if (value == true)
                {onGetDataWalletWithUser(isRefresh: true), onGetDataUserById()}
            });
  }

  ///
  ///onGoWithDraw
  ///
  void onGoWithDraw() {
    Get.toNamed(WalletMoneyRoutes.WITHDRAW)?.then((value) => {
          if (value == true)
            {onGetDataWalletWithUser(isRefresh: true), onGetDataUserById()}
        });
    ;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    super.onClose();
  }
}
