import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/order/order_history_response.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/provider/image_upload_provider.dart';
import 'package:template/provider/review_provider.dart';
import 'package:template/utils/images_path.dart';

class ReviewerController extends GetxController {
  final ImageUploadProvider imageUploadProvider =
      GetIt.I.get<ImageUploadProvider>();

  final ReviewProvider reviewProvider = GetIt.I.get<ReviewProvider>();

  Rx<OrderHistoryResponse> orderResponse = OrderHistoryResponse().obs;
  List<Map<String, dynamic>> list = [
    {
      "name": 'delicious',
      "image": ImagesPath.emojione_face_savoring_food,
      "title": "Ngon xỉu",
      "isActive": true,
    },
    {
      "name": 'wellPacked',
      "image": CupertinoIcons.cube_box_fill, //ImagesPath.notopackage,
      "title": "Đóng gói kĩ",
      "isActive": false,
    },
    {
      "name": 'veryWorthTheMoney',
      "image": ImagesPath.ratdangtien,
      "title": "Rất đáng tiền",
      "isActive": false,
    },
    {
      "name": 'satisfied',
      "image": CupertinoIcons.hand_thumbsup_fill, //ImagesPath.hailong,
      "title": "Hài lòng",
      "isActive": false,
    },
    {
      "name": 'quickService',
      "image": Icons.bolt, //ImagesPath.phucvunhanh,
      "title": "Phục vụ nhanh",
      "isActive": false,
    },
    {
      "name": 'sad',
      "image": ImagesPath.noto_sad_but_relieved_face,
      "title": "Buồn",
      "isActive": false,
    },
  ];

  double ratePoint = 5.0;
  bool isSatisfied = true;

  TextEditingController contentController = TextEditingController();

  List<File> files = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    orderResponse.value = Get.arguments as OrderHistoryResponse;
  }

  ///
  ///onChangeReviewShop
  ///
  void onChangeReviewShop(int index) {
    final indexTrue = list.indexWhere((element) => element['isActive'] == true);

    if (indexTrue != -1) {
      list[indexTrue]['isActive'] = false;
    }
    list[index]['isActive'] = true;
    update();
  }

  ///
  ///onChangeReviewShipper
  ///
  void onChangeReviewShipper() {
    isSatisfied = !isSatisfied;
    update();
  }

  ///
  ///onChangeReviewShipper
  ///
  void onChangeRatePoint(double value) {
    ratePoint = value;
    update();
  }

  ///
  ///pickMultiImage
  ///
  Future pickMultiImage() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Please waiting...');
      update();
      for (final item in images) {
        files.add(File(item.path));
      }
      print('Count images select ${files.length}');
      EasyLoading.dismiss();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIAlert.error(message: 'Bạn phải cho phép quyền truy cập hệ thống');
    }
  }

  ///
  ///onSummit
  ///
  void onSummit() {
    EasyLoading.show(status: 'loading...');
    Map<String, dynamic> param = {};

    param['idUser'] = orderResponse.value.idUser!.id;
    param['idUserShop'] = orderResponse.value.idUserShop!.id;
    param['idUserShipper'] = orderResponse.value.idUserShipper;
    param['idOrder'] = orderResponse.value.id;
    param['ratePoint'] = IZINumber.parseInt(ratePoint);
    if (contentController.text.isNotEmpty) {
      param['content'] = contentController.text;
    }

    for (final item in list) {
      if (item['name'] == 'delicious' && item['isActive'] == true) {
        param['shopReactions'] = {"delicious": 10};
      }
      if (item['name'] == 'wellPacked' && item['isActive'] == true) {
        param['shopReactions'] = {"wellPacked": 10};
      }
      if (item['name'] == 'veryWorthTheMoney' && item['isActive'] == true) {
        param['shopReactions'] = {"veryWorthTheMoney": 10};
      }
      if (item['name'] == 'satisfied' && item['isActive'] == true) {
        param['shopReactions'] = {"satisfied": 10};
      }
      if (item['name'] == 'quickService' && item['isActive'] == true) {
        param['shopReactions'] = {"quickService": 10};
      }
      if (item['name'] == 'sad' && item['isActive'] == true) {
        param['shopReactions'] = {"sad": 10};
      }
    }

    if (isSatisfied) {
      param['shipperReactions'] = {"satisfied": 10};
    } else {
      param['shipperReactions'] = {"notSatisfied": 10};
    }

    if (files.isNotEmpty) {
      imageUploadProvider.addImages(
          files: files,
          onSuccess: (data) {
            if (data.isNotEmpty) {
              param['images'] = data;
              onAddReviewDb(param);
            }
          },
          onError: (error) => {
                EasyLoading.dismiss(),
              });
    } else {
      onAddReviewDb(param);
    }
  }

  ///
  ///onAddReviewDb
  ///
  void onAddReviewDb(dynamic reviewRequest) {
    print('bbb');
    print(reviewRequest);
    reviewProvider.add(
        data: reviewRequest,
        onSuccess: (data) {
          EasyLoading.dismiss();
          IZIAlert.success(message: 'Đánh giá thành công');
          Get.back(result: true);
        },
        onError: (error) {
          print(error);
          EasyLoading.dismiss();
        });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    contentController.dispose();
    super.onClose();
  }
}
