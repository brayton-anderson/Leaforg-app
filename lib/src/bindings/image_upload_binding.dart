import 'package:get/get.dart';

import '../controllers/image_upload_controller.dart';

class ImagesUploadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageUploadController>(
      () => ImageUploadController(),
    );
  }
}
