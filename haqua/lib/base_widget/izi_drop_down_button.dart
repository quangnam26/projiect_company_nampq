import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:tiengviet/tiengviet.dart';

class DropDownButton<T> extends StatelessWidget {
  const DropDownButton({
    Key? key,
    this.hint = "",
    this.onChanged,
    required this.data,
    this.width,
    this.height,
    required this.value,
    this.label,
    required this.isRequired,
    this.isEnable = true,
    this.isSort = true,
    this.padding,
    this.textStyleValue,
    this.borderRadius,
    this.colorBorder,
    this.backgroundColor,
    this.textStyleHintText,
  }) : super(key: key);
  final String? hint;
  final double? width, height;
  final Function(T? value)? onChanged;
  final String? label;
  final bool? isRequired;
  final List<T> data;
  final T? value;
  final bool? isEnable;
  final EdgeInsetsGeometry? padding;
  final bool? isSort;
  final TextStyle? textStyleValue;
  final TextStyle? textStyleHintText;
  final double? borderRadius;
  final Color? colorBorder;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (isSort!) {
      data.sort((a, b) => TiengViet.parse(a.toString()).toLowerCase().compareTo(TiengViet.parse(b.toString()).toLowerCase()));
    }
    return Container(
      width: width ?? IZIDimensions.iziSize.width,
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          if (label != null)
            Container(
              padding: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: label,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                  ),
                  children: [
                    if (isRequired!)
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      )
                    else
                      const TextSpan(),
                  ],
                ),
              ),
            ),
          Container(
            height: height ?? IZIDimensions.ONE_UNIT_SIZE * 75,
            decoration: BoxDecoration(
              color: backgroundColor ?? ColorResources.WHITE,
              borderRadius: BorderRadius.circular(
                borderRadius ?? IZIDimensions.BLUR_RADIUS_3X,
              ),
              // border: Border.all(
              //   color: colorBorder ?? ColorResources.PRIMARY_APP,
              // ),
            ),
            child: FormField(
              enabled: isEnable!,
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(
                      IZIDimensions.SPACE_SIZE_3X,
                    ),
                    border: OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(
                      //   IZIDimensions.BLUR_RADIUS_3X,
                      // ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorBorder ?? ColorResources.WHITE,
                      ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorBorder ?? ColorResources.WHITE,
                      ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorBorder ?? ColorResources.WHITE,
                      ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: backgroundColor ?? ColorResources.WHITE,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_2X,
                      ),
                      autofocus: true,
                      onTap: () {},
                      hint: Text(
                        hint!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textStyleHintText,
                      ),
                      value: value,
                      style: textStyleValue ??
                          TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_SPAN,
                            color: ColorResources.BLACK,
                          ),
                      isDense: true,
                      isExpanded: true,
                      onChanged: isEnable!
                          ? (val) {
                              onChanged!(val);
                            }
                          : null,
                      items: data
                          .map(
                            (e) => DropdownMenuItem<T>(
                              value: e,
                              child: Text(
                                e.toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
