import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

class DisplayListViewOrGridViewPage extends StatelessWidget {
  final List list;
  final String titleSectionLeft;
  final String titleSectionRight;
  final Widget Function(int id) itemWidget;
  final void Function()? onTapRight;

  IZIListViewType type;
  final double? mainAxisExtent;
  final double? heightListView;
  bool countdown;
  final DateTime? dateTimeEnd;
  final DateTime? dateTime;
  final Widget? countdownWidget;
  DisplayListViewOrGridViewPage(
      this.list, this.titleSectionLeft, this.titleSectionRight,
      {Key? key,
      required this.itemWidget,
      this.onTapRight,
      this.type = IZIListViewType.LISTVIEW,
      this.mainAxisExtent,
      this.heightListView,
      this.countdown = false,
      this.dateTimeEnd,
      this.dateTime,
      this.countdownWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: IZIListView(
          marginLabel: EdgeInsets.only(
              top: IZIDimensions.SPACE_SIZE_1X,
              bottom: IZIDimensions.SPACE_SIZE_1X),
          labelWidget: Row(children: [
            IZIText(
              text: titleSectionLeft,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.PRIMARY_9),
            ),
            if (countdown)
              if (!IZIValidate.nullOrEmpty(dateTime))
                countdownWidget!
              else
                const SizedBox()
          ]),
          action: GestureDetector(
            onTap: onTapRight,
            child: IZIText(
              text: titleSectionRight,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .85,
                  fontWeight: FontWeight.w400,
                  color: ColorResources.RED_COLOR_2),
            ),
          ),
          crossAxisSpacing: type == IZIListViewType.LISTVIEW
              ? null
              : IZIDimensions.SPACE_SIZE_3X,
          mainAxisSpacing: type == IZIListViewType.LISTVIEW
              ? null
              : IZIDimensions.SPACE_SIZE_3X,
          type: type,
          physics: type == IZIListViewType.LISTVIEW
              ? const ScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          scrollDirection: type == IZIListViewType.LISTVIEW
              ? Axis.horizontal
              : Axis.vertical,
          height: heightListView,
          mainAxisExtent: mainAxisExtent,
          itemCount: list.length,
          builder: itemWidget),
    );
  }
}
