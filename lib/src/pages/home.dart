import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:leaforgapp/src/elements/SearchWidget.dart';
import '../shared/leaforg_footer_mobile_row.dart';
import '../shared/leaforg_footer_row.dart';
import '../shared/leaforg_partners_sectionWrap.dart';
import '../shared/leaforg_partners_sectionrow.dart';
import 'package:ud_design/ud_design.dart';
import '../elements/HomeIconChipsList.dart';
import '../models/home_icons.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/home_controller.dart';
import '../helpers/responsive.dart';
import '../shared/about.dart';
import '../shared/constants.dart';
import '../shared/page_body.dart';
import '../elements/CardsCarouselWidget.dart';
import '../elements/CaregoriesCarouselWidget.dart';
import '../elements/DeliveryAddressBottomSheetWidget.dart';
import '../elements/ProductsCarouselWidget.dart';
import '../elements/GridWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import '../repository/user_repository.dart';
import 'leaforg_locations.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;

  StreamSubscription locationSubscription;
  StreamSubscription boundsSubscription;

  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  ScrollController _controller = ScrollController();

  bool _visible = true;

  //static String get id => null;

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _visible = !_visible;
        }));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    //startconts();
  }

  void _scrollListener() {
    print(_controller.position.maxScrollExtent);
    if (_controller.position.extentAfter < 700) {
      // you reached at page bottom
    }
  }

  @override
  Widget build(BuildContext context) {
    UdDesign.init(context);
    final mediaQuery = MediaQuery.of(context);
    print(mediaQuery.size.height);
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle2 = TextStyle(
            fontSize: checkingDevice(mediaQuery) == 'mobile'
                ? UdDesign.fontSize(22.5)
                : checkingDevice(mediaQuery) == 'small_tab'
                    ? UdDesign.fontSize(28.0)
                    : checkingDevice(mediaQuery) == 'big_tab'
                        ? UdDesign.fontSize(32.5)
                        : UdDesign.fontSize(45.0),
            fontWeight: FontWeight.w600,
            height: 1.35)
        .copyWith(color: themeData.scaffoldBackgroundColor);
    final TextStyle linkStyle2 = TextStyle(
            fontSize: UdDesign.fontSize(15.0),
            fontWeight: FontWeight.w500,
            color: Theme.of(context).splashColor,
            height: 1.35)
        .copyWith(color: themeData.shadowColor);
    final TextStyle linkStyle4 = TextStyle(
            fontSize: UdDesign.fontSize(15.0),
            fontWeight: FontWeight.w500,
            color: Theme.of(context).splashColor,
            height: 1.35)
        .copyWith(color: themeData.splashColor);
    final TextStyle linkStyle3 = TextStyle(
            fontSize: UdDesign.fontSize(15.0),
            fontWeight: FontWeight.w700,
            height: 1.35)
        .copyWith(color: themeData.selectedRowColor);
    final TextStyle footerStyle = TextStyle(
            fontSize: UdDesign.fontSize(12.0),
            color: Theme.of(context).splashColor,
            height: 1.35)
        .copyWith(color: themeData.splashColor);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: checkingDevice(mediaQuery) == "mobile"
                ? AppBar(
                    leading: new IconButton(
                      icon: new Icon(Icons.sort,
                          color: Theme.of(context).hintColor),
                      onPressed: () =>
                          widget.parentScaffoldKey.currentState.openDrawer(),
                    ),
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    elevation: 0,
                    centerTitle: true,
                    title: ValueListenableBuilder(
                      valueListenable: settingsRepo.setting,
                      builder: (context, value, child) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/leaforg_icon_green.png"),
                              fit: BoxFit.contain,
                              alignment: Alignment.topLeft,
                            ),
                            color: Colors.transparent,
                          ),
                        );
                      },
                    ),
                    actions: <Widget>[
                      new ShoppingCartButtonWidget(
                          iconColor: Theme.of(context).hintColor,
                          labelColor: Theme.of(context).secondaryHeaderColor),
                      new Padding(
                        padding: const EdgeInsets.only(right: 60, top: 5),
                        child: AboutIconButton(),
                      ),
                    ],
                  )
                : checkingDevice(mediaQuery) == 'small_tab'
                    ? AppBar(
                        leading: new IconButton(
                          icon: new Icon(Icons.sort,
                              color: Theme.of(context).hintColor),
                          onPressed: () => widget.parentScaffoldKey.currentState
                              .openDrawer(),
                        ),
                        automaticallyImplyLeading: false,
                        backgroundColor: Theme.of(context).secondaryHeaderColor,
                        elevation: 0,
                        centerTitle: true,
                        title: ValueListenableBuilder(
                          valueListenable: settingsRepo.setting,
                          builder: (context, value, child) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/img/leaforg_icon_green.png"),
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topLeft,
                                ),
                                color: Colors.transparent,
                              ),
                            );
                          },
                        ),
                        actions: <Widget>[
                          new ShoppingCartButtonWidget(
                              iconColor: Theme.of(context).hintColor,
                              labelColor:
                                  Theme.of(context).secondaryHeaderColor),
                          new Padding(
                            padding: const EdgeInsets.only(right: 60, top: 5),
                            child: AboutIconButton(),
                          ),
                        ],
                      )
                    : AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Theme.of(context).secondaryHeaderColor,
                        elevation: 0,
                        centerTitle: false,
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 60),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/img/leaforg_icon_green.png"),
                                fit: BoxFit.contain,
                                alignment: Alignment.topLeft,
                              ),
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        actions: <Widget>[
                            new Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: ShoppingCartButtonWidget(
                                    iconColor: Theme.of(context).hintColor,
                                    labelColor: Theme.of(context)
                                        .secondaryHeaderColor)),
                            new Padding(
                              padding: EdgeInsets.only(
                                  right: UdDesign.pt(60), top: UdDesign.pt(0)),
                              child: AboutIconButton(),
                            ),
                          ])),
        body: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: _con.refreshHome,
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: checkingDevice(mediaQuery) == 'mobile'
                          ? null
                          : checkingDevice(mediaQuery) == 'small_tab'
                              ? null
                              : TopCurve(),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment(0.55, 1.05),
                            focalRadius: 414,
                            colors: [
                              //Color(0xFF00154E).withOpacity(.75),
                              Theme.of(context).hintColor,
                              Theme.of(context).secondaryHeaderColor,
                            ],
                          ),
                        ),
                        height: checkingDevice(mediaQuery) == 'mobile'
                            ? UdDesign.blocksYaxis(100)
                            : checkingDevice(mediaQuery) == 'small_tab'
                                ? UdDesign.blocksYaxis(100)
                                : UdDesign.blocksYaxis(86.00749625187406),
                        width: UdDesign.blocksXaxis(100),
                        child: PageBody(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: checkingDevice(mediaQuery) == 'mobile'
                                    ? UdDesign.blocksYaxis(86.00749625187406)
                                    : UdDesign.blocksYaxis(37.48125937031484),
                                width: checkingDevice(mediaQuery) == 'mobile'
                                    ? UdDesign.blocksXaxis(83.54685212298683)
                                    : checkingDevice(mediaQuery) == 'small_tab'
                                        ? UdDesign.blocksXaxis(
                                            33.41874084919473)
                                        : checkingDevice(mediaQuery) ==
                                                'big_tab'
                                            ? UdDesign.blocksXaxis(
                                                33.41874084919473)
                                            : UdDesign.blocksXaxis(
                                                33.41874084919473),
                                padding: EdgeInsets.all(UdDesign.pt(10)),
                                margin: EdgeInsets.all(UdDesign.pt(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        'Green products near you',
                                        textAlign: TextAlign.center,
                                        style: aboutTextStyle2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: UdDesign.blocksYaxis(
                                          2.248875562218891),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(SearchModal());
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           LeaforgLocationsScreen()),
                                        // );
                                      },
                                      child: Container(
                                        height: UdDesign.blocksYaxis(
                                            7.496251874062969),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              UdDesign.pt(10)),
                                          color:
                                              themeData.scaffoldBackgroundColor,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: UdDesign.pt(50),
                                              height: UdDesign.pt(50),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        UdDesign.pt(10)),
                                                    bottomLeft: Radius.circular(
                                                        UdDesign.pt(10))),
                                                color: themeData.hintColor,
                                              ),
                                              child: Icon(
                                                PhosphorIcons
                                                    .magnifying_glass_fill,
                                                color: Colors.white,
                                                size: UdDesign.pt(30),
                                              ),
                                            ),
                                            SizedBox(
                                              width: UdDesign.blocksXaxis(
                                                  0.7320644216691069),
                                            ),
                                            Center(
                                              child: Text(
                                                'What\'s the product?',
                                                style: linkStyle2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: UdDesign.blocksYaxis(
                                          1.499250374812594),
                                    ),
                                    Center(
                                      child: Text(
                                        'Use current location',
                                        style: linkStyle3,
                                      ),
                                    ),
                                    checkingDevice(mediaQuery) == 'big_tab'
                                        ? SizedBox(
                                            height: 0,
                                            width: 0,
                                          )
                                        : checkingDevice(mediaQuery) ==
                                                'desktop'
                                            ? SizedBox(
                                                height: 0,
                                                width: 0,
                                              )
                                            : SizedBox(
                                                height: UdDesign.blocksYaxis(
                                                    1.499250374812594),
                                              ),
                                    checkingDevice(mediaQuery) == 'big_tab'
                                        ? SizedBox(
                                            height: 0,
                                            width: 0,
                                          )
                                        : checkingDevice(mediaQuery) ==
                                                'desktop'
                                            ? SizedBox(
                                                height: 0,
                                                width: 0,
                                              )
                                            : Container(
                                                alignment: Alignment.center,
                                                height: checkingDevice(
                                                            mediaQuery) ==
                                                        'mobile'
                                                    ? UdDesign.pt(390)
                                                    : checkingDevice(
                                                                mediaQuery) ==
                                                            'small_tab'
                                                        ? UdDesign.pt(280)
                                                        : checkingDevice(
                                                                    mediaQuery) ==
                                                                'big_tab'
                                                            ? UdDesign.pt(140)
                                                            : UdDesign.pt(140),
                                                color: Colors.transparent,
                                                child: HomeIconChipsList(
                                                  homeIconChipsitems:
                                                      _homeiconsListItems
                                                          .toList(),
                                                ),
                                              ),
                                  ],
                                ),
                              ),
                              checkingDevice(mediaQuery) == 'mobile'
                                  ? SizedBox(
                                      height: 0,
                                      width: 0,
                                    )
                                  : checkingDevice(mediaQuery) == 'small_tab'
                                      ? SizedBox(
                                          height: 0,
                                          width: 0,
                                        )
                                      : SizedBox(
                                          height: UdDesign.blocksYaxis(
                                              2.998500749625187),
                                        ),
                              checkingDevice(mediaQuery) == 'mobile'
                                  ? SizedBox(
                                      height: 0,
                                      width: 0,
                                    )
                                  : checkingDevice(mediaQuery) == 'small_tab'
                                      ? SizedBox(
                                          height: 0,
                                          width: 0,
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: mediaQuery.size.width,
                                              alignment: Alignment.center,
                                              height: checkingDevice(
                                                          mediaQuery) ==
                                                      'mobile'
                                                  ? UdDesign.pt(420)
                                                  : checkingDevice(
                                                              mediaQuery) ==
                                                          'small_tab'
                                                      ? UdDesign.pt(280)
                                                      : checkingDevice(
                                                                  mediaQuery) ==
                                                              'big_tab'
                                                          ? UdDesign.pt(140)
                                                          : UdDesign.pt(140),
                                              color: Colors.transparent,
                                              child: HomeIconChipsList(
                                                homeIconChipsitems:
                                                    _homeiconsListItems
                                                        .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                              checkingDevice(mediaQuery) == 'mobile'
                                  ? SizedBox(
                                      height: 0,
                                      width: 0,
                                    )
                                  : checkingDevice(mediaQuery) == 'small_tab'
                                      ? SizedBox(
                                          height: 0,
                                          width: 0,
                                        )
                                      : SizedBox(
                                          height: UdDesign.blocksYaxis(
                                              11.99400299850075),
                                        ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Container(
                //   width: mediaQuery.size.width,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     mainAxisSize: MainAxisSize.max,
                //     children: List.generate(
                //         settingsRepo.setting.value.homeSections.length, (index) {
                //       String _homeSection =
                //           settingsRepo.setting.value.homeSections.elementAt(index);
                //       switch (_homeSection) {
                //         case 'slider':
                //           return HomeSliderWidget(slides: _con.slides);

                //         default:
                //           return SizedBox(height: 0);
                //       }
                //     }),
                //   ),
                // ),
                PageBody(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConst.edgePadding),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: checkingDevice(mediaQuery) == 'mobile'
                                ? UdDesign.pt(140.7320644216691)
                                : checkingDevice(mediaQuery) == 'small_tab'
                                    ? UdDesign.blocksXaxis(140.7320644216691)
                                    : UdDesign.pt(356),
                            height: checkingDevice(mediaQuery) == 'mobile'
                                ? UdDesign.pt(21)
                                : checkingDevice(mediaQuery) == 'small_tab'
                                    ? UdDesign.blocksYaxis(21)
                                    : UdDesign.pt(55),
                            decoration: BoxDecoration(
                              // color: Colors.transparent,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/green_stores_near.png"),
                                fit: BoxFit.cover,
                                alignment: Alignment.topRight,
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: checkingDevice(mediaQuery) == 'mobile'
                                    ? EdgeInsets.only(top: 7)
                                    : EdgeInsets.only(top: 17),
                                child: Text(
                                  checkingDevice(mediaQuery) == 'mobile'
                                      ? 'Green stores '
                                      : checkingDevice(mediaQuery) ==
                                              'small_tab'
                                          ? 'Green stores '
                                          : 'Green stores near you ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color(0xFF004E15),
                                      fontSize: checkingDevice(mediaQuery) ==
                                              'mobile'
                                          ? UdDesign.fontSize(14.23133235724744)
                                          : checkingDevice(mediaQuery) ==
                                                  'small_tab'
                                              ? UdDesign.fontSize(
                                                  14.23133235724744)
                                              : UdDesign.fontSize(27),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                settingsRepo.setting.value.homeSections.length,
                                (index) {
                              String _homeSection = settingsRepo
                                  .setting.value.homeSections
                                  .elementAt(index);
                              switch (_homeSection) {
                                // case 'search':
                                //   return Padding(
                                //     padding: const EdgeInsets.symmetric(horizontal: 160),
                                //     child: SearchBarWidget(
                                //       onClickFilter: (event) {
                                //         widget.parentScaffoldKey.currentState.openEndDrawer();
                                //       },
                                //     ),
                                //   );
                                case 'top_stores_heading':
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        left: 20,
                                        right: 20,
                                        bottom: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                S.of(context).top_stores,
                                                style: linkStyle4,
                                                maxLines: 1,
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (currentUser
                                                        .value.apiToken ==
                                                    null) {
                                                  _con.requestForCurrentLocation(
                                                      context);
                                                } else {
                                                  var bottomSheetController =
                                                      widget.parentScaffoldKey
                                                          .currentState
                                                          .showBottomSheet(
                                                    (context) =>
                                                        DeliveryAddressBottomSheetWidget(
                                                            scaffoldKey: widget
                                                                .parentScaffoldKey),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                  );
                                                  bottomSheetController.closed
                                                      .then((value) {
                                                    _con.refreshHome();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color: settingsRepo
                                                              .deliveryAddress
                                                              .value
                                                              ?.address ==
                                                          null
                                                      ? Theme.of(context)
                                                          .focusColor
                                                          .withOpacity(0.1)
                                                      : Theme.of(context)
                                                          .secondaryHeaderColor,
                                                ),
                                                child: Text(
                                                  S.of(context).delivery,
                                                  style: TextStyle(
                                                      color: settingsRepo
                                                                  .deliveryAddress
                                                                  .value
                                                                  ?.address ==
                                                              null
                                                          ? Theme.of(context)
                                                              .splashColor
                                                          : Theme.of(context)
                                                              .primaryColor),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 7),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  settingsRepo.deliveryAddress
                                                      .value?.address = null;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color: settingsRepo
                                                              .deliveryAddress
                                                              .value
                                                              ?.address !=
                                                          null
                                                      ? Theme.of(context)
                                                          .splashColor
                                                          .withOpacity(0.1)
                                                      : Theme.of(context)
                                                          .secondaryHeaderColor,
                                                ),
                                                child: Text(
                                                  S.of(context).pickup,
                                                  style: TextStyle(
                                                      color: settingsRepo
                                                                  .deliveryAddress
                                                                  .value
                                                                  ?.address !=
                                                              null
                                                          ? Theme.of(context)
                                                              .hintColor
                                                          : Theme.of(context)
                                                              .primaryColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (settingsRepo.deliveryAddress.value
                                                ?.address !=
                                            null)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 12),
                                            child: Text(
                                              S.of(context).near_to +
                                                  " " +
                                                  (settingsRepo.deliveryAddress
                                                      .value?.address),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          ),
                                        // Center(
                                        //   child: Container(
                                        //     width: mediaQuery.size.width / 5.464,
                                        //     height:
                                        //         (mediaQuery.size.width / 5.464) /
                                        //             4.545454545454545,
                                        //     decoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.all(
                                        //           Radius.circular(50)),
                                        //       color: Theme.of(context)
                                        //           .focusColor
                                        //           .withOpacity(0.6),
                                        //     ),
                                        //     child: Center(
                                        //       child: Text(
                                        //         'See more stores',
                                        //         textAlign: TextAlign.center,
                                        //         style: TextStyle(
                                        //             color: Color(0xFF004E15),
                                        //             fontSize: 18,
                                        //             fontWeight: FontWeight.w700),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                case 'top_stores':
                                  return CardsCarouselWidget(
                                      storesList: _con.topStores,
                                      heroTag: 'home_top_stores');
                                case 'trending_week_heading':
                                  return ListTile(
                                    dense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    leading: Icon(
                                      Icons.trending_up,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    title: Text(
                                      S.of(context).trending_this_week,
                                      style: linkStyle4,
                                    ),
                                    subtitle: Text(
                                      S
                                          .of(context)
                                          .clickOnTheProductToGetMoreDetailsAboutIt,
                                      maxLines: 2,
                                      style: footerStyle,
                                    ),
                                  );
                                case 'trending_week':
                                  return ProductsCarouselWidget(
                                      productsList: _con.trendingProducts,
                                      heroTag: 'home_product_carousel');
                                case 'categories_heading':
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ListTile(
                                      dense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      leading: Icon(
                                        Icons.category,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      title: Text(
                                        S.of(context).product_categories,
                                        style: linkStyle4,
                                      ),
                                    ),
                                  );
                                case 'categories':
                                  return CategoriesCarouselWidget(
                                    categories: _con.categories,
                                  );
                                case 'popular_heading':
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: ListTile(
                                      dense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      leading: Icon(
                                        Icons.trending_up,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      title: Text(
                                        S.of(context).most_popular,
                                        style: linkStyle4,
                                      ),
                                    ),
                                  );
                                case 'popular':
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: GridWidget(
                                      storesList: _con.popularStores,
                                      heroTag: 'home_stores',
                                    ),
                                  );
                                default:
                                  return SizedBox(height: 0);
                              }
                            }),
                          ),
                        ]),
                  ),
                ),
                checkingDevicePlatform() == 'phone_app'
                    ? SizedBox(height: 0, width: 0)
                    : checkingDevicePlatform() == 'small_tab_app'
                        ? SizedBox(height: 0, width: 0)
                        : checkingDevicePlatform() == 'big_tab_app'
                            ? SizedBox(height: 0, width: 0)
                            : checkingDevicePlatform() == 'desktop_app'
                                ? SizedBox(height: 0, width: 0)
                                : Stack(children: <Widget>[
                                    ClipPath(
                                        clipper: checkingDevice(mediaQuery) ==
                                                'mobile'
                                            ? null
                                            : checkingDevice(mediaQuery) ==
                                                    'small_tab'
                                                ? null
                                                : MiddleCurve(),
                                        child: Container(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.03),
                                          height: checkingDevice(mediaQuery) ==
                                                  'mobile'
                                              ? 1880
                                              : 1280,
                                          width: mediaQuery.size.width,
                                          child: PageBody(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'Join, let\'s save earth',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: checkingDevice(
                                                                        mediaQuery) ==
                                                                    'mobile'
                                                                ? UdDesign
                                                                    .fontSize(
                                                                        28)
                                                                : checkingDevice(
                                                                            mediaQuery) ==
                                                                        'small_tab'
                                                                    ? UdDesign
                                                                        .fontSize(
                                                                            28)
                                                                    : UdDesign
                                                                        .fontSize(
                                                                            35),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: checkingDevice(
                                                                  mediaQuery) ==
                                                              'mobile'
                                                          ? LeaforgPartnersWrap()
                                                          : checkingDevice(
                                                                      mediaQuery) ==
                                                                  'small_tab'
                                                              ? LeaforgPartnersWrap()
                                                              : LeaforgPartnersRow(),
                                                    ),
                                                    SizedBox(
                                                      height: checkingDevice(
                                                                  mediaQuery) ==
                                                              'mobile'
                                                          ? 300
                                                          : checkingDevice(
                                                                      mediaQuery) ==
                                                                  'small_tab'
                                                              ? 300
                                                              : 0,
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        )),
                                    checkingDevicePlatform() == 'phone_app'
                                        ? SizedBox(height: 0, width: 0)
                                        : checkingDevicePlatform() ==
                                                'small_tab_app'
                                            ? SizedBox(height: 0, width: 0)
                                            : checkingDevicePlatform() ==
                                                    'big_tab_app'
                                                ? SizedBox(height: 0, width: 0)
                                                : checkingDevicePlatform() ==
                                                        'desktop_app'
                                                    ? SizedBox(
                                                        height: 0, width: 0)
                                                    : new Positioned(
                                                        top: 0,
                                                        left: 50,
                                                        right: 50,
                                                        bottom: checkingDevice(
                                                                    mediaQuery) ==
                                                                'mobile'
                                                            ? 1760
                                                            : checkingDevice(
                                                                        mediaQuery) ==
                                                                    'small_tab'
                                                                ? 1760
                                                                : 790,
                                                        child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            //radius: 200,
                                                            child: Container(
                                                              height: 140,
                                                              width: 140,
                                                              child: Image.asset(
                                                                  'assets/images/save_earth.png'),
                                                            )),
                                                      ),
                                    checkingDevicePlatform() == 'phone_app'
                                        ? SizedBox(height: 0, width: 0)
                                        : checkingDevicePlatform() ==
                                                'small_tab_app'
                                            ? SizedBox(height: 0, width: 0)
                                            : checkingDevicePlatform() ==
                                                    'big_tab_app'
                                                ? SizedBox(height: 0, width: 0)
                                                : checkingDevicePlatform() ==
                                                        'desktop_app'
                                                    ? SizedBox(
                                                        height: 0, width: 0)
                                                    : new Positioned(
                                                        bottom: 0,
                                                        child: new Align(
                                                          alignment:
                                                              FractionalOffset
                                                                  .bottomCenter,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        0.0),
                                                            child: ClipPath(
                                                              clipper: checkingDevice(
                                                                          mediaQuery) ==
                                                                      'mobile'
                                                                  ? null
                                                                  : checkingDevice(
                                                                              mediaQuery) ==
                                                                          'small_tab'
                                                                      ? null
                                                                      : BottomCurve(),
                                                              child: Container(
                                                                color: Theme.of(
                                                                        context)
                                                                    .splashColor,
                                                                height: 400,
                                                                width:
                                                                    mediaQuery
                                                                        .size
                                                                        .width,
                                                                child: PageBody(
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                15),
                                                                    child:
                                                                        ListView(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          AppConst
                                                                              .edgePadding),
                                                                      children: <
                                                                          Widget>[
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                        ),
                                                                        Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: <
                                                                              Widget>[
                                                                            checkingDevice(mediaQuery) == 'mobile'
                                                                                ? Container(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    height: 80,
                                                                                    width: 80,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(10),
                                                                                        bottomRight: Radius.circular(10),
                                                                                      ),
                                                                                      image: DecorationImage(
                                                                                        image: AssetImage("assets/images/leaforg_mobile_white_icon_small.png"),
                                                                                        fit: BoxFit.contain,
                                                                                        alignment: Alignment.topLeft,
                                                                                      ),
                                                                                      color: Colors.transparent,
                                                                                    ),
                                                                                  )
                                                                                : checkingDevice(mediaQuery) == 'small_tab'
                                                                                    ? Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        height: 100,
                                                                                        width: 100,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(10),
                                                                                            bottomRight: Radius.circular(10),
                                                                                          ),
                                                                                          image: DecorationImage(
                                                                                            image: AssetImage("assets/images/leaforg_mobile_white_icon_small.png"),
                                                                                            fit: BoxFit.contain,
                                                                                            alignment: Alignment.topLeft,
                                                                                          ),
                                                                                          color: Colors.transparent,
                                                                                        ),
                                                                                      )
                                                                                    : Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        height: 100,
                                                                                        width: 358,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(10),
                                                                                            bottomRight: Radius.circular(10),
                                                                                          ),
                                                                                          image: DecorationImage(
                                                                                            image: AssetImage("assets/images/leaforg_orangewhite_footer_icon_small.png"),
                                                                                            fit: BoxFit.contain,
                                                                                            alignment: Alignment.topLeft,
                                                                                          ),
                                                                                          color: Colors.transparent,
                                                                                        ),
                                                                                      ),
                                                                            SizedBox(
                                                                              width: UdDesign.pt(30),
                                                                            ),
                                                                            checkingDevice(mediaQuery) == 'mobile'
                                                                                ? Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      SizedBox(height: UdDesign.pt(20)),
                                                                                      Text(
                                                                                        'Call us:  00, 000,000,000',
                                                                                        textAlign: TextAlign.left,
                                                                                        style: TextStyle(color: Colors.white, fontSize: UdDesign.fontSize(15), fontWeight: FontWeight.w700),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: UdDesign.pt(15),
                                                                                      ),
                                                                                      Text(
                                                                                        checkingDevice(mediaQuery) == 'mobile'
                                                                                            ? 'publicrelations@leaforg.com'
                                                                                            : checkingDevice(mediaQuery) == 'small_tab'
                                                                                                ? 'publicrelations@leaforg.com'
                                                                                                : 'Email us:  publicrelations@leaforg.com',
                                                                                        textAlign: TextAlign.left,
                                                                                        style: TextStyle(color: Colors.white, fontSize: UdDesign.fontSize(15), fontWeight: FontWeight.w700),
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : checkingDevice(mediaQuery) == 'small_tab'
                                                                                    ? Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          SizedBox(height: UdDesign.pt(20)),
                                                                                          Text(
                                                                                            'Call us:  00, 000,000,000',
                                                                                            textAlign: TextAlign.left,
                                                                                            style: TextStyle(color: Colors.white, fontSize: UdDesign.fontSize(15), fontWeight: FontWeight.w700),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: UdDesign.pt(15),
                                                                                          ),
                                                                                          Text(
                                                                                            checkingDevice(mediaQuery) == 'mobile'
                                                                                                ? 'publicrelations@leaforg.com'
                                                                                                : checkingDevice(mediaQuery) == 'small_tab'
                                                                                                    ? 'publicrelations@leaforg.com'
                                                                                                    : 'Email us:  publicrelations@leaforg.com',
                                                                                            textAlign: TextAlign.left,
                                                                                            style: TextStyle(color: Colors.white, fontSize: UdDesign.fontSize(15), fontWeight: FontWeight.w700),
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    : SizedBox(height: 0, width: 0),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                20),
                                                                        checkingDevice(mediaQuery) ==
                                                                                'mobile'
                                                                            ? LeaforgFooterMobileRow()
                                                                            : checkingDevice(mediaQuery) == 'small_tab'
                                                                                ? LeaforgFooterMobileRow()
                                                                                : LeaforgFooterRow(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                  ]),
              ],
            ),
          ),
        ));
  }

  final address_search = TextEditingController();
  // String s_address = address_search.toString();

  final List<HomeIconsChips> _homeiconsListItems = [
    // HomeIconsChips(
    //   id: '1',
    //   title: 'Foods',
    //   image: 'assets/images/main/vegeterian_foods.png',
    // ),
    HomeIconsChips(
      id: '2',
      title: 'Marketplace',
      image: 'assets/images/main/shop_green_leaforg.png',
    ),
    HomeIconsChips(
      id: '3',
      title: 'Recyclers',
      image: 'assets/images/main/delivery_at_leaforg.png',
    ),
    HomeIconsChips(
      id: '4',
      title: 'Community',
      image: 'assets/images/main/post_an_activity.png',
    ),
    // HomeIconsChips(
    //   id: '5',
    //   title: 'Promotions',
    //   image: 'assets/images/main/promotions_leaforg.png',
    // ),
  ];
}

class MiddleCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 1764;
    final double _yScaling = size.height / 896;
    path.lineTo(1324.5 * _xScaling, 148.6 * _yScaling);
    path.cubicTo(
      1198.34 * _xScaling,
      148.6 * _yScaling,
      1078.19 * _xScaling,
      129.13 * _yScaling,
      969 * _xScaling,
      93.97 * _yScaling,
    );
    path.cubicTo(
      969 * _xScaling,
      93.97 * _yScaling,
      969 * _xScaling,
      95.19 * _yScaling,
      969 * _xScaling,
      95.19 * _yScaling,
    );
    path.cubicTo(
      965.35 * _xScaling,
      93.55 * _yScaling,
      961.68 * _xScaling,
      91.95 * _yScaling,
      958 * _xScaling,
      90.36 * _yScaling,
    );
    path.cubicTo(
      929.1866666666665 * _xScaling,
      80.73333333333332 * _yScaling,
      901.1866666666665 * _xScaling,
      70.03333333333333 * _yScaling,
      874 * _xScaling,
      58.26 * _yScaling,
    );
    path.cubicTo(
      761.9 * _xScaling,
      20.81 * _yScaling,
      637.92 * _xScaling,
      0 * _yScaling,
      507.5 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      321.84 * _xScaling,
      0 * _yScaling,
      149.19 * _xScaling,
      42.15 * _yScaling,
      5.34 * _xScaling,
      114.47 * _yScaling,
    );
    path.cubicTo(
      5.34 * _xScaling,
      114.47 * _yScaling,
      0 * _xScaling,
      114.47 * _yScaling,
      0 * _xScaling,
      114.47 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      114.47 * _yScaling,
      0 * _xScaling,
      2000 * _yScaling,
      0 * _xScaling,
      2000 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      2800 * _yScaling,
      2000 * _xScaling,
      2800 * _yScaling,
      1800 * _xScaling,
      2000 * _yScaling,
    );
    path.cubicTo(
      1800 * _xScaling,
      2000 * _yScaling,
      1800 * _xScaling,
      147 * _yScaling,
      1800 * _xScaling,
      47 * _yScaling,
    );
    path.cubicTo(
      1661.68 * _xScaling,
      111.43 * _yScaling,
      1498.83 * _xScaling,
      148.6 * _yScaling,
      1324.5 * _xScaling,
      148.6 * _yScaling,
    );
    path.cubicTo(
      1324.5 * _xScaling,
      148.6 * _yScaling,
      1324.5 * _xScaling,
      148.6 * _yScaling,
      1324.5 * _xScaling,
      148.6 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class BottomCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 1764;
    final double _yScaling = size.height / 846;
    path.lineTo(1786.73 * _xScaling, 60.58 * _yScaling);
    path.cubicTo(
      1565.65 * _xScaling,
      23.63 * _yScaling,
      1249.76 * _xScaling,
      0.5 * _yScaling,
      899 * _xScaling,
      0.5 * _yScaling,
    );
    path.cubicTo(
      548.24 * _xScaling,
      0.5 * _yScaling,
      232.33 * _xScaling,
      23.63 * _yScaling,
      11.25 * _xScaling,
      60.58 * _yScaling,
    );
    path.cubicTo(
      11.25 * _xScaling,
      60.58 * _yScaling,
      0.5 * _xScaling,
      60.58 * _yScaling,
      150.5 * _xScaling,
      60.58 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      60.58 * _yScaling,
      0.5 * _xScaling,
      62.4 * _yScaling,
      0.5 * _xScaling,
      62.4 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      62.4 * _yScaling,
      0 * _xScaling,
      16.48 * _yScaling,
      0 * _xScaling,
      62.48 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      62.48 * _yScaling,
      0 * _xScaling,
      313.77 * _yScaling,
      0 * _xScaling,
      313.77 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      313.77 * _yScaling,
      50.5 * _xScaling,
      313.85999999999996 * _yScaling,
      -50.5 * _xScaling,
      313.85999999999996 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      313.85999999999996 * _yScaling,
      0.5 * _xScaling,
      800 * _yScaling,
      -50.5 * _xScaling,
      900 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      900 * _yScaling,
      1800.5 * _xScaling,
      1000 * _yScaling,
      1900.5 * _xScaling,
      1000 * _yScaling,
    );
    path.cubicTo(
      1800.5 * _xScaling,
      900 * _yScaling,
      1800.5 * _xScaling,
      60.58 * _yScaling,
      1900.5 * _xScaling,
      60.58 * _yScaling,
    );
    path.cubicTo(
      1800.5 * _xScaling,
      60.58 * _yScaling,
      1786.73 * _xScaling,
      60.58 * _yScaling,
      1786.73 * _xScaling,
      60.58 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class TopCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 1764;
    final double _yScaling = size.height / 896;
    path.lineTo(901 * _xScaling, 733.16 * _yScaling);
    path.cubicTo(
      1258 * _xScaling,
      733.16 * _yScaling,
      1578.94 * _xScaling,
      759.0799999999999 * _yScaling,
      1800.5 * _xScaling,
      800.31 * _yScaling,
    );
    path.cubicTo(
      1800.5 * _xScaling,
      800.31 * _yScaling,
      1800.5 * _xScaling,
      2.16 * _yScaling,
      1800.5 * _xScaling,
      2.16 * _yScaling,
    );
    path.cubicTo(
      180.5 * _xScaling,
      -200.16 * _yScaling,
      -200.5 * _xScaling,
      -200.16 * _yScaling,
      -200.5 * _xScaling,
      -200.16 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      2.16 * _yScaling,
      0.5 * _xScaling,
      800.5 * _yScaling,
      0.5 * _xScaling,
      800.5 * _yScaling,
    );
    path.cubicTo(
      222.09 * _xScaling,
      759.16 * _yScaling,
      543.43 * _xScaling,
      733.16 * _yScaling,
      901 * _xScaling,
      733.16 * _yScaling,
    );
    path.cubicTo(
      1001 * _xScaling,
      0.16 * _yScaling,
      2001 * _xScaling,
      0.16 * _yScaling,
      2001 * _xScaling,
      0.16 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
