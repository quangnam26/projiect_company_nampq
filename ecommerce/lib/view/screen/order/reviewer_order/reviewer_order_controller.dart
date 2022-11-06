import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/data/model/cart/cart_response.dart';
import 'package:template/data/model/orders/order_response.dart';
import 'package:template/data/model/rate/rate_request.dart';
import 'package:template/data/model/rate/rate_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/image_upload_provider.dart';
import 'package:template/provider/rate_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class ReviewerOrderController extends GetxController {
  RateProvider rateProvider = RateProvider();
  RateResponse rateResponse = RateResponse();
  RateRequest rateRequest = RateRequest();

  double rateNumber = 5;
  final ImageUploadProvider imageUploadProvider = ImageUploadProvider();

  ItemsOptionResponse itemsOptionResponse = ItemsOptionResponse();

  List<File> filesImage = [];
  List<File> filesVideo = [];

  String? avatarg;
  String? videoarg;

  String contentReviewProduct = "";

  bool existsCheck = false;

  String? idRate;
  @override
  void onInit() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      if (!IZIValidate.nullOrEmpty(Get.arguments['items'])) {
        itemsOptionResponse = Get.arguments['items'] as ItemsOptionResponse;
      }
    }
    rateProvider.paginate(
        page: 1,
        limit: 1,
        filter:
            "&user=${sl<SharedPreferenceHelper>().getProfile}&product=${itemsOptionResponse.idProduct!.id}${!IZIValidate.nullOrEmpty(Get.arguments['idOrder']) ? "&order=${Get.arguments['idOrder']}" : ""}",
        onSuccess: (onSuccess) {
          if (onSuccess.isNotEmpty) {
            existsCheck = true;
            idRate = onSuccess.first.id;
            rateNumber = double.parse(onSuccess.first.point.toString());
            contentReviewProduct = onSuccess.first.content!;
            if (!IZIValidate.nullOrEmpty(onSuccess.first.image)) {
              avatarg = onSuccess.first.image!.first;
            }
            if (!IZIValidate.nullOrEmpty(onSuccess.first.video)) {
              videoarg = onSuccess.first.video!.first;
            }
          }
          update();
        },
        onError: (onError) {});

    super.onInit();
  }

  Future pickImage() async {
    filesImage = [];
    try {
      EasyLoading.show(status: 'Please waiting...');
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (images == null) return;
      // update();
      filesImage = [File(images.path)];
      imageUploadProvider.addImages(
        files: filesImage,
        onSuccess: (List<String> value) {
          print(value.first);
          avatarg = value.first;
          EasyLoading.dismiss();
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          // IZIToast().error(message: e.toString());
        },
      );
      EasyLoading.dismiss();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIAlert.error(message: 'Bạn phải cho phép quyền truy cập hệ thống');
      openAppSettings();
    }
  }

  Future pickVideo() async {
    filesVideo = [];
    try {
      EasyLoading.show(status: 'Please waiting...');
      final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (video == null) return;
      // update();
      filesVideo = [File(video.path)];
      // videoarg = video.path;
      imageUploadProvider.addImages(
          files: filesVideo,
          onSuccess: (List<String> value) {
            print(value.first);
            videoarg = value.first;
            EasyLoading.dismiss();
            update();
          },
          onError: (e) {
            EasyLoading.dismiss();
            // IZIToast().error(message: e.toString());
          },
          type: "file");
      EasyLoading.dismiss();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIAlert.error(message: 'Bạn phải cho phép quyền truy cập hệ thống');
      openAppSettings();
    }
  }

  void onChangeRate(double newRate) {
    rateNumber = newRate;
    update();
  }

  void addReview() {
    rateRequest.user =
        UserResponse(id: sl<SharedPreferenceHelper>().getProfile);
    if (!IZIValidate.nullOrEmpty(avatarg)) {
      rateRequest.image!.add(avatarg!);
    }
    if (!IZIValidate.nullOrEmpty(videoarg)) {
      rateRequest.video!.add(videoarg!);
    }

    rateRequest.product = itemsOptionResponse.idProduct;
    rateRequest.point = rateNumber.round();

    rateRequest.order = OrderResponse(id: Get.arguments['idOrder'].toString());
    if (!existsCheck) {
      EasyLoading.show(status: "Please wait...");
      rateProvider.add(
          data: rateRequest,
          onSuccess: (onSuccess) {
            IZIAlert.success(message: "Đánh giá sản phẩm thành công ");
            print(onSuccess);
            EasyLoading.dismiss();
          },
          onError: (onError) {
            IZIAlert.error(message: "Đánh giá sản phẩm thất bại ");

            EasyLoading.dismiss();
          });
    }
  }
}
