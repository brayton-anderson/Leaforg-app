// @dart=2.11


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'src/bindings/network_binding.dart';
import 'package:provider/provider.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

import 'generated/l10n.dart';
import 'route_generator.dart';
import 'src/bloc/application_bloc.dart';
import 'src/helpers/FBCloudMessaging.dart';
import 'src/helpers/app_config.dart' as config;
import 'src/models/setting.dart';
import 'src/repository/user_repository.dart' as userRepo;
import 'src/repository/settings_repository.dart' as settingRepo;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  if ((defaultTargetPlatform == TargetPlatform.iOS) ||
      (defaultTargetPlatform == TargetPlatform.android)) {
    await Firebase.initializeApp();
  } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
      (defaultTargetPlatform == TargetPlatform.macOS) ||
      (defaultTargetPlatform == TargetPlatform.windows)) {
    // Some desktop specific code there
  } else {
    // Some web specific code there
  }
  print('Handling a background message ${message.messageId}');
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GlobalConfiguration().loadFromAsset("configurations");
  if ((defaultTargetPlatform == TargetPlatform.iOS) ||
      (defaultTargetPlatform == TargetPlatform.android)) {
    await Firebase.initializeApp();
    AndroidNotificationChannel channel;
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
      (defaultTargetPlatform == TargetPlatform.macOS) ||
      (defaultTargetPlatform == TargetPlatform.windows)) {
    // Some desktop specific code there
  } else {
    // Some web specific code there
  }
  //await ApplicationBloc();
  //print(CustomTrace(StackTrace.current,
  //  message: "base_url: ${GlobalConfiguration().getString('base_url')}"));
  //print(CustomTrace(StackTrace.current,
  //  message:
  //  "api_base_url: ${GlobalConfiguration().getString('api_base_url')}"));
  configureApp();
  //setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FBCloudMessaging.instance.takeFCMTokenWhenAppLaunch();
    //FBCloudMessaging.instance.initLocalNotification();
    settingRepo.initSettings();
    settingRepo.getCurrentLocation();
    userRepo.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ApplicationBloc(),
        //final applicationBloc = Provider.of<ApplicationBloc>(context)
        child: ValueListenableBuilder(
            valueListenable: settingRepo.setting,
            builder: (context, Setting _setting, _) {
              // print(CustomTrace(StackTrace.current,
              //  message: _setting.toMap().toString()));
              return GetMaterialApp(
                  enableLog: true,
                  defaultTransition: Transition.fade,
                  //opaqueRoute: Get.isOpaqueRouteDefault,
                  //popGesture: Get.isPopGestureEnable,
                  //transitionDuration: Get.defaultTransitionDuration,
                  navigatorKey: settingRepo.navigatorKey,
                  title: _setting.appName,
                  initialRoute: '/Splash',
                  initialBinding: CreateNewtworkBinding(),
                  onGenerateRoute: RouteGenerator.generateRoute,
                  debugShowCheckedModeBanner: false,
                  locale: _setting.mobileLanguage.value,
                  localizationsDelegates: [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  theme: _setting.brightness.value == Brightness.light
                      ? ThemeData(
                          fontFamily: 'Poppins',
                          primaryColor: Color(0xFFFFFFFF),
                          floatingActionButtonTheme:
                              FloatingActionButtonThemeData(
                                  elevation: 0, foregroundColor: Colors.white),
                          brightness: Brightness.light,
                          secondaryHeaderColor: config.Colors().mainColor(1),
                          dividerColor: config.Colors().accentColor(0.1),
                          focusColor: config.Colors().accentColor(1),
                          primaryColorLight: Color(0xFFe6ffec),
                          selectedRowColor: Color(0xFFffaa00),
                          shadowColor: Color(0xFF1D1D1D).withOpacity(0.3),
                          splashColor: Color(0xFF000000),
                          scaffoldBackgroundColor: Color(0xFFF9F9F9),
                          hintColor: config.Colors().secondColor(1),
                          textTheme: TextTheme(
                            headline5: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                                color: config.Colors().secondColor(1),
                                height: 1.35),
                            headline4: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).splashColor,
                                height: 1.35),
                            headline3: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: config.Colors().secondColor(1),
                                height: 1.35),
                            headline2: TextStyle(
                                fontSize: 45.0,
                                fontWeight: FontWeight.w600,
                                color: config.Colors().mainColor(1),
                                height: 1.35),
                            headline1: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: config.Colors().secondColor(1),
                                height: 1.5),
                            subtitle1: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: config.Colors().secondColor(1),
                                height: 1.35),
                            headline6: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700,
                                color: config.Colors().mainColor(1),
                                height: 1.35),
                            bodyText2: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: config.Colors().secondColor(1),
                                height: 1.35),
                            bodyText1: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: config.Colors().secondColor(1),
                                height: 1.35),
                            caption: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context).splashColor,
                                height: 1.35),
                          ),
                        )
                      : ThemeData(
                          fontFamily: 'Poppins',
                          primaryColor: Color(0xFF252525),
                          brightness: Brightness.dark,
                          secondaryHeaderColor:
                              config.Colors().mainDarkColor(1),
                          dividerColor: config.Colors().accentColor(0.1),
                          hintColor: config.Colors().secondDarkColor(1),
                          focusColor: config.Colors().accentDarkColor(1),
                          primaryColorLight: Color(0xFFe6ffec),
                          selectedRowColor: Color(0xFFffaa00),
                          shadowColor: Color(0xFF1D1D1D).withOpacity(0.3),
                          scaffoldBackgroundColor: Color(0xFF090909),
                          splashColor: Color(0xFF000000),
                          textTheme: TextTheme(
                            headline5: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                                color: config.Colors().secondDarkColor(1),
                                height: 1.35),
                            headline4: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: config.Colors()
                                    .secondDarkColor(1)
                                    .withOpacity(0.3),
                                height: 1.35),
                            headline3: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: config.Colors().secondDarkColor(1),
                                height: 1.35),
                            headline2: TextStyle(
                                fontSize: 45.0,
                                fontWeight: FontWeight.w600,
                                color: config.Colors().mainDarkColor(1),
                                height: 1.35),
                            headline1: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300,
                                color: config.Colors().secondDarkColor(1),
                                height: 1.5),
                            subtitle1: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: config.Colors().secondDarkColor(1),
                                height: 1.35),
                            headline6: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700,
                                color: config.Colors().mainDarkColor(1),
                                height: 1.35),
                            bodyText2: TextStyle(
                                fontSize: 12.0,
                                color: config.Colors().secondDarkColor(1),
                                height: 1.35),
                            bodyText1: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: config.Colors().secondDarkColor(1),
                                height: 1.35),
                            caption: TextStyle(
                                fontSize: 12.0,
                                color: config.Colors().secondDarkColor(0.6),
                                height: 1.35),
                          ),
                        ));
            }));
  }
}
