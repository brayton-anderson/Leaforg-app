import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/market_place.dart';
import '../pages/sorry_page_comming_soon.dart';
import '../repository/user_repository.dart';
import '../pages/community_nav.dart';
import '../helpers/responsive.dart';
import '../models/home_subicons.dart';
import 'package:ud_design/ud_design.dart';
import '../models/home_subicon_position.dart';
import '../models/home_icons.dart';
import 'HomeSubIconChipsList.dart';

class HomeIconChipsItem extends StatefulWidget {
  final HomeIconsChips homeIconsChips;

  @override
  _HomeIconChipsItemState createState() => _HomeIconChipsItemState();
  const HomeIconChipsItem({
    Key key,
    @required this.homeIconsChips,
  }) : super(key: key);
}

class _HomeIconChipsItemState extends State<HomeIconChipsItem> {
  static String _homeiconsid = '0';
  @override
  Widget build(BuildContext context) {
    UdDesign.init(context);
    final mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle =
        themeData.textTheme.bodyText1.copyWith(color: themeData.splashColor);
    return GestureDetector(
        onTap: () {
          setState(() {
            _homeiconsid = widget.homeIconsChips.id;
          });
          widget.homeIconsChips.id == '4'
              ? currentUser.value.apiToken == null
                  ? Navigator.of(Get.context).pushReplacementNamed('/Login')
                  : Get.to(() => CommunityNavScreen())
              : widget.homeIconsChips.id == '2'
                  ? Get.to(() => MarketPlace())
                  : widget.homeIconsChips.id == '3'
                      ? Get.to(() => ComingSoonWidget())
                      : gethomeiconPositions().then((value) {
                          if (value != null) {
                            showInstallments(value);
                          }
                        });
        },
        child: Material(
          elevation: 5,
          type: MaterialType.button,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(1000),
          child: Container(
            height: checkingDevice(mediaQuery) == 'mobile'
                ? UdDesign.pt(60)
                : checkingDevice(mediaQuery) == 'small_tab'
                    ? UdDesign.pt(80)
                    : checkingDevice(mediaQuery) == 'big_tab'
                        ? UdDesign.pt(120)
                        : UdDesign.pt(120),
            width: checkingDevice(mediaQuery) == 'mobile'
                ? UdDesign.pt(60)
                : checkingDevice(mediaQuery) == 'small_tab'
                    ? UdDesign.pt(80)
                    : checkingDevice(mediaQuery) == 'big_tab'
                        ? UdDesign.pt(120)
                        : UdDesign.pt(120),
            margin: EdgeInsets.symmetric(
                horizontal: UdDesign.pt(5), vertical: UdDesign.pt(5)),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Color(0xfffffff5), width: UdDesign.pt(2.0)),
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
                Container(
                  height: checkingDevice(mediaQuery) == 'mobile'
                      ? UdDesign.pt(50)
                      : checkingDevice(mediaQuery) == 'small_tab'
                          ? UdDesign.pt(60)
                          : checkingDevice(mediaQuery) == 'big_tab'
                              ? UdDesign.pt(70)
                              : UdDesign.pt(70),
                  width: checkingDevice(mediaQuery) == 'mobile'
                      ? UdDesign.pt(50)
                      : checkingDevice(mediaQuery) == 'small_tab'
                          ? UdDesign.pt(60)
                          : checkingDevice(mediaQuery) == 'big_tab'
                              ? UdDesign.pt(70)
                              : UdDesign.pt(70),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.homeIconsChips.image),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                RichText(
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        style: aboutTextStyle,
                        text: widget.homeIconsChips.title,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void showInstallments(HomesubiconPosition value) {
    print(value.bottom);

    new Timer(const Duration(seconds: 5), () {
      setState(() {});
      // Navigator.pop(context);

      print("15 second later.");
    });
    //final tallment = inst;
    double top = double.parse(value.top);
    double left = double.parse(value.left);
    double right = double.parse(value.right);
    double bottom = double.parse(value.bottom);
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle =
        themeData.textTheme.bodyText1.copyWith(color: themeData.splashColor);
    showDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: themeData.secondaryHeaderColor.withOpacity(0.85),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10000)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: widget.homeIconsChips.id == '1'
                        ? BoxConstraints(
                            maxWidth: 400,
                            maxHeight: 350,
                            minWidth: 400,
                            minHeight: 350,
                          )
                        : widget.homeIconsChips.id == '4'
                            ? BoxConstraints(
                                maxWidth: 380,
                                maxHeight: 350,
                                minWidth: 380,
                                minHeight: 350,
                              )
                            : BoxConstraints(
                                maxWidth: 350,
                                maxHeight: 350,
                                minWidth: 350,
                                minHeight: 350,
                              ),
                    child: Stack(children: <Widget>[
                      Positioned(
                        left: left,
                        bottom: bottom,
                        right: right,
                        top: top,
                        child: Material(
                          elevation: 5,
                          type: MaterialType.button,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(1000),
                          child: Transform.scale(
                            scale: 1.295,
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 2.1, sigmaY: 2.1),
                              child: Container(
                                height: 250,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  // border: Border.all(
                                  //     color: Color(0xfffffff5).withOpacity(0.1),
                                  //     width: 10.0),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    HomeSubIconChipsList(
                                      homeSubIconChipsitems: _homeiconsid == '1'
                                          ? _homesubiconsListItems.toList()
                                          : _homeiconsid == '2'
                                              ? _homesubiconsListItemstwo
                                                  .toList()
                                              : _homeiconsid == '3'
                                                  ? _homesubiconsListItemsthree
                                                      .toList()
                                                  : _homesubiconsListItemsfour
                                                      .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
              widget.homeIconsChips.id == '1'
                  ? SizedBox(
                      height: 30,
                    )
                  : widget.homeIconsChips.id == '3'
                      ? SizedBox(
                          height: 30,
                        )
                      : SizedBox(
                          height: 0,
                        ),
              Container(
                  width: 300,
                  height: 100,
                  color: Colors.transparent,
                  alignment: widget.homeIconsChips.id == '1'
                      ? Alignment.centerLeft
                      : widget.homeIconsChips.id == '3'
                          ? Alignment.centerLeft
                          : Alignment.center,
                  child: Text(
                    widget.homeIconsChips.id == '1'
                        ? 'FOODS'
                        : widget.homeIconsChips.id == '2'
                            ? 'STORES'
                            : widget.homeIconsChips.id == '3'
                                ? 'HELPERS'
                                : '          COMMUNITY',
                    textAlign: widget.homeIconsChips.id == '1'
                        ? TextAlign.start
                        : widget.homeIconsChips.id == '3'
                            ? TextAlign.start
                            : TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  final List<HomeSubIconsChips> _homesubiconsListItems = [
    HomeSubIconsChips(
      id: '1',
      title: 'Vegeterian',
      image: 'assets/images/stores/vegeterian_foods.png',
      top: '60',
      bottom: '0',
      left: '143',
      right: '0',
      mainicons_id: '1',
      containpos: Alignment.centerLeft,
    ),
    HomeSubIconsChips(
      id: '2',
      title: 'Fast foods',
      image: 'assets/images/stores/green_stores_at_leaforg.png',
      top: '60',
      bottom: '0',
      left: '0',
      right: '143',
      mainicons_id: '1',
      containpos: Alignment.centerRight,
    ),
  ];

  final List<HomeSubIconsChips> _homesubiconsListItemstwo = [
    HomeSubIconsChips(
      id: '3',
      title: 'Stores',
      image: 'assets/images/shops/shop_green_leaforg.png',
      top: '0',
      bottom: '143',
      left: '0',
      right: '65',
      mainicons_id: '2',
      containpos: Alignment.topCenter,
    ),
    HomeSubIconsChips(
      id: '4',
      title: 'Gas/Water',
      image: 'assets/images/shops/gas_and_water_delivery.png',
      top: '60',
      bottom: '0',
      left: '0',
      right: '143',
      mainicons_id: '2',
      containpos: Alignment.centerLeft,
    ),
    HomeSubIconsChips(
      id: '5',
      title: 'Juice Palor',
      image: 'assets/images/shops/juice_palor_store.png',
      top: '60',
      bottom: '0',
      left: '0',
      right: '143',
      mainicons_id: '2',
      containpos: Alignment.centerRight,
    ),
  ];

  final List<HomeSubIconsChips> _homesubiconsListItemsthree = [
    HomeSubIconsChips(
      id: '6',
      title: 'Shipping',
      image: 'assets/images/helpers/delivery_at_leaforg.png',
      top: '0',
      bottom: '143',
      left: '0',
      right: '65',
      mainicons_id: '3',
      containpos: Alignment.topCenter,
    ),
    HomeSubIconsChips(
      id: '7',
      title: 'Repairs',
      image: 'assets/images/helpers/repairs_leaforg_now.png',
      top: '60',
      bottom: '0',
      left: '0',
      right: '143',
      mainicons_id: '3',
      containpos: Alignment.centerLeft,
    ),
    HomeSubIconsChips(
      id: '8',
      title: 'Shop for?',
      image: 'assets/images/helpers/shop_for_me_now.png',
      top: '60',
      bottom: '0',
      left: '0',
      right: '143',
      mainicons_id: '3',
      containpos: Alignment.centerRight,
    ),
  ];

  final List<HomeSubIconsChips> _homesubiconsListItemsfour = [
    HomeSubIconsChips(
      id: '9',
      title: 'Post feed',
      image: 'assets/images/community/post_an_activity.png',
      top: '60',
      bottom: '0',
      left: '0',
      right: '143',
      mainicons_id: '4',
      containpos: Alignment.centerLeft,
    ),
    HomeSubIconsChips(
      id: '10',
      title: 'View feeds',
      image: 'assets/images/community/read_activities_leaforg.png',
      top: '60',
      bottom: '0',
      left: '0',
      right: '143',
      mainicons_id: '4',
      containpos: Alignment.centerRight,
    ),
  ];

  HomesubiconPosition _homesub;

  Future<HomesubiconPosition> gethomeiconPositions() async {
    final _result = await repogethomeiconPosition();
    return HomesubiconPosition.fromJSON(_result);
  }

  Future<Map<String, dynamic>> repogethomeiconPosition() async {
    //var _data;
    if (widget.homeIconsChips.id == '1') {
      final data = {
        "top": '50',
        "bottom": '0',
        "left": '0',
        "right": '100',
      };
      return data;
    } else if (widget.homeIconsChips.id == '2') {
      final data = {
        "top": '0',
        "bottom": '80',
        "left": '60',
        "right": '0',
      };
      return data;
    } else if (widget.homeIconsChips.id == '3') {
      final data = {
        "top": '80',
        "bottom": '0',
        "left": '0',
        "right": '60',
      };
      return data;
    } else {
      final data = {
        "top": '0',
        "bottom": '80',
        "left": '100',
        "right": '0',
      };
      return data;
    }
  }
}
