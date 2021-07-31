import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../repository/cart_repository.dart';
import '../repository/category_repository.dart';
import '../repository/product_repository.dart';

class CategoryController extends ControllerMVC {
  List<Product> products = <Product>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  Category category;
  bool loadCart = false;
  List<Cart> carts = [];

  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);

  CategoryController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForProductsByCategory({String id, String message}) async {
    final Stream<Product> stream = await getProductsByCategory(id);
    stream.listen((Product _product) {
      setState(() {
        products.add(_product);
      });
    }, onError: (a) {
      Get.snackbar(
            "Hi",
            "Leaforg",
            showProgressIndicator: false,
            duration: Duration(seconds: 5),
            snackStyle: SnackStyle.FLOATING,
            maxWidth: MediaQuery.of(Get.context).size.width - 200,
            backgroundColor: errorColor,
            messageText: Text(
              '${S.of(Get.context).verify_your_internet_connection}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          );
    }, onDone: () {
      if (message != null) {
        Get.snackbar(
            "Hi",
            "Leaforg",
            showProgressIndicator: false,
            duration: Duration(seconds: 5),
            snackStyle: SnackStyle.FLOATING,
            maxWidth: MediaQuery.of(Get.context).size.width - 200,
            backgroundColor: Theme.of(Get.context).secondaryHeaderColor,
            messageText: Text(
              message,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          );
      }
    });
  }

  void listenForCategory({String id, String message}) async {
    final Stream<Category> stream = await getCategory(id);
    stream.listen((Category _category) {
      setState(() => category = _category);
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
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          );
    }, onDone: () {
      if (message != null) {
        Get.snackbar(
            "Hi",
            "Leaforg",
            showProgressIndicator: false,
            duration: Duration(seconds: 5),
            snackStyle: SnackStyle.FLOATING,
            maxWidth: MediaQuery.of(Get.context).size.width - 200,
            backgroundColor: Theme.of(Get.context).secondaryHeaderColor,
            messageText: Text(
              message,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          );
      }
    });
  }

  Future<void> listenForCart() async {
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
    _newCart.extras = [];
    _newCart.quantity = 1;
    // if product exist in the cart then increment quantity
    var _oldCart = isExistInCart(_newCart);
    if (_oldCart != null) {
      _oldCart.quantity++;
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
            backgroundColor: Theme.of(Get.context).secondaryHeaderColor,
            messageText: Text(
              S.of(Get.context).this_product_was_added_to_cart,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
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
        if (reset) carts.clear();
        carts.add(_newCart);
        Get.snackbar(
            "Hi",
            "Leaforg",
            showProgressIndicator: false,
            duration: Duration(seconds: 5),
            snackStyle: SnackStyle.FLOATING,
            maxWidth: MediaQuery.of(Get.context).size.width - 200,
            backgroundColor: Theme.of(Get.context).secondaryHeaderColor,
            messageText: Text(
              S.of(Get.context).this_product_was_added_to_cart,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          );
      });
    }
  }

  Cart isExistInCart(Cart _cart) {
    return carts.firstWhere((Cart oldCart) => _cart.isSame(oldCart),
        orElse: () => null);
  }

  Future<void> refreshCategory() async {
    products.clear();
    category = new Category();
    listenForProductsByCategory(
        message: S.of(Get.context).category_refreshed_successfuly);
    listenForCategory(message: S.of(Get.context).category_refreshed_successfuly);
  }
}
