import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../helpers/responsive.dart';
import '../shared/page_body.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../controllers/store_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/ProductItemWidget.dart';
import '../elements/GalleryCarouselWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/ShoppingCartFloatButtonWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class DetailsWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  DetailsWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends StateMVC<DetailsWidget> {
  StoreController _con;

  _DetailsWidgetState() : super(StoreController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForStore(id: widget.routeArgument.id);
    _con.listenForGalleries(widget.routeArgument.id);
    _con.listenForFeaturedProducts(widget.routeArgument.id);
    _con.listenForStoreReviews(id: widget.routeArgument.id);
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed('/List',
                arguments: new RouteArgument(id: widget.routeArgument.id));
          },
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          icon: Icon(
            Icons.store,
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          label: Text(
            S.of(context).list,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: RefreshIndicator(
          onRefresh: _con.refreshStore,
          child: _con.store == null
              ? CircularLoadingWidget(height: 500)
              : Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CustomScrollView(
                      primary: true,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          backgroundColor:
                              Theme.of(context).hintColor.withOpacity(0.9),
                          expandedHeight: 300,
                          elevation: 0,
                          iconTheme: IconThemeData(
                              color: Theme.of(context).primaryColor),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Hero(
                              tag: (widget?.routeArgument?.heroTag ?? '') +
                                  _con.store.id,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: _con.store.image.url,
                                placeholder: (context, url) => Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: PageBody(
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20, bottom: 10, top: 25),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          _con.store?.name ?? '',
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 2,
                                          style: linkStyle4,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 32,
                                        child: Chip(
                                          padding: EdgeInsets.all(0),
                                          label: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(_con.store.rate,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .merge(TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor))),
                                              Icon(
                                                Icons.star_border,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                          backgroundColor: Theme.of(context)
                                              .secondaryHeaderColor
                                              .withOpacity(0.9),
                                          shape: StadiumBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 20),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: _con.store.closed
                                              ? Colors.grey
                                              : Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: _con.store.closed
                                          ? Text(
                                              S.of(context).closed,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .merge(TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )
                                          : Text(
                                              S.of(context).open,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .merge(TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(child: SizedBox(height: 0)),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: Helper.canDelivery(_con.store)
                                              ? Colors.green
                                              : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: Text(
                                        Helper.getDistance(
                                            _con.store.distance,
                                            Helper.of(context).trans(
                                                setting.value.distanceUnit)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .merge(TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  child: Helper.applyHtml(
                                      context, _con.store.description),
                                ),
                                ImageThumbCarouselWidget(
                                    galleriesList: _con.galleries),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ListTile(
                                    dense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                    leading: Icon(
                                      Icons.stars,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    title: Text(
                                      S.of(context).information,
                                      style: linkStyle2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  child: Helper.applyHtml(
                                      context, _con.store.information),
                                ),
                                Wrap(
                                  children: <Widget>[
                                    Container(
                                      width:
                                          checkingDevice(mediaQuery) == "mobile"
                                              ? mediaQuery.size.width
                                              : mediaQuery.size.width / 2 - 220,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      color: Theme.of(context).primaryColor,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              _con.store.address ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: aboutTextStyle,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          SizedBox(
                                            width: 42,
                                            height: 42,
                                            child: RawMaterialButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    '/Pages',
                                                    arguments:
                                                        new RouteArgument(
                                                            id: '1',
                                                            param: _con.store));
                                              },
                                              child: Icon(
                                                Icons.directions,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 24,
                                              ),
                                              fillColor: Theme.of(context)
                                                  .secondaryHeaderColor
                                                  .withOpacity(0.9),
                                              shape: StadiumBorder(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          checkingDevice(mediaQuery) == "mobile"
                                              ? 0
                                              : 70,
                                    ),
                                    Container(
                                      width:
                                          checkingDevice(mediaQuery) == "mobile"
                                              ? mediaQuery.size.width
                                              : mediaQuery.size.width / 2 - 220,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      color: Theme.of(context).primaryColor,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              '${_con.store.phone} \n${_con.store.mobile}',
                                              overflow: TextOverflow.ellipsis,
                                              style: aboutTextStyle,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          SizedBox(
                                            width: 42,
                                            height: 42,
                                            child: RawMaterialButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: () {
                                                launch(
                                                    "tel:${_con.store.mobile}");
                                              },
                                              child: Icon(
                                                Icons.call,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 24,
                                              ),
                                              fillColor: Theme.of(context)
                                                  .secondaryHeaderColor
                                                  .withOpacity(0.9),
                                              shape: StadiumBorder(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                _con.featuredProducts.isEmpty
                                    ? SizedBox(height: 0)
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: ListTile(
                                          dense: true,
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          leading: Icon(
                                            Icons.store,
                                            color: Theme.of(context).hintColor,
                                          ),
                                          title: Text(
                                            S.of(context).featured_products,
                                            style: linkStyle2,
                                          ),
                                        ),
                                      ),
                                _con.featuredProducts.isEmpty
                                    ? SizedBox(height: 0)
                                    : GridView.builder(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: _con.featuredProducts.length,
                                        itemBuilder: (context, index) {
                                          return ProductItemWidget(
                                            heroTag: 'details_featured_product',
                                            product: _con.featuredProducts
                                                .elementAt(index),
                                          );
                                        },
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: checkingDevice(
                                                            mediaQuery) ==
                                                        "mobile"
                                                    ? 2
                                                    : 4,
                                                crossAxisSpacing:
                                                    checkingDevice(
                                                                mediaQuery) ==
                                                            "mobile"
                                                        ? 0.0
                                                        : 4.0,
                                                mainAxisSpacing: 4.0),
                                      ),
                                SizedBox(height: 120),
                                _con.reviews.isEmpty
                                    ? SizedBox(height: 5)
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: ListTile(
                                          dense: true,
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          leading: Icon(
                                            Icons.recent_actors,
                                            color: Theme.of(context).hintColor,
                                          ),
                                          title: Text(
                                            S.of(context).what_they_say,
                                            style: linkStyle2,
                                          ),
                                        ),
                                      ),
                                _con.reviews.isEmpty
                                    ? SizedBox(height: 5)
                                    : ReviewsListWidget(
                                        reviewsList: _con.reviews),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 32,
                      right: 20,
                      child: ShoppingCartFloatButtonWidget(
                        iconColor: Theme.of(context).primaryColor,
                        labelColor: Theme.of(context).hintColor,
                        routeArgument: RouteArgument(
                            param: '/Details', id: widget.routeArgument.id),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
