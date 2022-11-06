import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_box_image.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/account_user/infor_account/infor_account_controller.dart';

class InforAccountPage extends GetView<InforAccountController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: IZIScreen(
        isSingleChildScrollView: false,
        appBar: IZIAppBar(
          widthActions: IZIDimensions.iziSize.width * .5,
          actions: [
            GetBuilder(
              init: InforAccountController(),
              builder: (InforAccountController controller) {
                return Obx(() => IZIButton(
                      borderRadius: IZIDimensions.BORDER_RADIUS_4X,
                      padding: EdgeInsets.symmetric(
                        vertical: IZIDimensions.SPACE_SIZE_2X,
                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      margin: EdgeInsets.zero,
                      width: IZIDimensions.iziSize.width * .35,
                      isEnabled: controller.genBollButtonUpdate(),
                      onTap: () {
                        controller.onPushDataUpdateProfileUser();
                      },
                      label: 'update'.tr,
                    ));
              },
            ),
          ],
          iconBack: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorResources.PRIMARY_APP,
              size: IZIDimensions.ONE_UNIT_SIZE * 45,
            ),
          ),
          title: "",
        ),
        body: GetBuilder<InforAccountController>(
            init: InforAccountController(),
            builder: (InforAccountController controller) {
              if (controller.isLoading) {
                return Center(
                  child: IZILoading().isLoadingKit,
                );
              }
              return Container(
                padding: EdgeInsets.fromLTRB(
                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                  IZIDimensions.SPACE_SIZE_3X,
                  IZIDimensions.SPACE_SIZE_2X,
                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                ),
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.iziSize.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Avatar.
                      _avatar(controller),

                      /// Phone number.
                      if (!IZIValidate.nullOrEmpty(controller.phoneNumberController))
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: _phoneNumber(controller),
                        ),

                      /// Full name.
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: _fullName(controller),
                      ),

                      /// Born.
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: _born(controller),
                      ),

                      /// Gender.
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: _gender(controller),
                      ),

                      /// Province.
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: _province(controller),
                      ),

                      /// Nation.
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: _nation(controller),
                      ),

                      /// Job.
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: _job(controller),
                      ),

                      /// Experience.
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: _experience(controller),
                      ),

                      /// LIST EXPERIENCE.
                      Obx(() {
                        if (!IZIValidate.nullOrEmpty(controller.experienceRequestList)) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.experienceRequestList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                padding: EdgeInsets.all(
                                  IZIDimensions.SPACE_SIZE_2X,
                                ),
                                width: IZIDimensions.iziSize.width,
                                decoration: BoxDecoration(
                                  color: ColorResources.WHITE,
                                  borderRadius: BorderRadius.circular(
                                    IZIDimensions.BLUR_RADIUS_3X,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  bottom: IZIDimensions.SPACE_SIZE_1X,
                                                ),
                                                child: Text(
                                                  'Field'.tr,
                                                  style: TextStyle(
                                                    color: ColorResources.BLACK,
                                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controller.experienceRequestList[index].fieldName.toString(),
                                                  style: TextStyle(
                                                    color: ColorResources.BLACK,
                                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Years_experience'.tr,
                                                style: TextStyle(
                                                  color: ColorResources.BLACK,
                                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controller.experienceRequestList[index].year.toString(),
                                                  style: TextStyle(
                                                    color: ColorResources.BLACK,
                                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller.onDeleteExperience(index: index);
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: ColorResources.RED,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }

                        return const SizedBox();
                      }),

                      Obx(() {
                        /// Major.
                        if (!IZIValidate.nullOrEmpty(controller.capacityList)) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: _major(controller),
                          );
                        }

                        return const SizedBox();
                      }),

                      /// Albums.
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: _albums(controller),
                      ),

                      /// Certificates.
                      Obx(() {
                        if (!IZIValidate.nullOrEmpty(controller.capacityList)) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: _certificates(controller),
                          );
                        }

                        return const SizedBox();
                      }),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  ///
  /// Avatar.
  ///
  Widget _avatar(InforAccountController controller) {
    return Obx(() => Container(
          margin: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_3X,
          ),
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.width * .31,
          child: GestureDetector(
            onTap: () {
              controller.pickAvatar();
            },
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorResources.PRIMARY_APP,
                        shape: BoxShape.circle,
                      ),
                      width: IZIDimensions.iziSize.width * .30,
                      height: IZIDimensions.iziSize.width * .30,
                      child: Center(
                        child: ClipOval(
                          child: IZIImage(
                            !IZIValidate.nullOrEmpty(controller.userResponse.value.avatar) ? controller.userResponse.value.avatar.toString() : ImagesPath.logo_haqua,
                            width: IZIDimensions.iziSize.width * .28,
                            height: IZIDimensions.iziSize.width * .28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: IZIDimensions.ONE_UNIT_SIZE,
                  left: IZIDimensions.iziSize.width * .52,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorResources.PRIMARY_APP,
                      shape: BoxShape.circle,
                    ),
                    width: IZIDimensions.ONE_UNIT_SIZE * 60,
                    height: IZIDimensions.ONE_UNIT_SIZE * 60,
                    child: Center(
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        size: IZIDimensions.ONE_UNIT_SIZE * 35,
                        color: ColorResources.WHITE,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  ///
  /// Phone Number.
  ///
  Widget _phoneNumber(InforAccountController controller) {
    return Obx(() => IZIInput(
          label: "phone_number".tr,
          borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
          placeHolder: "phone_number".tr,
          type: IZIInputType.PHONE,
          isBorder: true,
          colorBorder: ColorResources.PRIMARY_APP,
          disbleError: true,
          allowEdit: false,
          initValue: IZIOther().formatPhoneNumber(controller.phoneNumberController.toString()),
        ));
  }

  ///
  /// Full name.
  ///
  Widget _fullName(InforAccountController controller) {
    return Obx(() => IZIInput(
          label: "fullName".tr,
          borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
          placeHolder: "import_full_name".tr,
          type: IZIInputType.TEXT,
          isBorder: true,
          colorBorder: ColorResources.PRIMARY_APP,
          disbleError: true,
          initValue: controller.fullNameController.value,
          onChanged: (val) {
            controller.onChangedValueName(val);
          },
          errorText: controller.errorTextName.value,
          validate: (val) {
            controller.onValidateName(val);
            return null;
          },
        ));
  }

  ///
  /// Born.
  ///
  Widget _born(InforAccountController controller) {
    return Obx(() => IZIInput(
          label: "date".tr,
          borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
          placeHolder: IZIDate.formatDate(DateTime.now()).tr,
          type: IZIInputType.TEXT,
          isBorder: true,
          colorBorder: ColorResources.PRIMARY_APP,
          disbleError: true,
          isDatePicker: true,
          iziPickerDate: IZIPickerDate.CUPERTINO,
          initValue: controller.bornController.value,
          maximumDate: DateTime.now().add(const Duration(hours: 1)),
          onChanged: (val) {
            print(val);
            controller.onChangedBorn(val);
          },
        ));
  }

  ///
  /// Gender.
  ///
  Widget _gender(InforAccountController controller) {
    return Obx(() => DropDownButton<String>(
          borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
          data: GENDER_DATA_PROFILE,
          isRequired: false,
          value: controller.sexController.value,
          label: "gender".tr,
          isSort: false,
          hint: "import_gender".tr,
          onChanged: (val) {
            controller.onChangedGender(val!);
          },
        ));
  }

  ///
  /// Province.
  ///
  Widget _province(InforAccountController controller) {
    return Obx(() => DropDownButton<ProvinceResponse>(
          borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
          data: controller.provinceResponseList,
          isRequired: false,
          value: !IZIValidate.nullOrEmpty(controller.provinceResponse.value.id) ? controller.provinceResponse.value : null,
          label: "province".tr,
          isSort: false,
          hint: "import_province".tr,
          onChanged: (val) {
            controller.onChangedProvince(val!);
          },
        ));
  }

  ///
  /// Nation.
  ///
  Widget _nation(InforAccountController controller) {
    return Obx(() => DropDownButton<String>(
          borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
          data: NATION_PROFILE,
          isRequired: false,
          value: !IZIValidate.nullOrEmpty(controller.countryController.value) ? controller.countryController.value : null,
          label: "nation".tr,
          onChanged: (val) {
            controller.onChangedCountry(val!);
          },
          isSort: false,
          hint: "import_nation".tr,
        ));
  }

  ///
  /// job.
  ///
  Widget _job(InforAccountController controller) {
    return Obx(() => IZIInput(
          label: "Job".tr,
          borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
          placeHolder: "import_job".tr,
          type: IZIInputType.TEXT,
          isBorder: true,
          colorBorder: ColorResources.PRIMARY_APP,
          disbleError: true,
          initValue: controller.jobController.value,
          onChanged: (val) {
            controller.onChangedJob(val);
          },
        ));
  }

  ///
  /// Experience.
  ///
  Widget _experience(InforAccountController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: Text(
                'experience'.tr,
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: IZIDimensions.iziSize.width,
              padding: EdgeInsets.all(
                IZIDimensions.SPACE_SIZE_2X,
              ),
              decoration: BoxDecoration(
                color: ColorResources.WHITE,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BORDER_RADIUS_3X,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: Text(
                      'experience'.tr,
                      style: TextStyle(
                        color: ColorResources.BLACK,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: IZIInput(
                            borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                            placeHolder: "import_speciality".tr,
                            type: IZIInputType.TEXT,
                            isBorder: true,
                            colorBorder: ColorResources.PRIMARY_APP,
                            fillColor: ColorResources.GREY.withOpacity(.2),
                            disbleError: true,
                            onChanged: (val) {
                              controller.onChangedExperience(val);
                            },
                            errorText: controller.errorTextExperience.value,
                            validate: (val) {
                              controller.onValidateExperience(val);
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        Expanded(
                          flex: 2,
                          child: IZIInput(
                            borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                            placeHolder: "year".tr,
                            type: IZIInputType.NUMBER,
                            fillColor: ColorResources.GREY.withOpacity(.2),
                            isBorder: true,
                            colorBorder: ColorResources.PRIMARY_APP,
                            disbleError: true,
                            onChanged: (val) {
                              controller.onChangedYear(val);
                            },
                            // errorText: controller.errorTextPassword,
                            // validate: (val) {
                            //   controller.onValidatePassword(val);
                            //   return null;
                            // },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          child: Text(
                            'year'.tr,
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IZIButton(
                        isEnabled: controller.genBollButtonExperience(),
                        width: IZIDimensions.iziSize.width * .4,
                        label: 'Add_new'.tr,
                        onTap: () {
                          controller.addExperience();
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  ///
  /// Major.
  ///
  Widget _major(InforAccountController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: Text(
                "Image_description_major_if_so".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.BLACK,
                ),
              ),
            ),
            IZIBoxImage(
              onPress: () {},
              onPreviewImages: (val, values) {
                controller.goToPreviewImage(imageUrl: val);
              },
              onDelete: (val, values) {},
              images: !IZIValidate.nullOrEmpty(controller.capacityList) ? controller.capacityList : [],
            ),
          ],
        ));
  }

  ///
  /// Albums.
  ///
  Widget _albums(InforAccountController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: Text(
                "avatar".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.BLACK,
                ),
              ),
            ),
            IZIBoxImage(
              onDelete: (val, values) {
                controller.onDeleteFiles(file: val, files: values);
              },
              isAddImage: true,
              images: !IZIValidate.nullOrEmpty(controller.albumsList) ? controller.albumsList : [],
              onPress: () {
                controller.pickAlbums();
              },
            ),
          ],
        ));
  }

  ///
  /// Certificates.
  ///
  Widget _certificates(InforAccountController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_1X,
          ),
          child: Text(
            "certificate".tr,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
              fontWeight: FontWeight.w600,
              color: ColorResources.BLACK,
            ),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.historyQuizResponseList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_2X,
                ),
                width: IZIDimensions.iziSize.width,
                padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BORDER_RADIUS_2X,
                  ),
                  color: ColorResources.WHITE,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BORDER_RADIUS_2X,
                      ),
                      child: IZIImage(
                        controller.historyQuizResponseList[index].idCertificate!.thumbnail.toString(),
                        width: IZIDimensions.ONE_UNIT_SIZE * 140,
                        height: IZIDimensions.ONE_UNIT_SIZE * 140,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              child: Text(
                                controller.historyQuizResponseList[index].idCertificate!.title.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              child: Text(
                                '${'percent_certi'.tr} ${controller.historyQuizResponseList[index].percent!.toStringAsFixed(0)}/100%',
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              child: Text(
                                '${'number_exam_certi'.tr} ${controller.historyQuizResponseList[index].numberTest}',
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              child: Text(
                                '${'last_date_certi'.tr} ${IZIDate.formatDate(controller.historyQuizResponseList[index].updatedAt!)}',
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }
}
