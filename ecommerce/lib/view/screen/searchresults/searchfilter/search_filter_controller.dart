import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/brand/brand_response.dart';
import 'package:template/data/model/category/category_response.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/brand_provider.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/product_provider.dart';

class SearchFilterController extends GetxController {
  // khai áo API
  final CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();
  final BrandProvider brandProvider = GetIt.I.get<BrandProvider>();
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  RefreshController refreshController = RefreshController();

// List
  List<CategoryResponse> listCategoryResponse = [];
  List<BrandResponse> listBrandResponse = [];
  List<ProductResponse> listProductReponse = [];

//valiable
  int pageFilterSearch = 1;
  int pageLimitSearch = 10;

  bool descTextShowFlag = true;
  bool descTextPortfolio = true;
  String price1 = '0';
  String price2 = '0';

  int page = 1;
  int limitPage = 10;
  bool isLoading = false;
  double currentRange1 = 0.0;
  int selected = 0;
  int selectBrands = 0;
  String idBrand = '';
  String idCategory = '';
  bool isloading = false;

  @override
  void onInit() {
    super.onInit();
    isloading = true;
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        getDataBrand();
        _getDataCategory();
        isloading = false;
      },
    );
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  /// moreProductPortfolio
  ///
  void moreProductBrands() {
    descTextShowFlag = !descTextShowFlag;
    update();
  }

  ///
  /// more Product Brands
  ///
  void moreProductPortfolio() {
    descTextPortfolio = !descTextPortfolio;
    update();
  }

  ///
  /// selecColorProductPortfolio
  ///
  void selecColor(int index) {
    selected = index;
    idCategory = listCategoryResponse[index].id ?? "";
    update();
  }

  ///
  /// selecColorProductPortfolio
  ///
  void selecColorBand(int index) {
    selectBrands = index;
    idBrand = listBrandResponse[index].id ?? "";
    print("brand $idBrand");
    update();
  }

  ///
  ///GetDataCategory
  ///
  void _getDataCategory() {
    categoryProvider.paginate(
      page: 1,
      limit: 10,
      filter: '',
      onSuccess: (onSuccess) {
        listCategoryResponse = onSuccess;
        print("listCate $onSuccess");
        update();
      },
      onError: (onError) {
        print("on Error category $onError");
      },
    );
  }

  ///
  /// getDataBrand
  ///
  void getDataBrand() {
    brandProvider.paginate(
      page: page,
      limit: limitPage,
      filter: '',
      onSuccess: (model) {
        listBrandResponse = model;
        update();
      },
      onError: (onError) {
        print("brandProvider $onError");
      },
    );
  }

  // void onchannge() {
  //   getDatafilter();
  // }

  ///
  ///
  ///

  String getDatafilter() {
    String filter = '';
    if (double.parse(price1.toString().replaceAll('.', "")) >= 0 &&
        double.parse(price2.toString().replaceAll('.', "")) >=
            double.parse(price1.toString().replaceAll('.', ""))) {
      filter =
          '&price>=${double.parse(price1.toString().replaceAll('.', ""))}&price<=${double.parse(price2.toString().replaceAll('.', ""))}';
    }

    return filter;
  }

  ///
  ///price3
  ///
  void price3(String v) {
    price2 = v;
    update();
  }

  ///
  ///price3
  ///
  void price4(String v) {
    price1 = v;
    update();
  }

  ///
  ///Getdata
  ///
  void getdata() {
    productProvider.paginate(
      page: 1,
      limit: 10,
      filter: getDatafilter(),
      onSuccess: (onSuccess) {
        listProductReponse = onSuccess;
        update();
      },
      onError: (onError) {},
    );
  }

  ///
  ///OnBack
  ///
  void onBack() {
    print("aar ${getDatafilter()}");
    if (price1 == '0' && price2 == '0') {
      Get.back(
        result: {
          'category': IZIValidate.nullOrEmpty(idCategory)
              ? listCategoryResponse[selected].id
              : idCategory,
          'brand': IZIValidate.nullOrEmpty(idBrand)
              ? listBrandResponse[selected].id
              : idBrand,
        },
      );
    } else {
      Get.back(
        result: {
          'category': IZIValidate.nullOrEmpty(idCategory)
              ? listCategoryResponse[selected].id
              : idCategory,
          'brand': IZIValidate.nullOrEmpty(idBrand)
              ? listBrandResponse[selected].id
              : idBrand,
          'price': getDatafilter(),
        },
      );
    }
  }
}
