import 'package:flutter/material.dart';
import '../bloc/application_bloc.dart';
import 'package:provider/provider.dart';
import '../models/places_chips.dart';

class PlacesChipsItem extends StatefulWidget {
  final PlacesChips placesChips;

  @override
  _PlacesChipsItemState createState() => _PlacesChipsItemState();
  const PlacesChipsItem({
    Key key,
    @required this.placesChips,
  }) : super(key: key);
}

class _PlacesChipsItemState extends State<PlacesChipsItem> {
  static String _selchip = 'none';

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return FilterChip(
      label: Text(
        widget.placesChips.title,
        style: TextStyle(
            color: _selchip == widget.placesChips.params
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.w500),
      ),
      onSelected: (val) {
        applicationBloc.togglePlaceType(widget.placesChips.params, val);

        setState(() {
          _selchip = widget.placesChips.params;
        });
      },
      showCheckmark: true,
      selectedShadowColor: Color(0xFF000000).withOpacity(0.6),
      selected: applicationBloc.placeType == widget.placesChips.params,
      disabledColor: Colors.black54,
      backgroundColor: Color(0xFF000000).withOpacity(0.1),
      selectedColor: Theme.of(context).hintColor,
    );
  }
}
