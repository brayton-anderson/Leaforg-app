import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/extra.dart';

class ExtraItemWidget extends StatefulWidget {
  final Extra extra;
  final VoidCallback onChanged;

  ExtraItemWidget({
    Key key,
    this.extra,
    this.onChanged,
  }) : super(key: key);

  @override
  _ExtraItemWidgetState createState() => _ExtraItemWidgetState();
}

class _ExtraItemWidgetState extends State<ExtraItemWidget>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  Animation<double> sizeCheckAnimation;
  Animation<double> rotateCheckAnimation;
  Animation<double> opacityAnimation;
  Animation opacityCheckAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 350), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation = Tween(begin: 0.0, end: 60.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    opacityAnimation = Tween(begin: 0.0, end: 0.5).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    opacityCheckAnimation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    rotateCheckAnimation = Tween(begin: 2.0, end: 0.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    sizeCheckAnimation = Tween<double>(begin: 0, end: 36).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle =
        themeData.textTheme.bodyText1.copyWith(color: themeData.splashColor);
    final TextStyle aboutTextStyle2 = themeData.textTheme.headline2
        .copyWith(color: themeData.scaffoldBackgroundColor);
    final TextStyle linkStyle2 =
        themeData.textTheme.headline4.copyWith(color: themeData.splashColor);
    final TextStyle linkStyle4 =
        themeData.textTheme.headline1.copyWith(color: themeData.hintColor);
    final TextStyle linkStyle3 = themeData.textTheme.headline3
        .copyWith(color: themeData.secondaryHeaderColor);
    final TextStyle footerStyle =
        themeData.textTheme.caption.copyWith(color: themeData.splashColor);
    return InkWell(
      onTap: () {
        if (widget.extra.checked) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
        widget.extra.checked = !widget.extra.checked;
        widget.onChanged();
      },
      child: Container(
        width: 292,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(widget.extra.image?.thumb),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  height: animation.value,
                  width: animation.value,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    color: Theme.of(context)
                        .secondaryHeaderColor
                        .withOpacity(opacityAnimation.value),
                  ),
                  child: Transform.rotate(
                    angle: rotateCheckAnimation.value,
                    child: Icon(
                      Icons.check,
                      size: sizeCheckAnimation.value,
                      color: Theme.of(context)
                          .primaryColor
                          .withOpacity(opacityCheckAnimation.value),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.extra?.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: linkStyle2,
                  ),
                  SizedBox(height: 3),
                  Text(
                    Helper.skipHtml(widget.extra.description),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: footerStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Helper.getPrice(widget.extra.price, context,
                              style: linkStyle3),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
