import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

class IZITabBar<T> extends StatelessWidget {
  const IZITabBar(
      {Key? key,
      required this.items,
      required this.onTapChangedTabbar,
      this.currentIndex = 0,
      this.onTap,
      this.heightTabView,
      this.widthTabBar,
      this.heightTabBar,
      this.colorTabBar,
      this.disibleColorTabBar,
      this.radiusTabBar,
      this.isUnderLine = true,
      this.colorText,
      this.disbleColorText,
      this.colorUnderLine,
      this.isSort})
      : super(key: key);

  final List<T> items;
  final int? currentIndex;
  final Function? onTap;
  final Function(int index) onTapChangedTabbar;
  final double? heightTabView;
  final double? widthTabBar;
  final Color? colorTabBar;
  final Color? disibleColorTabBar;
  final double? radiusTabBar;
  final bool? isUnderLine;
  final double? heightTabBar;
  final Color? colorText;
  final Color? disbleColorText;
  final Color? colorUnderLine;
  final bool? isSort;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: heightTabBar ?? IZIDimensions.ONE_UNIT_SIZE * 60,
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          radiusTabBar ?? 0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(
            items.length,
            (index) => GestureDetector(
              onTap: () {
                onTapChangedTabbar(index);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.ONE_UNIT_SIZE * 10,
                  vertical: IZIDimensions.ONE_UNIT_SIZE * 5,
                ),
                // height: double.infinity,
                width: widthTabBar != null
                    ? (widthTabBar!.roundToDouble() / (items.length + .4))
                    : IZIDimensions.ONE_UNIT_SIZE *
                        580.roundToDouble() /
                        (items.length + .5),
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? colorTabBar ?? ColorResources.WHITE
                      : disibleColorTabBar ?? ColorResources.WHITE,
                  borderRadius: !isUnderLine!
                      ? BorderRadius.circular(
                          radiusTabBar ?? IZIDimensions.BLUR_RADIUS_3X,
                        )
                      : null,
                  border: isUnderLine!
                      ? Border(
                          bottom: currentIndex == index
                              ? BorderSide(
                                  width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                  color: colorUnderLine ??
                                      ColorResources.MY_ORDER_LABEL,
                                )
                              : BorderSide.none,
                        )
                      : null,
                ),
                child: items is List<Map>
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!IZIValidate.nullOrEmpty(
                              (items as List<Map>)[index]['flag']))
                            const SizedBox()
                          else if ((items as List<Map>)[index]['icon']
                              is IconData)
                            Icon(
                                (items as List<Map>)[index]['icon'] as IconData,
                                color: currentIndex == index
                                    ? colorText ?? ColorResources.MY_ORDER_LABEL
                                    : disbleColorText ?? ColorResources.GREY)
                          else
                            Container(
                              decoration: const BoxDecoration(
                                  // color: ColorResources.YELLOW
                                  // color: currentIndex == index
                                  //     ? colorText ?? ColorResources.MY_ORDER_LABEL
                                  //     : disbleColorText ?? ColorResources.GREY,
                                  ),
                              child: IZIImage((items as List<Map>)[index]
                                      ['icon']
                                  .toString()),
                            ),
                          Row(
                            children: [
                              Flexible(
                                child: IZIText(
                                  text: (items as List<Map>)[index]['text']
                                      .toString(),
                                  style: TextStyle(
                                    color: currentIndex == index
                                        ? colorText ??
                                            ColorResources.MY_ORDER_LABEL
                                        : disbleColorText ??
                                            ColorResources.GREY,
                                    fontWeight: currentIndex == index
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                  ),
                                ),
                              ),
                              if (!IZIValidate.nullOrEmpty(
                                      (items as List<Map>)[index]['flag']) &&
                                  (items as List<Map>)[index]['flag'] == true)
                                Icon(
                                  isSort!
                                      ? Icons.arrow_upward_outlined
                                      : Icons.arrow_downward_outlined,
                                  color: ColorResources.GREY,
                                )
                            ],
                          )
                        ],
                      )
                    : Center(
                        child: Text(
                          items[index].toString(),
                          style: TextStyle(
                            color: currentIndex == index
                                ? colorText ?? ColorResources.MY_ORDER_LABEL
                                : disbleColorText ?? ColorResources.GREY,
                            fontWeight: currentIndex == index
                                ? FontWeight.w600
                                : FontWeight.normal,
                            fontFamily: 'Roboto',
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                          maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
