import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

EdgeInsetsGeometry responsivePadding(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 700) {
    return EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0);
  } else if (deviceWidth < 1200) {
    return EdgeInsets.symmetric(horizontal: 50.0, vertical: 25.0);
  } else if (deviceWidth < 1650) {
    return EdgeInsets.only(left: 200.0, right: 200, top: 20.0, bottom: 40.0);
  }
  return EdgeInsets.only(left: 200.0, right: 200, top: 20.0, bottom: 40.0);
}

int responsiveNumGridTiles(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth <= 699) {
    return 1;
  } else if (deviceWidth <= 999) {
    return 2;
  } else if (deviceWidth <= 1199) {
    return 3;
  } else if (deviceWidth <= 1649) {
    return 4;
  }
  return 5;
}

EdgeInsetsGeometry resporegPadding(MediaQueryData mediaQuery) {
  double devmobWidth = mediaQuery.size.width;
  double devtabWidth = mediaQuery.size.width * 50;
  double devdeskWidth = mediaQuery.size.width * 50;

  if (devmobWidth <= 350) {
    return EdgeInsets.only(left: 30.0, right: 30.0);
  } else if (devtabWidth <= 499.5) {
    return EdgeInsets.only(left: 40.0, right: 40.0);
  } else if (devdeskWidth <= 854.1) {
    return EdgeInsets.only(left: 40.0, right: 40.0);
  } else if (devdeskWidth <= 887.9) {
    return EdgeInsets.only(left: 40.0, right: 40.0);
  }
  return EdgeInsets.only(left: 35.0, right: 35.0);
}

double respsignContainerWidth(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  double deviceHeight = mediaQuery.size.height;
  if (deviceWidth <= 699) {
    //print("${deviceWidth.toString()} - height:-${deviceHeight.toString()}");
    return mediaQuery.size.width;
  } else if (deviceWidth <= 999) {
    final widthPr = mediaQuery.size.width * 0.50;
   // print("${widthPr.toString()} - height:-${deviceHeight.toString()}");
    return mediaQuery.size.width * 0.50;
  } else if (deviceWidth <= 1199) {
    final widthPr = mediaQuery.size.width * 0.65;
    //print("${widthPr.toString()} - height:-${deviceHeight.toString()}");
    return mediaQuery.size.width * 0.65;
  } else if (deviceWidth <= 1649) {
    final widthPr = mediaQuery.size.width * 0.65;
   // print("${widthPr.toString()} - height:-${deviceHeight.toString()}");
    return mediaQuery.size.width * 0.65;
  }
  //print("${deviceWidth.toString()} - height:-${deviceHeight.toString()}");
  return mediaQuery.size.width * 0.65;
}

double responsiveImageHeight(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 700) {
    return 250.0;
  } else if (deviceWidth < 1200) {
    return mediaQuery.size.width * 0.25;
  } else if (deviceWidth < 1650) {
    return mediaQuery.size.width * 0.2;
  }
  return mediaQuery.size.width * 0.15;
}

AspectRatioCrop() {
  if ((defaultTargetPlatform == TargetPlatform.iOS) ||
      (defaultTargetPlatform == TargetPlatform.android)) {
    final settings = {
      [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
    };
    return;
  } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
      (defaultTargetPlatform == TargetPlatform.macOS) ||
      (defaultTargetPlatform == TargetPlatform.windows)) {
    return [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9
    ];
  } else {
    // Some web specific code there
  }
}

String checkingDevice(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 600) {
    return "mobile";
  } else if (deviceWidth > 600 && deviceWidth < 720) {
   // print(deviceWidth);
    return "small_tab";
  } else if (deviceWidth > 720 && deviceWidth < 1024) {
   // print(deviceWidth);
    return "big_tab";
  } else {
   // print(deviceWidth);
    return "desktop";
  }
}

String checkingDevicePlatform() {
  if (GetPlatform.isMobile) {
    if (GetPlatform.isWeb) {
      if (Get.context.isPhone) {
       // print("android_web_(w=)_less_than_600p");
        return "phone_web";
      } else if (Get.context.isSmallTablet) {
       // print("small_tab_web_(w=)_great_than_600p");
        return "small_tab_web";
      } else if (Get.context.isLargeTablet) {
       // print("big_tab_web_(w=)_great_than_720p");
        return "big_tab_web";
      }
    } else {
      if (Get.context.isPhone) {
       // print("android_app_(w=)_less_than_600p");
        return "phone_app";
      } else if (Get.context.isSmallTablet) {
        //print("small_tab_app_(w=)_great_than_600p");
        return "small_tab_app";
      } else if (Get.context.isLargeTablet) {
        //print("big_tab_app_(w=)_great_than_720p");
        return "big_tab_app";
      }
    }
  } else if (GetPlatform.isDesktop) {
    if (GetPlatform.isWeb) {
      //print("android_web_desktop");
      return "desktop_web";
    } else {
     // print("android_app_desktop");
      return "desktop_app";
    }
  }
  // if (GetPlatform.isAndroid) {
  //   if (GetPlatform.isMobile) {
  //     if (GetPlatform.isWeb) {
  //       if (Get.context.isPhone) {
  //         print("android_web_(w=)_less_than_600p");
  //         return "phone_web";
  //       } else if (Get.context.isSmallTablet) {
  //         print("small_tab_web_(w=)_great_than_600p");
  //         return "small_tab_web";
  //       } else if (Get.context.isLargeTablet) {
  //         print("big_tab_web_(w=)_great_than_720p");
  //         return "big_tab_web";
  //       }
  //     } else {
  //       if (Get.context.isPhone) {
  //         print("android_app_(w=)_less_than_600p");
  //         return "phone_app";
  //       } else if (Get.context.isSmallTablet) {
  //         print("small_tab_app_(w=)_great_than_600p");
  //         return "small_tab_app";
  //       } else if (Get.context.isLargeTablet) {
  //         print("big_tab_app_(w=)_great_than_720p");
  //         return "big_tab_app";
  //       }
  //     }
  //   } else if (GetPlatform.isDesktop) {
  //     if (GetPlatform.isWeb) {
  //       print("android_web_desktop");
  //       return "desktop_web";
  //     } else {
  //       print("android_app_desktop");
  //       return "desktop_app";
  //     }
  //   }
  // } else if (GetPlatform.isIOS) {
  //   if (GetPlatform.isWeb) {
  //     if (Get.context.isPhone) {
  //       print("ios_web_(w=)_less_than_600p");
  //       return "phone_web";
  //     } else if (Get.context.isSmallTablet) {
  //       print("small_ipad_web_(w=)_great_than_600p");
  //       return "small_tab_web";
  //     } else if (Get.context.isLargeTablet) {
  //       print("big_ipad_web_(w=)_great_than_720p");
  //       return "big_tab_web";
  //     } else {
  //       print("ios_web");
  //       return "phone_web";
  //     }
  //   } else {
  //     if (Get.context.isPhone) {
  //       print("ios_app_(w=)_less_than_600p");
  //       return "phone_app";
  //     } else if (Get.context.isSmallTablet) {
  //       print("small_ipad_app_(w=)_great_than_600p");
  //       return "small_tab_app";
  //     } else if (Get.context.isLargeTablet) {
  //       print("big_ipad_app_(w=)_great_than_720p");
  //       return "big_tab_app";
  //     } else {
  //       print("ios_app");
  //       return "phone_app";
  //     }
  //   }
  // } else if (GetPlatform.isWindows) {
  //   if (GetPlatform.isMobile) {
  //     if (GetPlatform.isWeb) {
  //       if (Get.context.isPhone) {
  //         print("windows_phone_web_(w=)_less_than_600p");
  //         return "phone_web";
  //       } else if (Get.context.isSmallTablet) {
  //         print("windows_small_tab_web_(w=)_great_than_600p");
  //         return "small_tab_web";
  //       } else if (Get.context.isLargeTablet) {
  //         print("windows_big_tab_web_(w=)_great_than_720p");
  //         return "big_tab_web";
  //       } else {
  //         print("windows_phone_web");
  //         return "phone_web";
  //       }
  //     } else {
  //       if (Get.context.isPhone) {
  //         print("windows_phone_app_(w=)_less_than_600p");
  //         return "phone_app";
  //       } else if (Get.context.isSmallTablet) {
  //         print("windows_small_tab_app_(w=)_great_than_600p");
  //         return "small_tab_app";
  //       } else if (Get.context.isLargeTablet) {
  //         print("windows_big_tab_app_(w=)_great_than_720p");
  //         return "big_tab_app";
  //       } else {
  //         print("windows_phone_app");
  //         return "phone_app";
  //       }
  //     }
  //   } else if (GetPlatform.isDesktop) {
  //     if (GetPlatform.isWeb) {
  //       print("widows_web_desktop");
  //       return "desktop_web";
  //     } else {
  //       print("widows_app_desktop");
  //       return "desktop_app";
  //     }
  //   }
  // } else if (GetPlatform.isMacOS) {
  //   if (GetPlatform.isMobile) {
  //     if (GetPlatform.isWeb) {
  //       if (Get.context.isPhone) {
  //         print("macos_phone_web_(w=)_less_than_600p");
  //         return "phone_web";
  //       } else if (Get.context.isSmallTablet) {
  //         print("macos_small_tab_web_(w=)_great_than_600p");
  //         return "small_tab_web";
  //       } else if (Get.context.isLargeTablet) {
  //         print("macos_big_tab_web_(w=)_great_than_720p");
  //         return "big_tab_web";
  //       } else {
  //         print("macos_phone_web");
  //         return "phone_web";
  //       }
  //     } else {
  //       if (Get.context.isPhone) {
  //         print("macos_phone_app_(w=)_less_than_600p");
  //         return "phone_app";
  //       } else if (Get.context.isSmallTablet) {
  //         print("macos_small_tab_app_(w=)_great_than_600p");
  //         return "small_tab_app";
  //       } else if (Get.context.isLargeTablet) {
  //         print("macos_big_tab_app_(w=)_great_than_720p");
  //         return "big_tab_app";
  //       } else {
  //         print("macos_phone_app");
  //         return "phone_app";
  //       }
  //     }
  //   } else if (GetPlatform.isDesktop) {
  //     if (GetPlatform.isWeb) {
  //       print("macos_web");
  //       return "desktop_web";
  //     } else {
  //       print("macos_app");
  //       return "desktop_app";
  //     }
  //   }
  // } else if (GetPlatform.isLinux) {
  //   if (GetPlatform.isMobile) {
  //     if (GetPlatform.isWeb) {
  //       if (Get.context.isPhone) {
  //         print("linux_phone_web_(w=)_less_than_600p");
  //         return "phone_web";
  //       } else if (Get.context.isSmallTablet) {
  //         print("linux_small_tab_web_(w=)_great_than_600p");
  //         return "small_tab_web";
  //       } else if (Get.context.isLargeTablet) {
  //         print("linux_big_tab_web_(w=)_great_than_720p");
  //         return "big_tab_web";
  //       } else {
  //         print("linux_phone_web");
  //         return "phone_web";
  //       }
  //     } else {
  //       if (Get.context.isPhone) {
  //         print("linux_phone_app_(w=)_less_than_600p");
  //         return "phone_app";
  //       } else if (Get.context.isSmallTablet) {
  //         print("linux_small_tab_app_(w=)_great_than_600p");
  //         return "small_tab_app";
  //       } else if (Get.context.isLargeTablet) {
  //         print("linux_big_tab_app_(w=)_great_than_720p");
  //         return "big_tab_app";
  //       } else {
  //         print("linux_phone_app");
  //         return "phone_app";
  //       }
  //     }
  //   } else if (GetPlatform.isDesktop) {
  //     if (GetPlatform.isWeb) {
  //       print("linux_web_desktop");
  //       return "desktop_web";
  //     } else {
  //       print("linux_app_desktop");
  //       return "desktop_app";
  //     }
  //   }
  // } else if (GetPlatform.isFuchsia) {
  //   if (GetPlatform.isMobile) {
  //     if (GetPlatform.isWeb) {
  //       if (Get.context.isPhone) {
  //         print("fuchsia_phone_web_(w=)_less_than_600p");
  //         return "phone_web";
  //       } else if (Get.context.isSmallTablet) {
  //         print("fuchsia_small_tab_web_(w=)_great_than_600p");
  //         return "small_tab_web";
  //       } else if (Get.context.isLargeTablet) {
  //         print("fuchsia_big_tab_web_(w=)_great_than_720p");
  //         return "big_tab_web";
  //       } else {
  //         print("fuchsia_phone_web");
  //         return "phone_web";
  //       }
  //     } else {
  //       if (Get.context.isPhone) {
  //         print("fuchsia_phone_app_(w=)_less_than_600p");
  //         return "phone_app";
  //       } else if (Get.context.isSmallTablet) {
  //         print("fuchsia_small_tab_app_(w=)_great_than_600p");
  //         return "small_tab_app";
  //       } else if (Get.context.isLargeTablet) {
  //         print("fuchsia_big_tab_app_(w=)_great_than_720p");
  //         return "big_tab_app";
  //       } else {
  //         print("fuchsia_phone_app");
  //         return "phone_app";
  //       }
  //     }
  //   } else if (GetPlatform.isDesktop) {
  //     if (GetPlatform.isWeb) {
  //       print("fuchsia_web_desktop");
  //       return "desktop_web";
  //     } else {
  //       print("fuchsia_app_desktop");
  //       return "desktop_app";
  //     }
  //   }
  // }
 // print("dont_know");
  return "dont_know";
}

double responsiveTitleHeight(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 700) {
    return 120.0;
  } else if (deviceWidth < 1200) {
    return mediaQuery.size.width * 0.1;
  } else if (deviceWidth < 1650) {
    return mediaQuery.size.width * 0.07;
  }
  return mediaQuery.size.width * 0.05;
}
