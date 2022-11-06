import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';

class IZISuccessfulScreen extends StatelessWidget {
  const IZISuccessfulScreen({
    Key? key,
    required this.labelAppBar,
    required this.title,
    required this.labelButton,
    required this.onTap,
    required this.typeButton,
    this.description,
    this.content,
    this.isSingleChildScrollView,
  }) : super(key: key);

  final String labelAppBar;
  final Widget? content;
  final String title;
  final String? description;
  final String labelButton;
  final Function onTap;
  final IZIButtonType typeButton;
  final bool? isSingleChildScrollView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND,
      body: IZIScreen(
        isSingleChildScrollView: false,
        background: const BackgroundApp(),
        appBar: IZIAppBar(
          title: labelAppBar,
          iconBack: const SizedBox(),
        ),
        body: Container(
          padding: EdgeInsets.only(
            bottom: SPACE_BOTTOM_SHEET,
          ),
          color: ColorResources.BACKGROUND,
          width: IZIDimensions.iziSize.width,
          child: isSingleChildScrollView == true && content != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      content!,
                    ],
                  ),
                )
              : Column(
                  children: [
                    AvatarGlow(
                      glowColor: ColorResources.SUCCESSFUL_PAGE,
                      endRadius: IZIDimensions.iziSize.width * .4,
                      repeatPauseDuration: const Duration(milliseconds: 50),
                      child: ClipOval(
                        child: Container(
                          width: IZIDimensions.iziSize.width * .37,
                          height: IZIDimensions.iziSize.width * .37,
                          color: ColorResources.SUCCESSFUL_PAGE,
                          child: Center(
                            child: Icon(
                              Icons.done_rounded,
                              size: IZIDimensions.ONE_UNIT_SIZE * 150,
                              color: ColorResources.WHITE,
                            ),
                          ),
                        ),
                      ),
                    ),
                    content ??
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                IZIDimensions.ONE_UNIT_SIZE * 60,
                                0,
                                IZIDimensions.ONE_UNIT_SIZE * 60,
                                IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  color: ColorResources.BLACK,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                IZIDimensions.ONE_UNIT_SIZE * 60,
                                0,
                                IZIDimensions.ONE_UNIT_SIZE * 60,
                                IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: Text(
                                description!,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.BLACK,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                  ],
                ),
        ),
        widgetBottomSheet: IZIButton(
          margin: EdgeInsets.fromLTRB(
            IZIDimensions.PADDING_HORIZONTAL_SCREEN,
            0,
            IZIDimensions.PADDING_HORIZONTAL_SCREEN,
            IZIDimensions.SPACE_SIZE_2X,
          ),
          type: typeButton,
          onTap: () {
            onTap();
          },
          label: labelButton,
        ),
      ),
    );
  }
}
