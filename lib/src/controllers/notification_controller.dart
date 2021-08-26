import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/snackbar_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/notification.dart' as model;
import '../repository/notification_repository.dart';
import 'check_network/network_controller.dart';

class NotificationController extends ControllerMVC {
  List<model.Notification> notifications = <model.Notification>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  NotificationController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForNotifications();
  }

  void listenForNotifications({String message}) async {
    final Stream<model.Notification> stream = await getNotifications();
    stream.listen((model.Notification _notification) {
      setState(() {
        notifications.add(_notification);
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
      final request = "info_snack";

     getSnackbarNotification(messages, request, button, route);
      }
    });
  }

  Future<void> refreshNotifications() async {
    notifications.clear();
    listenForNotifications(
        message: S.of(Get.context).notifications_refreshed_successfuly);
  }
}
