import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/extra.dart';
import '../models/favorite.dart';
import '../models/product.dart';
import '../repository/cart_repository.dart';
import '../repository/product_repository.dart';

class ProductController extends ControllerMVC {
  Product product;
  double quantity = 1;
  double total = 0;
  List<Cart> carts = [];
  Favorite favorite;
  bool loadCart = false;
  GlobalKey<ScaffoldState> scaffoldKey;
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  ProductController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForProduct({String productId, String message}) async {
    final Stream<Product> stream = await getProduct(productId);
    stream.listen((Product _product) {
      setState(() => product = _product);
    }, onError: (a) {
      print(a);
      Get.snackbar(
        "Hi",
        "Leaforg",
        showProgressIndicator: false,
        duration: Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        maxWidth: MediaQuery.of(Get.context).size.width - 200,
        backgroundColor: errorColor,
        messageText: Text(
          S.of(Get.context).verify_your_internet_connection,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
    }, onDone: () {
      calculateTotal();
      if (message != null) {
        Get.snackbar(
          "Hi",
          "Leaforg",
          showProgressIndicator: false,
          duration: Duration(seconds: 5),
          snackStyle: SnackStyle.FLOATING,
          maxWidth: MediaQuery.of(Get.context).size.width - 200,
          backgroundColor: successColor,
          messageText: Text(
            message,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        );
      }
    });
  }

  void listenForFavorite({String productId}) async {
    final Stream<Favorite> stream = await isFavoriteProduct(productId);
    stream.listen((Favorite _favorite) {
      setState(() => favorite = _favorite);
    }, onError: (a) {
      print(a);
    });
  }

  void listenForCart() async {
    final Stream<Cart> stream = await getCart();
    stream.listen((Cart _cart) {
      carts.add(_cart);
    });
  }

  bool isSameStores(Product product) {
    if (carts.isNotEmpty) {
      return carts[0].product?.store?.id == product.store?.id;
    }
    return true;
  }

  void addToCart(Product product, {bool reset = false}) async {
    setState(() {
      this.loadCart = true;
    });
    var _newCart = new Cart();
    _newCart.product = product;
    _newCart.extras =
        product.extras.where((element) => element.checked).toList();
    _newCart.quantity = this.quantity;
    // if product exist in the cart then increment quantity
    var _oldCart = isExistInCart(_newCart);
    if (_oldCart != null) {
      _oldCart.quantity += this.quantity;
      updateCart(_oldCart).then((value) {
        setState(() {
          this.loadCart = false;
        });
      }).whenComplete(() {
        Get.snackbar(
          "Hi",
          "Leaforg",
          showProgressIndicator: false,
          duration: Duration(seconds: 5),
          snackStyle: SnackStyle.FLOATING,
          maxWidth: MediaQuery.of(Get.context).size.width - 200,
          backgroundColor: successColor,
          messageText: Text(
            S.of(Get.context).this_product_was_added_to_cart,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        );
      });
    } else {
      // the product doesnt exist in the cart add new one
      addCart(_newCart, reset).then((value) {
        setState(() {
          this.loadCart = false;
        });
      }).whenComplete(() {
        Get.snackbar(
          "Hi",
          "Leaforg",
          showProgressIndicator: false,
          duration: Duration(seconds: 5),
          snackStyle: SnackStyle.FLOATING,
          maxWidth: MediaQuery.of(Get.context).size.width - 200,
          backgroundColor: successColor,
          messageText: Text(
            S.of(Get.context).this_product_was_added_to_cart,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        );
      });
    }
  }

  Cart isExistInCart(Cart _cart) {
    return carts.firstWhere((Cart oldCart) => _cart.isSame(oldCart),
        orElse: () => null);
  }

  void addToFavorite(Product product) async {
    var _favorite = new Favorite();
    _favorite.product = product;
    _favorite.extras = product.extras.where((Extra _extra) {
      return _extra.checked;
    }).toList();
    addFavorite(_favorite).then((value) {
      setState(() {
        this.favorite = value;
      });
      Get.snackbar(
          "Hi",
          "Leaforg",
          showProgressIndicator: false,
          duration: Duration(seconds: 5),
          snackStyle: SnackStyle.FLOATING,
          maxWidth: MediaQuery.of(Get.context).size.width - 200,
          backgroundColor: successColor,
          messageText: Text(
            S.of(Get.context).thisProductWasAddedToFavorite,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        );
    });
  }

  void removeFromFavorite(Favorite _favorite) async {
    removeFavorite(_favorite).then((value) {
      setState(() {
        this.favorite = new Favorite();
      });
      Get.snackbar(
          "Hi",
          "Leaforg",
          showProgressIndicator: false,
          duration: Duration(seconds: 5),
          snackStyle: SnackStyle.FLOATING,
          maxWidth: MediaQuery.of(Get.context).size.width - 200,
          backgroundColor: infoColor,
          messageText: Text(
            S.of(Get.context).thisProductWasRemovedFromFavorites,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        );
    });
  }

  Future<void> refreshProduct() async {
    var _id = product.id;
    product = new Product();
    listenForFavorite(productId: _id);
    listenForProduct(
        productId: _id, message: S.of(Get.context).productRefreshedSuccessfuly);
  }

  void calculateTotal() {
    total = product?.price ?? 0;
    product?.extras?.forEach((extra) {
      total += extra.checked ? extra.price : 0;
    });
    total *= quantity;
    setState(() {});
  }

  incrementQuantity() {
    if (this.quantity <= 99) {
      ++this.quantity;
      calculateTotal();
    }
  }

  decrementQuantity() {
    if (this.quantity > 1) {
      --this.quantity;
      calculateTotal();
    }
  }
}
