import 'dart:async';

import 'package:adv_fab/adv_fab.dart';
import 'package:flutter/material.dart';

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
  String _reas = checkingDevicePlatform();

  @override
  Widget build(BuildContext context) {
    print("${_reas}");
    return _reas == 'desktop_web'
        ? WillPopScope(
            onWillPop: Helper.of(context).onWillPop,
            child: Scaffold(
              key: widget.scaffoldKey,
              drawer: DrawerWidget(),
              endDrawer: FilterWidget(onFilter: (filter) {
                Navigator.of(context).pushReplacementNamed('/Pages',
                    arguments: widget.currentTab);
              }),
              body: widget.currentPage,

              ///[SEtting up the floating action button]
              floatingActionButton: AdvFab(
                showLogs: true,
                onFloatingActionButtonTapped: () {
                  useAsFloatingActionButton = false;
                  useNavigationBar = true;
                  if (mounted) {
                    setState(() {});
                  }
                  new Timer(Duration(seconds: 4), () {
                    useAsFloatingActionButton = true;
                useNavigationBar = false;
                  if (mounted) {
                    setState(() {});
                  }
                  });
                },
                floatingActionButtonIcon: Icons.add,
                floatingActionButtonIconColor: Colors.white,
                navigationBarIconActiveColor: Color(0xFF004E15),
                navigationBarIconInactiveColor: Colors.white,
                collapsedColor: Color(0xFFFFAA00),
                useAsNavigationBar: useNavigationBar,
                useAsFloatingActionButton: useAsFloatingActionButton,
                controller: mabialaFABController,
                animationDuration: Duration(milliseconds: 350),
                navigationBarIcons: [
                  AdvFabNavigationBarIcon(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/Pages', arguments: 0);
                    },
                    title: 'Notifications',
                    icon: Icons.notifications,
                  ),
                  AdvFabNavigationBarIcon(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/Pages',
                          arguments: widget.routeArgument);
                    },
                    title: 'Maps',
                    icon: Icons.location_on,
                  ),
                  AdvFabNavigationBarIcon(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/Pages', arguments: 2);
                    },
                    title: 'Home',
                    icon: Icons.home,
                  ),
                  AdvFabNavigationBarIcon(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/Pages', arguments: 3);
                      },
                      title: 'Stores',
                      icon: Icons.store),
                  AdvFabNavigationBarIcon(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/Pages', arguments: 4);
                        setState(() {});
                      },
                      title: 'Favorites',
                      icon: Icons.favorite),
                ],
              ),
            ),
          )
        : _reas == 'desktop_app'
            ? WillPopScope(
                onWillPop: Helper.of(context).onWillPop,
                child: Scaffold(
                  key: widget.scaffoldKey,
                  drawer: DrawerWidget(),
                  endDrawer: FilterWidget(onFilter: (filter) {
                    Navigator.of(context).pushReplacementNamed('/Pages',
                        arguments: widget.currentTab);
                  }),
                  body: widget.currentPage,
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Theme.of(context).shadowColor,
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                    iconSize: 22,
                    elevation: 0,
                    backgroundColor: Theme.of(context).hintColor,
                    selectedIconTheme: IconThemeData(size: 28),
                    unselectedItemColor:
                        Theme.of(context).focusColor.withOpacity(1),
                    currentIndex: widget.currentTab,

                    onTap: (int i) {
                      this._selectTab(i);
                    },
                    // this will be set when a new tab is tapped
                    items: [
                      BottomNavigationBarItem(
                        label: '',
                        icon: Icon(
                          Icons.notifications,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        activeIcon: new Container(height: 0.0),
                      ),
                      BottomNavigationBarItem(
                        label: '',
                        icon: Icon(
                          Icons.location_on,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        activeIcon: new Container(height: 0.0),
                      ),
                      BottomNavigationBarItem(
                          label: '',
                          activeIcon: new Container(height: 5.0),
                          icon: CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: new Icon(
                              Icons.home,
                              color: Theme.of(context).shadowColor,
                            ),
                          )),
                      BottomNavigationBarItem(
                        label: '',
                        icon: new Icon(
                          Icons.fastfood,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        activeIcon: new Container(height: 0.0),
                      ),
                      BottomNavigationBarItem(
                        label: '',
                        icon: new Icon(
                          Icons.favorite,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        activeIcon: new Container(height: 0.0),
                      ),
                    ],
                  ),
                ),
              )
            : WillPopScope(
                onWillPop: Helper.of(context).onWillPop,
                child: Scaffold(
                  key: widget.scaffoldKey,
                  drawer: DrawerWidget(),
                  endDrawer: FilterWidget(onFilter: (filter) {
                    Navigator.of(context).pushReplacementNamed('/Pages',
                        arguments: widget.currentTab);
                  }),
                  body: widget.currentPage,
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Theme.of(context).shadowColor,
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                    iconSize: 22,
                    elevation: 0,
                    backgroundColor: Theme.of(context).hintColor,
                    selectedIconTheme: IconThemeData(size: 28),
                    unselectedItemColor:
                        Theme.of(context).focusColor.withOpacity(1),
                    currentIndex: widget.currentTab,
                    onTap: (int i) {
                      this._selectTab(i);
                    },
                    // this will be set when a new tab is tapped
                    items: [
                      BottomNavigationBarItem(
                        label: '',
                        icon: Icon(
                          Icons.notifications,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        activeIcon: new Container(height: 0.0),
                      ),
                      BottomNavigationBarItem(
                        label: '',
                        icon: Icon(
                          Icons.location_on,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        activeIcon: new Container(height: 0.0),
                      ),
                      BottomNavigationBarItem(
                          label: '',
                          activeIcon: new Container(height: 5.0),
                          icon: CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: new Icon(
                              Icons.home,
                              color: Theme.of(context).shadowColor,
                            ),
                          )),
                      BottomNavigationBarItem(
                        label: '',
                        icon: new Icon(
                          Icons.fastfood,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        activeIcon: new Container(height: 0.0),
                      ),
                      BottomNavigationBarItem(
                        label: '',
                        icon: new Icon(
                          Icons.favorite,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        activeIcon: new Container(height: 0.0),
                      ),
                    ],
                  ),
                ),
              );
  }
}
