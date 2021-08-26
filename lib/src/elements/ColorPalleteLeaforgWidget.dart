import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'CreateStoriesWidget.dart';
import '../models/color_palletes.dart';

class ColorPalleteItem extends StatefulWidget {
  final Palette colorPalleteItem;

  @override
  _ColorPalleteItemState createState() => _ColorPalleteItemState();
  const ColorPalleteItem({
    Key key,
    @required this.colorPalleteItem,
  }) : super(key: key);
}

class _ColorPalleteItemState extends State<ColorPalleteItem>
    with TickerProviderStateMixin {
  static String _colorpalleteid = '0';
  static Color _colorpalletecolor;
  static int _mycolorinteger;

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
    return GestureDetector(
        onTap: () async {
          setState(() {
            _colorpalleteid = widget.colorPalleteItem.name;
            _colorpalletecolor = widget.colorPalleteItem.primary;
            _mycolorinteger = _colorpalletecolor.value;
            _controller.forward();
          });
          await setCurrentColors(_mycolorinteger);
          await getCurrentColors();
        },
        child: Container(
          padding: EdgeInsets.all(2),
          height: 25,
          width: 25,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                  child: Container(
                padding: EdgeInsets.all(5),
                height: 21,
                width: 21,
                decoration: BoxDecoration(
                    color: widget.colorPalleteItem.primary,
                    borderRadius: BorderRadius.circular(1000)),
              )),
              _colorpalleteid == widget.colorPalleteItem.name
                  ? Center(
                      child: Icon(
                      PhosphorIcons.check_fill,
                      size: 15,
                      color: widget.colorPalleteItem.name == 'WHITE'
                          ? Theme.of(context).splashColor
                          : Theme.of(context).primaryColor,
                    ))
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ],
          ),
          decoration: BoxDecoration(
              color: widget.colorPalleteItem.primary,
              border: Border.all(
                color: Theme.of(context).hintColor.withOpacity(0.09),
                width: 0.8,
              ),
              borderRadius: BorderRadius.circular(1000)),
        ));
  }

 
}


