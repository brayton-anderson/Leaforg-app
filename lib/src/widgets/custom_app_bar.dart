import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import '../models/data_models.dart';
import '../widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  final User currentUser;
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar({
    Key key,
    @required this.currentUser,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: AssetImage("assets/img/leaforg_icon_green.png"),
                fit: BoxFit.contain,
                alignment: Alignment.topLeft,
              ),
              color: Colors.transparent,
            ),
          ),
          SizedBox(
            width: 100,
          ),
          Container(
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.1),
                          blurRadius: 7,
                          offset: Offset(0, 3)),
                    ],
                    border: Border.all(
                        width: 0.2,
                        color: Theme.of(context).splashColor.withOpacity(0.18)),
                    color: Theme.of(context).splashColor.withOpacity(0.05)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        PhosphorIcons.magnifying_glass_light,
                        size: 26,
                        color: Theme.of(context).splashColor.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Search Leaforg',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color:
                                Theme.of(context).splashColor.withOpacity(0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 50,
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: CustomTabBar(
              icons: icons,
              selectedIndex: selectedIndex,
              onTap: onTap,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UserCard(),
                const SizedBox(width: 12.0),
                Stack(alignment: Alignment.topCenter, children: [
                  CircleButton(
                    icon: PhosphorIcons.bell_simple_fill,
                    iconSize: 30.0,
                    onPressed: () => print('Search'),
                  ),
                  Container(
                    height: 20.0,
                    width: 20.0,
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 0.5,
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                        child: Text(
                      '9+',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  )
                ]),
                Stack(alignment: Alignment.topCenter, children: [
                  CircleButton(
                    icon: PhosphorIcons.chat_teardrop_text_fill,
                    iconSize: 30.0,
                    onPressed: () => print('Messenger'),
                  ),
                  Container(
                    height: 20.0,
                    width: 20.0,
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 0.5,
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                        child: Text(
                      '9+',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  )
                ]),
                CircleButton(
                  icon: PhosphorIcons.circles_four_fill,
                  iconSize: 30.0,
                  onPressed: () => print('Messenger'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
