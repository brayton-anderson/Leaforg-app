import 'package:flutter/material.dart';
import 'story_profile_avatar.dart';
import '../models/userstories.dart';

class UserCard extends StatelessWidget {
  final StoriesuserModel users;
  const UserCard({
    Key key,
    this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StoryProfileAvatar(
            users: users,
          ),
          const SizedBox(width: 6.0),
          Flexible(
            child: Text(
              users.user_name,
              style: const TextStyle(fontSize: 16.0)
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
