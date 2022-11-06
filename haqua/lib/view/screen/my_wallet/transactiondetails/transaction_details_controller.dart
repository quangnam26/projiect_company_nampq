import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/data/model/transaction/transaction_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/transaction_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/izi_preview_image_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionDetailsController extends GetxController {
  //Khai bao API
  final TransactionProvider transactionProvider = GetIt.I.get<TransactionProvider>();
  final UserProvider userProvider = GetIt.I.get<UserProvider>();

  //Khai bao data
  UserResponse userResponse = UserResponse();
  TransactionResponse transactionResponse = TransactionResponse();
  bool isLoading = true;
  String? idTransaction;

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  ///
  /// getArgument
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      idTransaction = Get.arguments.toString();
    }
    getDetailTransaction();
  }

  ///
  /// getDetailTransaction
  ///
  void getDetailTransaction() {
    transactionProvider.find(
      id: idTransaction.toString(),
      onSuccess: (model) {
        transactionResponse = model;
        getInfoUser();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// get id
  ///

  void getInfoUser() {
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (data) {
        userResponse = data;
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// callHotLine
  ///
  Future<void> callHotLine(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    // await launchUrl(launchUri);
    if (await launchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  ///
  /// genImageTypeTransaction
  ///
  String genImageTypeTransaction() {
    if (transactionResponse.typeTransaction == WITHDRAW) {
      return ImagesPath.icon_rut_tien;
    }

    return ImagesPath.icon_nap_tien;
  }

  ///
  /// genTextAmount
  ///
  Widget genTextAmount() {
    if (transactionResponse.typeTransaction == RECHARGE) {
      return Text(
        '${IZIPrice.currencyConverterVND(IZINumber.parseDouble(transactionResponse.money.toString()))}VNĐ',
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          color: ColorResources.GREEN,
        ),
      );
    }
    if (transactionResponse.typeTransaction == WITHDRAW) {
      return Text(
        '- ${IZIPrice.currencyConverterVND(IZINumber.parseDouble(transactionResponse.money.toString()))}VNĐ',
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          color: ColorResources.RED,
        ),
      );
    }

    return Text(
      '0 VNĐ',
      style: TextStyle(
        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
        color: ColorResources.GREEN,
      ),
    );
  }

  ///
  /// getStatusTransaction
  ///
  Widget getStatusTransaction(String statusPayment) {
    if (statusPayment == SUCCESS_TRANSACTION) {
      return Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: IZIDimensions.SPACE_SIZE_3X,
              bottom: IZIDimensions.SPACE_SIZE_1X * 0.6,
            ),
            height: IZIDimensions.ONE_UNIT_SIZE * 25,
            width: IZIDimensions.ONE_UNIT_SIZE * 25,
            child: const Icon(
              Icons.check,
              color: ColorResources.GREEN,
            ),
          ),
          IZIText(
            text: "thanh_cong".tr,
            style: TextStyle(
              color: ColorResources.BLACK,
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
            ),
            maxLine: 1,
            textAlign: TextAlign.end,
          ),
        ],
      );
    } else if (statusPayment == FAILED_TRANSACTION) {
      return Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: IZIDimensions.SPACE_SIZE_3X,
              bottom: IZIDimensions.SPACE_SIZE_1X * 0.6,
            ),
            height: IZIDimensions.ONE_UNIT_SIZE * 25,
            width: IZIDimensions.ONE_UNIT_SIZE * 25,
            child: const Icon(
              Icons.clear,
              color: ColorResources.RED,
            ),
          ),
          IZIText(
            text: "that_bai".tr,
            style: TextStyle(
              color: ColorResources.BLACK,
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
            ),
            maxLine: 1,
            textAlign: TextAlign.end,
          ),
        ],
      );
    }
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: IZIDimensions.SPACE_SIZE_3X,
            bottom: IZIDimensions.SPACE_SIZE_1X * 0.6,
          ),
          height: IZIDimensions.ONE_UNIT_SIZE * 25,
          width: IZIDimensions.ONE_UNIT_SIZE * 25,
          child: const Icon(Icons.priority_high, color: ColorResources.YELLOW_PRIMARY2),
        ),
        IZIText(
          text: "đang_cho".tr,
          style: TextStyle(
            color: ColorResources.BLACK,
            fontWeight: FontWeight.w600,
            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          ),
          maxLine: 1,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }

  ///
  /// genMoneySource
  ///
  Widget genMoneySource() {
    if (transactionResponse.typeTransaction == RECHARGE && transactionResponse.methodTransaction == TRANSFERS) {
      return Text(
        '${"Bank_wallet".tr}${!IZIValidate.nullOrEmpty(userResponse.bankName) ? " ${userResponse.bankName}" : ""}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          color: ColorResources.PRIMARY_APP,
        ),
      );
    }

    if (transactionResponse.typeTransaction == RECHARGE && transactionResponse.methodTransaction == MOMO) {
      return Text(
        'momo_wallet'.tr,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          color: ColorResources.MOMO_TRANSACTION,
        ),
      );
    }

    if (transactionResponse.typeTransaction == RECHARGE && transactionResponse.methodTransaction == VIETTEL_PAY) {
      return Text(
        'Viettel_Pay_Wallet'.tr,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          color: ColorResources.VIETTEL_PAY_TRANSACTION,
        ),
      );
    }

    return Text(
      'haqua_wallet'.tr,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
        color: ColorResources.PRIMARY_APP,
      ),
    );
  }

  ///
  /// goToPreviewImage
  ///
  void goToPreviewImage({required String imageUrl}) {
    Get.toNamed(IZIPreviewImageRoutes.IZI_PREVIEW_IMAGE, arguments: imageUrl);
  }
}
