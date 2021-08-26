import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../elements/DegradableProducts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/responcive_app.dart';
import '../elements/CircularLoadingWidget.dart';
import '../controllers/marketplace_controller.dart';

class MarketPlace extends StatefulWidget {
  MarketPlace({
    Key key,
  }) : super(key: key);
  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends StateMVC<MarketPlace> {
  MarketPlaceController _con;

  _MarketPlaceState() : super(MarketPlaceController()) {
    _con = controller;
  }

  String idStore = '0';

  @override
  void initState() {
    _con.listenForTrendingProducts(idStore);
    _con.listenForCategories(idStore);
    _con.listenForProducts(idStore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle =
        themeData.textTheme.bodyText1.copyWith(color: themeData.splashColor);
    final TextStyle linkStyle2 =
        themeData.textTheme.headline4.copyWith(color: themeData.splashColor);
    final TextStyle linkStyle4 =
        themeData.textTheme.headline1.copyWith(color: themeData.hintColor);
    return Scaffold(
      key: _con.scaffoldKey,
      body: RefreshIndicator(
        onRefresh: _con.refreshStore,
        child: Stack(fit: StackFit.expand, children: <Widget>[
          CustomScrollView(primary: true, shrinkWrap: false, slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).hintColor.withOpacity(0.9),
              expandedHeight: 300,
              elevation: 0,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Hero(
                  tag: "marketplace",
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://2fcb01fd.us-south.apigw.appdomain.cloud/leaforg/storage/app/public/18/pexels-brett-sayles-2599538.jpg',
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(2),
                      height: mediaQuery.size.height,
                      constraints: BoxConstraints(
                        maxHeight: mediaQuery.size.height,
                        minHeight: mediaQuery.size.height,
                        minWidth: 0,
                        maxWidth: 160,
                      ),
                      color: Colors.greenAccent,
                    ),
                    Container(
                      height: mediaQuery.size.height,
                      constraints: BoxConstraints(
                        maxHeight: mediaQuery.size.height,
                        minHeight: mediaQuery.size.height,
                        minWidth: 300,
                        maxWidth: 1000,
                      ),
                      color: Colors.white,
                      child: _con.products.isEmpty
                          ? CircularLoadingWidget(height: 500)
                          : GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: _con.products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          Responsive.isMobile(context)
                                              ? 1
                                              : Responsive.isTablet(context)
                                                  ? 2
                                                  : 4,
                                      crossAxisSpacing:
                                          Responsive.isMobile(context)
                                              ? 0.0
                                              : 4.0,
                                      mainAxisSpacing: 4.0),
                              itemBuilder: (context, index) {
                                return DegradableProductItemWidget(
                                  heroTag: 'menu_list',
                                  degradable: _con.products.elementAt(index),
                                );
                              }),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ]),
      ),
    );
  }
}
