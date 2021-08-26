import 'user_product.dart';

import '../helpers/custom_trace.dart';
import '../models/category.dart';
import '../models/extra.dart';
import '../models/extra_group.dart';
import '../models/media.dart';
import '../models/nutrition.dart';
import '../models/store.dart';
import '../models/review.dart';
import 'coupon.dart';

class Product {
  String id;
  String name;
  double price;
  double discountPrice;
  Media image;
  String description;
  String ingredients;
  String weight;
  String unit;
  String packageItemsCount;
  bool featured;
  bool deliverable;
  String user_id;
  String is_user_product;
  String main_category;
  UserProduct userproduct;
  Store store;
  Category category;
  List<Extra> extras;
  List<ExtraGroup> extraGroups;
  List<Review> productReviews;
  List<Nutrition> nutritions;

  Product();

  Product.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0.0;
      discountPrice = jsonMap['discount_price'] != null
          ? jsonMap['discount_price'].toDouble()
          : 0.0;
      price = discountPrice != 0 ? discountPrice : price;
      discountPrice = discountPrice == 0
          ? discountPrice
          : jsonMap['price'] != null
              ? jsonMap['price'].toDouble()
              : 0.0;
      description = jsonMap['description'];
      is_user_product = jsonMap['is_user_product'];
      user_id = jsonMap['user_id'];
      main_category = jsonMap['main_category'];
      ingredients = jsonMap['ingredients'];
      weight = jsonMap['weight'] != null ? jsonMap['weight'].toString() : '';
      unit = jsonMap['unit'] != null ? jsonMap['unit'].toString() : '';
      packageItemsCount = jsonMap['package_items_count'].toString();
      featured = jsonMap['featured'] ?? false;
      deliverable = jsonMap['deliverable'] ?? false;
      userproduct = jsonMap['userproduct'] != null
          ? UserProduct.fromJSON(jsonMap['userproduct'])
          : UserProduct.fromJSON({});
      store = jsonMap['stores'] != null
          ? Store.fromJSON(jsonMap['stores'])
          : Store.fromJSON({});
      category = jsonMap['category'] != null
          ? Category.fromJSON(jsonMap['category'])
          : Category.fromJSON({});
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0
          ? Media.fromJSON(jsonMap['media'][0])
          : new Media();
      extras =
          jsonMap['extras'] != null && (jsonMap['extras'] as List).length > 0
              ? List.from(jsonMap['extras'])
                  .map((element) => Extra.fromJSON(element))
                  .toSet()
                  .toList()
              : [];
      extraGroups = jsonMap['extra_groups'] != null &&
              (jsonMap['extra_groups'] as List).length > 0
          ? List.from(jsonMap['extra_groups'])
              .map((element) => ExtraGroup.fromJSON(element))
              .toSet()
              .toList()
          : [];
      productReviews = jsonMap['product_reviews'] != null &&
              (jsonMap['product_reviews'] as List).length > 0
          ? List.from(jsonMap['product_reviews'])
              .map((element) => Review.fromJSON(element))
              .toSet()
              .toList()
          : [];
      nutritions = jsonMap['nutrition'] != null &&
              (jsonMap['nutrition'] as List).length > 0
          ? List.from(jsonMap['nutrition'])
              .map((element) => Nutrition.fromJSON(element))
              .toSet()
              .toList()
          : [];
    } catch (e) {
      id = '';
      name = '';
      price = 0.0;
      discountPrice = 0.0;
      description = '';
      is_user_product = '';
      user_id = '';
      main_category = '';
      weight = '';
      ingredients = '';
      unit = '';
      packageItemsCount = '';
      featured = false;
      deliverable = false;
      userproduct = UserProduct.fromJSON({});
      store = Store.fromJSON({});
      category = Category.fromJSON({});
      image = new Media();
      extras = [];
      extraGroups = [];
      productReviews = [];
      nutritions = [];
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["price"] = price;
    map["discountPrice"] = discountPrice;
    map["description"] = description;
    map["ingredients"] = ingredients;
    map["weight"] = weight;
    return map;
  }

  double getRate() {
    double _rate = 0;
    productReviews.forEach((e) => _rate += double.parse(e.rate));
    _rate = _rate > 0 ? (_rate / productReviews.length) : 0;
    return _rate;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;

  Coupon applyCoupon(Coupon coupon) {
    if (coupon.code != '') {
      if (coupon.valid == null) {
        coupon.valid = false;
      }
      coupon.discountables.forEach((element) {
        if (!coupon.valid) {
          if (element.discountableType == "App\\Models\\Product") {
            if (element.discountableId == id) {
              coupon = _couponDiscountPrice(coupon);
            }
          } else if (element.discountableType == "App\\Models\\Store") {
            if (element.discountableId == store.id) {
              coupon = _couponDiscountPrice(coupon);
            }
          } else if (element.discountableType == "App\\Models\\Category") {
            if (element.discountableId == category.id) {
              coupon = _couponDiscountPrice(coupon);
            }
          }
        }
      });
    }
    return coupon;
  }

  Coupon _couponDiscountPrice(Coupon coupon) {
    coupon.valid = true;
    discountPrice = price;
    if (coupon.discountType == 'fixed') {
      price -= coupon.discount;
    } else {
      price = price - (price * coupon.discount / 100);
    }
    if (price < 0) price = 0;
    return coupon;
  }
}
