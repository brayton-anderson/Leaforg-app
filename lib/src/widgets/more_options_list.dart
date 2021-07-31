import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import '../soconfig/pallete.dart';
import '../models/data_models.dart';
import '../widgets/widgets.dart';

class MoreOptionsList extends StatelessWidget {
  final List<List> _moreOptionsList = const [
    [PhosphorIcons.users_fill, Colors.deepPurple, 'Friends'],
    [PhosphorIcons.chat_teardrop_text_fill, Palette.facebookBlue, 'Messenger'],
    [PhosphorIcons.megaphone_simple_fill, Colors.orange, 'Pages'],
    [PhosphorIcons.package_fill, Palette.facebookBlue, 'Marketplace'],
    [PhosphorIcons.ticket_fill, Palette.facebookBlue, 'Promotions'],
    [PhosphorIcons.calendar_x_fill, Colors.red, 'Events'],
  ];

  final User currentUser;
  final User user;

  const MoreOptionsList({
    Key key,
    @required this.currentUser,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 520,
      constraints: BoxConstraints(
        maxWidth: 280.0,
        maxHeight: 520,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 15,
                offset: Offset(0, 5)),
          ],
          border: Border.all(
              width: 0.2,
              color: Theme.of(context).splashColor.withOpacity(0.4)),
          color: Theme.of(context).primaryColor),
      child: ListView.builder(
        itemCount: 1 + _moreOptionsList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return UserCardBig();
          }
          final List option = _moreOptionsList[index - 1];
          return Center(
            child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _Option(
                    icon: option[0],
                    color: option[1],
                    label: option[2],
                  ),
                )),
          );
        },
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _Option({
    Key key,
    @required this.icon,
    @required this.color,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print(label),
      child: Row(
        children: [
          Icon(icon, size: 38.0, color: color),
          const SizedBox(width: 6.0),
          Flexible(
            child: Text(
              label,
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
