import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../shared/page_body.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/map_controller.dart';
import '../elements/CardsCarouselWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../models/store.dart';
import '../models/route_argument.dart';

class MapWidget extends StatefulWidget {
  final RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  MapWidget({Key key, this.routeArgument, this.parentScaffoldKey})
      : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends StateMVC<MapWidget> {
  MapController _con;

  _MapWidgetState() : super(MapController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.currentStore = widget.routeArgument?.param as Store;
    if (_con.currentStore?.latitude != null) {
      // user select a store
      _con.getStoreLocation();
      _con.getDirectionSteps();
    } else {
      _con.getCurrentLocation();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: _con.currentStore?.latitude == null
            ? new IconButton(
                icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
                onPressed: () =>
                    widget.parentScaffoldKey.currentState.openDrawer(),
              )
            : IconButton(
                icon: new Icon(Icons.arrow_back,
                    color: Theme.of(context).hintColor),
                onPressed: () =>
                    Navigator.of(context).pushNamed('/Pages', arguments: 2),
              ),
        title: Text(
          S.of(context).maps_explorer,
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.my_location,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              _con.goCurrentLocation();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              widget.parentScaffoldKey.currentState.openEndDrawer();
            },
          ),
        ],
      ),
      body: Stack(
//        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          _con.cameraPosition == null
              ? CircularLoadingWidget(height: 0)
              : GoogleMap(
                  mapToolbarEnabled: false,
                  mapType: MapType.hybrid,
                  myLocationEnabled: true,
                  initialCameraPosition: _con.cameraPosition,
                  markers: Set.from(_con.allMarkers),
                  onMapCreated: (GoogleMapController controller) {
                    _con.mapController.complete(controller);
                  },
                  onCameraMove: (CameraPosition cameraPosition) {
                    _con.cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    _con.getStoresOfArea();
                  },
                  polylines: _con.polylines,
                ),
          PageBody(
            child: CardsCarouselWidget(
              storesList: _con.topStores,
              heroTag: 'map_stores',
            ),
          ),
        ],
      ),
    );
  }
}
