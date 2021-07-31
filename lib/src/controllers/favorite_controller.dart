import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/favorite.dart';
import '../repository/product_repository.dart';

class FavoriteController extends ControllerMVC {
  List<Favorite> favorites = <Favorite>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  FavoriteController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForFavorites();
  }

  void listenForFavorites({String message}) async {
    final Stream<Favorite> stream = await getFavorites();
    stream.listen((Favorite _favorite) {
      setState(() {
        favorites.add(_favorite);
      });
    }, onError: (a) {
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

  Future<void> refreshFavorites() async {
    favorites.clear();
    listenForFavorites(message: S.of(Get.context).favorites_refreshed_successfuly);
  }
}
