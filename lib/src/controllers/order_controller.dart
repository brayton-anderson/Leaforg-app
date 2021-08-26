import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/snackbar_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/order.dart';
import '../repository/order_repository.dart';
import 'check_network/network_controller.dart';

class OrderController extends ControllerMVC {
  List<Order> orders = <Order>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);
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
      final messages = "";
      final button = "";
      final route = "";
      final request = "check internet";

     getSnackbarNotification(messages, request, button, route);
      
    }, onDone: () {
      if (message != null) {
      final messages = message;
      final button = "";
      final route = "";
      final request = "info_snack";

     getSnackbarNotification(messages, request, button, route);
      }
    });
  }

  void doCancelOrder(Order order) {
    cancelOrder(order).then((value) {
      setState(() {
        order.active = false;
      });
    }).catchError((e) {
      final messages = e;
      final button = "";
      final route = "";
      final request = "error_snack";

     getSnackbarNotification(messages, request, button, route);
    }).whenComplete(() {
      //refreshOrders();
      final messages = S.of(Get.context).orderThisorderidHasBeenCanceled(order.id);
      final button = "";
      final route = "";
      final request = "info_snack";

     getSnackbarNotification(messages, request, button, route);
    });
  }

  Future<void> refreshOrders() async {
    orders.clear();
    listenForOrders(message: S.of(Get.context).order_refreshed_successfuly);
  }
}
