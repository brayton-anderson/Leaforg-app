import '../helpers/custom_trace.dart';
import '../models/media.dart';

class StoreCategory {
  String id;
  String stores_name;
  Media stores_image;

  StoreCategory();

  StoreCategory.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      stores_name = jsonMap['stores_name'];
      stores_image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0
          ? Media.fromJSON(jsonMap['media'][0])
          : new Media();
    } catch (e) {
      id = '';
      stores_name = '';
      stores_image = new Media();
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
