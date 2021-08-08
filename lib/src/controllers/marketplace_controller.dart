import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/degradable_repository.dart';
import '../../generated/l10n.dart';
import '../models/product.dart';
import '../models/degradable.dart';

class MarketPlaceController extends GetxController {
  Degradable degradable;
  GlobalKey<ScaffoldState> scaffoldKey;
  Rx<List<Degradable>> degradableList = Rx<List<Degradable>>([]);
  List<Degradable> get degradables => degradableList.value;
  List<Product> trendingProducts = <Product>[];
  List<Product> featuredProducts = <Product>[];
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    // fetchApi();
    listenForDegradable();
    super.onInit();
  }

  @override
  void onReady() {
    // called after the widget is rendered on screen
    // showIntroDialog();
    super.onReady();
  }

  //BuildContext context;

  MarketPlaceController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForDegradable({String message}) async {
    final Stream<Degradable> stream = await getDegradable();
    stream.listen((Degradable _degradable) {
      degradable = _degradable;
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
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
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
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        );
      }
    });
  }

  Future<void> refreshStore() async {
    var _id = degradable.id;
    degradable = new Degradable();
    featuredProducts.clear();
    listenForDegradable(message: S.of(Get.context).store_refreshed_successfuly);
    // listenForStoreReviews(id: _id);
    // listenForGalleries(_id);
    // listenForFeaturedProducts(_id);
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    // closeStream();
    super.onClose();
  }
}
