import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/account_user/account_controller.dart';
import '../../../routes/route_path/account_routers.dart';
import '../../../routes/route_path/my_wallet_routers.dart';
import '../../../routes/route_path/quotation_routers.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.iziSize.height,
        child: SafeArea(
          child: GetBuilder(
              init: AccountController(),
              builder: (AccountController controller) {
                if (controller.isLoading) {
                  return Center(
                    child: IZILoading().isLoadingKit,
                  );
                }
                if (!controller.isLogin) {
                  return SafeArea(
                    child: SizedBox(
                      width: IZIDimensions.iziSize.width,
                      height: IZIDimensions.iziSize.height,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: IZIDimensions.iziSize.height * .06,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IZIButton(
                                  type: IZIButtonType.OUTLINE,
                                  width: IZIDimensions.iziSize.width * .3,
                                  label: "sign_up".tr,
                                  onTap: () {
                                    controller.signUpFromGuestAccount();
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  child: IZIButton(
                                    width: IZIDimensions.iziSize.width * .3,
                                    label: "sign_in".tr,
                                    onTap: () {
                                      controller.loginFromGuestAccount();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: IZIDimensions.iziSize.height * .1,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                IZIDimensions.BORDER_RADIUS_5X,
                              ),
                              child: IZIImage(
                                ImagesPath.account_guest,
                                height: IZIDimensions.iziSize.width,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "account".tr,
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            fontWeight: FontWeight.w600,
                            color: ColorResources.BLACK,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: Obx(
                            () => ClipOval(
                              child: IZIImage(
                                !IZIValidate.nullOrEmpty(controller.userResponse.value.avatar.toString()) ? controller.userResponse.value.avatar.toString() : ImagesPath.splash_haqua,
                                width: IZIDimensions.iziSize.width * .3,
                                height: IZIDimensions.iziSize.width * .3,
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            // "Nguyễn Đặng Ngọc Ánh"
                            controller.userResponse.value.fullName ?? "HAQUA",
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                              fontWeight: FontWeight.w600,
                              color: ColorResources.BLACK.withOpacity(.7),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: IZIDimensions.SPACE_SIZE_2X,
                            left: IZIDimensions.SPACE_SIZE_1X,
                            right: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          padding: EdgeInsets.all(
                            IZIDimensions.SPACE_SIZE_2X,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: ColorResources.BORDER,
                            ),
                            borderRadius: BorderRadius.circular(
                              IZIDimensions.BORDER_RADIUS_6X,
                            ),
                          ),
                          child: Column(
                            children: [
                              /// Rating bar widget.
                              _ratingBarWidget(controller),

                              Container(
                                width: IZIDimensions.iziSize.width,
                                margin: EdgeInsets.only(
                                  top: IZIDimensions.SPACE_SIZE_2X,
                                ),
                                child: Row(
                                  children: [
                                    /// Reputation.
                                    Obx(
                                      () => _itemCustomerReviews(
                                        "Reputation".tr,
                                        (controller.userResponse.value.statisticReview!.totalReputation != 0 && controller.userResponse.value.statisticReview!.countReputation != 0) ? (controller.userResponse.value.statisticReview!.totalReputation! / controller.userResponse.value.statisticReview!.countReputation!).toStringAsPrecision(2) : '0',
                                        ImagesPath.prestige_detail_profile,
                                      ),
                                    ),
                                    _verticalDivider(),

                                    /// Satisfied.
                                    Obx(
                                      () => _itemCustomerReviews(
                                        "Satisfied".tr,
                                        controller.userResponse.value.statisticReview!.numberStatisfied!.toStringAsFixed(0),
                                        ImagesPath.logo_satisfied,
                                      ),
                                    ),
                                    _verticalDivider(),

                                    /// Unsatisfied.
                                    Obx(
                                      () => _itemCustomerReviews(
                                        "Unsatisfied".tr,
                                        controller.userResponse.value.statisticReview!.numberNotStatisfied!.toStringAsFixed(0),
                                        ImagesPath.logo_unsatisfied,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: IZIDimensions.SPACE_SIZE_5X,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: IZIDimensions.SPACE_SIZE_4X,
                            horizontal: IZIDimensions.SPACE_SIZE_3X,
                          ),
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                IZIDimensions.BORDER_RADIUS_6X,
                              ),
                              topRight: Radius.circular(
                                IZIDimensions.BORDER_RADIUS_6X,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              //Info User
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: "thong_tin_ca_nhan".tr,
                                urlIcon: ImagesPath.user,
                                isTrailing: true,
                                isLeadingUrl: true,
                                onTap: () {
                                  controller.goToInfoUser();
                                },
                              ),

                              //File
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: "ho_so".tr,
                                urlIcon: ImagesPath.directbox,
                                isTrailing: true,
                                isLeadingUrl: true,
                                onTap: () {
                                  controller.navigatorAccountMenu(appRouter: AccountRouter.BRIEFCASE);
                                },
                              ),

                              //Change Language
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: "change_language".tr,
                                urlIcon: ImagesPath.user,
                                isTrailing: true,
                                isLeadingUrl: false,
                                leadingIcon: Icons.change_circle_outlined,
                                onTap: () {
                                  controller.navigatorAccountMenu(
                                    appRouter: AccountRouter.CHANGE_LANGUAGE,
                                  );
                                },
                              ),

                              //Quote Posted
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: "cau_hoi_da_dang".tr,
                                urlIcon: ImagesPath.question,
                                isTrailing: true,
                                isLeadingUrl: true,
                                onTap: () {
                                  controller.navigatorAccountMenu(
                                    appRouter: QuotationRoutes.MY_QUESTION_LIST,
                                  );
                                },
                              ),

                              //Quoted Ques
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: "cau_hoi_da_bao_gia".tr,
                                urlIcon: ImagesPath.quotationquestion,
                                isTrailing: true,
                                isLeadingUrl: true,
                                onTap: () {
                                  controller.navigatorAccountMenu(
                                    appRouter: QuotationRoutes.QUOTATION,
                                  );
                                },
                              ),

                              //Capacity
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: "nang_luc".tr,
                                urlIcon: ImagesPath.award,
                                isTrailing: true,
                                isLeadingUrl: true,
                                onTap: () {
                                  controller.navigatorAccountMenu(
                                    appRouter: AccountRouter.YOUR_ABILITIES,
                                  );
                                },
                              ),

                              //AreasOfExpertise
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: "AreasOfExpertise".tr,
                                urlIcon: ImagesPath.areas_of_expertise_icon,
                                isTrailing: true,
                                isLeadingUrl: true,
                                onTap: () {
                                  controller.goToAreasOfExpertise();
                                },
                              ),

                              //Wallet
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: "vi_cua_toi".tr,
                                urlIcon: ImagesPath.vi,
                                isTrailing: true,
                                isLeadingUrl: true,
                                onTap: () {
                                  controller.navigatorAccountMenu(
                                    appRouter: MyWalletRouters.MYWALLET,
                                  );
                                },
                              ),

                              //Share
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: "chia_se_ban_be".tr,
                                urlIcon: ImagesPath.send,
                                isTrailing: true,
                                isLeadingUrl: true,
                                onTap: () {
                                  controller.navigatorAccountMenu(
                                    appRouter: AccountRouter.SHARE_FRIEND,
                                  );
                                },
                              ),

                              //Notice
                              Obx(
                                () => _accountMenu(
                                  controller: controller,
                                  isMarginBottom: true,
                                  isSwitchNotice: true,
                                  nameMenu: "bat_tat".tr,
                                  urlIcon: ImagesPath.copySuccess,
                                  isTrailing: true,
                                  isLeadingUrl: true,
                                  onTap: () {},
                                ),
                              ),

                              //Suggest
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: "gop_y".tr,
                                urlIcon: ImagesPath.gopy,
                                isTrailing: true,
                                isLeadingUrl: true,
                                onTap: () {},
                              ),

                              //Delete Acc
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: true,
                                isSwitchNotice: false,
                                nameMenu: 'del_acc'.tr,
                                urlIcon: ImagesPath.delete_account,
                                isTrailing: false,
                                isLeadingUrl: true,
                                onTap: () {
                                  controller.deleteAccount();
                                },
                              ),

                              //Log Out
                              _accountMenu(
                                controller: controller,
                                isMarginBottom: false,
                                isSwitchNotice: false,
                                nameMenu: "dang_xuat".tr,
                                urlIcon: ImagesPath.logout,
                                isTrailing: true,
                                isLeadingUrl: true,
                                onTap: () {
                                  controller.logOut();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  ///
  ///_accountMenu
  ///
  Widget _accountMenu({
    required AccountController controller,
    required bool isMarginBottom,
    required bool isSwitchNotice,
    required bool isTrailing,
    required bool isLeadingUrl,
    required String urlIcon,
    required String nameMenu,
    IconData? leadingIcon,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: IZIDimensions.iziSize.width,
          color: ColorResources.WHITE,
          margin: EdgeInsets.only(
            bottom: isMarginBottom ? IZIDimensions.ONE_UNIT_SIZE * 20 : 0,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorResources.ICON_LEADING_ITEM_USER_INFOR,
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BLUR_RADIUS_2X,
                  ),
                ),
                margin: EdgeInsets.only(
                  right: IZIDimensions.SPACE_SIZE_2X,
                ),
                padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
                child: isLeadingUrl
                    ? IZIImage(
                        urlIcon,
                        color: ColorResources.GREY,
                      )
                    : Icon(
                        leadingIcon,
                        color: ColorResources.GREY,
                      ),
              ),
              Expanded(
                child: Text(
                  nameMenu,
                  overflow: TextOverflow.ellipsis,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK.withOpacity(.7),
                  ),
                ),
              ),
              if (isTrailing)
                Container(
                  decoration: const BoxDecoration(),
                  child: isSwitchNotice
                      ? Switch(activeColor: ColorResources.PRIMARY_APP, value: controller.isSwitch.value, onChanged: (v) => controller.switchButtonNotify(value: v))
                      : Icon(
                          Icons.arrow_forward_ios,
                          color: ColorResources.BLACK.withOpacity(.7),
                        ),
                )
              else
                const SizedBox(),
            ],
          )),
    );
  }

  ///
  /// Rating bar widget
  ///
  Widget _ratingBarWidget(AccountController accountController) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RatingBar.builder(
            ignoreGestures: true,
            initialRating: accountController.userResponse.value.statisticReview!.totalRating == 0 || accountController.userResponse.value.statisticReview!.countRating == 0 ? 0 : accountController.userResponse.value.statisticReview!.totalRating! / accountController.userResponse.value.statisticReview!.countRating!,
            minRating: 1,
            itemSize: IZIDimensions.ONE_UNIT_SIZE * 40,
            allowHalfRating: true,
            itemPadding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_1X,
            ),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: ColorResources.STAR_COLOR,
              size: IZIDimensions.ONE_UNIT_SIZE * 40,
            ),
            onRatingUpdate: (rataing) {},
          ),
          Text(
            accountController.userResponse.value.statisticReview!.totalRating == 0 || accountController.userResponse.value.statisticReview!.countRating == 0 ? '0.0' : (accountController.userResponse.value.statisticReview!.totalRating! / accountController.userResponse.value.statisticReview!.countRating!).toStringAsPrecision(2),
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.BLACK,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Vertical Divider.
  ///
  VerticalDivider _verticalDivider() {
    return const VerticalDivider(
      thickness: 2,
      color: ColorResources.BORDER,
    );
  }

  ///
  /// Item custom reviews.
  ///
  Widget _itemCustomerReviews(String title, String countReview, String imagePath) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_SPAN,
              fontWeight: FontWeight.w600,
              color: ColorResources.BLACK,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IZIImage(
                  imagePath,
                  color: ColorResources.PRIMARY_APP,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: IZIDimensions.SPACE_SIZE_1X,
                  ),
                  child: Text(
                    countReview,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      color: ColorResources.BLACK,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
