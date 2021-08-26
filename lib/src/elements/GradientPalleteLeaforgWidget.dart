import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import '../models/gradient_palletes.dart';
import 'CreateStoriesWidget.dart';

class GradientPalleteItem extends StatefulWidget {
  final GradientPallete gradientPalleteItem;

  @override
  _GradientPalleteItemState createState() => _GradientPalleteItemState();
  const GradientPalleteItem({
    Key key,
    @required this.gradientPalleteItem,
  }) : super(key: key);
}

class _GradientPalleteItemState extends State<GradientPalleteItem>
    with TickerProviderStateMixin {
  static String _gradientpalleteid = '0';
  static Color _shadowcolorpalletecolor;

  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    super.initState();
  }

  // Dispose the controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 30,
      width: 30,
      child: CircularGradientButton(
        child: _gradientpalleteid == widget.gradientPalleteItem.name
            ? Icon(
                PhosphorIcons.check_fill,
                size: 15,
                color: Theme.of(context).primaryColor,
              )
            : SizedBox(
                height: 0,
                width: 0,
              ),
        callback: () async {
          setState(() {
            _gradientpalleteid = widget.gradientPalleteItem.name;
          });
          await setCurrentGradient(widget.gradientPalleteItem.name);
          await setCurrentShadowGradient(
              widget.gradientPalleteItem.shaddowcolor.value);
          await getCurrentGradients();
          await getCurrentShadowColors();
        },
        gradient: widget.gradientPalleteItem.gradient,
        shadowColor: widget.gradientPalleteItem.shaddowcolor,
      ),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Theme.of(context).hintColor.withOpacity(0.3),
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(1000)),
    );
  }
}
