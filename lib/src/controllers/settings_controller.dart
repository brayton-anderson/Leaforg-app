import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/credit_card.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

class SettingsController extends ControllerMVC {
  CreditCard creditCard = new CreditCard();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  SettingsController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void update(Userss user) async {
    user.deviceToken = null;
    repository.update(user).then((value) {
      setState(() {});
      Get.snackbar(
        "Hi",
        "Leaforg",
        showProgressIndicator: false,
        duration: Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        maxWidth: MediaQuery.of(Get.context).size.width - 200,
        backgroundColor: successColor,
        messageText: Text(
         S.of(Get.context).profile_settings_updated_successfully,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  void updateCreditCard(CreditCard creditCard) {
    repository.setCreditCard(creditCard).then((value) {
      setState(() {});
      Get.snackbar(
        "Hi",
        "Leaforg",
        showProgressIndicator: false,
        duration: Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        maxWidth: MediaQuery.of(Get.context).size.width - 200,
        backgroundColor: successColor,
        messageText: Text(
         S.of(Get.context).payment_settings_updated_successfully,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  void listenForUser() async {
    creditCard = await repository.getCreditCard();
    setState(() {});
  }

  Future<void> refreshSettings() async {
    creditCard = new CreditCard();
  }
}
