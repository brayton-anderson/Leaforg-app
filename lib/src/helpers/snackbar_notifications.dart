import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import '../controllers/check_network/network_controller.dart';
import 'responcive_app.dart';

//class SnackbarNotification {
final CreateNetworkController _networkController =
    Get.find<CreateNetworkController>();
var infoColor = Color(0xFFFFC001);
var errorColor = Color(0xFFCCCCCC);
var successColor = Theme.of(Get.context).hintColor;

void getSnackbarNotification(messages, request, button, route) {
  if (request == "check internet") {
    return Get.snackbar(
      "",
      "",
      showProgressIndicator: false,
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: Responsive.isMobile(Get.context)
          ? MediaQuery.of(Get.context).size.width
          : MediaQuery.of(Get.context).size.width / 4 + 100,
      backgroundColor: Colors.transparent,
      messageText: Obx(() => Container(
          width: Responsive.isMobile(Get.context)
              ? MediaQuery.of(Get.context).size.width
              : MediaQuery.of(Get.context).size.width / 4 + 100,
          height: 100,
          color: _networkController.connectionStatus.value == 1 ||
                  _networkController.connectionStatus.value == 2
              ? infoColor
              : errorColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 10,
                height: 100,
                color: _networkController.connectionStatus.value == 1 ||
                        _networkController.connectionStatus.value == 2
                    ? infoColor
                    : errorColor,
              ),
              Container(
                width: Responsive.isMobile(Get.context)
                    ? MediaQuery.of(Get.context).size.width - 10
                    : MediaQuery.of(Get.context).size.width / 4 + 90,
                height: 100,
                color: Colors.white,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        child: Center(
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: _networkController
                                            .connectionStatus.value ==
                                        1 ||
                                    _networkController.connectionStatus.value ==
                                        2
                                ? infoColor
                                : errorColor,
                            child: Center(
                                child: Icon(
                              _networkController.connectionStatus.value == 1
                                  ? PhosphorIcons.wifi_high_fill
                                  : _networkController.connectionStatus.value ==
                                          2
                                      ? PhosphorIcons.cell_signal_high_fill
                                      : PhosphorIcons.wifi_slash_fill,
                              color: Colors.white,
                              size: 30,
                            )),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: Responsive.isMobile(Get.context)
                            ? MediaQuery.of(Get.context).size.width - 60
                            : MediaQuery.of(Get.context).size.width / 4 - 10,
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _networkController.connectionStatus.value ==
                                            1 ||
                                        _networkController
                                                .connectionStatus.value ==
                                            2
                                    ? 'You\'re Online now'
                                    : 'You\'re Offline now',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                _networkController.connectionStatus.value == 1
                                    ? 'Great! You\'re connected to wifi'
                                    : _networkController
                                                .connectionStatus.value ==
                                            2
                                        ? 'Amazing! You\'re connected to mobile'
                                        : 'Oops! You\'re not connected',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ]),
                      ),
                    ]),
              ),
            ],
          ))),
    );
  } else if (request == "info_snack") {
    return Get.snackbar(
      "",
      "",
      showProgressIndicator: false,
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: Responsive.isMobile(Get.context)
          ? MediaQuery.of(Get.context).size.width
          : MediaQuery.of(Get.context).size.width / 4 + 100,
      backgroundColor: Colors.transparent,
      messageText: Container(
        width: Responsive.isMobile(Get.context)
            ? MediaQuery.of(Get.context).size.width
            : MediaQuery.of(Get.context).size.width / 4 + 100,
        height: 100,
        color: infoColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 10,
              height: 100,
              color: infoColor,
            ),
            Container(
              width: Responsive.isMobile(Get.context)
                  ? MediaQuery.of(Get.context).size.width - 10
                  : MediaQuery.of(Get.context).size.width / 4 + 90,
              height: 100,
              color: Colors.white,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: infoColor,
                          child: Center(
                              child: Icon(
                            PhosphorIcons.warning_fill,
                            color: Colors.white,
                            size: 30,
                          )),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: Responsive.isMobile(Get.context)
                          ? MediaQuery.of(Get.context).size.width - 60
                          : MediaQuery.of(Get.context).size.width / 4 - 10,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Erm...',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              messages,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ]),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  } else if (request == "check internet_button") {
    return Get.snackbar(
      "",
      "",
      showProgressIndicator: false,
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: Responsive.isMobile(Get.context)
          ? MediaQuery.of(Get.context).size.width
          : MediaQuery.of(Get.context).size.width / 4 + 100,
      backgroundColor: Colors.transparent,
      mainButton: TextButton(
        onPressed: () {
          Navigator.of(Get.context).pushNamed(route);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(Get.context).secondaryHeaderColor,
          ),
          child: Center(
            child: Text(
              button,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      messageText: Obx(() => Container(
            width: Responsive.isMobile(Get.context)
                ? MediaQuery.of(Get.context).size.width
                : MediaQuery.of(Get.context).size.width / 4 + 100,
            height: 100,
            color: _networkController.connectionStatus.value == 1 ||
                    _networkController.connectionStatus.value == 2
                ? infoColor
                : errorColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 10,
                  height: 100,
                  color: _networkController.connectionStatus.value == 1 ||
                          _networkController.connectionStatus.value == 2
                      ? infoColor
                      : errorColor,
                ),
                Container(
                  width: Responsive.isMobile(Get.context)
                      ? MediaQuery.of(Get.context).size.width - 10
                      : MediaQuery.of(Get.context).size.width / 4 + 90,
                  height: 100,
                  color: Colors.white,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
                          child: Center(
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor:
                                  _networkController.connectionStatus.value ==
                                              1 ||
                                          _networkController
                                                  .connectionStatus.value ==
                                              2
                                      ? infoColor
                                      : errorColor,
                              child: Center(
                                  child: Icon(
                                _networkController.connectionStatus.value == 1
                                    ? PhosphorIcons.wifi_high_fill
                                    : _networkController
                                                .connectionStatus.value ==
                                            2
                                        ? PhosphorIcons.cell_signal_high_fill
                                        : PhosphorIcons.wifi_slash_fill,
                                color: Colors.white,
                                size: 30,
                              )),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: Responsive.isMobile(Get.context)
                              ? MediaQuery.of(Get.context).size.width - 60
                              : MediaQuery.of(Get.context).size.width / 4 - 10,
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _networkController.connectionStatus.value ==
                                              1 ||
                                          _networkController
                                                  .connectionStatus.value ==
                                              2
                                      ? 'You\'re Online now'
                                      : 'You\'re Offline now',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  _networkController.connectionStatus.value == 1
                                      ? 'Great! You\'re connected to wifi'
                                      : _networkController
                                                  .connectionStatus.value ==
                                              2
                                          ? 'Amazing! You\'re connected to mobile'
                                          : 'Oops! You\'re not connected',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                        ),
                      ]),
                ),
              ],
            ),
          )),
    );
  } else if (request == "success_snack") {
    return Get.snackbar(
      "",
      "",
      showProgressIndicator: false,
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: Responsive.isMobile(Get.context)
          ? MediaQuery.of(Get.context).size.width
          : MediaQuery.of(Get.context).size.width / 4 + 100,
      backgroundColor: Colors.transparent,
      messageText: Container(
        width: Responsive.isMobile(Get.context)
            ? MediaQuery.of(Get.context).size.width
            : MediaQuery.of(Get.context).size.width / 4 + 100,
        height: 100,
        color: successColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 10,
              height: 100,
              color: successColor,
            ),
            Container(
              width: Responsive.isMobile(Get.context)
                  ? MediaQuery.of(Get.context).size.width - 10
                  : MediaQuery.of(Get.context).size.width / 4 + 90,
              height: 100,
              color: Colors.white,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: successColor,
                          child: Center(
                              child: Icon(
                            PhosphorIcons.check_circle_fill,
                            color: Colors.white,
                            size: 30,
                          )),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: Responsive.isMobile(Get.context)
                          ? MediaQuery.of(Get.context).size.width - 60
                          : MediaQuery.of(Get.context).size.width / 4 - 10,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Awesome!',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              messages,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ]),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  } else {
    return Get.snackbar(
      "",
      "",
      showProgressIndicator: false,
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: Responsive.isMobile(Get.context)
          ? MediaQuery.of(Get.context).size.width
          : MediaQuery.of(Get.context).size.width / 4 + 100,
      backgroundColor: Colors.transparent,
      messageText: Container(
        width: Responsive.isMobile(Get.context)
            ? MediaQuery.of(Get.context).size.width
            : MediaQuery.of(Get.context).size.width / 4 + 100,
        height: 100,
        color: errorColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 10,
              height: 100,
              color: errorColor,
            ),
            Container(
              width: Responsive.isMobile(Get.context)
                  ? MediaQuery.of(Get.context).size.width - 10
                  : MediaQuery.of(Get.context).size.width / 4 + 90,
              height: 100,
              color: Colors.white,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: errorColor,
                          child: Center(
                              child: Icon(
                            PhosphorIcons.link_break_fill,
                            color: Colors.white,
                            size: 30,
                          )),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: Responsive.isMobile(Get.context)
                          ? MediaQuery.of(Get.context).size.width - 60
                          : MediaQuery.of(Get.context).size.width / 4 - 10,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Oh no!',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              messages == ""
                                  ? "Sorry! an error occurred"
                                  : messages,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ]),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

 
//}
