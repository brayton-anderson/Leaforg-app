import 'package:flutter/material.dart';
import '../models/home_subicons.dart';

class HomeSubIconChipsItem extends StatefulWidget {
  final HomeSubIconsChips homeSubIconsChips;

  @override
  _HomeSubIconChipsItemState createState() => _HomeSubIconChipsItemState();
  const HomeSubIconChipsItem({
    Key key,
    @required this.homeSubIconsChips,
  }) : super(key: key);
}

class _HomeSubIconChipsItemState extends State<HomeSubIconChipsItem> {
  @override
  Widget build(BuildContext context) {
    // double top = double.parse(widget.homeSubIconsChips.top);
    // double left = double.parse(widget.homeSubIconsChips.left);
    // double right = double.parse(widget.homeSubIconsChips.right);
    // double bottom = double.parse(widget.homeSubIconsChips.bottom);
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle =
        themeData.textTheme.bodyText1.copyWith(color: themeData.splashColor);
    return GestureDetector(
      onTap: () {
        widget.homeSubIconsChips.id == '5'
            ? print('its number 5')
            : print('none');
      },
      child: Container(
        height: 120.0,
        width: 120.0,
        alignment: widget.homeSubIconsChips.containpos,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xfffffff5), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(1000)),
          gradient: RadialGradient(
            center: Alignment(0.55, 0.55),
            focalRadius: 64,
            colors: [
              Color(0xFFf2f2f2).withOpacity(.75),
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 70,
                width: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.homeSubIconsChips.image),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Center(
              child: RichText(
                overflow: TextOverflow.fade,
                maxLines: 2,
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      style: aboutTextStyle,
                      text: widget.homeSubIconsChips.title,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
