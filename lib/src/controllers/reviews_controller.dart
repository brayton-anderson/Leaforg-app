import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/snackbar_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../models/review.dart';
import '../repository/product_repository.dart' as productRepo;
import '../repository/order_repository.dart';
import '../repository/store_repository.dart' as storeRepo;
import 'check_network/network_controller.dart';

class ReviewsController extends ControllerMVC {
  Review storeReview;
  List<Review> productsReviews = [];
  Order order;
  List<Product> productsOfOrder = [];
  List<OrderStatus> orderStatus = <OrderStatus>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);
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
      final messages = "";
      final button = "";
      final route = "";
      final request = "check internet";

     getSnackbarNotification(messages, request, button, route);
    }, onDone: () {
      getProductsOfOrder();
      if (message != null) {
        final messages = message;
      final button = "";
      final route = "";
      final request = "success_snack";

     getSnackbarNotification(messages, request, button, route);
      }
    });
  }

  void addProductReview(Review _review, Product _product) async {
    productRepo.addProductReview(_review, _product).then((value) {
      final messages = S.of(Get.context).the_product_has_been_rated_successfully;
      final button = "";
      final route = "";
      final request = "success_snack";

     getSnackbarNotification(messages, request, button, route);
    });
  }

  void addStoreReview(Review _review) async {
    storeRepo
        .addStoreReview(_review, this.order.productOrders[0].product.store)
        .then((value) {
      refreshOrder();
      final messages = S.of(Get.context).the_store_has_been_rated_successfully;
      final button = "";
      final route = "";
      final request = "success_snack";

     getSnackbarNotification(messages, request, button, route);
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
