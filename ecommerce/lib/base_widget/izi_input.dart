// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_other.dart';

import 'package:template/helper/izi_validate.dart';
import 'package:template/theme/app_theme.dart';
import 'package:template/utils/color_resources.dart';

// Text, number, tiền đều có thể hiện thị defaul = text
// PrefixIcon
// Lable bên trên có thể không (Có thể null)
// Label trên border (Có thể có or null)
// Có bắt phải nhập hay không
// Validate EditText -> Fail hiển thị error label
// Sufix label nếu nó là tiền (Nếu là tiền hiện thị thêm icon tiền)
//

enum IZIInputType {
  TEXT,
  PASSWORD,
  NUMBER,
  DOUBLE,
  PRICE,
  EMAIL,
  PHONE,
  INCREMENT,
  MILTIPLINE,
}

enum IZIPickerDate {
  MATERIAL,
  CUPERTINO,
}

// ignore: must_be_immutable
class IZIInput extends StatefulWidget {
  IZIInput(
      {Key? key,
      this.label,
      this.placeHolder,
      this.allowEdit = true,
      this.maxLine = 1,
      this.isRequired = false,
      required this.type,
      this.width,
      this.fontSize,
      this.height,
      this.suffixIcon,
      this.paddingTop,
      this.errorText,
      this.textInputAction,
      this.onChanged,
      this.isValidate,
      this.focusNode,
      this.padding,
      this.onSubmitted,
      this.borderRadius,
      this.hintStyle,
      this.borderSide,
      this.isBorder = false,
      this.fillColor,
      this.prefixIcon,
      // this.prefixIcon2,
      this.validate,
      this.isLegend = false,
      this.borderSize,
      this.disbleError = false,
      this.miniSize = false,
      this.colorDisibleBorder = ColorResources.GREY,
      this.colorBorder = ColorResources.CIRCLE_COLOR_BG3,
      this.min = 1,
      this.max = 10,
      this.widthIncrement,
      this.isDatePicker = false,
      this.iziPickerDate = IZIPickerDate.MATERIAL,
      this.obscureText,
      this.contentPaddingIncrement,
      this.initValue,
      this.onTap,
      this.isNotShadown = true,
      this.labelStyle,
      this.isTimePicker = false,
      this.maximumDate,
      this.minimumDate,
      this.initDate,
      this.style,
      this.isResfreshForm = false,
      this.cursorColor,
      this.controller,
      this.inputFormatters,
      this.suficIcons,
      this.autofocus,
      this.password})
      : super(key: key);
  final String? label;
  final String? placeHolder;
  final bool? allowEdit;
  final int? maxLine;
  final IZIInputType type;
  final bool? isRequired;
  final double? width;
  final double? fontSize;
  final double? height;
  final Widget? suffixIcon;
  final double? paddingTop;
  final String? errorText;
  final TextInputAction? textInputAction;
  final Function(String value)? onChanged;
  final Function(bool value)? isValidate;
  bool? boldHinText;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;
  final Function(dynamic)? onSubmitted;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final BorderSide? borderSide;
  final bool? isBorder;
  final Color? fillColor;
  // final Widget? prefixIcon;
  final Widget Function(FocusNode? focusNode)? prefixIcon;
  final String? Function(String)? validate;
  final bool? isLegend;
  final double? borderSize;
  final bool disbleError;
  final bool miniSize;
  final Color? colorDisibleBorder;
  final Color? colorBorder;
  final double? min;
  final double? max;
  final double? widthIncrement;
  final bool? isDatePicker;
  final bool? isTimePicker;
  final IZIPickerDate? iziPickerDate;
  final bool? obscureText;
  final EdgeInsets? contentPaddingIncrement;
  final String? initValue;
  final Function? onTap;
  final bool? isNotShadown;
  final TextStyle? labelStyle;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final DateTime? initDate;
  final TextStyle? style;
  final Color? cursorColor;
  final bool? autofocus;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? suficIcons;
  final String? password;

  bool? isResfreshForm = false;
  _IZIInputState iziState = _IZIInputState();
  @override
  // ignore: no_logic_in_create_state
  _IZIInputState createState() => iziState = _IZIInputState();
}

class _IZIInputState extends State<IZIInput> {
  FocusNode? focusNode;
  TextEditingController? textEditingController;
  MoneyMaskedTextController? numberEditingController;
  MoneyMaskedTextController? doubleEditingController;

  bool isShowedError = false;
  bool isVisible = true;
  bool isDisibleIncrement = false;
  bool isDisibleReduction = false;
  String? _errorText = "";

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.initValue ?? '');
    //TODO: fork lại fackage của họ, Thêm try catch
    // Khởi tạo lại NumberController set IniitValue
    if (widget.type == IZIInputType.INCREMENT) {
      numberEditingController = MoneyMaskedTextController(
        initialValue: IZINumber.parseDouble(widget.initValue ?? widget.min.toString()),
        precision: 0,
        decimalSeparator: '',
      );
    } else {
      numberEditingController = MoneyMaskedTextController(
        precision: 0,
        decimalSeparator: '',
      );
    }

    doubleEditingController = MoneyMaskedTextController(
      precision: 1,
    );

    focusNode = widget.focusNode ?? FocusNode();
    if (widget.type == IZIInputType.INCREMENT) {
      checkDisibleIncrement(IZINumber.parseInt(numberEditingController!.text));
    }
    // else if (widget.type == IZIInputType.NUMBER || widget.type == IZIInputType.PRICE) {
    //   numberEditingController!.clear();
    //   doubleEditingController!.clear();
    // }
  }

  @override
  void dispose() {
    focusNode?.dispose();
    textEditingController?.dispose();
    numberEditingController?.dispose();
    doubleEditingController?.dispose();
    super.dispose();
  }

  void setValue(dynamic newValue) {
    if (!IZIValidate.nullOrEmpty(newValue) && widget.type == IZIInputType.NUMBER ||
        !IZIValidate.nullOrEmpty(newValue) && widget.type == IZIInputType.PRICE ||
        !IZIValidate.nullOrEmpty(newValue) && widget.type == IZIInputType.DOUBLE) {
      numberEditingController = MoneyMaskedTextController(
        initialValue: IZINumber.parseDouble(newValue.toString()),
        precision: 0,
        decimalSeparator: '',
      );
      doubleEditingController = MoneyMaskedTextController(
        initialValue: IZINumber.parseDouble(newValue.toString()),
        precision: 1,
      );
    } else {
      textEditingController!.text = newValue.toString();
    }
    setState(() {});
  }

  TextInputType getType(IZIInputType type) {
    if (type == IZIInputType.NUMBER) {
      return TextInputType.number;
    } else if (type == IZIInputType.PASSWORD) {
      return TextInputType.visiblePassword;
    } else if (type == IZIInputType.PRICE) {
      return TextInputType.number;
    } else if (type == IZIInputType.TEXT) {
      return TextInputType.text;
    } else if (type == IZIInputType.EMAIL) {
      return TextInputType.emailAddress;
    } else if (type == IZIInputType.PHONE) {
      return TextInputType.phone;
    } else if (type == IZIInputType.DOUBLE) {
      return const TextInputType.numberWithOptions();
    } else if (type == IZIInputType.INCREMENT) {
      return TextInputType.number;
    } else if (type == IZIInputType.MILTIPLINE) {
      return TextInputType.multiline;
    }
    return TextInputType.text;
  }

  TextEditingController getController(IZIInputType type) {
    if (type == IZIInputType.NUMBER) {
      return widget.controller ?? numberEditingController!;
    } else if (type == IZIInputType.PASSWORD) {
      return textEditingController!;
    } else if (type == IZIInputType.PRICE) {
      return numberEditingController!;
    } else if (type == IZIInputType.TEXT) {
      return widget.controller ?? textEditingController!;
    } else if (type == IZIInputType.EMAIL) {
      return textEditingController!;
    } else if (type == IZIInputType.PHONE) {
      return widget.controller ?? textEditingController!;
    } else if (type == IZIInputType.DOUBLE) {
      return doubleEditingController!;
    } else if (type == IZIInputType.INCREMENT) {
      return widget.controller ?? numberEditingController!;
    }
    return widget.controller ?? textEditingController!;
  }

  String? Function(String)? checkValidate(
    IZIInputType type,
  ) {
    if (widget.validate != null) {
      return widget.validate;
    }
    if (type == IZIInputType.NUMBER) {
      return null;
    } else if (type == IZIInputType.PASSWORD) {
      return IZIValidate.password;
    } else if (type == IZIInputType.PRICE) {
      return null;
    } else if (type == IZIInputType.TEXT) {
      if (!IZIValidate.nullOrEmpty(widget.password)) {
        return IZIValidate.password;
      }
      return null;
    } else if (type == IZIInputType.EMAIL) {
      return IZIValidate.email;
    } else if (type == IZIInputType.PHONE) {
      return IZIValidate.phone;
    } else if (type == IZIInputType.INCREMENT) {
      return IZIValidate.increment;
    } else {
      return null;
    }
  }

  void onIncrement(IZIInputType type, {required bool increment}) {
    if (type == IZIInputType.INCREMENT) {
      final controller = getController(widget.type);
      if (IZIValidate.nullOrEmpty(controller.text)) {
        controller.text = '1';
      }
      int value = int.parse(controller.text);
      if (increment) {
        value++;
        controller.text = value.toString();
        checkDisibleIncrement(value);
      } else {
        validator(widget.type, value.toString());
        if (value > 0) {
          value--;
          controller.text = value.toString();
        }
        checkDisibleIncrement(value);
      }
      if (widget.onChanged != null) {
        widget.onChanged!(getController(widget.type).text);
        validator(widget.type, value.toString());
      }
    }
  }

  void checkDisibleIncrement(int value) {
    if (IZINumber.parseInt(getController(widget.type).text) <= widget.min! && !isDisibleReduction) {
      setState(() {
        isDisibleReduction = true;
      });
      return;
    }
    if (IZINumber.parseInt(getController(widget.type).text) > widget.min! && isDisibleReduction) {
      setState(() {
        isDisibleReduction = false;
      });
      return;
    }
    if (IZINumber.parseInt(getController(widget.type).text) >= widget.max! && !isDisibleIncrement) {
      setState(() {
        isDisibleIncrement = true;
      });
      return;
    }

    if (IZINumber.parseInt(getController(widget.type).text) < widget.max! && isDisibleIncrement) {
      setState(() {
        isDisibleIncrement = false;
      });
      return;
    }
  }

  void validator(IZIInputType type, String val) {
    if (checkValidate(widget.type) != null && isShowedError) {
      setState(() {
        _errorText = checkValidate(widget.type)!(val.toString());
        print("error: $_errorText");
      });
      if (widget.isValidate != null) {
        widget.isValidate!(IZIValidate.nullOrEmpty(_errorText));
      }
    }
  }

  void datePicker(IZIPickerDate pickerType) {
    // if (widget.isTimePicker!) {
    //   showTimePicker(
    //     context: context,
    //     initialTime: initialTime,
    //   );
    // }
    if (pickerType == IZIPickerDate.CUPERTINO) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: ColorResources.WHITE,
          ),
          height: IZIDimensions.ONE_UNIT_SIZE * 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                height: IZIDimensions.ONE_UNIT_SIZE * 400,
                child: CupertinoDatePicker(
                  mode: widget.isTimePicker! ? CupertinoDatePickerMode.time : CupertinoDatePickerMode.date,
                  // initialDateTime: DateTime.now(),
                  use24hFormat: true,
                  initialDateTime: widget.initDate ??
                      widget.minimumDate ??
                      DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        DateTime.now().hour,
                        DateTime.now().minute,
                      ),
                  maximumDate: widget.maximumDate ?? DateTime(2222),
                  minimumDate: widget.minimumDate ??
                      DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        // DateTime.now().hour,
                        // DateTime.now().minute,
                      ),

                  onDateTimeChanged: (value) {
                    if (widget.isTimePicker!) {
                      getController(widget.type).text =
                          "${value.hour < 10 ? "0${value.hour}" : value.hour}:${value.minute < 10 ? "0${value.minute}" : value.minute}"; //IZIDate.formatDate(value, format: 'hh:mm a');
                      // widget.onChanged!("${value.hour}:${value.minute}");
                      widget.onChanged!(IZIDate.formatDate(value, format: 'yyyy-MM-dd HH:mm:ss'));
                      IZIOther.primaryFocus();
                    } else {
                      final String date = IZIDate.formatDate(value);
                      getController(widget.type).text = date;
                      if (!IZIValidate.nullOrEmpty(widget.onChanged)) {
                        widget.onChanged!(IZIDate.formatDate(value, format: 'yyyy-MM-dd'));
                      }
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  final now = DateTime.now();

                  final value = getController(widget.type).text;

                  if (widget.isTimePicker! && IZIValidate.nullOrEmpty(value)) {
                    widget.onChanged!("${now.hour}:${now.minute}");
                    getController(widget.type).text =
                        "${now.hour < 10 ? "0${now.hour}" : now.hour}:${now.minute < 10 ? "0${now.minute}" : now.minute}";
                  } else {
                    if (widget.isDatePicker! && IZIValidate.nullOrEmpty(value)) {
                      final String date = IZIDate.formatDate(now);
                      getController(widget.type).text = date;
                      widget.onChanged!(IZIDate.formatDate(now, format: 'yyyy-MM-dd'));
                    }
                  }

                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: Text(
                    "Xác nhận",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      color: ColorResources.PRIMARY_1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      showDatePicker(
        context: context,
        initialDate: widget.initDate ?? widget.minimumDate ?? DateTime.now(),
        firstDate: widget.minimumDate ?? DateTime.now(),
        lastDate: widget.maximumDate ?? DateTime(2100),
        // initialDate: DateTime.now(),
        // firstDate: DateTime.now(),
        // lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: AppTheme.light.copyWith(
              colorScheme: const ColorScheme.light(
                primary: ColorResources.PRIMARY_1,
              ),
            ),
            child: child!,
          );
        },
      ).then(
        (value) {
          if (!IZIValidate.nullOrEmpty(value)) {
            final String date = IZIDate.formatDate(value!);
            getController(widget.type).text = date;
            if (!IZIValidate.nullOrEmpty(widget.onChanged)) {
              widget.onChanged!(IZIDate.formatDate(value, format: 'yyyy-MM-dd'));
            }
          }
        },
      );
    }
  }

  Widget? getSuffixIcon() {
    if (widget.isDatePicker! && IZIValidate.nullOrEmpty(widget.suffixIcon)) {
      return const Icon(
        Icons.calendar_today,
        color: ColorResources.NEUTRALS_4,
      );
    }
    if (widget.type == IZIInputType.PRICE) {
      return SizedBox.shrink(
        child: Padding(
          padding: EdgeInsets.only(
            right: IZIDimensions.SPACE_SIZE_1X,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(widget.suficIcons ?? "VNĐ"),
          ),
        ),
      );
    } else if (widget.type == IZIInputType.PASSWORD) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        child: Icon(
          isVisible ? Icons.visibility : Icons.visibility_off,
        ),
      );
    }
    if (!IZIValidate.nullOrEmpty(widget.suffixIcon)) {
      return widget.suffixIcon!;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == IZIInputType.INCREMENT) {
      checkDisibleIncrement(IZINumber.parseInt(numberEditingController!.text));
    }
    if (!focusNode!.hasListeners) {
      focusNode!.addListener(() {
        setState(() {});
      });
    }
    if (!IZIValidate.nullOrEmpty(widget.errorText) && IZIValidate.nullOrEmpty(_errorText)) {
      _errorText = widget.errorText.toString();
    }

    if (widget.isResfreshForm == true) {
      if (widget.type == IZIInputType.NUMBER ||
          widget.type == IZIInputType.PRICE ||
          widget.type == IZIInputType.DOUBLE) {
        getController(widget.type).text = '0';
      } else {
        getController(widget.type).text = '';
      }
    }
    return SizedBox(
      width: widget.width ?? IZIDimensions.iziSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isLegend == false && widget.label != null)
            Container(
              padding: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: widget.label,
                  style: widget.labelStyle ??
                      TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        fontWeight: FontWeight.w400,
                        color: ColorResources.NEUTRALS_4,
                      ),
                  children: [
                    if (widget.isRequired!)
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
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
          Row(
            children: [
              if (IZIInputType.INCREMENT == widget.type)
                GestureDetector(
                  onTap: () {
                    if (!isDisibleReduction) {
                      IZIOther.primaryFocus();
                      onIncrement(widget.type, increment: false);
                    }
                  },
                  child: Container(
                    // margin: EdgeInsets.all(
                    //   IZIDimensions.ONE_UNIT_SIZE * 10,
                    // ),
                    height: widget.height ?? IZIDimensions.ONE_UNIT_SIZE * 100,
                    constraints: BoxConstraints(
                      maxHeight: IZIDimensions.ONE_UNIT_SIZE * 80,
                    ),
                    width: widget.widthIncrement ?? IZIDimensions.ONE_UNIT_SIZE * 80,
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: widget.isNotShadown! ? null : IZIOther().boxShadow,
                      border: widget.isBorder!
                          ? isDisibleReduction
                              ? Border.all(
                                  color: widget.colorDisibleBorder ?? ColorResources.NEUTRALS_2,
                                )
                              : Border.all(
                                  color: widget.colorBorder ?? ColorResources.NEUTRALS_2,
                                )
                          : isDisibleReduction
                              ? Border.all(
                                  color: widget.colorDisibleBorder ?? ColorResources.NEUTRALS_2,
                                )
                              : Border.all(
                                  color: widget.colorBorder ?? ColorResources.NEUTRALS_2,
                                ),
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_2X,
                      ),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: isDisibleReduction
                          ? widget.colorDisibleBorder ?? ColorResources.GREY
                          : widget.colorBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                    ),
                  ),
                ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    if (widget.isDatePicker! && widget.allowEdit!) {
                      datePicker(widget.iziPickerDate!);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: widget.isNotShadown! ? null : IZIOther().boxShadow,
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_1X,
                      ),
                    ),
                    width:
                        IZIInputType.INCREMENT == widget.type ? widget.width ?? IZIDimensions.ONE_UNIT_SIZE * 90 : null,
                    height: widget.miniSize ? 40 : null,
                    child: TextFormField(
                      autofocus: widget.autofocus ?? false,
                      onTap: () {
                        if (!IZIValidate.nullOrEmpty(widget.onTap)) {
                          widget.onTap!();
                        }
                      },
                      textAlign: IZIInputType.INCREMENT == widget.type ? TextAlign.center : TextAlign.start,
                      onFieldSubmitted: (val) {
                        if (!IZIValidate.nullOrEmpty(widget.onSubmitted)) {
                          widget.onSubmitted!(val);
                        }
                        if (!IZIValidate.nullOrEmpty(val) && IZIInputType.INCREMENT == widget.type) {
                          if (IZINumber.parseInt(val) < widget.min!) {
                            getController(widget.type).text = IZINumber.parseInt(widget.min.toString()).toString();
                          }
                        }
                      },
                      onChanged: (val) {
                        isShowedError = true;
                        if (widget.type == IZIInputType.NUMBER || widget.type == IZIInputType.DOUBLE) {
                          if (IZIValidate.nullOrEmpty(val)) {
                            // getController(widget.type).text = '0';
                            // val = '0';
                          }
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(val);
                          // onIncrement(widget.type, increment: true);
                        }
                        validator(widget.type, val.toString());
                      },
                      textInputAction: widget.textInputAction,
                      keyboardType: getType(widget.type),
                      maxLines: widget.maxLine,
                      textAlignVertical: TextAlignVertical.top,
                      enabled: widget.isDatePicker! ? false : widget.allowEdit,
                      controller: getController(widget.type),
                      obscureText: widget.obscureText ?? widget.type == IZIInputType.PASSWORD && isVisible,
                      focusNode: focusNode,
                      inputFormatters: widget.inputFormatters,
                      style: widget.style,
                      cursorColor: widget.cursorColor ?? ColorResources.PRIMARY_1,
                      decoration: InputDecoration(
                        hintStyle: widget.hintStyle ??
                            TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_SPAN * 1.2,
                              fontWeight: FontWeight.normal,
                              color: ColorResources.NEUTRALS_5,
                            ),
                        contentPadding: widget.miniSize ? const EdgeInsets.all(10) : widget.contentPaddingIncrement,
                        isDense: true,
                        labelText: widget.isLegend == true ? widget.label : null,
                        labelStyle: TextStyle(
                          fontSize: focusNode!.hasFocus ? IZIDimensions.FONT_SIZE_H5 : IZIDimensions.FONT_SIZE_H6,
                          fontWeight: focusNode!.hasFocus ? FontWeight.w600 : FontWeight.normal,
                          color: ColorResources.BLACK,
                        ),
                        prefixIcon: IZIValidate.nullOrEmpty(widget.prefixIcon) ? null : widget.prefixIcon!(focusNode),
                        border: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false)
                                        ? ColorResources.LIGHT_GREY
                                        : ColorResources.LIGHT_GREY,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_1X,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false)
                                        ? ColorResources.LIGHT_GREY
                                        : ColorResources.LIGHT_GREY,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_1X,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false)
                                        ? ColorResources.LIGHT_GREY
                                        : ColorResources.LIGHT_GREY,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_1X,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false)
                                        ? ColorResources.LIGHT_GREY
                                        : ColorResources.LIGHT_GREY,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_1X,
                          ),
                        ),
                        filled: true,
                        hintText: widget.placeHolder,
                        fillColor: (widget.allowEdit == false)
                            ? widget.fillColor ?? ColorResources.LIGHT_GREY.withOpacity(0.4)
                            : widget.fillColor ?? ColorResources.WHITE,
                        suffixIcon: getSuffixIcon(),
                      ),
                    ),
                  ),
                ),
              ),
              if (IZIInputType.INCREMENT == widget.type)
                GestureDetector(
                  onTap: () {
                    if (!isDisibleIncrement) {
                      IZIOther.primaryFocus();
                      onIncrement(widget.type, increment: true);
                    }
                  },
                  child: Container(
                    // margin: EdgeInsets.all(
                    //   IZIDimensions.ONE_UNIT_SIZE * 10,
                    // ),
                    constraints: BoxConstraints(maxHeight: IZIDimensions.ONE_UNIT_SIZE * 80),
                    height: widget.height ?? IZIDimensions.ONE_UNIT_SIZE * 80,
                    width: widget.widthIncrement ?? IZIDimensions.ONE_UNIT_SIZE * 80,
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      // boxShadow: IZIOther().boxShadow,
                      border: widget.isBorder!
                          ? isDisibleIncrement
                              ? Border.all(
                                  color: widget.colorDisibleBorder ?? ColorResources.NEUTRALS_2,
                                )
                              : Border.all(
                                  color: widget.colorBorder ?? ColorResources.NEUTRALS_2,
                                )
                          : isDisibleIncrement
                              ? Border.all(
                                  color: widget.colorDisibleBorder ?? ColorResources.NEUTRALS_2,
                                )
                              : Border.all(
                                  color: widget.colorBorder ?? ColorResources.NEUTRALS_2,
                                ),
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_2X,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: isDisibleIncrement
                          ? widget.colorDisibleBorder ?? ColorResources.GREY
                          : widget.colorBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                    ),
                  ),
                ),
            ],
          ),
          // if (!widget.disbleError)
          if (!IZIValidate.nullOrEmpty(_errorText) && !widget.disbleError)
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
              alignment: Alignment.topLeft,
              child: Text(
                IZIValidate.nullOrEmpty(_errorText.toString()) ? "" : _errorText.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
