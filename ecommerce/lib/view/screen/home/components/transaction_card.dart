import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

enum IZIStatusTransaction {
  AWAIT,
  DONE,
  FAIL,
}

enum IZITypeTransaction {
  DRAW,
  RECHARGE,
  PLUS,
}

enum IZIMethodTransaction {
  TRANSFER,
  MOMO,
  VIETTELL_PAY,
}

enum IZITypePayment {
  THANH_TOAN_DICH_VU,
  NAP_VAO_RUT,
}

// ignore: must_be_immutable
class CustomIZICart extends StatelessWidget {
  CustomIZICart({
    Key? key,
    this.row1Left,
    this.row1Right,
    this.row2Left,
    this.row2Right,
    this.row3Left,
    this.title,
    this.typeTransaction = IZITypeTransaction.RECHARGE,
    this.onTap,
    this.marginCard,
    this.radiusCard,
    this.colorBG,
    this.statusTransaction = IZIStatusTransaction.DONE,
    this.statusTypePayment = IZITypePayment.NAP_VAO_RUT,
    this.methodTransaction = IZIMethodTransaction.TRANSFER,
  }) : super(key: key);

  final String? row1Left;
  final String? row1Right;
  final String? row2Left;
  final String? row2Right;
  final String? row3Left;
  final String? title;
  final Function? onTap;
  final EdgeInsets? marginCard;
  final Color? colorBG;
  final double? radiusCard;
  IZITypeTransaction? typeTransaction;
  IZIStatusTransaction? statusTransaction;
  IZITypePayment? statusTypePayment;
  IZIMethodTransaction? methodTransaction;

  Widget getTypePayment() {
    if (statusTypePayment == IZITypePayment.THANH_TOAN_DICH_VU) {
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
                        ),
                        SizedBox(
                          width: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        getStatusPayment(statusTransaction!),
                      ],
                    ),
                  ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_1X,
                ),
                // Tiền
                getStatusMoney(typeTransaction!)
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
                    getStatusPayment(statusTransaction!),
                    getStatusMoney(typeTransaction!),
                  ],
                )
              ],
            ),
      ],
    );
  }

  Widget getStatusPayment(IZIStatusTransaction statusPayment) {
    if (statusPayment == IZIStatusTransaction.DONE) {
      return const IZIText(
        text: "Thành công",
        style: TextStyle(
          color: ColorResources.GREEN,
          fontWeight: FontWeight.w400,
        ),
        maxLine: 1,
        textAlign: TextAlign.end,
      );
    } else if (statusPayment == IZIStatusTransaction.FAIL) {
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
        color: ColorResources.YELLOW_PRIMARY2,
        fontWeight: FontWeight.w400,
      ),
      maxLine: 1,
      textAlign: TextAlign.end,
    );
  }

  ///
  /// Số tiền rút và nạp , thanh toán
  ///
  Widget getStatusMoney(IZITypeTransaction statusPrice) {
    if (statusPrice == IZITypeTransaction.DRAW && !IZIValidate.nullOrEmpty(row2Left)) {
      return IZIText(
        text: "- ${row2Left.toString()}VNĐ",
        style: TextStyle(
          color: backgroundStatus(),
          fontWeight: FontWeight.w700,
        ),
        maxLine: 1,
        textAlign: TextAlign.start,
      );
    } else if (statusPrice == IZITypeTransaction.RECHARGE && !IZIValidate.nullOrEmpty(row2Left)) {
      return IZIText(
        text: "${row2Left.toString()}VNĐ",
        style: TextStyle(
          color: backgroundStatus(),
          fontWeight: FontWeight.w700,
        ),
        maxLine: 1,
        textAlign: TextAlign.start,
      );
    } else if (statusPrice == IZITypeTransaction.PLUS && !IZIValidate.nullOrEmpty(row2Left)) {
      return IZIText(
        text: "${row2Left.toString()}VNĐ",
        style: TextStyle(
          color: backgroundStatus(),
          fontWeight: FontWeight.w700,
        ),
        maxLine: 1,
        textAlign: TextAlign.start,
      );
    }
    return const SizedBox();
  }

  ///
  /// genColorBG
  ///
  Color genColorBG(IZIMethodTransaction methodTransaction) {
    if (methodTransaction == IZIMethodTransaction.TRANSFER) {
      return ColorResources.WHITE;
    }

    if (methodTransaction == IZIMethodTransaction.MOMO) {
      return ColorResources.RED;
    }

    if (methodTransaction == IZIMethodTransaction.VIETTELL_PAY) {
      return ColorResources.GREEN;
    }

    return ColorResources.WHITE;
  }

  ///
  /// Hình ảnh trạng thái
  ///
  Widget imageStatus() {
    if (typeTransaction == IZITypeTransaction.DRAW) {
      return borderLable(
        child: IZIImage(
          ImagesPath.NAP_TIEN_VAO_VI,
          height: IZIDimensions.ONE_UNIT_SIZE * 70,
          width: IZIDimensions.ONE_UNIT_SIZE * 75,
          color: ColorResources.RED,
          fit: BoxFit.contain,
        ),
        status: IZITypeTransaction.DRAW,
      );
    } else if (typeTransaction == IZITypeTransaction.PLUS) {
      return borderLable(
        child: IZIImage(
          ImagesPath.THANH_TOAN,
          height: IZIDimensions.ONE_UNIT_SIZE * 70,
          width: IZIDimensions.ONE_UNIT_SIZE * 75,
          color: ColorResources.GREEN,
          fit: BoxFit.contain,
        ),
        status: IZITypeTransaction.PLUS,
      );
    }
    return borderLable(
      child: IZIImage(
        title.toString().toLowerCase().contains("rút tiền") ? ImagesPath.artboard19 : ImagesPath.bg2,
        height: IZIDimensions.ONE_UNIT_SIZE * 70,
        width: IZIDimensions.ONE_UNIT_SIZE * 75,
        color: ColorResources.LABEL_ORDER_DANG_GIAO,
      ),
      status: IZITypeTransaction.RECHARGE,
    );
  }

  ///
  /// Border của trạng thái
  ///
  Widget borderLable({required Widget child, required IZITypeTransaction status}) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_2X,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorResources.GREY),
          ),
          child: child,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundStatus(),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 50,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              iconStatus(),
              size: IZIDimensions.ONE_UNIT_SIZE * 25,
              color: ColorResources.WHITE,
            ),
          ),
        )
      ],
    );
  }

  ///
  /// Icon trạng thái
  ///
  IconData iconStatus() {
    if (statusTransaction == IZIStatusTransaction.FAIL) {
      return Icons.clear;
    } else if (statusTransaction == IZIStatusTransaction.AWAIT) {
      return Icons.priority_high;
    }
    return Icons.check;
  }

  ///
  /// Màu nền của icon trạng thái
  ///
  Color backgroundStatus() {
    if (statusTransaction == IZIStatusTransaction.FAIL) {
      return ColorResources.RED;
    } else if (statusTransaction == IZIStatusTransaction.AWAIT) {
      return ColorResources.YELLOW;
    }
    return Colors.green;
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
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_2X,
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 0.02),
          color: genColorBG(methodTransaction!),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 2,
              color: ColorResources.NEUTRALS_6,
            ),
          ],
          borderRadius: BorderRadius.circular(
            radiusCard ?? IZIDimensions.BORDER_RADIUS_4X,
          ),
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
