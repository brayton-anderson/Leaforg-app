import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/product.dart';
import '../models/route_argument.dart';

class ProductsCarouselItemWidget extends StatelessWidget {
  final double marginLeft;
  final Product product;
  final String heroTag;

  ProductsCarouselItemWidget(
      {Key key, this.heroTag, this.marginLeft, this.product})
      : super(key: key);

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
    return InkWell(
      splashColor: Theme.of(context).secondaryHeaderColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: RouteArgument(id: product.id, heroTag: heroTag));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Hero(
                tag: heroTag + product.id,
                child: Container(
                  margin: EdgeInsetsDirectional.only(
                      start: this.marginLeft, end: 20),
                  width: 100,
                  height: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: product.image.thumb,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(end: 25, top: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: product.discountPrice > 0
                      ? Colors.red
                      : Theme.of(context).secondaryHeaderColor,
                ),
                alignment: AlignmentDirectional.topEnd,
                child: Helper.getPrice(
                  product.price,
                  context,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
              width: 100,
              margin:
                  EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    this.product.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: linkStyle2,
                  ),
                  Text(
                    product.store.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: footerStyle,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
