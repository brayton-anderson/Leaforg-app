import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../helpers/maps_util.dart';
import '../models/address.dart';
import '../models/store.dart';
import '../repository/store_repository.dart';
import '../repository/settings_repository.dart' as sett;

class MapController extends ControllerMVC {
  Store currentStore;
  List<Store> topStores = <Store>[];
  List<Marker> allMarkers = <Marker>[];
  Address currentAddress;
  Set<Polyline> polylines = new Set();
  CameraPosition cameraPosition;
  MapsUtil mapsUtil = new MapsUtil();
  Completer<GoogleMapController> mapController = Completer();

  void listenForNearStores(Address myLocation, Address areaLocation) async {
    final Stream<Store> stream = await getNearStores(myLocation, areaLocation);
    stream.listen((Store _store) {
      setState(() {
        topStores.add(_store);
      });
      Helper.getMarker(_store.toMap()).then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });
    }, onError: (a) {}, onDone: () {});
  }

  void getCurrentLocation() async {
    try {
      currentAddress = sett.deliveryAddress.value;
      setState(() {
        if (currentAddress.isUnknown()) {
          cameraPosition = CameraPosition(
            target: LatLng(40, 3),
            zoom: 4,
          );
        } else {
          cameraPosition = CameraPosition(
            target: LatLng(currentAddress.latitude, currentAddress.longitude),
            zoom: 14.4746,
          );
        }
      });
      if (!currentAddress.isUnknown()) {
        Helper.getMyPositionMarker(
                currentAddress.latitude, currentAddress.longitude)
            .then((marker) {
          setState(() {
            allMarkers.add(marker);
          });
        });
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }

  void getStoreLocation() async {
    try {
      currentAddress = await sett.getCurrentLocation();
      setState(() {
        cameraPosition = CameraPosition(
          target: LatLng(double.parse(currentStore.latitude),
              double.parse(currentStore.longitude)),
          zoom: 14.4746,
        );
      });
      Helper.getMyPositionMarker(
              currentAddress.latitude, currentAddress.longitude)
          .then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }

  Future<void> goCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;

    sett.setCurrentLocation().then((_currentAddress) {
      setState(() {
        sett.deliveryAddress.value = _currentAddress;
        currentAddress = _currentAddress;
      });
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentAddress.latitude, _currentAddress.longitude),
        zoom: 14.4746,
      )));
    });
  }

  void getStoresOfArea() async {
    setState(() {
      topStores = <Store>[];
      Address areaAddress = Address.fromJSON({
        "latitude": cameraPosition.target.latitude,
        "longitude": cameraPosition.target.longitude
      });
      if (cameraPosition != null) {
        listenForNearStores(currentAddress, areaAddress);
      } else {
        listenForNearStores(currentAddress, currentAddress);
      }
    });
  }

  void getDirectionSteps() async {
    currentAddress = await sett.getCurrentLocation();
    mapsUtil
        .get("origin=" +
            currentAddress.latitude.toString() +
            "," +
            currentAddress.longitude.toString() +
            "&destination=" +
            currentStore.latitude +
            "," +
            currentStore.longitude +
            "&key=${sett.setting.value?.googleMapsKey}")
        .then((dynamic res) {
      if (res != null) {
        List<LatLng> _latLng = res as List<LatLng>;
        _latLng?.insert(
            0, new LatLng(currentAddress.latitude, currentAddress.longitude));
        setState(() {
          polylines.add(new Polyline(
              visible: true,
              polylineId: new PolylineId(currentAddress.hashCode.toString()),
              points: _latLng,
              color: config.Colors().mainColor(0.8),
              width: 6));
        });
      }
    });
  }

  Future refreshMap() async {
    setState(() {
      topStores = <Store>[];
    });
    listenForNearStores(currentAddress, currentAddress);
  }
}
