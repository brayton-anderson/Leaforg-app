import '../models/places_chips.dart';
import 'package:flutter/material.dart';
import 'PlaceChipsWidget.dart';

class PlacesChipsList extends StatelessWidget {
  final List<PlacesChips> placesChipsitems;

  PlacesChipsList({this.placesChipsitems});

  @override
  Widget build(BuildContext context) {
    return placesChipsitems.isEmpty
        ? Column(
            children: [
              Text(
                'No Places Added!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ],
          )
        : GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: placesChipsitems.length,
            itemBuilder: (context, index) {
              return PlacesChipsItem(placesChips: placesChipsitems[index]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              mainAxisExtent: 30,
              
            ),
            );
  }
}
