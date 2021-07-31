import '../models/store_categories.dart';
import 'package:flutter/material.dart';
import 'StorePlaceChipsWidget.dart';

class StoresPlacesChipsList extends StatelessWidget {
  final List<StoreCategory> storePlacesChipsitems;

  StoresPlacesChipsList({this.storePlacesChipsitems});

  @override
  Widget build(BuildContext context) {
    return storePlacesChipsitems.isEmpty
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
            itemCount: storePlacesChipsitems.length,
            itemBuilder: (context, index) {
              return StorePlacesChipsItem(
                  storeplacesChips: storePlacesChipsitems[index]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              mainAxisExtent: 30,
            ));
  }
}
