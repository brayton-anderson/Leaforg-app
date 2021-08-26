import 'dart:async';

//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../helpers/snackbar_notifications.dart';
//import 'package:google_map_location_picker/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/custom_trace.dart';
import '../repository/settings_repository.dart' as settingRepo;
import 'check_network/network_controller.dart';

class SplashScreenController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldMessengerState> scaffoldKey;

  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  //BuildContext context;
  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  //BuildContext context;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldMessengerState>();
    // Should define these variables before the app loaded
    progress.value = {"Setting": 0, "User": 0};
  }

  get badge => null;

  get sound => null;

  @override
  void initState() {
    super.initState();
    // firebaseMessaging.getInitialMessage();
    // configureFirebase(firebaseMessaging);
    settingRepo.setting.addListener(() {
      print(settingRepo.setting.value.appName);
      print(settingRepo.setting.value.mainColor);
      if (settingRepo.setting.value.appName != null &&
          settingRepo.setting.value.mainColor != null) {
        progress.value["Setting"] = 41;
        progress.value["User"] = 59;
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        progress.notifyListeners();
      }
    });
    // userRepo.settimgs.addListener(() {
    //   // print(userRepo.currentUser.value.auth);

    //   progress.value["User"] = 59;
    //   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    //   progress.notifyListeners();
    // });
    Timer(Duration(seconds: 20), () {
      final messages = "";
      final button = "";
      final route = "";
      final request = "check internet";

     getSnackbarNotification(messages, request, button, route);
    });
  }

  // void configureFirebase(FirebaseMessaging _firebaseMessaging) {
  //   try {
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       RemoteNotification notificationOnMessage = message.notification;
  //       AndroidNotification notificationOnLaunch =
  //           message.notification?.android;
  //     });
  //   } catch (e) {
  //     print(CustomTrace(StackTrace.current, message: e));
  //     print(CustomTrace(StackTrace.current, message: 'Error Config Firebase'));
  //   }
  // }

  Future notificationOnResume(Map<String, dynamic> message) async {
    print(CustomTrace(StackTrace.current, message: message['data']['id']));
    try {
      //  if (message['data']['id'] == "orders") {
      settingRepo.navigatorKey.currentState
          .pushReplacementNamed('/Pages', arguments: 3);
      // }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Future notificationOnLaunch(Map<String, dynamic> message) async {
    //String messageId = await settingRepo.getMessageId();
    try {
      //if (messageId != message['google.message_id']) {
      if (message['data']['id'] == "orders") {
        // await settingRepo.saveMessageId(message['google.message_id']);
        settingRepo.navigatorKey.currentState
            .pushReplacementNamed('/Pages', arguments: 3);
        // }
      }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Future notificationOnMessage(Map<String, dynamic> message) async {
    Fluttertoast.showToast(
      msg: message['notification']['title'],
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
    );
  }
}
