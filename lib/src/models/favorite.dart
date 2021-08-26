import '../helpers/custom_trace.dart';
import '../models/extra.dart';
import '../models/product.dart';

class Favorite {
  String id;
  Product product;
  List<Extra> extras;
  String userId;

  Favorite();

  Favorite.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : null;
      product = jsonMap['products'] != null
          ? Product.fromJSON(jsonMap['products'])
          : Product.fromJSON({});
      extras = jsonMap['extras'] != null
          ? List.from(jsonMap['extras'])
              .map((element) => Extra.fromJSON(element))
              .toList()
          : null;
    } catch (e) {
      id = '';
      product = Product.fromJSON({});
      extras = [];
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["product_id"] = product.id;
    map["user_id"] = userId;
    map["extras"] = extras.map((element) => element.id).toList();
    return map;
  }
}
