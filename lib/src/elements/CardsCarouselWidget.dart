import 'package:flutter/material.dart';

import '../elements/CardsCarouselLoaderWidget.dart';
import '../models/store.dart';
import '../models/route_argument.dart';
import 'CardWidget.dart';

// ignore: must_be_immutable
class CardsCarouselWidget extends StatefulWidget {
  List<Store> storesList;
  String heroTag;

  CardsCarouselWidget({Key key, this.storesList, this.heroTag})
      : super(key: key);

  @override
  _CardsCarouselWidgetState createState() => _CardsCarouselWidgetState();
}

class _CardsCarouselWidgetState extends State<CardsCarouselWidget> {
  @override
  void initState() {
    super.initState();
  }

  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return widget.storesList.isEmpty
        ? CardsCarouselLoaderWidget()
        : Container(
            height: 288,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: widget.storesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Details',
                        arguments: RouteArgument(
                          id: widget.storesList.elementAt(index).id,
                          heroTag: widget.heroTag,
                        ));
                  },
                  child: CardWidget(
                      store: widget.storesList.elementAt(index),
                      heroTag: widget.heroTag),
                );
              },
            ),
          );
  }
}
