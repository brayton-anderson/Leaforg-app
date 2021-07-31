import 'package:get/get.dart';
import '../controllers/check_network/network_controller.dart';

class CreateNewtworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNetworkController>(
      () => CreateNetworkController(),
    );
  }
}
