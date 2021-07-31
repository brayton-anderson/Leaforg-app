import 'package:get/get.dart';
import '../controllers/community_controlers/create_postsandstories_dialog.dart';


class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostDialogController>(
      () => CreatePostDialogController(),
    );
    
  }
}