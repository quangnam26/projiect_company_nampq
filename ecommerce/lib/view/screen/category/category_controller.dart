import 'dart:math';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/brand/brand_response.dart';
import 'package:template/data/model/product/product_response.dart';

import 'package:template/provider/category_provider.dart';
import 'package:template/provider/product_provider.dart';

import '../../../data/model/category/category_response.dart';
import '../../../routes/route_path/detail_page_router.dart';

class CategoryController extends GetxController {
// khai bao api
  final CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  RefreshController refreshController = RefreshController();
  RefreshController refreshtrollerTow = RefreshController();

//List
  List<CategoryResponse> listCategoryRespone = [];
  List<ProductResponse> listProductsResponse = [];
  List<BrandResponse> listBrandResponse = [];

//avliable
  int selected = 0;
  int page = 1;
  int limitPage = 10;
  String id = '';
  bool isloading = false;
  bool isckeck = false;
  var arg = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    // //  Get.arguments as CategoryResponse
    // if (arg != null) {
    //   if (arg is String) {
    //     id = arg.toString();
    //   } else {
    //     id = (Get.arguments as CategoryResponse).id!;
    //   }
    // }

    getDataCategory(
      isRefresh: true,
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    refreshtrollerTow.dispose();
    super.onClose();
  }

  ///
  /// isOntaoImage
  ///
  void isOntapImage(int index) {
    selected = index;
    print("daata ${index}");

    // listCategoryRespone[index].id ?? "";
    getDataProducts(id: listCategoryRespone[index].id!, isrefresh: true);
    update();
  } 

  ///
  ///onLoading
  ///
  void onLoadingData() {
    getDataCategory(
      isRefresh: false,
    );
  }

  ///
  ///onRefresh
  ///
  void onRefreshData() {
    refreshController.resetNoData();
    getDataCategory(
      isRefresh: true,
    );
  }

  ///
  ///getDataCategory
  ///

  Future<void> getDataCategory({
    required bool isRefresh,
  }) async {
    if (isRefresh) {
      page = 1;
      listCategoryRespone.clear();
    } else {
      page++;
    }
    isloading = true;
    categoryProvider.paginate(
      page: page,
      limit: limitPage,
      filter: '',
      // '&sort=createdAt',
      onSuccess: (List<CategoryResponse> model) {
        listCategoryRespone.addAll(model);

        // selected = 5;
        if (isRefresh) {
          Future.delayed(const Duration(milliseconds: 300), () {
            refreshController.resetNoData(); // data đã làm mới lại
            refreshController.refreshCompleted();
            // làm mới dữ liệu
          });
        } else {
          refreshController.loadNoData();
          refreshController.loadComplete();
          // đã load thanh công
        }
        if (arg != null) {
          final a = listCategoryRespone.indexWhere(
              (element) => element.id.toString() == (arg as CategoryResponse).id);
          if (a != -1) {
            isOntapImage(a);
            getDataProducts(id: listCategoryRespone[a].id!, isrefresh: true);
          } else {
            getDataProducts(id: listCategoryRespone[0].id!, isrefresh: true);
          }
        } else {
          getDataProducts(id: listBrandResponse[0].id!, isrefresh: true);
        }


     

        // getDataProducts(id: id, isrefresh: true);
        isloading = false;
        update();
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  ///OnTap Product GO TO DETAIL PAGE.
  ///
  void onTapProduct({required ProductResponse proudct}) {
    Get.toNamed(DetailPageRoutes.DETAIL_PAGE, arguments: proudct)?.then(
      (_) {
        onRefreshData();
      },
    );
  }

  ///
  ///onLoading
  ///
  void onLoadingDataProduct() {
    getDataProducts(id: id, isrefresh: false);
  }

  ///
  ///onRefresh
  ///
  void onRefreshDataProduct() {
    refreshController.resetNoData();
    getDataProducts(id: id, isrefresh: true);
  }

  ///
  ///getDataProducts
  ///
  void getDataProducts({required String id, required bool isrefresh}) {
    if (isrefresh) {
      page = 1;
      listProductsResponse.clear();
    } else {
      page++;
    }
    productProvider.paginate(
      page: page,
      limit: 10,
      filter: '&category=$id',
      onSuccess: (model) {
        // listCategoryRespone.addAll(model);
        listProductsResponse.addAll(model);

        print("model11 ${model.length}");
        if (isrefresh) {
          Future.delayed(const Duration(milliseconds: 300), () {
            refreshtrollerTow.resetNoData(); // data đã làm mới lại
            refreshtrollerTow.refreshCompleted(); // data đã hoàn thành
            // làm mới dữ liệu
          });
        } else {
          refreshtrollerTow.loadNoData();
          refreshtrollerTow.loadComplete();
          // đã load thanh công
        }

        update();
      },
      onError: (onError) {
        print(onError);
      },
    );
  }
}
