import 'package:flutter/material.dart';
import '../repository/user_repository.dart';
import '../widgets/widgets.dart';

class UserCardBig extends StatelessWidget {
  const UserCardBig({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
              height: 100,
              width: 280,
              constraints: BoxConstraints(
                maxHeight: 100,
                maxWidth: 280,
              ),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(currentUser.value.image.thumb)),
              )),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                width: 280,
                color: Colors.transparent,
              ),
              ProfileAvatarBig(),
              const SizedBox(height: 10.0),
              Flexible(
                child: Text(
                  currentUser.value.name,
                  style: const TextStyle(fontSize: 16.0).copyWith(
                      color: Colors.black, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 0.5,
                child: Divider(height: 10.0, thickness: 0.5),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
