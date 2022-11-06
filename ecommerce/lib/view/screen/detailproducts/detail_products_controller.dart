import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/cart/cart_response.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/data/model/rate/rate_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/cart_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/rate_provider.dart';
import 'package:template/routes/route_path/cart_router.dart';
import 'package:template/view/screen/cart/cart_controller.dart';
import 'package:video_player/video_player.dart';
import '../../../data/model/cart/cart_request.dart';
import '../../../sharedpref/shared_preference_helper.dart';

class DetailProductsController extends GetxController {
  final sharedPreference = sl<SharedPreferenceHelper>();
  final CartProvider cartProvider = GetIt.I.get<CartProvider>();
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  final RateProvider rateProvider = GetIt.I.get<RateProvider>();

  // Nhận data product from arguments.
  ValueNotifier<ProductResponse> productResponse =
      ValueNotifier<ProductResponse>(ProductResponse());

  /// List
  List<RateResponse> rateResponseList = [];
  List<ProductResponse> productResponseRelatedList = <ProductResponse>[];
  String idUser = sl<SharedPreferenceHelper>().getProfile;
  // Variables.
  ColorsOption? selectedColor;
  SizesOption? selectedSize;
  int isSelected = 0;
  int quantity = 1;
  bool descTextShowFlag = false;
  RxDouble extraPrice = 0.0.obs;

  ValueNotifier<CartResponse> cart =
      ValueNotifier<CartResponse>(CartResponse());
  ValueNotifier<int> stock = ValueNotifier<int>(0);
  ValueNotifier<int> amountProductInCart = ValueNotifier<int>(0);
  ValueNotifier<bool> isFavorite = ValueNotifier<bool>(false);

  VideoPlayerController? videoController;
  Future<void>? initializeControllerFuture;
  String? id;

  @override
  void onInit() {
    final arg = Get.arguments;
    if (arg != null) {
      if (arg is String) {
        id = arg.toString();
      } else {
        productResponse.value = Get.arguments as ProductResponse;
      }
    }
    getProduct();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    cart.dispose();
    stock.dispose();
    amountProductInCart.dispose();
    productResponse.dispose();
    videoController?.dispose();
    extraPrice.close();
  }

  ///
  /// Get current product.
  ///
  void getProduct() {
    productProvider.find(
      id: IZIValidate.nullOrEmpty(id)
          ? productResponse.value.id.toString()
          : id.toString(),
      onSuccess: (product) {
        productResponse.value = product;
        // init data.
        initColorAndSize();
        _getRelateProduct();

        if (!IZIValidate.nullOrEmpty(productResponse.value)) {
          _getRate();
        }

        // Get cart of user.
        getCartForUser();
        update();
      },
      onError: (onError) {},
    );
  }

  Future<void> _startVideoPlayer(String path) async {
    videoController = VideoPlayerController.network(path);
    initializeControllerFuture = videoController?.initialize();

    videoController!.addListener(() {
      // ignore: unnecessary_statements
      videoController!.value.position;
      update();
    });
  }

  ///
  /// Init data.
  ///
  void initColorAndSize() {
    isFavorite.value = productResponse.value.favorites
            ?.contains(sharedPreference.getProfile) ??
        false;
    if (productResponse.value.colorsOption != null) {
      if (productResponse.value.colorsOption!.isNotEmpty) {
        selectedColor = productResponse.value.colorsOption!.first;
      }
    }

    if (productResponse.value.sizesOption != null) {
      if (productResponse.value.sizesOption!.isNotEmpty) {
        selectedSize = productResponse.value.sizesOption!.first;
      }
    }
    getAmountInStock(
      color: selectedColor == null ? '' : selectedColor!.id.toString(),
      size: selectedSize == null ? '' : selectedSize!.id.toString(),
    );
    getExtraPrice();
  }

  ///
  /// The add product into my favorite.
  ///
  void favorite() {
    productProvider.favorite(
      userId: sharedPreference.getProfile,
      productId: productResponse.value.id.toString(),
      onSuccess: (val) {
        /// Favorite successful.
        isFavorite.value =
            val.favorites?.contains(sharedPreference.getProfile) ?? false;
      },
      onError: (onError) {
        debugPrint(
            "An error occurred while trying to favorite the product $onError");
      },
    );
  }

  ///
  /// getRate
  ///
  void _getRate() {
    rateProvider.paginate(
      page: 1,
      limit: 1,
      filter: "&product=${productResponse.value.id}&populate=user",
      onSuccess: (data) {
        if (IZIValidate.nullOrEmpty(data)) {
          rateResponseList = [];
        } else {
          rateResponseList = data;
          if (!IZIValidate.nullOrEmpty(rateResponseList.first.video)) {
            _startVideoPlayer(rateResponseList.first.video!.first);
          }
        }
        update();
      },
      onError: (onError) {
        debugPrint("An error occurred while getting rate for product $onError");
      },
    );
  }

  ///
  /// ontapSize
  ///
  void onChangeSized(SizesOption size) {
    selectedSize = size;
    getAmountInStock(
      color: selectedColor == null ? '' : selectedColor!.id.toString(),
      size: selectedSize == null ? '' : selectedSize!.id.toString(),
    );
    getExtraPrice();
    update();
  }

  ///
  ///imageOntap
  ///
  void imageOnTap(int index) {
    isSelected = index;
    update();
  }

  ///
  /// colorOntap
  ///
  void onChangeColor(ColorsOption color) {
    selectedColor = color;
    getAmountInStock(
      color: selectedColor == null ? '' : selectedColor!.id.toString(),
      size: selectedSize == null ? '' : selectedSize!.id.toString(),
    );
    getExtraPrice();
    update();
  }

// flag show text (Xem thêm  hay rút gọn)
  void onPressViewMoreOrShort() {
    descTextShowFlag = !descTextShowFlag;
    update();
  }

  ///
  /// get Relate Product
  ///
  void _getRelateProduct() {
    EasyLoading.show(status: "please waiting....");
    productProvider.paginate(
      page: 1,
      limit: 5,
      filter:
          '&_id!=${productResponse.value.id}&category=${productResponse.value.idCategory?.id}&populate=product',
      onSuccess: (data) {
        productResponseRelatedList = data;

        update();
        EasyLoading.dismiss();
      },
      onError: (onError) {
        debugPrint("An error occurred while retrieving product $onError");
        EasyLoading.dismiss();
      },
    );
  }

  ///
  /// Get the cart of user.
  ///
  void getCartForUser() {
    cartProvider.paginate(
      page: 1,
      limit: 1,
      filter: '&user=${sharedPreference.getProfile}&populate=items.product',
      onSuccess: (cart) {
        // If user haven't cart. Create a new cart.
        if (cart.isEmpty) {
          // Create a new cart.
          createNewCartForUser();
        } else {
          // Cart.
          this.cart.value = cart.first;
          setAmountProductInCart();
        }
      },
      onError: (onError) {
        debugPrint("An error occurred while getting the cart of user $onError");
      },
    );
  }

  ///
  /// Create a new cart.
  ///
  void createNewCartForUser() {
    final CartRequest cart = CartRequest();
    cart.itemsOption = [];
    cart.userResponse = UserResponse(id: sharedPreference.getProfile);
    cartProvider.add(
      data: cart,
      onSuccess: (cart) {
        // Create a new cart sucessfully.
        this.cart.value = cart;
      },
      onError: (onError) {
        debugPrint(
            "An error occurred while creating the cart of user $onError");
      },
    );
  }

  ///
  /// Add product to the cart of user.
  ///
  void addProductToCart({required String cartId}) {
    // QuantityPrices
    final QuantityPrices quantityPrices = QuantityPrices();
    final option = isHaveInCart();
    final amount = option.quantityPrices == null
        ? 0
        : IZINumber.parseInt(option.quantityPrices?.quantity);
    quantityPrices.idSize = selectedSize?.id;
    quantityPrices.idColors = selectedColor?.id;
    quantityPrices.price = productResponse.value.price;

    if (amount > 0) {
      option.quantity =
          IZINumber.parseInt(option.quantityPrices?.quantity) + quantity;
      if (this.cart.value.itemsOption != null &&
          this.cart.value.itemsOption!.isNotEmpty) {
        this
            .cart
            .value
            .itemsOption
            ?.firstWhere((element) => element.hashCode == option.hashCode)
            .quantityPrices
            ?.quantity = option.quantity;
      }
    } else {
      quantityPrices.quantity = quantity;
    }

    // itemOptions
    final ItemsOptionResponse item = ItemsOptionResponse();
    item.quantityPrices = quantityPrices;
    item.idProduct = productResponse.value;

    // update
    final CartRequest cart = CartRequest();
    cart.itemsOption = amount > 0
        ? [...this.cart.value.itemsOption ?? []]
        : [...this.cart.value.itemsOption ?? [], item];

    cartProvider.update(
      data: cart,
      id: cartId,
      onSuccess: (CartRequest cart) {
        // Add the product to the cart sucessfully.
        quantity = 1;
        this.cart.value = cart;
        setAmountProductInCart();
        Get.back();
      },
      onError: (onError) {
        // Get.offAllNamed(SplashRoutes.LOGIN);
      },
    );
  }

  ///
  /// @return true if have the product available.
  ///
  ItemsOptionResponse isHaveInCart() {
    if (cart.value.itemsOption == null) {
      return ItemsOptionResponse();
    }
    final itemOption = cart.value.itemsOption?.firstWhere((element) {
      return element.idProduct?.id == productResponse.value.id &&
          element.quantityPrices?.idColors == selectedColor?.name &&
          element.quantityPrices?.idSize == selectedSize?.name;
    }, orElse: () => ItemsOptionResponse());
    return itemOption!;
  }

  ///
  /// Update amount product in the cart.
  ///
  void setAmountProductInCart() {
    if (IZIValidate.nullOrEmpty(idUser)) {
      amountProductInCart.value = 0;
    } else {
      amountProductInCart.value =
          cart.value.itemsOption == null ? 0 : cart.value.itemsOption!.length;
    }
  }

  ///
  /// Get extra price;
  ///
  void getExtraPrice() {
    if (!IZIValidate.nullOrEmpty(productResponse.value.quantityPrices) &&
        productResponse.value.quantityPrices!.isNotEmpty) {
      final val = productResponse.value.quantityPrices!.firstWhereOrNull(
          (element) =>
              element.idSize == selectedSize!.id.toString() &&
              selectedColor!.id.toString() == element.idColors);
      if (val != null) {
        extraPrice.value = IZINumber.parseDouble(val.price);
      }
    }
    extraPrice.value = 0;
  }

  ///
  /// Get stock of the product.
  ///
  void getAmountInStock({required String size, required String color}) {
    QuantityPrices option = QuantityPrices();
    // Haven't both.
    if (productResponse.value.sizesOption == null &&
        productResponse.value.colorsOption == null) {
      productResponse.value.quantityPrices!.firstWhere(
        (element) =>
            size.toLowerCase() == element.idSize.toString().toLowerCase() &&
            color.toLowerCase() == element.idColors.toString().toLowerCase(),
        orElse: () => QuantityPrices(),
      );
    } else {
      // If haven't size.
      if (productResponse.value.sizesOption == null) {
        option = productResponse.value.quantityPrices!.firstWhere(
          (element) =>
              color.toLowerCase() == element.idColors.toString().toLowerCase(),
          orElse: () => QuantityPrices(),
        );
      } else {
        // If haven't color.
        if (productResponse.value.colorsOption == null) {
          option = productResponse.value.quantityPrices!.firstWhere(
            (element) =>
                size.toLowerCase() == element.idSize.toString().toLowerCase(),
            orElse: () => QuantityPrices(),
          );
        } else {
          // Have both.
          option = productResponse.value.quantityPrices!.firstWhere(
            (element) =>
                size.toLowerCase() == element.idSize.toString().toLowerCase() &&
                color.toLowerCase() ==
                    element.idColors.toString().toLowerCase(),
            orElse: () => QuantityPrices(),
          );
        }
      }
    }

    if (option.id != null) {
      stock.value = IZINumber.parseInt(option.quantity);
    } else {
      stock.value = 0;
    }
    // return stock.value;
  }

  ///
  /// get money have promote.
  ///
  double getMoneyHavePromote() {
    return productResponse.value.price! -
        (productResponse.value.price! *
            (productResponse.value.discountPercent! / 100));
  }

  ///
  /// get money have promote with product.
  ///
  double getPromotionWithProduct(ProductResponse product) {
    return product.price! - (product.price! * (product.discountPercent! / 100));
  }

  ///
  /// quantityChanged
  ///
  // ignore: avoid_setters_without_getters
  set quantityChanged(int newQuantity) {
    quantity = newQuantity;
  }

  ///
  /// On tap product.
  ///
  void onTapProduct({required ProductResponse productResponse}) {
    this.productResponse.value = productResponse;

    _getRelateProduct();
  }

  ///
  /// On payment product.
  ///
  void onPayment() {
    Get.toNamed(CartRoutes.CART)?.then(
      (_) {
        getCartForUser();
        Get.delete<CartController>();
      },
    );
  }

  void buttonOnOffVideo(VideoPlayerController videoPlayerController) {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      // If the video is paused, play it.
      videoPlayerController.play();
    }
    update();
  }
}
