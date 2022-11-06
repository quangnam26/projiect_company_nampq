import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import '../../../base_widget/izi_button.dart';
import '../../../base_widget/izi_image.dart';
import '../../../base_widget/izi_input.dart';
import '../components/coupons_widget.dart';
import 'coupons_controller.dart';

class CouponsPage extends GetView<CouponsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: Container(
        color: ColorResources.NEUTRALS_7,
      ),
      safeAreaBottom: false,
      appBar: IZIAppBar(
        title: "",
        colorBG: ColorResources.NEUTRALS_7,
        iconBack: GestureDetector(
          onTap: () {
            controller.onBack();
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: ColorResources.NEUTRALS_4,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          IZIOther.primaryFocus();
        },
        child: Container(
          color: ColorResources.NEUTRALS_7,
          height: IZIDimensions.iziSize.height,
          width: IZIDimensions.iziSize.width,
          child: Column(
            children: [
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_1X,
              ),
              Text(
                'Coupons của bạn ở đây này',
                style: textStyleH5.copyWith(
                  color: ColorResources.NEUTRALS_4,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              Text(
                'Coupons',
                style: textStyleH3.copyWith(
                  color: ColorResources.NEUTRALS_2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_4X,
              ),
              Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 170,
                width: IZIDimensions.ONE_UNIT_SIZE * 170,
                padding: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 50,
                ),
                decoration: const BoxDecoration(
                  color: ColorResources.NEUTRALS_6,
                  shape: BoxShape.circle,
                ),
                child: IZIImage(
                  ImagesPath.coupons,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_4X,
              ),
              appliedCoupons(),
              Expanded(
                child: coupons(),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewPadding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  ///  coupon list
  ///
  Widget coupons() {
    return IZILoaderOverLay(
      loadingWidget: SpinKitWanderingCubes(
        color: ColorResources.PRIMARY_1,
        size: IZIDimensions.ONE_UNIT_SIZE * 80,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.vouchers.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X,
                ),
                Obx(() {
                  return CouponsWidget(
                    onTap: () {
                      controller.onSelecteVoucher(
                        controller.vouchers[index],
                      );
                    },
                    enable: controller.totalPrice > IZINumber.parseDouble(controller.vouchers[index].minOrderPrice),
                    bg: controller.vouchers[index].id == controller.voucher.value.id
                        ? ColorResources.PRIMARY_3
                        : controller.totalPrice > IZINumber.parseDouble(controller.vouchers[index].minOrderPrice)
                            ? null
                            : ColorResources.NEUTRALS_5,
                    code: controller.vouchers[index].code.toString(),
                    description: controller.vouchers[index].name.toString(),
                    expiration: IZIDate.formatDate(DateTime.fromMillisecondsSinceEpoch(controller.vouchers[index].toDate!)),
                    width: IZIDimensions.iziSize.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_2X,
                    ),
                  );
                }),
              ],
            );
          },
        );
      }),
    );
  }

  ///
  /// bill
  ///
  Widget appliedCoupons() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Row(
        children: [
          Expanded(
            child: IZIInput(
              type: IZIInputType.TEXT,
              placeHolder: 'Nhập mã giảm giá ở đây',
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
              onChanged: (val) {
                controller.code = val;
              },
            ),
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_3X,
          ),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 90,
            ),
            child: IZIButton(
              onTap: () {
                controller.huntVoucher();
              },
              padding: EdgeInsets.symmetric(
                horizontal: IZIDimensions.SPACE_SIZE_3X,
                vertical: IZIDimensions.SPACE_SIZE_3X,
              ),
              width: IZIDimensions.ONE_UNIT_SIZE * 200,
              borderRadius: 5,
              label: "Áp dụng",
            ),
          ),
        ],
      ),
    );
  }

  /// Bill
  Widget billContent({required String title, required double double, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyleH6.copyWith(
            color: color ?? ColorResources.NEUTRALS_2,
          ),
        ),
        Text(
          '${IZIPrice.currencyConverterVND(double)}đ',
          style: textStyleH6.copyWith(
            color: color ?? ColorResources.NEUTRALS_4,
          ),
        ),
      ],
    );
  }

  ///
  /// address
  ///
  Widget address() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
        vertical: IZIDimensions.SPACE_SIZE_2X,
      ),
      color: ColorResources.WHITE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Giao bởi tài xế",
                style: textStyleH6.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Thay đổi",
                style: textStyleH6.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: SizedBox(
                  height: IZIDimensions.ONE_UNIT_SIZE * 100,
                  width: IZIDimensions.ONE_UNIT_SIZE * 100,
                  child: IZIImage(
                    ImagesPath.shipper,
                  ),
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "123 Châu Thị Vĩnh Tế, Mỹ An, Ngũ Hành Sơn",
                            maxLines: 2,
                            style: textStyleH5.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorResources.NEUTRALS_1,
                            ),
                          ),
                          Text(
                            "123 Châu Thị Vĩnh Tế, Mỹ An, Ngũ Hành Sơn",
                            maxLines: 2,
                            style: textStyleH6.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorResources.NEUTRALS_4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorResources.NEUTRALS_4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
