import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../helper/izi_other.dart';
import '../../../../utils/color_resources.dart';

enum TRANSPORTTYPE {
  CAN_XE,
  DI_CHUNG,
  GUI_DO,
  CHO_GUI_DO,
}

class SuperTransportCard extends StatelessWidget {
  final String name;
  final String address;
  final String value;
  final TRANSPORTTYPE transportType;
  final String createDate;
  final Function onTap;
  final String image;
  const SuperTransportCard({
    required this.name,
    required this.address,
    required this.value,
    required this.transportType,
    required this.createDate,
    required this.onTap,
    required this.image,

  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      margin: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.ONE_UNIT_SIZE * 30,
        ),
        boxShadow: IZIOther().boxShadow,
        color: ColorResources.WHITE,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CircleAvatar(
              radius: IZIDimensions.ONE_UNIT_SIZE * 30,
              child: IZIImage(
                image,
              ),
            ),
          ),
          SizedBox(
            width: IZIDimensions.ONE_UNIT_SIZE * 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: ColorResources.NEUTRALS_2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_1X,
                ),
                Text(
                  address,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    color: ColorResources.NEUTRALS_4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_1X,
                ),
                Row(
                  children: [
                    Icon(
                      iconType(),
                      size: IZIDimensions.ONE_UNIT_SIZE * 25,
                      color: ColorResources.NEUTRALS_4,
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Text(
                      value,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        color: ColorResources.NEUTRALS_4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              button(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: IZIDimensions.ONE_UNIT_SIZE * 25,
                    color: ColorResources.NEUTRALS_4,
                  ),
                  SizedBox(
                    width: IZIDimensions.SPACE_SIZE_1X,
                  ),
                  Text(
                    createDate,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_SPAN,
                      color: ColorResources.BLACK,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  ///
  /// Button gửi đồ
  ///
  Widget button() {
    return IZIButton(
      onTap: () {
        onTap();
      },
      label: buttonTitle(),
      width:  buttonTitle().contains('Cho gửi đồ') ? IZIDimensions.ONE_UNIT_SIZE * 120 : IZIDimensions.ONE_UNIT_SIZE * 100,
      fontSizedLabel: IZIDimensions.ONE_UNIT_SIZE * 15,
      padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),
      borderRadius: 7,
      colorBG: buttonColorBg(),
    );
  }

  ///
  /// button title
  ///
  String buttonTitle() {
    if (transportType == TRANSPORTTYPE.CAN_XE) {
      return "Cần xe";
    } else if (transportType == TRANSPORTTYPE.DI_CHUNG) {
      return "Đi chung";
    } else if (transportType == TRANSPORTTYPE.GUI_DO) {
      return "Gửi đồ";
    }
    return 'Cho gửi đồ';
  }

  ///
  /// button color
  ///
  Color buttonColorBg() {
    if (transportType == TRANSPORTTYPE.CAN_XE) {
      return ColorResources.RED;
    } else if (transportType == TRANSPORTTYPE.DI_CHUNG) {
      return ColorResources.PRIMARY_2;
    } else if (transportType == TRANSPORTTYPE.GUI_DO) {
      return ColorResources.PRIMARY_1;
    }
    return ColorResources.YELLOW;
  }

  ///
  /// icon
  ///
  IconData iconType() {
    if (transportType == TRANSPORTTYPE.CAN_XE) {
      return CupertinoIcons.person_solid;
    } else if (transportType == TRANSPORTTYPE.DI_CHUNG) {
      return Icons.chair;
    } else if (transportType == TRANSPORTTYPE.GUI_DO) {
      return Icons.balance;
    }
    return Icons.balance;
  }
}
