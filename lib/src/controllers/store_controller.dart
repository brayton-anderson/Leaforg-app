import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/snackbar_notifications.dart';
import '../models/store_categories.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/gallery.dart';
import '../models/store.dart';
import '../models/review.dart';
import '../repository/category_repository.dart';
import '../repository/product_repository.dart';
import '../repository/gallery_repository.dart';
import '../repository/store_repository.dart';
import '../repository/settings_repository.dart';
import 'check_network/network_controller.dart';

class StoreController extends ControllerMVC {
  Store store;
  List<Gallery> galleries = <Gallery>[];
  List<Product> products = <Product>[];
  List<Store> stores = <Store>[];
  List<Category> categories = <Category>[];
  List<StoreCategory> storecategories = <StoreCategory>[];
  List<Product> trendingProducts = <Product>[];
  List<Product> featuredProducts = <Product>[];
  List<Review> reviews = <Review>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  //BuildContext context;

  StoreController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  // get currentState => null;

  void listenForStore({String id, String message}) async {
    final Stream<Store> stream = await getStore(id, deliveryAddress.value);
    stream.listen((Store _store) {
      setState(() => store = _store);
    }, onError: (a) {
      print(a);

      final messages = "";
      final button = "";
      final route = "";
      final request = "check internet";

      getSnackbarNotification(messages, request, button, route);
    }, onDone: () {
      if (message != null) {
        //final color = infoColor;
        //final messages = message;
        final button = "";
        final route = "";
        final request = "info_snack";

        getSnackbarNotification(message, request, button, route);
      }
    });
  }

  void listenForGalleries(String idStore) async {
    final Stream<Gallery> stream = await getGalleries(idStore);
    stream.listen((Gallery _gallery) {
      setState(() => galleries.add(_gallery));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForStoreReviews({String id, String message}) async {
    final Stream<Review> stream = await getStoreReviews(id);
    stream.listen((Review _review) {
      setState(() => reviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForProducts(String idStore, {List<String> categoriesId}) async {
    final Stream<Product> stream =
        await getProductsOfStore(idStore, categories: categoriesId);
    stream.listen((Product _product) {
      setState(() => products.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      store..name = products.elementAt(0).store.name;
    });
  }

  void listenForTrendingProducts(String idStore) async {
    final Stream<Product> stream = await getTrendingProductsOfStore(idStore);
    stream.listen((Product _product) {
      setState(() => trendingProducts.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void listenForFeaturedProducts(String idStore) async {
    final Stream<Product> stream = await getFeaturedProductsOfStore(idStore);
    stream.listen((Product _product) {
      setState(() => featuredProducts.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForCategories(String storeId) async {
    final Stream<Category> stream = await getCategoriesOfStore(storeId);
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      categories.insert(0, new Category.fromJSON({'id': '0', 'name': 'All'}));
    });
  }

  Future<void> selectCategory(List<String> categoriesId) async {
    products.clear();
    listenForProducts(store.id, categoriesId: categoriesId);
  }

  Future<void> refreshStore() async {
    var _id = store.id;
    store = new Store();
    galleries.clear();
    reviews.clear();
    featuredProducts.clear();
    listenForStore(
        id: _id, message: S.of(Get.context).store_refreshed_successfuly);
    listenForStoreReviews(id: _id);
    listenForGalleries(_id);
    listenForFeaturedProducts(_id);
  }
}
