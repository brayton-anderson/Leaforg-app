import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/snackbar_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/faq_category.dart';
import '../repository/faq_repository.dart';
import 'check_network/network_controller.dart';

class FaqController extends ControllerMVC {
  List<FaqCategory> faqs = <FaqCategory>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);
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

  Future<void> refreshFaqs() async {
    faqs.clear();
    listenForFaqs(message: S.of(Get.context).faqsRefreshedSuccessfuly);
  }
}
