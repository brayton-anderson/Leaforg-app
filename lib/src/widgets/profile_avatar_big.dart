import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../repository/user_repository.dart';
import '../soconfig/pallete.dart';

class ProfileAvatarBig extends StatelessWidget {
  final bool isActive;
  final bool hasBorder;

  const ProfileAvatarBig({
    Key key,
    this.isActive = false,
    this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 46.0,
          backgroundColor: hasBorder
              ? Theme.of(context).secondaryHeaderColor
              : Palette.online,
          child: CircleAvatar(
            radius: 43.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(currentUser.value.image.thumb),
          ),
        ),
        isActive
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: Palette.online,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
