import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/district/district_response.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/transport/transport_resquest.dart';
import 'package:template/data/model/vehicle/vehicle_response.dart';
import 'package:template/data/model/village/vilage_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/view/screen/home/home_controller.dart';
import '../../../data/model/provider/provider.dart';
import '../../../di_container.dart';
import '../../../helper/izi_alert.dart';
import '../../../helper/izi_validate.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../../../utils/app_constants.dart';
import '../dash_board/dash_board_controller.dart';

class NewsController extends GetxController {
  final RefreshController refreshController = RefreshController();
  final Provider provider = Provider();
  String idUser = '';

  Map<String, int> loaiHinhs = {
    "Cần xe": 0,
    "Đi chung": 1,
    "Gửi đồ": 2,
    "Cho gửi đồ": 3,
  };

  RxString imageUploaded = ''.obs;
  String? loaiHinh;
  int? loaiHinhKey;
  bool? isClearForm = false;


  List<ProvinceResponse> listProvince = [];

  // Tỉnh/Tp Đi
  ProvinceResponse? provinceNameSelectedFrom;

  // Tỉnh/Tp Đến
  ProvinceResponse? provinceNameSelectedTo;

  // Quận,Huyện Đi
  List<DistrictResponse> listDistrictFrom = [];
  DistrictResponse? districtNameSelectedFrom;

  // Quận,Huyện Đến
  List<DistrictResponse> listDistrictTo = [];
  DistrictResponse? districtNameSelectedTo;

  // Phường,xã Đi
  List<VillageResponse> listVillageFrom = [];
  VillageResponse? villageSelectedFrom;

  // Phường,xã Đến
  List<VillageResponse> listVillageTo = [];
  VillageResponse? villageSelectedTo;

//  Loai Xe
  List<VehicleResponse> listVehicle = [];
  VehicleResponse? vehicleSelected;

  String? phone;
  String? description;
  String? addressFrom;
  String? addressTo;
  String? timeStart, dateStart, timeEnd, dateEnd;
  int numberPeople = 0, numberEmptySeats = 0;
  double soKyCanCho = 0;
  double soKyCoTheCho = 0;

  @override
  void onInit() {
    idUser = sl<SharedPreferenceHelper>().getProfile;
    loadProvince();
    loadVehicle();
    super.onInit();
  }

  ///
  /// thay đổi loại hình vận chuyển
  ///
  void onChangedLoaiHinh(String loaiHinhSelected) {
    loaiHinh = loaiHinhSelected;
    if (loaiHinhs.containsKey(loaiHinhSelected)) {
      loaiHinhKey = loaiHinhs[loaiHinhSelected];
    }
    update();
  }

  ///
  /// Load all tỉnh/tp
  ///
  void loadProvince() {
    provider.all(
      ProvinceResponse(),
      onSuccess: (list) {
        listProvince.clear();
        listProvince.addAll(list.cast<ProvinceResponse>());
        update();
      },
      onError: (err) {},
    );
  }

  ///
  /// thay đổi Tỉnh/Tp Đi
  ///
  void onChangedProvinceFrom(ProvinceResponse newProvider) {
    provinceNameSelectedFrom = newProvider;

    loadDistrictFrom();

    update();
  }

  ///
  /// thay đổi Tỉnh/Tp đến
  ///
  void onChangedProvinceTo(ProvinceResponse newProvider) {
    provinceNameSelectedTo = newProvider;
    loadDistrictTo();
    update();
  }

  ///
  /// load Quận/Huyện Đi theo Tỉnh/Tp Đi đã lựa chọn
  ///
  void loadDistrictFrom() {
    districtNameSelectedFrom = null;
    listDistrictFrom = [];
    if (districtNameSelectedFrom == null) {
      villageSelectedFrom = null;
      listVillageFrom = [];
    }
    provider.paginate(
      DistrictResponse(),
      page: 1,
      limit: 30,
      filter: '&idProvince=${provinceNameSelectedFrom!.id}&populate=idProvince',
      onSuccess: (data) {
        listDistrictFrom.clear();
        listDistrictFrom.addAll(data.cast<DistrictResponse>());
        update();
      },
      onError: (onError) {
        print("An error occurred while $onError");
      },
    );
  }

  ///
  /// load Quận/Huyện Đi theo Tỉnh/Tp Đi đã lựa chọn
  ///
  void loadDistrictTo() {
    districtNameSelectedTo = null;
    listDistrictTo = [];
    if (districtNameSelectedTo == null) {
      villageSelectedTo = null;
      listVillageTo = [];
    }
    provider.paginate(
      DistrictResponse(),
      page: 1,
      limit: 30,
      filter: '&idProvince=${provinceNameSelectedTo!.id}&populate=idProvince',
      onSuccess: (data) {
        listDistrictTo.cast();
        listDistrictTo.addAll(data.cast<DistrictResponse>());
        update();
      },
      onError: (onError) {
        print("An error occurred while $onError");
      },
    );
  }

  ///
  /// thay đổi lựa chọn Quận/Huyện đi
  ///
  void onChangedDistrictFrom(DistrictResponse newDistrict) {
    districtNameSelectedFrom = newDistrict;
    loadVillageFrom();
    update();
  }

  ///
  /// thay đổi lựa chọn Quận/Huyện đến
  ///
  void onChangedDistrictTo(DistrictResponse newDistrict) {
    districtNameSelectedTo = newDistrict;
    loadVillageTo();
    update();
  }

  ///
  /// load Phường/Xã Đi theo Quận/huyện Đi đã lựa chọn
  ///
  void loadVillageFrom() {
    provider.paginate(
      VillageResponse(),
      page: 1,
      limit: 30,
      filter:
          '&idDistrict=${districtNameSelectedFrom!.id}&populate=idDistrict.idProvince',
      onSuccess: (data) {
        listVillageFrom.clear();
        listVillageFrom.addAll(data.cast<VillageResponse>());
        update();
      },
      onError: (onError) {
        print("An error occurred while $onError");
      },
    );
  }

  ///
  /// load Phường/Xã Đi theo Quận/huyện đến đã lựa chọn
  ///
  void loadVillageTo() {
    provider.paginate(
      VillageResponse(),
      page: 1,
      limit: 30,
      filter:
          '&idDistrict=${districtNameSelectedTo!.id}&populate=idDistrict.idProvince',
      onSuccess: (data) {
        listVillageTo.clear();
        listVillageTo.addAll(data.cast<VillageResponse>());
        update();
      },
      onError: (onError) {
        print("An error occurred while $onError");
      },
    );
  }

  ///
  /// thay đổi lựa chọn Phường/xã Đi
  ///
  void onChangedVillageFrom(VillageResponse newVillage) {
    villageSelectedFrom = newVillage;
    update();
  }

  ///
  /// thay đổi lựa chọn Phường/xã đến
  ///
  void onChangedVillageTo(VillageResponse newVillage) {
    villageSelectedTo = newVillage;
    update();
  }

  




  ///
  /// Pick image
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      provider.uploadImage(
        files: [imageTemporary],
        onSuccess: (data) {
          if (!IZIValidate.nullOrEmpty(data)) {
            imageUploaded.value = "$BASE_URL_IMAGE/static/${data.files!.first}";
            update();
          }
        },
        onError: (onError) {
          EasyLoading.dismiss();
          print("An error occurred while uploading the image $onError");
        },
      );
      EasyLoading.dismiss();
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      IZIAlert.error(message: 'Bạn phải cho phép quyền truy cập hệ thống');
      IZIOther.openAppSettings();
    }
  }

  ///
  /// Load all loại xe
  ///
  void loadVehicle() {
    provider.all(
      VehicleResponse(),
      onSuccess: (list) {
        listVehicle.clear();
        listVehicle.addAll(list.cast<VehicleResponse>());
        update();
      },
      onError: (err) {
        print("Error: $err");
      },
    );
  }

  ///
  /// refresh form
  ///
  void clearForm() {
    loaiHinh = null;
    loaiHinhKey = null;
    provinceNameSelectedFrom = null;
    provinceNameSelectedTo = null;
    districtNameSelectedFrom = null;
    districtNameSelectedTo = null;
    villageSelectedFrom = null;
    villageSelectedTo = null;
    vehicleSelected = null;
    phone = '';
    description = '';
    addressFrom = '';
    addressTo = '';
    timeStart = '';
    dateStart = '';
    timeEnd = '';
    dateEnd = '';
    numberPeople = 0;
    numberEmptySeats = 0;
    soKyCanCho = 0;
    soKyCoTheCho = 0;
    imageUploaded.value = '';
    isClearForm = true;
    update();
    isClearForm = false;
  }

  ///
  /// thay đổi lựa chọn loại xe
  ///
  void onChangeVehicleType(VehicleResponse newVehicleType) {
    vehicleSelected = newVehicleType;
    update();
  }

  void createTransport() {
    if (isValidateValidAddNew()) {
      if (!IZIValidate.nullOrEmpty(
          imageUploaded.value.replaceAll('$BASE_URL_IMAGE/static/', ''))) {
        provider.uploadImage(
          files: [],
          endPoint:
              imageUploaded.value.replaceAll('$BASE_URL_IMAGE/static/', ''),
          method: IZIMethod.GET,
          onSuccess: (data) {
            if (!IZIValidate.nullOrEmpty(data) && !IZIValidate.nullOrEmpty(data.files)) {
              imageUploaded.value = "$BASE_URL_IMAGE/static/${data.files!.first}";
              addTrans();
            }
          },
          onError: (onError) {
            print("An error occurred while uploading the user $onError");
          },
        );
      } else {
        addTrans();
      }
    }
  }

  ///
  /// them moi
  ///
  void addTrans() {
    if (isValidateValidAddNew()) {
      // final dataStart = DateFormat("dd-MM-yyyy").parse(dateStart!);
      final dataStart = IZIDate.parse(dateStart!);
      // print("${dataStart.year} - ${dataStart.month} - ${dataStart.day}");
      final newTransport = TransportRequest(
        idUser: idUser,
        transportType: loaiHinhKey,
        idProvinceFrom: provinceNameSelectedTo!.id,
        idProvinceTo: provinceNameSelectedFrom!.id,
        idDistrictFrom: districtNameSelectedFrom!.id,
        idDistrictTo: districtNameSelectedTo!.id,
        idVillageFrom: villageSelectedFrom!.id,
        idVillageTo: villageSelectedTo!.id,
        addressFrom: addressFrom,
        addressTo: addressTo,
        timeStart: timeStart != null
            ? DateFormat("hh:mm").parse(timeStart!).millisecondsSinceEpoch
            : 0,
        dateStart: dateStart != null
            ? DateTime(
                    dataStart.year,
                    dataStart.month,
                    dataStart.day,
                    DateTime.now().hour,
                    DateTime.now().minute,
                    DateTime.now().second)
                .millisecondsSinceEpoch
            : 0,
        timeEnd: timeStart != null
            ? DateFormat("hh:mm").parse(timeStart!).millisecondsSinceEpoch
            : 0, //timeEnd chưa có
        dateEnd: dateStart != null
            ? DateFormat("dd-MM-yyyy").parse(dateStart!).millisecondsSinceEpoch
            : 0, //dateEnd chưa có
        phone: phone,
        numberPeople: loaiHinhKey == 0 ? numberPeople : 0,
        numberEmptySeats: loaiHinhKey == 1 ? numberEmptySeats : 0,
        numberSeats: IZIValidate.nullOrEmpty(vehicleSelected)
            ? 0
            : vehicleSelected!.numberSheat,
        maxNetWeight: soKyCoTheCho,
        netWeight: soKyCanCho,
        isActive: true,
        idVehicle: (loaiHinhKey == 1 || loaiHinhKey == 3)
            ? IZIValidate.nullOrEmpty(vehicleSelected)
                ? null
                : vehicleSelected!.id
            : null,
        description: description,
        images: IZIValidate.nullOrEmpty(imageUploaded.value) ? null : [imageUploaded.value],
      );

      provider.add(
        TransportRequest(),
        requestBody: newTransport,
        onSuccess: (success) {
          print(success);
          IZIAlert.success(message: "Thêm chuyến thành công");
          clearForm();
          final dashController = Get.find<DashBoardController>();
          final homeController = Get.find<HomeController>();
          dashController.onChangedPage(0);
          homeController.onRefresh();
        },
        onError: (onError) {
          print("An error occurred while processing the request $onError");
        },
      );
    }
  }

  ///
  /// Check validate
  ///
  /// if [true] form valid else invalid
  ///
  /// @return bool
  ///
  bool isValidateValidAddNew() {
    if (IZIValidate.nullOrEmpty(loaiHinhKey)) {
      IZIAlert.error(message: "Vui lòng chọn loại hình");
      return false;
    }
    if (IZIValidate.nullOrEmpty(provinceNameSelectedFrom)) {
      IZIAlert.error(message: "Tỉnh/Tp đi không được để trống");
      return false;
    }
    if (IZIValidate.nullOrEmpty(districtNameSelectedFrom)) {
      IZIAlert.error(message: "Quận/Huyện Đi không được để trống");
      return false;
    }
    if (IZIValidate.nullOrEmpty(villageSelectedFrom)) {
      IZIAlert.error(message: "Phường/Xã Đi không được để trống");
      return false;
    }
    if (IZIValidate.nullOrEmpty(addressFrom)) {
      IZIAlert.error(message: "Địa chỉ Đi không được để trống");
      return false;
    }
    if (IZIValidate.nullOrEmpty(provinceNameSelectedTo)) {
      IZIAlert.error(message: "Tỉnh/Tp đến không được để trống");
      return false;
    }

    if (IZIValidate.nullOrEmpty(districtNameSelectedTo)) {
      IZIAlert.error(message: "Quận/Huyện Đến không được để trống");
      return false;
    }

    if (IZIValidate.nullOrEmpty(villageSelectedTo)) {
      IZIAlert.error(message: "Phường/Xã Đến không được để trống");
      return false;
    }

    if (IZIValidate.nullOrEmpty(addressTo)) {
      IZIAlert.error(message: "Địa chỉ Đến không được để trống");
      return false;
    }
    if (IZIValidate.nullOrEmpty(timeStart)) {
      IZIAlert.error(message: "Thời gian Đi không được để trống");
      return false;
    }

    if (loaiHinhKey == 0) {
      if (IZIValidate.nullOrEmpty(numberPeople) || numberPeople == 0) {
        IZIAlert.error(message: "Số người cần đi không được để trống");
        return false;
      }
    }

    if (loaiHinhKey == 1) {
      if (IZIValidate.nullOrEmpty(numberEmptySeats) || numberEmptySeats == 0) {
        IZIAlert.error(message: "Số ghế còn trống không được để trống");
        return false;
      }
      if (IZIValidate.nullOrEmpty(vehicleSelected)) {
        IZIAlert.error(message: "Loại xe không được để trống");
        return false;
      }
    }

    if (loaiHinhKey == 2) {
      if (IZIValidate.nullOrEmpty(soKyCanCho) || soKyCanCho == 0) {
        IZIAlert.error(message: "Số ký cần chở không được để trống");
        return false;
      }
    }

    if (loaiHinhKey == 3) {
      if (IZIValidate.nullOrEmpty(vehicleSelected)) {
        IZIAlert.error(message: "Loại xe không được để trống");
        return false;
      }
      if (IZIValidate.nullOrEmpty(soKyCoTheCho) || soKyCoTheCho == 0) {
        IZIAlert.error(message: "Số ký có thể chở không được để trống");
        return false;
      }
    }

    if (IZIValidate.nullOrEmpty(phone)) {
      IZIAlert.error(message: "Số điện thoại không được để trống");
      return false;
    } else if (IZIValidate.phone(phone!) != null) {
      IZIAlert.error(message: IZIValidate.phone(phone!).toString());
      return false;
    }

    return true;
  }
}
