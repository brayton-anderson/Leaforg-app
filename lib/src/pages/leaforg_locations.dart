import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/responsive.dart';
import '../models/address.dart';
import '../elements/placesChipsList.dart';
import '../shared/page_body.dart';
import '../models/places_chips.dart';
import '../bloc/application_bloc.dart';
import '../models/place.dart';
import 'package:provider/provider.dart';

class LeaforgLocationsScreen extends StatefulWidget {
  LeaforgLocationsScreen({Key key}) : super(key: key);

  @override
  _LeaforgLocationsScreenState createState() => _LeaforgLocationsScreenState();
}

class _LeaforgLocationsScreenState extends State<LeaforgLocationsScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  StreamSubscription boundsSubscription;
  final _locationController = TextEditingController();

  static String _chipsData = 'big';

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected Location
    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _goToPlace(place);
      } else
        _locationController.text = "";
    });

    applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 5));
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    _locationController.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    final mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextStyle linkStyle4 =
        themeData.textTheme.headline6.copyWith(color: themeData.primaryColor);
    return Scaffold(
      body: Center(
        child: Stack(alignment: Alignment.center, children: [
          Container(
            height: mediaQuery.size.height - 100,
            width: checkingDevice(mediaQuery) == 'mobile'
                ? mediaQuery.size.width - 40
                : checkingDevice(mediaQuery) == 'small_tab'
                    ? mediaQuery.size.width - 80
                    : mediaQuery.size.width - 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).splashColor.withOpacity(0.2),
                    blurRadius: 5,
                    offset: Offset(0, 2)),
              ],
              color: Colors.white,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  checkingDevice(mediaQuery) == 'mobile'
                      ? Container(
                          height: checkingDevice(mediaQuery) == 'mobile'
                              ? (mediaQuery.size.height / 2) - 123
                              : checkingDevice(mediaQuery) == 'small_tab'
                                  ? (mediaQuery.size.height / 2) - 123
                                  : (mediaQuery.size.height - 100),
                          width: checkingDevice(mediaQuery) == 'mobile'
                              ? mediaQuery.size.width - 40
                              : checkingDevice(mediaQuery) == 'small_tab'
                                  ? mediaQuery.size.width - 80
                                  : (mediaQuery.size.width - 200) / 2 - 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: GoogleMap(
                              mapToolbarEnabled: false,
                              mapType: MapType.hybrid,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    applicationBloc.currentLocation.latitude,
                                    applicationBloc.currentLocation.longitude),
                                zoom: 14,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _mapController.complete(controller);
                              },
                              markers: Set<Marker>.of(applicationBloc.markers),
                            ),
                          ),
                        )
                      : checkingDevice(mediaQuery) == 'small_tab'
                          ? Container(
                              height: checkingDevice(mediaQuery) == 'mobile'
                                  ? (mediaQuery.size.height / 2) - 123
                                  : checkingDevice(mediaQuery) == 'small_tab'
                                      ? (mediaQuery.size.height / 2) - 123
                                      : (mediaQuery.size.height - 100),
                              width: checkingDevice(mediaQuery) == 'mobile'
                                  ? mediaQuery.size.width - 40
                                  : checkingDevice(mediaQuery) == 'small_tab'
                                      ? mediaQuery.size.width - 80
                                      : (mediaQuery.size.width - 200) / 2 - 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: GoogleMap(
                                  mapToolbarEnabled: false,
                                  mapType: MapType.hybrid,
                                  myLocationEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        applicationBloc
                                            .currentLocation.latitude,
                                        applicationBloc
                                            .currentLocation.longitude),
                                    zoom: 14,
                                  ),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _mapController.complete(controller);
                                  },
                                  markers:
                                      Set<Marker>.of(applicationBloc.markers),
                                ),
                              ),
                            )
                          : Container(
                              height: 145,
                              width: mediaQuery.size.width - 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/african_capital_signupseven.jpg"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ),
                                color:
                                    Theme.of(context).appBarTheme.shadowColor,
                              ),
                              child: Center(
                                child: Text(
                                  'Add a delivery address',
                                  style: linkStyle4,
                                ),
                              ),
                            ),
                  (applicationBloc.currentLocation == null)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Wrap(
                          children: [
                            //user input
                            Container(
                              height: checkingDevice(mediaQuery) == 'mobile'
                                  ? (mediaQuery.size.height / 2)
                                  : checkingDevice(mediaQuery) == 'small_tab'
                                      ? (mediaQuery.size.height / 2)
                                      : (mediaQuery.size.height - 100),
                              width: checkingDevice(mediaQuery) == 'mobile'
                                  ? mediaQuery.size.width - 40
                                  : checkingDevice(mediaQuery) == 'small_tab'
                                      ? mediaQuery.size.width - 80
                                      : (mediaQuery.size.width - 200) / 2 - 100,
                              decoration: BoxDecoration(
                                borderRadius: checkingDevice(mediaQuery) ==
                                        'mobile'
                                    ? BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )
                                    : checkingDevice(mediaQuery) == 'small_tab'
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                          ),
                                color: checkingDevice(mediaQuery) == 'mobile'
                                    ? themeData.primaryColor
                                    : checkingDevice(mediaQuery) == 'small_tab'
                                        ? themeData.primaryColor
                                        : Colors.transparent,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 3.0),
                                    child: TextField(
                                      controller: _locationController,
                                      autofocus: true,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      style: TextStyle(
                                          color: Color(0xFF000000)
                                              .withOpacity(0.8),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                      decoration: new InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.6),
                                              width: 4.0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.6),
                                              width: 4.0),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.6),
                                              width: 4.0),
                                        ),
                                        hintText:
                                            'Search for streets, cities, buildi..',
                                        suffixIcon: Icon(
                                          PhosphorIcons.x_circle,
                                          color: Color(0xFF000000)
                                              .withOpacity(0.4),
                                          size: 20,
                                        ),
                                        icon: Icon(
                                          PhosphorIcons.flag_banner,
                                          color: Color(0xFF000000)
                                              .withOpacity(0.6),
                                          size: 30,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Color(0xFF000000)
                                              .withOpacity(0.6),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        applicationBloc.searchPlaces(value);
                                        setState(() {
                                          _chipsData = 'small';
                                        });
                                      },
                                      onTap: () {
                                        applicationBloc.clearSelectedLocation();
                                        setState(() {
                                          _chipsData = 'big';
                                        });
                                      },
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        color: themeData.primaryColor,
                                      ),
                                      if (applicationBloc.searchResults !=
                                              null &&
                                          applicationBloc
                                                  .searchResults.length !=
                                              0)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 3,
                                              left: 20,
                                              right: 20,
                                              bottom: 5),
                                          child: Container(
                                            height: 170.0,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Theme.of(context)
                                                          .splashColor
                                                          .withOpacity(0.2),
                                                      blurRadius: 5,
                                                      offset: Offset(0, 2)),
                                                ],
                                                color: Colors.white,
                                                backgroundBlendMode:
                                                    BlendMode.lighten),
                                          ),
                                        ),
                                      if (applicationBloc.searchResults != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              left: 25,
                                              right: 25,
                                              bottom: 6),
                                          child: Container(
                                            height: 150.0,
                                            child: ListView.builder(
                                                itemCount: applicationBloc
                                                    .searchResults.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    title: Wrap(children: [
                                                      Text(
                                                        applicationBloc
                                                            .searchResults[
                                                                index]
                                                            .description,
                                                        style: TextStyle(
                                                            color: Color(
                                                                    0xFF000000)
                                                                .withOpacity(
                                                                    0.7),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Divider(
                                                        color: themeData
                                                            .secondaryHeaderColor
                                                            .withOpacity(0.4),
                                                      ),
                                                    ]),
                                                    onTap: () {
                                                      applicationBloc
                                                          .setSelectedLocation(
                                                              applicationBloc
                                                                  .searchResults[
                                                                      index]
                                                                  .placeId);
                                                      setState(() {
                                                        _chipsData = 'big';
                                                      });
                                                    },
                                                  );
                                                }),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 3.0),
                                    child: Center(
                                      child: Text(
                                          'Or find the nearest location below',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: themeData
                                                  .secondaryHeaderColor,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 3.0),
                                    child: PageBody(
                                      child: Container(
                                        height:
                                            _chipsData == 'big' ? 180.0 : 80.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context)
                                                      .splashColor
                                                      .withOpacity(0.2),
                                                  blurRadius: 5,
                                                  offset: Offset(0, 2)),
                                            ],
                                            color: Colors.white,
                                            backgroundBlendMode:
                                                BlendMode.lighten),
                                        child: ListView(
                                          children: [
                                            PlacesChipsList(
                                              placesChipsitems:
                                                  _placesListItems.toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //display maps
                            checkingDevice(mediaQuery) == 'mobile'
                                ? SizedBox(
                                    height: 0,
                                    width: 0,
                                  )
                                : checkingDevice(mediaQuery) == 'small_tab'
                                    ? SizedBox(
                                        height: 0,
                                        width: 0,
                                      )
                                    : Container(
                                        height: (mediaQuery.size.height - 100) -
                                            145,
                                        width:
                                            (mediaQuery.size.width - 200) / 2 -
                                                100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                          child: GoogleMap(
                                            mapToolbarEnabled: false,
                                            mapType: MapType.hybrid,
                                            myLocationEnabled: true,
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: LatLng(
                                                  applicationBloc
                                                      .currentLocation.latitude,
                                                  applicationBloc
                                                      .currentLocation
                                                      .longitude),
                                              zoom: 14,
                                            ),
                                            onMapCreated: (GoogleMapController
                                                controller) {
                                              _mapController
                                                  .complete(controller);
                                            },
                                            markers: Set<Marker>.of(
                                                applicationBloc.markers),
                                          ),
                                        ),
                                      ),
                          ],
                        ),
                ]),
          ),
        ]),
      ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(place.geometry.location.latitude,
                place.geometry.location.longitude),
            zoom: 14.0),
      ),
    );
  }

  final List<PlacesChips> _placesListItems = [
    PlacesChips(
      id: '1',
      title: 'Accounting',
      params: 'accounting',
    ),
    PlacesChips(
      id: '2',
      title: 'Airport',
      params: 'airport',
    ),
    PlacesChips(
      id: '3',
      title: 'Amusement park',
      params: 'amusement_park',
    ),
    PlacesChips(
      id: '4',
      title: 'Aquarium',
      params: 'aquarium',
    ),
    PlacesChips(
      id: '5',
      title: 'Art gallery',
      params: 'art_gallery',
    ),
    PlacesChips(
      id: '6',
      title: 'Atm',
      params: 'atm',
    ),
    PlacesChips(
      id: '7',
      title: 'Bakery',
      params: 'bakery',
    ),
    PlacesChips(
      id: '8',
      title: 'Bank',
      params: 'bank',
    ),
    PlacesChips(
      id: '9',
      title: 'Bar',
      params: 'bar',
    ),
    PlacesChips(
      id: '10',
      title: 'Beauty salon',
      params: 'beauty_salon',
    ),
    PlacesChips(
      id: '11',
      title: 'Bicycle store',
      params: 'bicycle_store',
    ),
    PlacesChips(
      id: '12',
      title: 'Book store',
      params: 'book_store',
    ),
    PlacesChips(
      id: '14',
      title: 'Bowling alley',
      params: 'bowling_alley',
    ),
    PlacesChips(
      id: '15',
      title: 'Bus station',
      params: 'bus_station',
    ),
    PlacesChips(
      id: '16',
      title: 'Cafe',
      params: 'cafe',
    ),
    PlacesChips(
      id: '17',
      title: 'Campground',
      params: 'campground',
    ),
    PlacesChips(
      id: '18',
      title: 'Car dealer',
      params: 'car_dealer',
    ),
    PlacesChips(
      id: '19',
      title: 'Car rental',
      params: 'car_rental',
    ),
    PlacesChips(
      id: '20',
      title: 'Car repair',
      params: 'car_repair',
    ),
    PlacesChips(
      id: '21',
      title: 'Car wash',
      params: 'car_wash',
    ),
    PlacesChips(
      id: '22',
      title: 'Casino',
      params: 'casino',
    ),
    PlacesChips(
      id: '23',
      title: 'Cemetery',
      params: 'cemetery',
    ),
    PlacesChips(
      id: '24',
      title: 'Church',
      params: 'church',
    ),
    PlacesChips(
      id: '25',
      title: 'City hall',
      params: 'city_hall',
    ),
    PlacesChips(
      id: '26',
      title: 'Clothing store',
      params: 'clothing_store',
    ),
    PlacesChips(
      id: '27',
      title: 'Convenience store',
      params: 'convenience_store',
    ),
    PlacesChips(
      id: '28',
      title: 'Courthouse',
      params: 'courthouse',
    ),
    PlacesChips(
      id: '29',
      title: 'Dentist',
      params: 'dentist',
    ),
    PlacesChips(
      id: '30',
      title: 'Department store',
      params: 'department_store',
    ),
    PlacesChips(
      id: '31',
      title: 'Doctor',
      params: 'doctor',
    ),
    PlacesChips(
      id: '32',
      title: 'Drugstore',
      params: 'drugstore',
    ),
    PlacesChips(
      id: '33',
      title: 'Electrician',
      params: 'electrician',
    ),
    PlacesChips(
      id: '34',
      title: 'Electronics store',
      params: 'electronics_store',
    ),
    PlacesChips(
      id: '35',
      title: 'Embassy',
      params: 'embassy',
    ),
    PlacesChips(
      id: '36',
      title: 'Fire station',
      params: 'fire_station',
    ),
    PlacesChips(
      id: '37',
      title: 'Florist',
      params: 'florist',
    ),
    PlacesChips(
      id: '38',
      title: 'Funeral home',
      params: 'funeral_home',
    ),
    PlacesChips(
      id: '39',
      title: 'Furniture store',
      params: 'furniture_store',
    ),
    PlacesChips(
      id: '40',
      title: 'Gas station',
      params: 'gas_station',
    ),
    PlacesChips(
      id: '41',
      title: 'Gym',
      params: 'gym',
    ),
    PlacesChips(
      id: '42',
      title: 'Hair care',
      params: 'hair_care',
    ),
    PlacesChips(
      id: '43',
      title: 'Hardware store',
      params: 'hardware_store',
    ),
    PlacesChips(
      id: '44',
      title: 'Hindu temple',
      params: 'hindu_temple',
    ),
    PlacesChips(
      id: '45',
      title: 'Home goods store',
      params: 'home_goods_store',
    ),
    PlacesChips(
      id: '46',
      title: 'Hospital',
      params: 'hospital',
    ),
    PlacesChips(
      id: '47',
      title: 'Insurance agency',
      params: 'insurance_agency',
    ),
    PlacesChips(
      id: '48',
      title: 'Jewelry store',
      params: 'jewelry_store',
    ),
    PlacesChips(
      id: '49',
      title: 'Laundry',
      params: 'laundry',
    ),
    PlacesChips(
      id: '50',
      title: 'Lawyer',
      params: 'lawyer',
    ),
    PlacesChips(
      id: '51',
      title: 'Library',
      params: 'library',
    ),
    PlacesChips(
      id: '52',
      title: 'Light rail station',
      params: 'light_rail_station',
    ),
    PlacesChips(
      id: '53',
      title: 'Liquor_store',
      params: 'liquor_store',
    ),
    PlacesChips(
      id: '54',
      title: 'Local government office',
      params: 'local_government_office',
    ),
    PlacesChips(
      id: '55',
      title: 'Locksmith',
      params: 'locksmith',
    ),
    PlacesChips(
      id: '56',
      title: 'Lodging',
      params: 'lodging',
    ),
    PlacesChips(
      id: '57',
      title: 'Meal delivery',
      params: 'meal_delivery',
    ),
    PlacesChips(
      id: '58',
      title: 'Meal takeaway',
      params: 'meal_takeaway',
    ),
    PlacesChips(
      id: '59',
      title: 'Mosque',
      params: 'mosque',
    ),
    PlacesChips(
      id: '60',
      title: 'Movie rental',
      params: 'movie_rental',
    ),
    PlacesChips(
      id: '61',
      title: 'Movie theater',
      params: 'movie_theater',
    ),
    PlacesChips(
      id: '62',
      title: 'Moving company',
      params: 'moving_company',
    ),
    PlacesChips(
      id: '63',
      title: 'Museum',
      params: 'museum',
    ),
    PlacesChips(
      id: '64',
      title: 'Night club',
      params: 'night_club',
    ),
    PlacesChips(
      id: '65',
      title: 'Painter',
      params: 'painter',
    ),
    PlacesChips(
      id: '66',
      title: 'Park',
      params: 'park',
    ),
    PlacesChips(
      id: '67',
      title: 'Parking',
      params: 'parking',
    ),
    PlacesChips(
      id: '68',
      title: 'Pet store',
      params: 'pet_store',
    ),
    PlacesChips(
      id: '69',
      title: 'Pharmacy',
      params: 'pharmacy',
    ),
    PlacesChips(
      id: '70',
      title: 'Physiotherapist',
      params: 'physiotherapist',
    ),
    PlacesChips(
      id: '71',
      title: 'Plumber',
      params: 'plumber',
    ),
    PlacesChips(
      id: '72',
      title: 'Police',
      params: 'police',
    ),
    PlacesChips(
      id: '73',
      title: 'Post office',
      params: 'post_office',
    ),
    PlacesChips(
      id: '74',
      title: 'Primary school',
      params: 'primary_school',
    ),
    PlacesChips(
      id: '75',
      title: 'Real estate agency',
      params: 'real_estate_agency',
    ),
    PlacesChips(
      id: '76',
      title: 'Store',
      params: 'store',
    ),
    PlacesChips(
      id: '77',
      title: 'Roofing contractor',
      params: 'roofing_contractor',
    ),
    PlacesChips(
      id: '78',
      title: 'Rv park',
      params: 'rv_park',
    ),
    PlacesChips(
      id: '79',
      title: 'School',
      params: 'school',
    ),
    PlacesChips(
      id: '80',
      title: 'Secondary school',
      params: 'secondary_school',
    ),
    PlacesChips(
      id: '81',
      title: 'Shoe store',
      params: 'shoe_store',
    ),
    PlacesChips(
      id: '82',
      title: 'Shopping mall',
      params: 'shopping_mall',
    ),
    PlacesChips(
      id: '83',
      title: 'Spa',
      params: 'spa',
    ),
    PlacesChips(
      id: '84',
      title: 'Stadium',
      params: 'stadium',
    ),
    PlacesChips(
      id: '85',
      title: 'Storage',
      params: 'storage',
    ),
    PlacesChips(
      id: '86',
      title: 'Store',
      params: 'store',
    ),
    PlacesChips(
      id: '87',
      title: 'Subway station',
      params: 'subway_station',
    ),
    PlacesChips(
      id: '88',
      title: 'Supermarket',
      params: 'supermarket',
    ),
    PlacesChips(
      id: '89',
      title: 'Synagogue',
      params: 'synagogue',
    ),
    PlacesChips(
      id: '90',
      title: 'Taxi stand',
      params: 'taxi_stand',
    ),
    PlacesChips(
      id: '91',
      title: 'Tourist attraction',
      params: 'tourist_attraction',
    ),
    PlacesChips(
      id: '92',
      title: 'Train station',
      params: 'train_station',
    ),
    PlacesChips(
      id: '93',
      title: 'Transit station',
      params: 'transit_station',
    ),
    PlacesChips(
      id: '94',
      title: 'Travel agency',
      params: 'travel_agency',
    ),
    PlacesChips(
      id: '95',
      title: 'University',
      params: 'university',
    ),
    PlacesChips(
      id: '96',
      title: 'Veterinary care',
      params: 'veterinary_care',
    ),
    PlacesChips(
      id: '97',
      title: 'Zoo',
      params: 'zoo',
    ),
  ];
}
