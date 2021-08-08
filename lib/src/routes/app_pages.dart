import 'package:get/get.dart';
import '../bindings/marketplace_binding.dart';
import '../pages/market_place.dart';
import '../bindings/create_post_binding.dart';
import '../widgets/widgets.dart';
import '../pages/splash_screen.dart';

import '../bindings/image_upload_binding.dart';
import '../pages/home.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;
  static const STARTPAGE = Routes.HOME;
  static const DEBG = Routes.DEBUG;
  static const SIGP = Routes.SIGNUP;
  static const MBVR = Routes.MOBVERFY;
  static const FBAUTH = Routes.FBAUTH;
  static const GOOGLEAUTH = Routes.GOOGLEAUTH;
  static const MOBVERFY2 = Routes.MOBVERFY2;
  static const LOGIN = Routes.LOGIN;
  static const PROFILE = Routes.PROFILE;
  static const RESETPASS = Routes.RESETPASS;
  static const PAGES = Routes.PAGES;
  static const DETAILS = Routes.DETAILS;
  static const LIST = Routes.LIST;
  static const PRODUCT = Routes.PRODUCT;
  static const CATEGORY = Routes.CATEGORY;
  static const CREATEPOST = Routes.CREATEPOST;
  static const MARKETPLACE = Routes.MARKETPLACE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeWidget(),
      binding: ImagesUploadBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      binding: ImagesUploadBinding(),
    ),
    GetPage(
      name: _Paths.CREATEPOST,
      page: () => CreatePostContainer(),
      binding: CreatePostBinding(),
    ),
    GetPage(
      name: _Paths.MARKETPLACE,
      page: () => MarketPlace(),
      binding: CreateMarketPlaceBinding(),
    ),
  ];

  static get keys => null;
}

  // static const DEBG = Routes.DEBUG;
  // static const SIGNUP;
  // static const MOBVERFY;
  // static const FBAUTH;
  // static const GOOGLEAUTH;
  // static const MOBVERFY2;
  // static const LOGIN;
  // static const PROFILE;
  // static const RESETPASS;
  // static const PAGES;
  // static const DETAILS;
  // static const LIST;
  // static const PRODUCT;
  // static const CATEGORY;