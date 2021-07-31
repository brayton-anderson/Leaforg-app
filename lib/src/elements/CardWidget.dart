import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/store.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  Store store;
  String heroTag;

  CardWidget({Key key, this.store, this.heroTag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle =
        themeData.textTheme.caption.copyWith(color: themeData.splashColor);
    final TextStyle aboutTextStyle2 =
        themeData.textTheme.bodyText1.copyWith(color: themeData.splashColor);
    return Container(
      width: 292,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Image of the card
          Stack(
            fit: StackFit.loose,
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              Hero(
                tag: this.heroTag + store.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: store.image.url,
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
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                        color: store.closed ? Colors.grey : Colors.green,
                        borderRadius: BorderRadius.circular(24)),
                    child: store.closed
                        ? Text(
                            S.of(context).closed,
                            style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          )
                        : Text(
                            S.of(context).open,
                            style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                        color: Helper.canDelivery(store)
                            ? Colors.green
                            : Colors.orange,
                        borderRadius: BorderRadius.circular(24)),
                    child: Helper.canDelivery(store)
                        ? Text(
                            S.of(context).delivery,
                            style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          )
                        : Text(
                            S.of(context).pickup,
                            style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        store.name,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: aboutTextStyle2,
                      ),
                      Text(
                        Helper.skipHtml(store.description),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: aboutTextStyle,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: Helper.getStarsList(double.parse(store.rate)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      RawMaterialButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/Pages',
                              arguments:
                                  new RouteArgument(id: '1', param: store));
                        },
                        child: Icon(Icons.directions,
                            color: Theme.of(context).primaryColor),
                        fillColor: Theme.of(context).secondaryHeaderColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      store.distance > 0
                          ? Text(
                              Helper.getDistance(
                                  store.distance,
                                  Helper.of(context)
                                      .trans(setting.value.distanceUnit)),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            )
                          : SizedBox(height: 0)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
