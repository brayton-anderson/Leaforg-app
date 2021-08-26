import 'package:get/get.dart';
import '../models/userstories.dart';
import '../repository/stories_repository.dart';
import '../repository/user_repository.dart';

class UserStoriesController extends GetxController {
  Rx<List<StoriesuserModel>> userstoryList = Rx<List<StoriesuserModel>>([]);

  List<StoriesuserModel> get userstories => userstoryList.value;


  @override
  void onInit() {
    super.onInit();
    var dar = userstories.map((e) => e.user_id);
    var f = dar.toList();
   // Utils.readTimestamp(data['postTimeStamp'])

    String uid = currentUser.value.id;
    userstoryList.bindStream(StoriesRepo().getUserStories()); //stream coming from firebase
  }
}