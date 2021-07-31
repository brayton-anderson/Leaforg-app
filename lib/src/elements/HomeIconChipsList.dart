import 'package:flutter/material.dart';
import '../helpers/responsive.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import 'HomeIconChipsWidget.dart';
import '../models/home_icons.dart';

class HomeIconChipsList extends StatefulWidget {
  final List<HomeIconsChips> homeIconChipsitems;

  @override
  _HomeIconChipsListState createState() => _HomeIconChipsListState();
  const HomeIconChipsList({
    Key key,
    @required this.homeIconChipsitems,
  }) : super(key: key);
}

class _HomeIconChipsListState extends State<HomeIconChipsList>
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
    final mediaQuery = MediaQuery.of(context);
    return widget.homeIconChipsitems.isEmpty
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
        : checkingDevice(mediaQuery) == 'mobile'
            ? Center(
                child: NineGridView(
                width: mediaQuery.size.width - 80,
                height: 390,
                arcAngle: (0 * 0).round().toDouble(),
                type: NineGridType.qqGp,
                itemCount: widget.homeIconChipsitems.length,
                itemBuilder: (context, index) {
                  return HomeIconChipsItem(
                      homeIconsChips: widget.homeIconChipsitems[index]);
                },
              ))
            : checkingDevice(mediaQuery) == 'small_tab'
                ? Center(
                    child: NineGridView(
                    width: mediaQuery.size.width,
                    height: 450,
                    arcAngle: (0 * 0).round().toDouble(),
                    type: NineGridType.qqGp,
                    itemCount: widget.homeIconChipsitems.length,
                    itemBuilder: (context, index) {
                      return HomeIconChipsItem(
                          homeIconsChips: widget.homeIconChipsitems[index]);
                    },
                  ))
                : ListView(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(widget.homeIconChipsitems.length,
                        (index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: HomeIconChipsItem(
                            homeIconsChips: widget.homeIconChipsitems[index]),
                      );
                    }),
                  );
  }
}
