import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/snackbar_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/order.dart';
import '../repository/order_repository.dart';
import 'check_network/network_controller.dart';

class ProfileController extends ControllerMVC {
  List<Order> recentOrders = [];
  GlobalKey<ScaffoldState> scaffoldKey;

  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  ProfileController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForRecentOrders();
  }

  void listenForRecentOrders({String message}) async {
    final Stream<Order> stream = await getRecentOrders();
    stream.listen((Order _order) {
      setState(() {
        recentOrders.add(_order);
      });
    }, onError: (a) {
      print(a);
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
      final request = "success_snack";

     getSnackbarNotification(messages, request, button, route);
        
      }
    });
  }

  Future<void> refreshProfile() async {
    recentOrders.clear();
    listenForRecentOrders(message: S.of(Get.context).orders_refreshed_successfuly);
  }
}
