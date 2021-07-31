import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/order.dart';
import '../repository/order_repository.dart';

class OrderController extends ControllerMVC {
  List<Order> orders = <Order>[];
  GlobalKey<ScaffoldState> scaffoldKey;

   var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  OrderController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForOrders();
  }

  void listenForOrders({String message}) async {
    final Stream<Order> stream = await getOrders();
    stream.listen((Order _order) {
      setState(() {
        orders.add(_order);
      });
    }, onError: (e) {
      print(e);
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

  void doCancelOrder(Order order) {
    cancelOrder(order).then((value) {
      setState(() {
        order.active = false;
      });
    }).catchError((e) {
      Get.snackbar(
        "Hi",
        "Leaforg",
        showProgressIndicator: false,
        duration: Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        maxWidth: MediaQuery.of(Get.context).size.width - 200,
        backgroundColor: errorColor,
        messageText: Text(
          e,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
    }).whenComplete(() {
      //refreshOrders();
      Get.snackbar(
        "Hi",
        "Leaforg",
        showProgressIndicator: false,
        duration: Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        maxWidth: MediaQuery.of(Get.context).size.width - 200,
        backgroundColor: infoColor,
        messageText: Text(
         S.of(Get.context).orderThisorderidHasBeenCanceled(order.id),
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  Future<void> refreshOrders() async {
    orders.clear();
    listenForOrders(message: S.of(Get.context).order_refreshed_successfuly);
  }
}
