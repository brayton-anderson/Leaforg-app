import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/product.dart';

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';

Future<Stream<Product>> getTrendingProductsOfStore(String storeId) async {
  Uri uri = Helper.getUri('api/products');
  uri = uri.replace(queryParameters: {
    'with': 'category;extras;productReviews',
    'searchFields': 'store_id:=;featured:=',
    'searchJoin': 'and',
  });
  print(uri.toString());
  // TODO Trending products only
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    final dada = jsonDecode(streamedRest.toString());
    print(dada);
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Product>> getProductsOfStore(String storeId,
    {List<String> categories}) async {
  Uri uri = Helper.getUri('api/products/categories');
  Map<String, dynamic> query = {
    'with': 'store;category;extras;productReviews',
    'searchFields': 'store_id:=',
  };
  print("nana");

  if (categories != null && categories.isNotEmpty) {
    query['categories[]'] = categories;
  }
  uri = uri.replace(queryParameters: query);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Category>> getCategoriesOfStore(String storeId) async {
  Uri uri = Helper.getUri('api/categories');
  Map<String, dynamic> _queryParams = {
    };

  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Category.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Category.fromJSON({}));
  }
}

Future<Stream<Product>> getStoreDegradable() async {
  final String url = 'https://soqo.co.ke/datadata/public/api/foods';

  print('nunu');
  //uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
    return streamedRest.stream
        .asBroadcastStream()
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
      // List<Empty>.from(json[""].map((x) => Empty.fromMap(x)))
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}
