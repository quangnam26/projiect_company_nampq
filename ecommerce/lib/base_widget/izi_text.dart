import 'package:flutter/material.dart';

import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

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
      style: style ?? TextStyle(fontSize: IZIDimensions.FONT_SIZE_SPAN, color: ColorResources.BLACK, fontWeight: FontWeight.normal),
    );
  }
}
