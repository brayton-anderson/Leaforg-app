import '../helpers/custom_trace.dart';
import '../models/extra.dart';
import '../models/product.dart';

class ProductOrder {
  String id;
  double price;
  double quantity;
  List<Extra> extras;
  Product product;
  DateTime dateTime;
  ProductOrder();

  ProductOrder.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0.0;
      quantity =
          jsonMap['quantity'] != null ? jsonMap['quantity'].toDouble() : 0.0;
      product = jsonMap['products'] != null
          ? Product.fromJSON(jsonMap['products'])
          : Product.fromJSON({});
      dateTime = DateTime.parse(jsonMap['updated_at']);
      extras = jsonMap['extras'] != null
          ? List.from(jsonMap['extras'])
              .map((element) => Extra.fromJSON(element))
              .toList()
          : [];
    } catch (e) {
      id = '';
      price = 0.0;
      quantity = 0.0;
      product = Product.fromJSON({});
      dateTime = DateTime(0);
      extras = [];
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["price"] = price;
    map["quantity"] = quantity;
    map["product_id"] = product.id;
    map["extras"] = extras.map((element) => element.id).toList();
    return map;
  }
}
