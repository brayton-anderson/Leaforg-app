import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../elements/social/const.dart';
import 'package:http/http.dart' as http;

class FBCloudMessaging {
//  UserController _con;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //FBCloudMessaging(this._con);

  static FBCloudMessaging get instance => FBCloudMessaging();

  Future takeFCMTokenWhenAppLaunch() async {
    try {
      //SharedPreferences prefs = await SharedPreferences.getInstance()s

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('A new onMessageOpenedApp event was published!');
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      });

      FirebaseMessaging.onMessage.listen(
        (message) {
          RemoteNotification notification = message.notification;
          if ((defaultTargetPlatform == TargetPlatform.iOS) ||
              (defaultTargetPlatform == TargetPlatform.android)) {
            if (Platform.isIOS) {
              _firebaseMessaging.requestPermission(
                  sound: true, badge: true, alert: true);
            }
            final FlutterLocalNotificationsPlugin
                _flutterLocalNotificationsPlugin =
                FlutterLocalNotificationsPlugin();
            AndroidNotificationChannel channel;
            AndroidNotification android = message.notification?.android;

            _flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channel.description,

                    // TODO add a proper drawable resource to android, for now using
                    //      one that already exists in example app.
                    icon: 'launch_background',
                  ),
                ));
          } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
              (defaultTargetPlatform == TargetPlatform.macOS) ||
              (defaultTargetPlatform == TargetPlatform.windows)) {
            final titlehead = message.notification.title;
            final content = message.notification.body;
            ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
              content: Container(
                height: 100,
                width: 300,
                child: Column(
                  children: [
                    Text('Sample snackbar'),
                    Text(titlehead),
                    Text(content),
                  ],
                ),
              ),
              elevation: 10.0,
              backgroundColor: Colors.white,
              behavior: SnackBarBehavior.floating,
            ));
          } else {
            final titlehead = message.notification.title;
            final content = message.notification.body;
            ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
              content: Container(
                height: 100,
                width: 300,
                child: Column(
                  children: [
                    Text('Sample snackbar'),
                    Text(titlehead),
                    Text(content),
                  ],
                ),
              ),
              elevation: 10.0,
              backgroundColor: Colors.white,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
      );
    } catch (e) {
      print(e.message);
    }
  }

  Future initLocalNotification() async {
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      // set iOS Local notification.
      var initializationSettingsAndroid =
          AndroidInitializationSettings('ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    } else {
      // set Android Local notification.
      var initializationSettingsAndroid =
          AndroidInitializationSettings('ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }
  }

  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  Future _selectNotification(String payload) async {}

  sendLocalNotification(name, msg) async {
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin
        .show(0, name, msg, platformChannelSpecifics, payload: 'item x');
  }

  // Send a notification message
  Future<void> sendNotificationMessageToPeerUser(
      String body, String title, String receiverToken) async {
    //FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await http.post(
      Uri.parse('https://api.rnfirebase.io/messaging/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$firebaseCloudserverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
            'image': title,
            "sound": "default"
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': receiverToken,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        completer.complete();
      },
    );
  }
}
