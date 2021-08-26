import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/snackbar_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../repository/cart_repository.dart';
import '../repository/category_repository.dart';
import '../repository/product_repository.dart';
import 'check_network/network_controller.dart';

class CategoryController extends ControllerMVC {
  List<Product> products = <Product>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  Category category;
  bool loadCart = false;
  List<Cart> carts = [];

  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);

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
      final messages = "";
      final button = "";
      final route = "";
      final request = "check internet";

     getSnackbarNotification(messages, request, button, route);
    }, onDone: () {
      if (message != null) {
      // final messages = "";
      final button = "";
      final route = "";
      final request = "success_snack";

     getSnackbarNotification(message, request, button, route);
      }
    });
  }

  void listenForCategory({String id, String message}) async {
    final Stream<Category> stream = await getCategory(id);
    stream.listen((Category _category) {
      setState(() => category = _category);
    }, onError: (a) {
      print(a);
      final messages = "";
      final button = "";
      final route = "";
      final request = "check internet";

     getSnackbarNotification(messages, request, button, route);
    }, onDone: () {
      if (message != null) {
        // final messages = "";
      final button = "";
      final route = "";
      final request = "success_snack";

     getSnackbarNotification(message, request, button, route);
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
      final messages = S.of(Get.context).this_product_was_added_to_cart;
      final button = "";
      final route = "";
      final request = "success_snack";

     getSnackbarNotification(messages, request, button, route);
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
      final messages = S.of(Get.context).this_product_was_added_to_cart;
      final button = "";
      final route = "";
      final request = "success_snack";

     getSnackbarNotification(messages, request, button, route);
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
