import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/data/model/district/district_response.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/screen/news/news_controller.dart';
import '../../../base_widget/izi_button.dart';
import '../../../base_widget/izi_drop_down_button.dart';
import '../../../base_widget/izi_image.dart';
import '../../../base_widget/izi_input.dart';
import '../../../data/model/province/province_response.dart';
import '../../../data/model/vehicle/vehicle_response.dart';
import '../../../data/model/village/vilage_response.dart';
import '../../../utils/color_resources.dart';

class NewsPage extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      appBar: const IZIAppBar(
        title: "Thêm mới",
        colorTitle: ColorResources.WHITE,
        iconBack: SizedBox(),
      ),
      background: const BackgroundAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder(
          builder: (NewsController controller) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: IZIDimensions.SPACE_SIZE_2X,
              ),
              height: IZIDimensions.iziSize.height,
              width: IZIDimensions.iziSize.width,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        loaiHinh(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        tinhTp(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        quanHuyen(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        phuongXa(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        diaChiCuTheNoiDi(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        tinhTpDen(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        quanHuyenDen(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        phuongXaDen(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        diaChiCuTheDen(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        gioDi(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        ngayDi(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        // Nếu Cần xe =>  số người cần đi
                        // Đi chung => loại xe và Số ghế còn trống
                        // Cần chở đồ =>  Số ký cần chở
                        // Cho chở đồ =>  Loại xe chờ và số ký có thể chở.
                        // if (controller.loaiHinh == 'Đi chung' || controller.loaiHinh == 'Cho gửi đồ') loaiXe(),
                        if (controller.loaiHinhKey == 1 ||
                            controller.loaiHinhKey == 3)
                          loaiXe(),

                        if (

                        // controller.loaiHinh == 'Đi chung' ||
                        //   controller.loaiHinh == 'Cho gửi đồ'
                        controller.loaiHinhKey == 1 ||
                            controller.loaiHinhKey == 3)
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_4X,
                          ),

                        if (controller.loaiHinhKey == 1) soGheConTrong(),
                        if (controller.loaiHinhKey == 1)
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_4X,
                          ),

                        if (controller.loaiHinhKey == 2) soKyCanCho(),
                        if (controller.loaiHinhKey == 2)
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_4X,
                          ),

                        if (controller.loaiHinhKey == 3) soKyCoTheCho(),
                        if (controller.loaiHinhKey == 3)
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_4X,
                          ),

                        if (controller.loaiHinhKey == 0) soNguoiCanDi(),
                        if (controller.loaiHinhKey == 0)
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_4X,
                          ),
                        phoneInput(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        moTaInput(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        image(),
                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 50,
                        ),
                        insertTrainButton(),
                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget image() {
    return SizedBox(
      width: IZIDimensions.iziSize.width,
      child: GestureDetector(
        onTap: () {
          controller.pickImage();
        },
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Hình ảnh",
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w400,
                  color: ColorResources.NEUTRALS_4,
                ),
              ),
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_1X,
            ),
            if (IZIValidate.nullOrEmpty(controller.imageUploaded.value))
              Container(
                padding: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 50,
                ),
                decoration: BoxDecoration(
                  color: ColorResources.NEUTRALS_7,
                  border: Border.all(
                    color: ColorResources.NEUTRALS_4,
                  ),
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BORDER_RADIUS_2X,
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.add,
                      color: ColorResources.NEUTRALS_3,
                    ),
                    Text(
                      'Upload',
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.NEUTRALS_4,
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 290,
                width: IZIDimensions.iziSize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BORDER_RADIUS_4X,
                  ),
                ),
                child: Obx(() {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_3X,
                    ),
                    child: IZIImage(controller.imageUploaded.value),
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }

  // Loai hình
  Widget loaiHinh() {
    return DropDownButton<String>(
      data: controller.loaiHinhs.keys.cast<String>().toList(),
      onChanged: (val) {
        controller.onChangedLoaiHinh(val!);
      },
      isRequired: true,
      isSort: false,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      value: controller.loaiHinh,
      hint: "Chọn loại hình",
      label: "Chọn loại hình",
      width: IZIDimensions.iziSize.width,
    );
  }

  // Tinh/tp di
  Widget tinhTp() {
    return DropDownButton<ProvinceResponse>(
      isSort: false,
      data: controller.listProvince,
      onChanged: (val) => controller.onChangedProvinceFrom(val!),
      isRequired: true,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      value: controller.provinceNameSelectedFrom,
      hint: "Tỉnh/TP đi",
      label: "Tỉnh/TP đi",
      width: IZIDimensions.iziSize.width,
    );
  }

  // Quận/huyện đi  *
  Widget quanHuyen() {
    return DropDownButton<DistrictResponse>(
      isSort: false,
      data: controller.listDistrictFrom,
      onChanged: (val) => controller.onChangedDistrictFrom(val!),
      isRequired: true,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      value: controller.districtNameSelectedFrom,
      hint: "Quận/huyện đi",
      label: "Quận/huyện đi",
      width: IZIDimensions.iziSize.width,
    );
  }

  // Phường/xã đi  *
  Widget phuongXa() {
    return DropDownButton<VillageResponse>(
      data: controller.listVillageFrom,
      onChanged: (val) => controller.onChangedVillageFrom(val!),
      isRequired: true,
      isSort: false,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      value: controller.villageSelectedFrom,
      hint: "Phường/xã đi",
      label: "Phường/xã đi",
      width: IZIDimensions.iziSize.width,
    );
  }

  // Địa chỉ cụ thể  nơi đi
  Widget diaChiCuTheNoiDi() {
    return IZIInput(
      onChanged: (val) {
        controller.addressFrom = val;
      },
      type: IZIInputType.TEXT,
      label: 'Địa chỉ cụ thể nơi đi',
      placeHolder: 'Địa chỉ cụ thể nơi đi',
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      isResfreshForm: controller.isClearForm,
      disbleError: true,
      isRequired: true,
      isNotShadown: false,
    );
  }

  // Tỉnh/Tp đến
  Widget tinhTpDen() {
    return DropDownButton<ProvinceResponse>(
      data: controller.listProvince,
      onChanged: (val) => controller.onChangedProvinceTo(val!),
      isRequired: true,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      value: controller.provinceNameSelectedTo,
      hint: "Tỉnh/Tp đến",
      label: "Tỉnh/Tp đến",
      width: IZIDimensions.iziSize.width,
    );
  }

  // Quận/huyện đến
  Widget quanHuyenDen() {
    return DropDownButton<DistrictResponse>(
      data: controller.listDistrictTo,
      onChanged: (val) => controller.onChangedDistrictTo(val!),
      isRequired: true,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      value: controller.districtNameSelectedTo,
      hint: "Quận/huyện đến",
      label: "Quận/huyện đến",
      width: IZIDimensions.iziSize.width,
    );
  }

  // Phường/xã đến  *
  Widget phuongXaDen() {
    return DropDownButton<VillageResponse>(
      data: controller.listVillageTo,
      onChanged: (val) => controller.onChangedVillageTo(val!),
      isRequired: true,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      value: controller.villageSelectedTo,
      hint: "Phường/xã đến",
      label: "Phường/xã đến",
      width: IZIDimensions.iziSize.width,
    );
  }

  // Địa chỉ cụ thể nơi đến
  Widget diaChiCuTheDen() {
    return IZIInput(
      onChanged: (val){
        controller.addressTo = val;
      },
      type: IZIInputType.TEXT,
      label: 'Địa chỉ cụ thể nơi đến',
      placeHolder: 'Địa chỉ cụ thể nơi đến',
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      isResfreshForm: controller.isClearForm,
      disbleError: true,
      isRequired: true,
      isNotShadown: false,
    );
  }

  ///
  /// Giở đi
  ///
  Widget gioDi() {
    return IZIInput(
      onChanged: (val) {
        controller.timeStart = val;
      },
      type: IZIInputType.TEXT,
      label: 'Giờ đi',
      placeHolder: 'Chọn giờ đi',
      isTimePicker: true,
      isDatePicker: true,
      iziPickerDate: IZIPickerDate.CUPERTINO,
      suffixIcon: const Icon(
        Icons.timer,
      ),
      isResfreshForm: controller.isClearForm,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      disbleError: true,
      isRequired: true,
      isNotShadown: false,
    );
  }

  ///
  /// Ngày đi
  ///
  Widget ngayDi() {
    return IZIInput(
      onChanged: (val) {
        controller.dateStart = val;
      },
      type: IZIInputType.TEXT,
      label: 'Ngày đi ',
      placeHolder: 'Chọn ngày đi',
      isDatePicker: true,
      suffixIcon: const Icon(
        Icons.calendar_month,
      ),
      isResfreshForm: controller.isClearForm,
      iziPickerDate: IZIPickerDate.CUPERTINO,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      disbleError: true,
      isRequired: true,
      isNotShadown: false,
    );
  }

  ///
  /// Số người cần đi
  ///
  Widget soNguoiCanDi() {
    return IZIInput(
      type: IZIInputType.NUMBER,
      label: 'Số người cần đi',
      placeHolder: 'Nhập vào số người',
      isResfreshForm: controller.isClearForm,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      disbleError: true,
      isRequired: true,
      isNotShadown: false,
      onChanged: (val) {
        controller.numberPeople = IZINumber.parseInt(val);
      },
    );
  }

  ///
  /// Số ghế còn trống
  ///
  Widget soGheConTrong() {
    return IZIInput(
      type: IZIInputType.NUMBER,
      label: 'Số ghế còn trống',
      placeHolder: 'Nhập vào số ghế còn trống',
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      isResfreshForm: controller.isClearForm,
      disbleError: true,
      isRequired: true,
      isNotShadown: false,
      onChanged: (val) {
        controller.numberEmptySeats = IZINumber.parseInt(val);
      },
    );
  }

  ///
  /// Số ký cần chờ
  ///
  Widget soKyCanCho() {
    return IZIInput(
      type: IZIInputType.DOUBLE,
      label: 'Số ký cần chở',
      placeHolder: 'Nhập vào số ký cần chờ',
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      isResfreshForm: controller.isClearForm,
      disbleError: true,
      isRequired: true,
      isNotShadown: false,
      onChanged: (val) {
        controller.soKyCanCho = IZINumber.parseDouble(val.replaceAll(',', '.'));
      },
    );
  }

  ///
  /// Số ký có thể chờ
  ///
  Widget soKyCoTheCho() {
    return IZIInput(
      type: IZIInputType.DOUBLE,
      label: 'Số ký có thể chở',
      placeHolder: 'Nhập vào số ký có thể chờ',
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      isResfreshForm: controller.isClearForm,
      disbleError: true,
      isRequired: true,
      isNotShadown: false,
      onChanged: (val) {
        controller.soKyCoTheCho =
            IZINumber.parseDouble(val.replaceAll(',', '.'));
      },
    );
  }

  // Loại xe
  Widget loaiXe() {
    return DropDownButton<VehicleResponse>(
      data: controller.listVehicle,
      onChanged: (val) {
        controller.onChangeVehicleType(val!);
      },
      isRequired: true,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      value: controller.vehicleSelected,
      hint: "Chọn loại xe",
      label: "Loại xe",
      width: IZIDimensions.iziSize.width,
    );
  }

  ///
  /// Phone
  ///
  Widget phoneInput() {
    return IZIInput(
      type: IZIInputType.PHONE,
      onChanged: (val){
        controller.phone = val;
      },
      label: 'Số điện thoại',
      placeHolder: '0352972441',
      suffixIcon: const Icon(
        Icons.phone,
      ),
      isResfreshForm: controller.isClearForm,
      isRequired: true,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      disbleError: true,
      isNotShadown: false,
    );
  }

  ///
  /// moTa
  ///
  Widget moTaInput() {
    return IZIInput(
      onChanged: (val){
        controller.description = val;
      },
      type: IZIInputType.MILTIPLINE,
      label: 'Mô tả',
      placeHolder: 'Nhập vào mô tả',
      isResfreshForm: controller.isClearForm,
      maxLine: 4,
      borderRadius: 5,
      disbleError: true,
      isNotShadown: false,
    );
  }

  Widget insertTrainButton() {
    return IZIButton(
      onTap: () => controller.createTransport(),
      label: "Thêm chuyến",
      borderRadius: 10,
    );
  }
}
