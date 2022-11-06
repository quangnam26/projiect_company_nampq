import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/accounts/otherpolicies/purchasepolicy/purchase_policy_controlller.dart';
import '../../../../../utils/color_resources.dart';
import 'package:flutter_html/flutter_html.dart';

class PurchasePolicyPage extends GetView<PurchasePolicyController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Chính sách mua hàng",
          style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.NEUTRALS_1,
              fontWeight: FontWeight.w600),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: ColorResources.WHITE,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.NEUTRALS_1,
          ),
        ),
      ),
      body: GetBuilder(
        init: PurchasePolicyController(),
        builder: (PurchasePolicyController controller) {
          if (controller.isloading) {
            return SizedBox(
              height: IZIDimensions.iziSize.height * 0.8,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.ORANGE,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Html(
                // anchorKey: staticAnchorKey,
                data: controller.policyAndTermResponse!.content ?? "",
                style: {
                  "table": Style(
                    backgroundColor: Colors.black,
                  ),
                  "tr": Style(
                    border: const Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  "th": Style(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.grey,
                  ),
                  "td": Style(
                    padding: const EdgeInsets.all(6),
                    alignment: Alignment.topLeft,
                  ),
                  'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                },
                tagsList: Html.tags..addAll(['tex', 'bird', 'flutter']),
                customRenders: {
                  tagMatcher("bird"): CustomRender.inlineSpan(
                      inlineSpan: (context, buildChildren) =>
                          const TextSpan(text: "🐦")),
                  tagMatcher("flutter"): CustomRender.widget(
                      widget: (context, buildChildren) => FlutterLogo(
                            style: (context.tree.element!
                                        .attributes['horizontal'] !=
                                    null)
                                ? FlutterLogoStyle.horizontal
                                : FlutterLogoStyle.markOnly,
                            textColor: context.style.color!,
                          )),
                  tagMatcher("table"): CustomRender.widget(
                    widget: (context, buildChildren) =>
                        const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text("data"),
                    ),
                  ),

                  networkSourceMatcher(domains: ["flutter.dev"]):
                      CustomRender.widget(widget: (context, buildChildren) {
                    return const FlutterLogo(size: 36);
                  }),
                  networkSourceMatcher(domains: ["mydomain.com"]):
                      networkImageRender(
                    headers: {"Custom-Header": "some-value"},
                    altWidget: (alt) => Text(alt ?? ""),
                    loadingWidget: () => const Text("Loading..."),
                  ),
                  // On relative paths starting with /wiki, prefix with a base url
                  (context) =>
                      context.tree.element?.attributes["src"] != null &&
                      context.tree.element!.attributes["src"]!
                          .startsWith("/wiki"): networkImageRender(
                      mapUrl: (url) => "https://upload.wikimedia.org${url!}"),
                  // Custom placeholder image for broken links
                  networkSourceMatcher():
                      networkImageRender(altWidget: (_) => const FlutterLogo()),
                },
                onLinkTap: (url, _, __, ___) {
                  print("Opening $url...");
                },
                onImageTap: (src, _, __, ___) {
                  print(src);
                },
                onImageError: (exception, stackTrace) {
                  print(exception);
                },
                onCssParseError: (css, messages) {
                  print("css that errored: $css");
                  print("error messages:");
                  for (final element in messages) {
                    print(element);
                  }
                  return null;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
