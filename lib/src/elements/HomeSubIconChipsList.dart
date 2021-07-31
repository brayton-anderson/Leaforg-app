import 'package:flutter/material.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import '../models/home_subicons.dart';
import 'HomeSubIconsWidget.dart';

class HomeSubIconChipsList extends StatefulWidget {
  final List<HomeSubIconsChips> homeSubIconChipsitems;

  @override
  _HomeSubIconChipsListState createState() => _HomeSubIconChipsListState();
  const HomeSubIconChipsList({
    Key key,
    @required this.homeSubIconChipsitems,
  }) : super(key: key);
}

class _HomeSubIconChipsListState extends State<HomeSubIconChipsList>
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
    return widget.homeSubIconChipsitems.isEmpty
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
        :
        // : ListView.builder(
        //     shrinkWrap: false,
        //     primary: true,
        //     itemExtent: 10.5,
        //     itemBuilder: (context, index) {
        //       return HomeSubIconChipsItem(
        //           homeSubIconsChips: homeSubIconChipsitems[index]);
        //     },
        //     // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     //     crossAxisSpacing: 1,
        //     //     mainAxisSpacing: 1,
        //     //     mainAxisExtent: 168,
        //     //     maxCrossAxisExtent: 175),
        //     itemCount: homeSubIconChipsitems.length,
        //   );

        Center(
            child: NineGridView(
            width: 240,
            height: 240,
            arcAngle: (0 * 0).round().toDouble(),
            type: NineGridType.qqGp,
            itemCount: widget.homeSubIconChipsitems.length,
            itemBuilder: (context, index) {
              return HomeSubIconChipsItem(
                  homeSubIconsChips: widget.homeSubIconChipsitems[index]);
            },
          ));
  }
}
