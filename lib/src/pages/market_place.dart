import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/route_argument.dart';
import '../elements/CircularLoadingWidget.dart';
import '../controllers/marketplace_controller.dart';

class MarketPlace extends StatefulWidget{


  final RouteArgument routeArgument;

  MarketPlace({Key key, this.routeArgument}) : super(key: key);
   @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {

  final controller = Get.put(MarketPlaceController());

  @override
  void initState() {
    controller.listenForDegradable();
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
      key: controller.scaffoldKey,
      body: RefreshIndicator(
        onRefresh: controller.refreshStore,
        child: controller.degradable == null
            ? CircularLoadingWidget(height: 500)
            : Stack(fit: StackFit.expand, children: <Widget>[
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
                            tag: (widget.routeArgument.heroTag ?? '') +
                                controller.degradable.id,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.degradable.image.url,
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
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: Wrap(
                            alignment: WrapAlignment.center,
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
                              ),
                              Container(
                                height: mediaQuery.size.height,
                                margin: EdgeInsets.all(2),
                                padding: EdgeInsets.all(2),
                                constraints: BoxConstraints(
                                  maxHeight: mediaQuery.size.height,
                                  minHeight: mediaQuery.size.height,
                                  minWidth: 0,
                                  maxWidth: 168,
                                ),
                                color: Colors.redAccent,
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
