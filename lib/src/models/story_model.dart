import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaforgapp/src/models/userstories.dart';
import '../controllers/stories_controller.dart';
import '../repository/stories_repository.dart';
import '../repository/user_repository.dart';
import 'stories.dart';
//using System.Linq;

class Message {
  final message;
  final timestamp;
  final uid;
  final user;
  const Message(this.message, this.timestamp, this.uid, this.user);
}

class ChatList extends StatefulWidget {
  ChatList();
  @override
  State<StatefulWidget> createState() => _WritePost();
}

class _WritePost extends State<ChatList> {
  @override
  void initState() {
    super.initState();
    StoriesRepo.getUser().then((value) {
      print(value.storyuserid);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    super.dispose();
    //StoriesRepo.getUser();
    //startconts();
  }

  @override
  Widget build(BuildContext context) {
    // var streamBuilder = StreamBuilder<List<StoriesModel>>(
    //     stream: StoriesRepo.todoStream(),
    //     builder: (BuildContext context,
    //         AsyncSnapshot<List<StoriesModel>> messagesSnapshot) {
    //       if (messagesSnapshot.hasError)
    //         return new Text('Error: ${messagesSnapshot.error}');
    //       switch (messagesSnapshot.connectionState) {
    //         case ConnectionState.waiting:
    //           return new Text("Loading...");
    //         default:
    //           return new ListView(
    //               scrollDirection: Axis.horizontal,
    //               children: messagesSnapshot.data.map((StoriesModel msg) {
    //                 return new ListTile(
    //                   title: new Text(msg.story_content),
    //                   subtitle: new Text(DateTime.fromMillisecondsSinceEpoch(
    //                               msg.story_timestamp)
    //                           .toString() +
    //                       "\n" +
    //                       (msg.story_commentcount ?? msg.storyuserid)),
    //                 );
    //               }).toList());
    //       }
    //     });
    return

        //streamBuilder;

        GetX<TodoController>(
      init: Get.put<TodoController>(TodoController()),
      builder: (TodoController todoController) {
        if (todoController != null && todoController.todos != null) {
          //final combinedList = [];
          //combinedList.addAll(todoController.users);

          var result = todoController.users.map((e) {
            StoriesModel founded = todoController.todos
                .singleWhere((w) => w.storyuserid == e.user_id, orElse: () {
              return null;
            });

            if (founded != null) {
              e.toMap(founded);
              return e;
            } else {
              return null;
            }
          }).toList();
          print(result);
          //List.from(todoController.todos)..addAll(todoController.users);
          //final combinedList = [todoController.users, todoController.todos].expand((element) => element).toList();
          return Container(
            height: 200.0,
            width: 101.0,
            color: Colors.transparent,
            child: ListView.builder(
              itemCount: result.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) {
                return _TodoCard(
                    uid: currentUser.value.id, todo: result[index]);
              },
            ),
          );
        } else {
          return Text("loading...");
        }
      },
    );
  }
}

class _TodoCard extends StatelessWidget {
  final String uid;
  final StoriesuserModel todo;

  const _TodoCard({Key key, this.uid, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                todo.user_image,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Checkbox(
              value: false,
              onChanged: (newValue) {
                StoriesRepo().addStories(newValue, uid, todo.storyuserid);
              },
            ),
          ],
        ),
      ),
    );
  }
}
