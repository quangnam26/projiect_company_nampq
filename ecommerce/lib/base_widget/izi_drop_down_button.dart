import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

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
    this.borderRadius,
    this.selectedItemBuilder,
    this.errorMessage,
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
  final double? borderRadius;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    // if (isSort!) {
    //   data.sort((a, b) => TiengViet.parse(a.toString()).toLowerCase().compareTo(TiengViet.parse(b.toString()).toLowerCase()));
    // }
    return Container(
      width: width ?? IZIDimensions.iziSize.width,
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      color: ColorResources.PRIMARY_9,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: IZIDimensions.FONT_SIZE_H6),
                  children: [
                    if (isRequired!)
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      )
                    else
                      const TextSpan(),
                  ],
                ),
              ),
            ),
          SizedBox(
            height: height ?? 49,
            child: FormField(
              enabled: isEnable!,
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_5X,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorResources.WHITE,
                      ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_5X,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorResources.WHITE,
                      ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_5X,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorResources.WHITE,
                      ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_5X,
                      ),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: ColorResources.WHITE,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      autofocus: true,
                      onTap: () {},
                      hint: Text(
                        hint!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      value: value,
                      style: TextStyle(
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
                      selectedItemBuilder: selectedItemBuilder,
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
          if (errorMessage != null)
            Container(
              margin: EdgeInsets.only(
                top: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: Text(
                errorMessage.toString(),
                style: const TextStyle(
                  color: ColorResources.RED,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
