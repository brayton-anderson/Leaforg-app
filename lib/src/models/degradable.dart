import '../helpers/custom_trace.dart';
import '../models/media.dart';
import 'product.dart';

class Degradable {
  String id;
  String name;
  Media image;
  String description;
  String active;
  Product product;

  Degradable();

  Degradable.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      description = jsonMap['description'];
      product = jsonMap['stores'] != null
          ? Product.fromJSON(jsonMap['stores'])
          : Product.fromJSON({});
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0
          ? Media.fromJSON(jsonMap['media'][0])
          : new Media();
    } catch (e) {
      id = '';
      name = '';
      description = '';
      product = Product.fromJSON({});
      image = new Media();
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["description"] = description;
    return map;
  }


}
