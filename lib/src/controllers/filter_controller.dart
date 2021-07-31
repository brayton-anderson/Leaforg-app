import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/cuisine.dart';
import '../models/filter.dart';
import '../repository/cuisine_repository.dart';

class FilterController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Cuisine> cuisines = [];
  Filter filter;
  Cart cart;

  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);
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
    cuisines.add(new Cuisine.fromJSON(
        {'id': '0', 'name': S.of(Get.context).all, 'selected': true}));
    final Stream<Cuisine> stream = await getCuisines();
    stream.listen((Cuisine _cuisine) {
      setState(() {
        if (filter.cuisines.contains(_cuisine)) {
          _cuisine.selected = true;
          cuisines.elementAt(0).selected = false;
        }
        cuisines.add(_cuisine);
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
    cuisines.forEach((Cuisine _f) {
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
