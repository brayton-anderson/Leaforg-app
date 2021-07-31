import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/notification.dart' as model;
import '../repository/notification_repository.dart';

class NotificationController extends ControllerMVC {
  List<model.Notification> notifications = <model.Notification>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);
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

  Future<void> refreshNotifications() async {
    notifications.clear();
    listenForNotifications(
        message: S.of(Get.context).notifications_refreshed_successfuly);
  }
}
