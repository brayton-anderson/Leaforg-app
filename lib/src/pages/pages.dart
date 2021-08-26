import 'dart:async';

import 'package:adv_fab/adv_fab.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../elements/DrawerWidget.dart';
import '../elements/FilterWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../pages/favorites.dart';
import '../pages/home.dart';
import '../pages/map.dart';
import '../pages/notifications.dart';
import '../pages/orders.dart';
import '../helpers/responsive.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    final this.currentTab,
    final this.routeArgument,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 2;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  _PagesWidgetState();

  int counter = 0;
  AdvFabController mabialaFABController;
  bool useAsFloatingActionButton = true;
  bool useNavigationBar = false;

  initState() {
    super.initState();
    _selectTab(widget.currentTab);
    mabialaFABController = AdvFabController();
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage =
              NotificationsWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = MapWidget(
              parentScaffoldKey: widget.scaffoldKey,
              routeArgument: widget.routeArgument);
          break;
        case 2:
          widget.currentPage =
              HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 3:
          widget.currentPage =
              OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 4:
          widget.currentPage =
              FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
      }
    });
  }

  // phone_web
  // small_tab_web
  // big_tab_web
  // phone_app
  // small_tab_app
  // big_tab_app
  // desktop_web
  // desktop_app

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        endDrawer: FilterWidget(onFilter: (filter) {
          Navigator.of(context)
              .pushReplacementNamed('/Pages', arguments: widget.currentTab);
        }),
        body: widget.currentPage,
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(
              iconData: PhosphorIcons.bell_ringing_fill,
              title: 'Notifications',
            ),
            TabData(
              iconData: PhosphorIcons.flag_banner_fill,
              title: 'Find Stores',
            ),
            TabData(
              iconData: PhosphorIcons.house_line_fill,
              title: 'Home',
            ),
            TabData(
              iconData: PhosphorIcons.storefront_fill,
              title: 'Placed Orders',
            ),
            TabData(
              iconData: PhosphorIcons.sparkle_fill,
              title: 'Favorites',
            ),
          ],
          onTabChangedListener: (int i) {
            this._selectTab(i);
          },
          initialSelection: widget.currentTab,
          activeIconColor: Theme.of(context).primaryColor,
          circleColor: Theme.of(context).hintColor,
          inactiveIconColor: Theme.of(context).splashColor.withOpacity(0.3),
          barBackgroundColor: Theme.of(context).hintColor,
          textColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
