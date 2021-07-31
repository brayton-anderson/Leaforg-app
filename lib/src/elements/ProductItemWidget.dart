import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/product.dart';
import '../models/route_argument.dart';

class ProductItemWidget extends StatelessWidget {
  final String heroTag;
  final Product product;

  const ProductItemWidget({Key key, this.product, this.heroTag})
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
        themeData.textTheme.bodyText2.copyWith(color: themeData.hintColor);
    final TextStyle linkStyle4 =
        themeData.textTheme.headline4.copyWith(color: themeData.splashColor);
    return InkWell(
      splashColor: Theme.of(context).secondaryHeaderColor,
      focusColor: Theme.of(context).secondaryHeaderColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: RouteArgument(id: product.id, heroTag: this.heroTag));
      },
      child: Container(
        width: 292,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: heroTag + product.id,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: product.image.url,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: linkStyle4,
                        ),
                        Row(
                          children: Helper.getStarsList(product.getRate()),
                        ),
                        Text(
                          product.extras.map((e) => e.name).toList().join(', '),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: aboutTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Helper.getPrice(
                        product.price,
                        context,
                        style: linkStyle4,
                      ),
                      product.discountPrice > 0
                          ? Helper.getPrice(product.discountPrice, context,
                              style: linkStyle2.merge(TextStyle(
                                  decoration: TextDecoration.lineThrough)))
                          : SizedBox(height: 0),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
