import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:template/data/model/transport/transport_resquest.dart';

import 'package:template/helper/izi_validate.dart';

import '../../../data/model/provider/provider.dart';
import '../../../data/model/transport/transport_response.dart';
import '../../../di_container.dart';

import '../../../helper/izi_other.dart';
import '../../../sharedpref/shared_preference_helper.dart';
// import 'components/dialog.dart';

class DetailController extends GetxController {
  final Provider provider = Provider();
  List<Map<String, dynamic>> strlist = [];

  //Variables
  TransportResponse? transport;
  String idUser = '';

  bool isFromHomePage = false;

  @override
  void onInit() {
    super.onInit();
    idUser = sl<SharedPreferenceHelper>().getProfile;
    final arg = Get.arguments;
    if (arg != null) {
      transport = arg['transport'] as TransportResponse;
      isFromHomePage = arg['isFromHomePage'] as bool;
      strlist = [
        {
          "text": startAddress(),
          "icon": Icons.gps_fixed_outlined,
          "title": "Đi"
        },
        {
          "text": endAddress(),
          "icon": Icons.location_on_outlined,
          "title": "Đến"
        }
      ];
    }
  }

  ///
  /// Địa điểm băt đầu
  ///
  String startAddress() {
    String address = '';
    // if (!IZIValidate.nullOrEmpty(transport!.addressFrom)) {
    //   address += '${transport!.addressFrom} ';
    // }
    if (!IZIValidate.nullOrEmpty(transport!.idVillageFrom)) {
      if (!IZIValidate.nullOrEmpty(transport!.idVillageFrom)) {
        address += '${transport!.idVillageFrom!.name} ';
      }
    }
    if (!IZIValidate.nullOrEmpty(transport!.idDistrictFrom)) {
      if (!IZIValidate.nullOrEmpty(transport!.idDistrictFrom)) {
        address += '- ${transport!.idDistrictFrom!.name} ';
      }
    }
    if (!IZIValidate.nullOrEmpty(transport!.idProvinceFrom)) {
      if (!IZIValidate.nullOrEmpty(transport!.idProvinceFrom)) {
        address += '- ${transport!.idProvinceFrom!.name}';
      }
    }
    return address;
  }

  ///
  /// Địa điểm kết thúc
  ///
  String endAddress() {
    String address = '';

    // if (!IZIValidate.nullOrEmpty(transport!.addressTo)) {
    //   address += '${transport!.addressTo} ';
    // }
    if (!IZIValidate.nullOrEmpty(transport!.idVillageTo)) {
      if (!IZIValidate.nullOrEmpty(transport!.idVillageTo)) {
        address += '${transport!.idVillageTo!.name} ';
      }
    }
    if (!IZIValidate.nullOrEmpty(transport!.idDistrictTo)) {
      if (!IZIValidate.nullOrEmpty(transport!.idDistrictTo)) {
        address += '- ${transport!.idDistrictTo!.name} ';
      }
    }
    if (!IZIValidate.nullOrEmpty(transport!.idProvinceTo)) {
      if (!IZIValidate.nullOrEmpty(transport!.idProvinceTo)) {
        address += '- ${transport!.idProvinceTo!.name}';
      }
    }
    return address;
  }

  ///
  /// get Time
  ///
  String getTime() {
    final time = DateTime.fromMillisecondsSinceEpoch(transport!.timeStart!);
    return '${time.hour < 10 ? '0${time.hour}' : time.hour}:${time.minute < 10 ? '0${time.minute}' : time.minute}';
  }

  ///
  /// Get value theo loại hình
  ///
  String getValueTransportType(int type) {
    if (type == 0) {
      return '${transport!.numberPeople.toString()} người';
    }
    if (type == 1) {
      return 'Còn ${transport!.numberEmptySeats.toString()} chỗ trống';
    }
    if (type == 2) {
      return "Gửi ${transport!.netWeight} ${getUnit(transport!.unitType!)}";
    }
    return "Cho ${transport!.maxNetWeight} ${getUnit(transport!.unitType!)}";
  }

  ///
  ///get unit
  ///
  String getUnit(int unit) {
    // Nếu đơn vị null trả về KG
    if (IZIValidate.nullOrEmpty(transport!.unitType)) {
      return 'Kg';
    }

    // Nếu đơn vị 0 trả về KG
    if (transport!.unitType == 0) {
      return 'Kg';
    }

    // Nếu đơn vị 1 trả về Tấn
    if (transport!.unitType == 1) {
      return 'Tấn';
    }

    return 'Kg';
  }

  ///
  /// Get value theo loại hình
  ///
  String getLoaiHinh(int type) {
    if (type == 0) {
      return "Cần gửi người";
    }
    if (type == 1) {
      return "Nhận gửi người";
    }
    if (type == 2) {
      return "Cần gửi hàng";
    }
    return 'Nhận gửi hàng';
  }

  ///
  /// Get value theo loại hình
  ///
  IconData getVehicleIcon(TransportResponse transport) {
    if (IZIValidate.nullOrEmpty(transport) ||
        IZIValidate.nullOrEmpty(transport.idVehicle) ||
        IZIValidate.nullOrEmpty(transport.idVehicle!.name)) {
      return Icons.car_rental;
    }

    final String type = transport.idVehicle!.name.toString();
    if (type.toString().toLowerCase().contains('Xe máy'.toLowerCase())) {
      return Icons.motorcycle_rounded;
    }

    if (type.toString().toLowerCase().contains('Xe 4 chỗ'.toLowerCase())) {
      return Icons.directions_car;
    }

    if (type.toString().toLowerCase().contains('Xe 5 chỗ'.toLowerCase())) {
      return Icons.airport_shuttle;
    }

    if (type.toString().toLowerCase().contains('Xe 7 chỗ'.toLowerCase())) {
      return Icons.airport_shuttle;
    }

    if (type.toString().toLowerCase().contains('Xe 29 chỗ'.toLowerCase())) {
      return Icons.directions_bus;
    }

    if (type.toString().toLowerCase().contains('Xe container'.toLowerCase())) {
      return Icons.local_shipping;
    }

    if (type.toString().toLowerCase().contains('Tàu'.toLowerCase())) {
      return Icons.directions_railway_filled_outlined;
    }

    if (type.toString().toLowerCase().contains('máy bay'.toLowerCase())) {
      return Icons.airplanemode_on_rounded;
    }

    return Icons.directions_car;
  }

  ///
  /// Get value theo loại hình
  ///
  IconData getLoaiHinhIcon(int type) {
    if (type == 0) {
      return CupertinoIcons.person_3_fill;
    }
    if (type == 1) {
      return Icons.chair;
    }
    if (type == 2) {
      return Icons.balance;
    }
    return Icons.shopify_outlined;
  }

  Future<void> onClickButton(BuildContext context) async {
    if (!IZIValidate.nullOrEmpty(transport) &&
        !IZIValidate.nullOrEmpty(transport!.idUser)) {
      if (transport!.idUser!.id!.contains(idUser) && isFromHomePage == false) {
        // showAnimatedDialog(
        //   context,
        //   DialogWidget(
        //     title: "Xác nhận",
        //     description: transport!.isActive == true
        //         ? "Khi bạn đồng ý, thông tin chuyến xe sẽ không còn hiển thị lên trang chủ"
        //         : "Khi bạn đồng ý, thông tin chuyến xe sẽ hiển thị lên trang chủ",
        //     onTapConfirm: () {
        //       onUpdateTransport(isActive: !transport!.isActive!);
        //       Get.back();
        //     },
        //     onTapCancel: () {
        //       Get.back();
        //     },
        //   ),
        // );
      } else {
        if (!IZIValidate.nullOrEmpty(transport!.phone)) {
          await IZIOther.callPhone(phone: transport!.phone!);
        }
      }
    }
  }

  void onUpdateTransport({required bool isActive}) {
    provider.update(
      TransportRequest(),
      id: transport!.id.toString(),
      requestBody: TransportRequest(
        isActive: isActive,
      ),
      onSuccess: (data) {
        transport!.isActive = (data as TransportRequest).isActive;
        update();
        Get.back();
      },
      onError: (onError) {
        print("An error occurred while updating the transport");
      },
    );
  }
}
