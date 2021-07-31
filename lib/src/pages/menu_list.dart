import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../helpers/responsive.dart';
import '../shared/page_body.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/store_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/ProductItemWidget.dart';
import '../elements/ProductsCarouselWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../models/store.dart';
import '../models/route_argument.dart';

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
  final RouteArgument routeArgument;

  MenuWidget({Key key, this.routeArgument}) : super(key: key);
}

class _MenuWidgetState extends StateMVC<MenuWidget> {
  StoreController _con;
  List<String> selectedCategories;

  _MenuWidgetState() : super(StoreController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.store = (new Store())..id = widget.routeArgument.id;
    _con.listenForTrendingProducts(widget.routeArgument.id);
    _con.listenForCategories(widget.routeArgument.id);
    selectedCategories = ['0'];
    _con.listenForProducts(widget.routeArgument.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle =
        themeData.textTheme.bodyText1.copyWith(color: themeData.splashColor);
    final TextStyle aboutTextStyle2 = themeData.textTheme.headline2
        .copyWith(color: themeData.scaffoldBackgroundColor);
    final TextStyle linkStyle2 =
        themeData.textTheme.headline4.copyWith(color: themeData.splashColor);
    final TextStyle linkStyle4 =
        themeData.textTheme.headline1.copyWith(color: themeData.hintColor);
    final TextStyle linkStyle3 = themeData.textTheme.headline3
        .copyWith(color: themeData.secondaryHeaderColor);
    final TextStyle footerStyle =
        themeData.textTheme.caption.copyWith(color: themeData.splashColor);
    final TextStyle linkStyle =
        themeData.textTheme.bodyText1.copyWith(color: themeData.primaryColor);
    return Scaffold(
      key: _con.scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _con.store?.name ?? '',
          overflow: TextOverflow.fade,
          softWrap: false,
          style: linkStyle4.merge(TextStyle(letterSpacing: 0)),
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).secondaryHeaderColor),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: PageBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBarWidget(),
              ),
              ListTile(
                dense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: Icon(
                  Icons.bookmark,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  S.of(context).featured_products,
                  style: linkStyle2,
                ),
                subtitle: Text(
                  S.of(context).clickOnTheProductToGetMoreDetailsAboutIt,
                  maxLines: 2,
                  style: footerStyle,
                ),
              ),
              ProductsCarouselWidget(
                  heroTag: 'menu_trending_product',
                  productsList: _con.trendingProducts),
              ListTile(
                dense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: Icon(
                  Icons.subject,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  S.of(context).all_menu,
                  style: linkStyle2,
                ),
                subtitle: Text(
                  S.of(context).clickOnTheProductToGetMoreDetailsAboutIt,
                  maxLines: 2,
                  style: footerStyle,
                ),
              ),
              _con.categories.isEmpty
                  ? SizedBox(height: 90)
                  : Container(
                      height: 90,
                      child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children:
                            List.generate(_con.categories.length, (index) {
                          var _category = _con.categories.elementAt(index);
                          var _selected =
                              this.selectedCategories.contains(_category.id);
                          return Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 20),
                            child: RawChip(
                              elevation: 0,
                              label: Text(_category.name),
                              labelStyle: _selected
                                  ? Theme.of(context).textTheme.bodyText2.merge(
                                      TextStyle(
                                          color:
                                              Theme.of(context).primaryColor))
                                  : footerStyle,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 15),
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.9),
                              selectedColor:
                                  Theme.of(context).secondaryHeaderColor,
                              selected: _selected,
                              //shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.05))),
                              showCheckmark: false,
                              selectedShadowColor: Theme.of(context)
                                  .splashColor
                                  .withOpacity(0.1),
                              shadowColor:
                                  Theme.of(context).hintColor.withOpacity(0.1),
                              avatar: (_category.id == '0')
                                  ? null
                                  : (_category.image.url
                                          .toLowerCase()
                                          .endsWith('.svg')
                                      ? SvgPicture.network(
                                          _category.image.url,
                                          color: _selected
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .secondaryHeaderColor,
                                        )
                                      : CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: _category.image.icon,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/img/loading.gif',
                                            fit: BoxFit.cover,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )),
                              onSelected: (bool value) {
                                setState(() {
                                  if (_category.id == '0') {
                                    this.selectedCategories = ['0'];
                                  } else {
                                    this.selectedCategories.removeWhere(
                                        (element) => element == '0');
                                  }
                                  if (value) {
                                    this.selectedCategories.add(_category.id);
                                  } else {
                                    this.selectedCategories.removeWhere(
                                        (element) => element == _category.id);
                                  }
                                  _con.selectCategory(this.selectedCategories);
                                });
                              },
                            ),
                          );
                        }),
                      ),
                    ),
              _con.products.isEmpty
                  ? CircularLoadingWidget(height: 250)
                  : GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _con.products.length,
                      itemBuilder: (context, index) {
                        return ProductItemWidget(
                          heroTag: 'menu_list',
                          product: _con.products.elementAt(index),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              checkingDevice(mediaQuery) == "mobile" ? 1 : 4,
                          crossAxisSpacing:
                              checkingDevice(mediaQuery) == "mobile"
                                  ? 2.0
                                  : 4.0,
                          mainAxisSpacing: 4.0),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
