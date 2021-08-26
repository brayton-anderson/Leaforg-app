import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../helpers/helper.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/store.dart';
import '../models/review.dart';
import '../models/slide.dart';
import '../repository/category_repository.dart';
import '../repository/product_repository.dart';
import '../repository/store_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/slider_repository.dart';

class HomeController extends ControllerMVC {
  List<Category> categories = <Category>[];
  List<Slide> slides = <Slide>[];
  List<Store> topStores = <Store>[];
  List<Store> popularStores = <Store>[];
  List<Review> recentReviews = <Review>[];
  List<Product> trendingProducts = <Product>[];

  HomeController() {
    listenForTopStores();
    listenForSlides();
    listenForTrendingProducts();
    listenForCategories();
    listenForPopularStores();
    listenForRecentReviews();
  }

  Future<void> listenForSlides() async {
    final Stream<Slide> stream = await getSlides();
    stream.listen((Slide _slide) {
      setState(() => slides.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForCategories() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForTopStores() async {
    final Stream<Store> stream =
        await getNearStores(deliveryAddress.value, deliveryAddress.value);
    stream.listen((Store _store) {
      setState(() => topStores.add(_store));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForPopularStores() async {
    final Stream<Store> stream = await getPopularStores(deliveryAddress.value);
    stream.listen((Store _store) {
      setState(() => popularStores.add(_store));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForRecentReviews() async {
    final Stream<Review> stream = await getRecentReviews();
    stream.listen((Review _review) {
      setState(() => recentReviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForTrendingProducts() async {
    final Stream<Product> stream =  
        await getTrendingProducts(deliveryAddress.value);
    stream.listen((Product _product) {
      setState(() => trendingProducts.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void requestForCurrentLocation(BuildContext context) {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    setCurrentLocation().then((_address) async {
      deliveryAddress.value = _address;
      await refreshHome();
      loader.remove();
    }).catchError((e) {
      loader.remove();
    });
  }

  Future<void> refreshHome() async {
    setState(() {
      slides = <Slide>[];
      categories = <Category>[];
      topStores = <Store>[];
      popularStores = <Store>[];
      recentReviews = <Review>[];
      trendingProducts = <Product>[];
    });
    await listenForSlides();
    await listenForTopStores();
    await listenForTrendingProducts();
    await listenForCategories();
    await listenForPopularStores();
    await listenForRecentReviews();
  }
}
