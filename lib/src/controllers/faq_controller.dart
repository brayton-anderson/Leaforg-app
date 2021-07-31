import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/faq_category.dart';
import '../repository/faq_repository.dart';

class FaqController extends ControllerMVC {
  List<FaqCategory> faqs = <FaqCategory>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  FaqController() {
    scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForFaqs();
  }

  void listenForFaqs({String message}) async {
    final Stream<FaqCategory> stream = await getFaqCategories();
    stream.listen((FaqCategory _faq) {
      setState(() {
        faqs.add(_faq);
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
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
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
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          );
      }
    });
  }

  Future<void> refreshFaqs() async {
    faqs.clear();
    listenForFaqs(message: S.of(Get.context).faqsRefreshedSuccessfuly);
  }
}
