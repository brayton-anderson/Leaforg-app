import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/review.dart';

// ignore: must_be_immutable
class ReviewItemWidget extends StatelessWidget {
  Review review;

  ReviewItemWidget({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle =
        themeData.textTheme.bodyText2.copyWith(color: themeData.primaryColor);
    final TextStyle linkStyle2 = themeData.textTheme.bodyText1
        .copyWith(color: themeData.secondaryHeaderColor);
    final TextStyle linkStyle4 =
        themeData.textTheme.headline4.copyWith(color: themeData.primaryColor);
    return InkWell(
      onTap: () {},
      child: Container(
        width: 296,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor,
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
            SizedBox(
              height: 5,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: review.user?.image?.thumb ?? '',
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          review.user.name,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(review.rate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .merge(TextStyle(
                                          color:
                                              Theme.of(context).primaryColor))),
                              Icon(
                                Icons.star_border,
                                color: Theme.of(context).primaryColor,
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
                  Text(
                    review.user.bio
                        .substring(0, min(30, review.user.bio.length)),
                    overflow: TextOverflow.ellipsis,
                    style: linkStyle2,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                Helper.skipHtml(review.review),
                style: aboutTextStyle,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
