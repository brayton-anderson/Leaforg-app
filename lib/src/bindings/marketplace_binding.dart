import 'package:get/get.dart';
import '../controllers/marketplace_controller.dart';

class CreateMarketPlaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketPlaceController>(
      () => MarketPlaceController(),
    );
  }
}