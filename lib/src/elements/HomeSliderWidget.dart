import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/responsive.dart';

import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../models/slide.dart';
import 'HomeSliderLoaderWidget.dart';

class HomeSliderWidget extends StatefulWidget {
  final List<Slide> slides;

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();

  HomeSliderWidget({Key key, this.slides}) : super(key: key);
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;
  AlignmentDirectional _alignmentDirectional;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle =
        themeData.textTheme.headline2.copyWith(color: themeData.primaryColor);
    return widget.slides == null || widget.slides.isEmpty
        ? HomeSliderLoaderWidget()
        : Stack(
            alignment: _alignmentDirectional ??
                Helper.getAlignmentDirectional(
                    widget.slides.elementAt(0).textPosition),
            fit: StackFit.passthrough,
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  height: checkingDevice(mediaQuery) == "mobile" ? 180 : 540,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                      _alignmentDirectional = Helper.getAlignmentDirectional(
                          widget.slides.elementAt(index).textPosition);
                    });
                  },
                ),
                items: widget.slides.map((Slide slide) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        height:
                            checkingDevice(mediaQuery) == "mobile" ? 140 : 420,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.01),
                                blurRadius: 0.5,
                                offset: Offset(0, 2)),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              child: CachedNetworkImage(
                                height: checkingDevice(mediaQuery) == "mobile"
                                    ? 140
                                    : 420,
                                width: double.infinity,
                                fit: Helper.getBoxFit(slide.imageFit),
                                imageUrl: slide.image.url,
                                placeholder: (context, url) => Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: checkingDevice(mediaQuery) == "mobile"
                                      ? 140
                                      : 420,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Container(
                              alignment: Helper.getAlignmentDirectional(
                                  slide.textPosition),
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: config.App(context).appWidth(40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    if (slide.text != null && slide.text != '')
                                      Text(
                                        slide.text,
                                        style: aboutTextStyle,
                                      ),
                                    if (slide.button != null &&
                                        slide.button != '')
                                      SizedBox(
                                        width: checkingDevice(mediaQuery) ==
                                                "mobile"
                                            ? double.infinity
                                            : 180,
                                        height: 45,
                                        child: RawMaterialButton(
                                          onPressed: () {
                                            if (slide.store != null) {
                                              Navigator.of(context).pushNamed(
                                                  '/Details',
                                                  arguments: RouteArgument(
                                                      id: slide.store.id,
                                                      heroTag: 'home_slide'));
                                            } else if (slide.product != null) {
                                              Navigator.of(context).pushNamed(
                                                  '/Product',
                                                  arguments: RouteArgument(
                                                      id: slide.product.id,
                                                      heroTag: 'home_slide'));
                                            }
                                          },
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          fillColor:
                                              themeData.secondaryHeaderColor,
                                          shape: StadiumBorder(),
                                          child: Text(
                                            slide.button,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 22, horizontal: 42),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.slides.map((Slide slide) {
                    return Container(
                      width: 20.0,
                      height: 3.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: _current == widget.slides.indexOf(slide)
                              ? themeData.secondaryHeaderColor
                              : themeData.secondaryHeaderColor
                                  .withOpacity(0.3)),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
  }
}
