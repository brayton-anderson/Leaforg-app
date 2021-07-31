import 'package:flutter/material.dart';
import '../repository/user_repository.dart';
import '../widgets/widgets.dart';

class UserCard extends StatelessWidget {
  

  const UserCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(),
          const SizedBox(width: 6.0),
          Flexible(
            child: Text(
              currentUser.value.name,
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
