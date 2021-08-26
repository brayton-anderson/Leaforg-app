import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/category.dart';
import '../models/store.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/degradable_repository.dart';
import '../models/product.dart';
import 'check_network/network_controller.dart';

class MarketPlaceController extends ControllerMVC {
  Store store;
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Product> products = <Product>[];
  List<Category> categories = <Category>[];
  List<Product> trendingProducts = <Product>[];
  //Rx degradableList = Rx<List<Degradable>>([]);
  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  //BuildContext context;

  MarketPlaceController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForTrendingProducts(String idStore) async {
    final Stream<Product> stream = await getTrendingProductsOfStore(idStore);
    stream.listen((Product _product) {
      setState(() => trendingProducts.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
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

  void listenForDegradable() async {
    final Stream<Product> streamede = await getStoreDegradable();
    //print(stream.toList());
    streamede.asBroadcastStream().listen((Product _product) {
      print(_product);
      print(products);
      setState(() => products.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      //store..name = products.elementAt(0).store.name;
    });
  }

  Future<void> refreshStore() async {
    //degradableList.bindStream(await getDegradable());
    //listenForDegradable(message: S.of(Get.context).store_refreshed_successfuly);
    // listenForStoreReviews(id: _id);
    // listenForGalleries(_id);
    // listenForFeaturedProducts(_id);
  }
}
