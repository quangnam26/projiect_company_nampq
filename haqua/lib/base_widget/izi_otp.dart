import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_toast.dart';
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
    required this.onChanged,
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
  final void Function(String?) onChanged;
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
      return IZIToast().error(message: "${"validate_otp_1".tr}${widget.codeLength} ${"validate_otp_2".tr}");
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
        child: Container(
          width: IZIDimensions.iziSize.width * 0.9,
          height: IZIDimensions.iziSize.height * 0.4,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorResources.PRIMARY_APP,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                IZIDimensions.BORDER_RADIUS_7X,
              ),
              bottomRight: Radius.circular(
                IZIDimensions.BORDER_RADIUS_7X,
              ),
            ),
            color: ColorResources.WHITE,
          ),
          child: Column(
            children: [
              if (!IZIValidate.nullOrEmpty(widget.lables)) ...widget.lables!,
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN * 3,
                    vertical: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  child: PinCodeTextField(
                    appContext: context,
                    length: widget.codeLength,
                    // obscuringCharacter: '*',
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                      fieldHeight: IZIDimensions.ONE_UNIT_SIZE * (120 - (10.5 * widget.codeLength)),
                      fieldWidth: IZIDimensions.ONE_UNIT_SIZE * (120 - (10.5 * widget.codeLength)),
                      activeFillColor: Colors.white,
                      selectedFillColor: ColorResources.WHITE,
                      disabledColor: ColorResources.GREY,
                      selectedColor: ColorResources.PRIMARY_APP,
                      errorBorderColor: ColorResources.RED,
                      activeColor: ColorResources.PRIMARY_APP,
                      inactiveColor: ColorResources.WHITE,
                      inactiveFillColor: ColorResources.GREY,
                    ),
                    cursorColor: ColorResources.PRIMARY_APP,
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
                        widget.onChanged(val);
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
                                text: widget.labelSendOtp ?? "send_again".tr,
                                style: TextStyle(
                                  fontSize: !isCountDown && count <= 0 ? IZIDimensions.FONT_SIZE_H6 : IZIDimensions.FONT_SIZE_SPAN,
                                  color: !isCountDown && count <= 0 ? widget.colorSMS ?? ColorResources.PRIMARY_APP : ColorResources.GREY,
                                  fontWeight: !isCountDown && count <= 0 ? FontWeight.w600 : FontWeight.normal,
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
                            Text("send_otp_again".tr),
                            Container(
                              margin: EdgeInsets.only(
                                left: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              alignment: Alignment.center,
                              child: IZIText(
                                text: "${(count ~/ 60) > 0 ? '${count ~/ 60}:' : ''}${count.toInt() % 60}s",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  color: ColorResources.BLACK,
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
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: ClipOval(
                          child: Container(
                            color: ColorResources.PRIMARY_APP,
                            width: IZIDimensions.ONE_UNIT_SIZE * 70,
                            height: IZIDimensions.ONE_UNIT_SIZE * 70,
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: ColorResources.WHITE,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        child: IZIButton(
                          isEnabled: widget.isEnabled,
                          label: widget.buttonLabel ?? "continue".tr,
                          borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
