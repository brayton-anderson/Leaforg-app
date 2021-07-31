import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../models/review.dart';
import '../repository/product_repository.dart' as productRepo;
import '../repository/order_repository.dart';
import '../repository/store_repository.dart' as storeRepo;

class ReviewsController extends ControllerMVC {
  Review storeReview;
  List<Review> productsReviews = [];
  Order order;
  List<Product> productsOfOrder = [];
  List<OrderStatus> orderStatus = <OrderStatus>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  ReviewsController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.storeReview = new Review.init("0");
  }

  void listenForOrder({String orderId, String message}) async {
    final Stream<Order> stream = await getOrder(orderId);
    stream.listen((Order _order) {
      setState(() {
        order = _order;
        productsReviews = List.generate(
            order.productOrders.length, (_) => new Review.init("0"));
      });
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
      getProductsOfOrder();
      if (message != null) {
        Get.snackbar(
        "Hi",
        "Leaforg",
        showProgressIndicator: false,
        duration: Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        maxWidth: MediaQuery.of(Get.context).size.width - 200,
        backgroundColor: infoColor,
        messageText: Text(
          message,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
      }
    });
  }

  void addProductReview(Review _review, Product _product) async {
    productRepo.addProductReview(_review, _product).then((value) {
      Get.snackbar(
        "Hi",
        "Leaforg",
        showProgressIndicator: false,
        duration: Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        maxWidth: MediaQuery.of(Get.context).size.width - 200,
        backgroundColor: successColor,
        messageText: Text(
          S.of(Get.context).the_product_has_been_rated_successfully,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  void addStoreReview(Review _review) async {
    storeRepo
        .addStoreReview(_review, this.order.productOrders[0].product.store)
        .then((value) {
      refreshOrder();
      Get.snackbar(
        "Hi",
        "Leaforg",
        showProgressIndicator: false,
        duration: Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        maxWidth: MediaQuery.of(Get.context).size.width - 200,
        backgroundColor: successColor,
        messageText: Text(
          S.of(Get.context).the_store_has_been_rated_successfully,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  Future<void> refreshOrder() async {
    listenForOrder(
        orderId: order.id,
        message: S.of(Get.context).reviews_refreshed_successfully);
  }

  void getProductsOfOrder() {
    this.order.productOrders.forEach((_productOrder) {
      if (!productsOfOrder.contains(_productOrder.product)) {
        productsOfOrder.add(_productOrder.product);
      }
    });
  }
}
