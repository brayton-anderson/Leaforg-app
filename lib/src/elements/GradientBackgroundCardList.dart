import 'package:flutter/material.dart';
import '../models/gradient_palletes.dart';
import 'GradientBackgroundWidget.dart';

class GradientPalleteBackgroundLeaforgList extends StatefulWidget {
  final List<GradientPallete> gradientPalleteLeaforgitems;

  @override
  _GradientPalleteBackgroundLeaforgListState createState() =>
      _GradientPalleteBackgroundLeaforgListState();
  const GradientPalleteBackgroundLeaforgList({
    Key key,
    @required this.gradientPalleteLeaforgitems,
  }) : super(key: key);
}

class _GradientPalleteBackgroundLeaforgListState extends State<GradientPalleteBackgroundLeaforgList>
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
    return widget.gradientPalleteLeaforgitems.isEmpty
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
                    crossAxisCount: 9,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemCount: widget.gradientPalleteLeaforgitems.length,
                itemBuilder: (context, index) {
                  return GradientBackgroundPalleteItem(
                      gradientPalleteItem: widget.gradientPalleteLeaforgitems[index]);
                }));
  }
}