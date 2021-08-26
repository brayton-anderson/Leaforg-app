import 'package:get/get.dart';
import '../models/userstories.dart';
import '../repository/stories_repository.dart';
import '../repository/user_repository.dart';
import '../models/stories.dart';

class TodoController extends GetxController {
  Rx<List<StoriesuserModel>> usersList = Rx<List<StoriesuserModel>>([]);

  List<StoriesuserModel> get users => usersList.value;

  Rx<List<StoriesModel>> todoList = Rx<List<StoriesModel>>([]);

  List<StoriesModel> get todos => todoList.value;

  @override
  void onInit() {
    super.onInit();
    var dar = users.map((e) => e.user_id);
    var f = dar.toList();

    String uid = currentUser.value.id;
    usersList.bindStream(StoriesRepo().getUserStories());
    todoList.bindStream(
        StoriesRepo().todoStream(uid)); //stream coming from firebase
  }
}
