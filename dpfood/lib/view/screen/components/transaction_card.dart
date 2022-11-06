import 'package:flutter/material.dart';

import '../../../base_widget/izi_image.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../helper/izi_validate.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/images_path.dart';

enum IZIStatusPayment {
  AWAIT,
  DONE,
  FAIL,
}

enum IZIStatusMoney {
  DRAW,
  RECHARGE,
  PLUS,
}

enum IZITYPEPAYMENT { THANH_TOAN_DICH_VU, NAP_VAO_RUT }

enum IZIStatus {
  SUCCESS,
  FAIL,
  NONE,
}

class TransactionCard extends StatelessWidget {
  TransactionCard({
    Key? key,
    this.row1Left,
    this.row1Right,
    this.row2Left,
    this.row2Right,
    this.row3Left,
    this.statusMoney,
    this.onTap,
    this.marginCard,
    this.radiusCard,
    this.colorBG,
    this.statusPayment,
    this.statusTypePayment = IZITYPEPAYMENT.THANH_TOAN_DICH_VU,
    this.status = IZIStatus.NONE,
  }) : super(key: key);

  final String? row1Left;
  final String? row1Right;
  final String? row2Left;
  final String? row2Right;
  final String? row3Left;
  final Function? onTap;
  final EdgeInsets? marginCard;
  final Color? colorBG;
  final double? radiusCard;
  IZIStatusMoney? statusMoney;
  IZIStatusPayment? statusPayment;
  IZITYPEPAYMENT? statusTypePayment;
  IZIStatus status;

  Widget getTypePayment() {
    if (statusTypePayment == IZITYPEPAYMENT.THANH_TOAN_DICH_VU) {
      return Column(
        children: [
          if (!IZIValidate.nullOrEmpty(row3Left))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!IZIValidate.nullOrEmpty(row3Left))
                  Expanded(
                    child: Row(
                      children: [
                        IZIText(
                          text: row3Left.toString(),
                          maxLine: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: ColorResources.NEUTRALS_2,
                          ),
                        ),
                        SizedBox(
                          width: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        getStatusPayment(statusPayment!),
                      ],
                    ),
                  ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_1X,
                ),
                // Tiền
                getStatusMoney(statusMoney!)
              ],
            ),
        ],
      );
    }
    // Nạp vào rút tiền
    return Column(
      children: [
        if (!IZIValidate.nullOrEmpty(row3Left))
          if (!IZIValidate.nullOrEmpty(row3Left))
            Column(
              children: [
                Row(
                  children: [
                    IZIText(
                      text: row3Left.toString(),
                      maxLine: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: ColorResources.NEUTRALS_2,
                      ),
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_1X,
                    ),
                  ],
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_1X * 0.9,
                ),
                // Tiền
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getStatusPayment(statusPayment!),
                    getStatusMoney(statusMoney!),
                  ],
                )
              ],
            ),
      ],
    );
  }

  Widget getStatusPayment(IZIStatusPayment statusPayment) {
    if (statusPayment == IZIStatusPayment.DONE) {
      return const IZIText(
        text: "Thành công",
        style: TextStyle(
          color: ColorResources.GREEN,
          fontWeight: FontWeight.w400,
        ),
        maxLine: 1,
        textAlign: TextAlign.end,
      );
    } else if (statusPayment == IZIStatusPayment.FAIL) {
      return const IZIText(
        text: "Thất bại",
        style: TextStyle(
          color: ColorResources.RED,
          fontWeight: FontWeight.w400,
        ),
        maxLine: 1,
        textAlign: TextAlign.end,
      );
    }
    return const IZIText(
      text: "Đang chờ",
      style: TextStyle(
        color: ColorResources.ORANGE,
        fontWeight: FontWeight.w400,
      ),
      maxLine: 1,
      textAlign: TextAlign.end,
    );
  }

  ///
  /// Số tiền rút và nạp , thanh toán
  ///
  Widget getStatusMoney(IZIStatusMoney statusPrice) {
    if (statusPrice == IZIStatusMoney.DRAW && !IZIValidate.nullOrEmpty(row2Left)) {
      return IZIText(
        text: IZIStatus.SUCCESS == status &&  statusPayment == IZIStatusPayment.DONE ? "- ${row2Left.toString()}đ" : "${row2Left.toString()}đ",
        style: TextStyle(color: backgroundStatus(), fontWeight: FontWeight.w700, fontSize: IZIDimensions.FONT_SIZE_H6),
        maxLine: 1,
        textAlign: TextAlign.start,
      );
    } else if (statusPrice == IZIStatusMoney.RECHARGE && !IZIValidate.nullOrEmpty(row2Left)) {
      return IZIText(
        text: IZIStatus.SUCCESS == status &&  statusPayment == IZIStatusPayment.DONE ? "+ ${row2Left.toString()}đ" : "${row2Left.toString()}đ",
        style: TextStyle(color: backgroundStatus(), fontWeight: FontWeight.w700, fontSize: IZIDimensions.FONT_SIZE_H6),
        maxLine: 1,
        textAlign: TextAlign.start,
      );
    } else if (statusPrice == IZIStatusMoney.PLUS && !IZIValidate.nullOrEmpty(row2Left)) {
      return IZIText(
        text: "${row2Left.toString()}đ",
        style: TextStyle(color: backgroundStatus(), fontWeight: FontWeight.w700, fontSize: IZIDimensions.FONT_SIZE_H6),
        maxLine: 1,
        textAlign: TextAlign.start,
      );
    }
    return const SizedBox();
  }

  ///
  /// Hình ảnh trạng thái
  ///
  Widget imageStatus() {
    if (statusMoney == IZIStatusMoney.DRAW) {
      return borderLable(
        child: IZIImage(
          ImagesPath.THANH_TOAN,
          height: IZIDimensions.ONE_UNIT_SIZE * 70,
          width: IZIDimensions.ONE_UNIT_SIZE * 75,
          colorIconsSvg: ColorResources.PRIMARY_2,
          fit: BoxFit.contain,
        ),
        status: IZIStatusMoney.DRAW,
      );
    } else if (statusMoney == IZIStatusMoney.PLUS) {
      return borderLable(
        child: IZIImage(
          ImagesPath.THANH_TOAN,
          height: IZIDimensions.ONE_UNIT_SIZE * 70,
          width: IZIDimensions.ONE_UNIT_SIZE * 75,
          colorIconsSvg: ColorResources.PRIMARY_1,
          fit: BoxFit.contain,
        ),
        status: IZIStatusMoney.PLUS,
      );
    }
    return borderLable(
      child: IZIImage(
        ImagesPath.NAP_TIEN_VAO_VI,
        height: IZIDimensions.ONE_UNIT_SIZE * 70,
        width: IZIDimensions.ONE_UNIT_SIZE * 75,
        colorIconsSvg: ColorResources.PRIMARY_3,
        fit: BoxFit.contain,
      ),
      status: IZIStatusMoney.RECHARGE,
    );
  }

  ///
  /// Border của trạng thái
  ///
  Widget borderLable({required Widget child, required IZIStatusMoney status}) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_2X,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xffD4D4D6)),
          ),
          child: child,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 50,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: iconStatus(),
          ),
        )
      ],
    );
  }

  ///
  /// Icon trạng thái
  ///
  IZIImage iconStatus() {
    if (statusPayment == IZIStatusPayment.FAIL) {
      return IZIImage("assets/images/Artboard_20.png", width: 20, height: 20);
    } else if (statusPayment == IZIStatusPayment.AWAIT) {
      return IZIImage("assets/images/Artboard_21.png", width: 20, height: 20);
    }
    return IZIImage("assets/images/Artboard_19.png", width: 20, height: 20);
  }

  ///
  /// Màu nền của icon trạng thái
  ///
  Color backgroundStatus() {
    if (statusPayment == IZIStatusPayment.FAIL) {
      return ColorResources.RED;
    } else if (statusPayment == IZIStatusPayment.AWAIT) {
      return ColorResources.ORANGE;
    }
    return ColorResources.GREEN;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!IZIValidate.nullOrEmpty(onTap)) {
          onTap!();
        }
      },
      child: Container(
        margin: marginCard ??
            EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_1X,
            ),
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_1X,
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 0.25, color: Color(0xffEAEAEA)),
          color: colorBG ?? ColorResources.WHITE,
        ),
        child: Row(
          children: [
            Container(
              height: IZIDimensions.ONE_UNIT_SIZE * 70,
              width: IZIDimensions.ONE_UNIT_SIZE * 75,
              margin: EdgeInsets.only(
                right: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: imageStatus(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!IZIValidate.nullOrEmpty(row1Left))
                          Expanded(
                            child: IZIText(
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLine: 2,
                              text: row1Left.toString(),
                              textAlign: TextAlign.start,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Nếu loại thanh toán là thanh toán dịch vụ

                  // Nếu loại thanh toán là nạp rút tiền
                  getTypePayment(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IZIText extends StatelessWidget {
  const IZIText({
    Key? key,
    this.textAlign,
    required this.text,
    this.style,
    this.maxLine,
  }) : super(key: key);
  final TextAlign? textAlign;
  final String text;
  final TextStyle? style;
  final int? maxLine;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLine ?? 1,
      overflow: TextOverflow.ellipsis,
      style: style ??
          TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_SPAN,
            color: ColorResources.BLACK,
            fontWeight: FontWeight.normal,
          ),
    );
  }
}
