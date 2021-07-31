import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../elements/SearchWidget.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged onClickFilter;

  const SearchBarWidget({Key key, this.onClickFilter}) : super(key: key);

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
      onTap: () {
        Navigator.of(context).push(SearchModal());
      },
      child: Container(
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 0),
              child: Icon(Icons.search,
                  color: Theme.of(context).secondaryHeaderColor),
            ),
            Expanded(
              child: Text(
                S.of(context).search_for_stores_or_products,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: footerStyle,
              ),
            ),
            SizedBox(width: 8),
            InkWell(
              onTap: () {
                onClickFilter('e');
              },
              child: Container(
                padding: const EdgeInsets.only(
                    right: 10, left: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      S.of(context).filter,
                      style: footerStyle,
                    ),
                    Icon(
                      Icons.filter_list,
                      color: Theme.of(context).splashColor,
                      size: 21,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}