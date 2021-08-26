import 'package:flutter/material.dart';
import '../models/color_palletes.dart';
import 'ColorPalleteLeaforgWidget.dart';

class ColorPalleteLeaforgList extends StatefulWidget {
  final List<Palette> colorPalleteLeaforgitems;

  @override
  _ColorPalleteLeaforgListState createState() =>
      _ColorPalleteLeaforgListState();
  const ColorPalleteLeaforgList({
    Key key,
    @required this.colorPalleteLeaforgitems,
  }) : super(key: key);
}

class _ColorPalleteLeaforgListState extends State<ColorPalleteLeaforgList>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.colorPalleteLeaforgitems.isEmpty
        ? Column(
            children: [
              Text(
                '!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ],
          )
        : Center(
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemCount: widget.colorPalleteLeaforgitems.length,
                itemBuilder: (context, index) {
                  return ColorPalleteItem(
                      colorPalleteItem: widget.colorPalleteLeaforgitems[index]);
                }));
  }
}
