import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/snackbar_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/franchise.dart';
import '../models/filter.dart';
import '../repository/franchise_repository.dart';
import 'check_network/network_controller.dart';

class FilterController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Franchise> cuisines = [];
  Filter filter;
  Cart cart;

  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;


  FilterController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForFilter().whenComplete(() {
      listenForCuisines();
    });
  }

  Future<void> listenForFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      filter = Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
    });
  }

  Future<void> saveFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filter.cuisines = this.cuisines.where((_f) => _f.selected).toList();
    prefs.setString('filter', json.encode(filter.toMap()));
  }

  void listenForCuisines({String message}) async {
    cuisines.add(new Franchise.fromJSON(
        {'id': '0', 'name': S.of(Get.context).all, 'selected': true}));
    final Stream<Franchise> stream = await getCuisines();
    stream.listen((Franchise _cuisine) {
      setState(() {
        if (filter.cuisines.contains(_cuisine)) {
          _cuisine.selected = true;
          cuisines.elementAt(0).selected = false;
        }
        cuisines.add(_cuisine);
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

  Future<void> refreshCuisines() async {
    cuisines.clear();
    listenForCuisines(message: S.of(Get.context).addresses_refreshed_successfuly);
  }

  void clearFilter() {
    setState(() {
      filter.open = false;
      filter.delivery = false;
      resetCuisines();
    });
  }

  void resetCuisines() {
    filter.cuisines = [];
    cuisines.forEach((Franchise _f) {
      _f.selected = false;
    });
    cuisines.elementAt(0).selected = true;
  }

  void onChangeCuisinesFilter(int index) {
    if (index == 0) {
      // all
      setState(() {
        resetCuisines();
      });
    } else {
      setState(() {
        cuisines.elementAt(index).selected =
            !cuisines.elementAt(index).selected;
        cuisines.elementAt(0).selected = false;
      });
    }
  }
}
