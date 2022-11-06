import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

class IZIOtp extends StatefulWidget {
  const IZIOtp({
    Key? key,
    this.validate,
    this.onTap,
    this.onTapSendSMS,
    this.countDown = 90,
    this.labelSendOtp,
    this.onChanged,
    this.codeLength = 4,
    this.buttonLabel,
    this.isEnabled = false,
    this.lables = const [],
    this.colorSMS = ColorResources.BLACK,
  }) : super(key: key);
  final List<Widget>? lables;
  final bool Function()? validate;
  final Function? onTap;
  final Function? onTapSendSMS;
  final Color? colorSMS;
  final String Function(String?)? onChanged;
  final String? labelSendOtp;
  final int? countDown;
  final int codeLength;
  final String? buttonLabel;
  final bool? isEnabled;

  @override
  _IZIOtpState createState() => _IZIOtpState();
}

class _IZIOtpState extends State<IZIOtp> {
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  bool isCountDown = true;
  Timer? _timer;
  int count = 90;
  TextEditingController? textEditingController;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    textEditingController = TextEditingController();
    count = widget.countDown!;
    countDown();
  }

  @override
  void dispose() {
    super.dispose();
    errorController?.close();
    textEditingController?.dispose();
    _timer?.cancel();
  }

  bool validateOTP() {
    if (textEditingController!.text.length != widget.codeLength) {
      errorController!.add(ErrorAnimationType.shake);
      return true;
    } else {
      return false;
    }
  }

  void onTap() {
    if (!IZIValidate.nullOrEmpty(widget.validate)) {
      hasError = widget.validate!();
    } else {
      hasError = validateOTP();
    }
    if (hasError == true) {
      return IZIAlert.error(message: "Mã xác thực phải ít nhất ${widget.codeLength} số");
    }
    if (!IZIValidate.nullOrEmpty(widget.onTap) && widget.isEnabled!) {
      widget.onTap!();
    }
  }

  void countDown() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (count < 1) {
            timer.cancel();
            isCountDown = false;
          } else {
            count = count - 1;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: GlassContainer.frostedGlass(
          width: IZIDimensions.iziSize.width * 0.9,
          height: IZIDimensions.iziSize.height * 0.6,
          borderColor: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              IZIDimensions.BORDER_RADIUS_7X,
            ),
            bottomRight: Radius.circular(
              IZIDimensions.BORDER_RADIUS_7X,
            ),
          ),
          frostedOpacity: 0.05,
          blur: 20,
          child: Column(
            children: [
              if (!IZIValidate.nullOrEmpty(widget.lables)) ...widget.lables!,
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                    vertical: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  child: PinCodeTextField(
                    appContext: context,
                    length: widget.codeLength,
                    // obscuringCharacter: '*',
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_5X),
                      fieldHeight: IZIDimensions.ONE_UNIT_SIZE * (120 - (10.5 * widget.codeLength)),
                      fieldWidth: IZIDimensions.ONE_UNIT_SIZE * (120 - (10.5 * widget.codeLength)),
                      activeFillColor: Colors.white,
                      selectedFillColor: ColorResources.WHITE,
                      disabledColor: ColorResources.GREY,
                      selectedColor: ColorResources.CIRCLE_COLOR_BG3,
                      errorBorderColor: ColorResources.RED,
                      activeColor: ColorResources.CIRCLE_COLOR_BG3,
                      inactiveColor: ColorResources.WHITE,
                      inactiveFillColor: ColorResources.WHITE,
                    ),
                    cursorColor: ColorResources.GREEN,
                    animationDuration: const Duration(
                      milliseconds: 300,
                    ),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    onCompleted: (v) {
                      // controller.onBtnCompleteTap();
                    },
                    onChanged: (val) {
                      if (!IZIValidate.nullOrEmpty(widget.onChanged)) {
                        widget.onChanged!(val);
                      }
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_5X,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          if (!IZIValidate.nullOrEmpty(widget.onTapSendSMS) && !isCountDown) {
                            widget.onTapSendSMS!();
                            setState(() {
                              count = widget.countDown ?? 90;
                              isCountDown = true;
                              countDown();
                            });
                          }
                        },
                        child: widget.onTapSendSMS != null
                            ? IZIText(
                                text: widget.labelSendOtp ?? "Gửi xác thực đến sms",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  color: !isCountDown && count <= 0 ? widget.colorSMS ?? ColorResources.WHITE : ColorResources.GREY,
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                    if (isCountDown && count > 0)
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Gửi lại sau "),
                            Container(
                              margin: EdgeInsets.only(
                                left: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              alignment: Alignment.center,
                              child: IZIText(
                                text: "${(count ~/ 60) > 0 ? '${count ~/ 60}:' : ''}${count.toInt() % 60}s",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: IZIDimensions.ONE_UNIT_SIZE * 20,
                    ),
                    child: IZIButton(
                      margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_5X,
                      ),
                      colorBG: ColorResources.WHITE,
                      color: ColorResources.CIRCLE_COLOR_BG3,
                      isEnabled: widget.isEnabled,
                      label: widget.buttonLabel ?? "Tiếp tục",
                      borderRadius: IZIDimensions.BLUR_RADIUS_2X,
                      padding: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.ONE_UNIT_SIZE * 50,
                        vertical: IZIDimensions.ONE_UNIT_SIZE * 20,
                      ),
                      onTap: () {
                        onTap();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
