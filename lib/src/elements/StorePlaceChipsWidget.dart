import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/store_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../bloc/application_bloc.dart';
import 'package:provider/provider.dart';
import '../models/store_categories.dart';

class StorePlacesChipsItem extends StatefulWidget {
  final StoreCategory storeplacesChips;

  @override
  _StorePlacesChipsItemState createState() => _StorePlacesChipsItemState();
  const StorePlacesChipsItem({
    Key key,
    @required this.storeplacesChips,
  }) : super(key: key);
}

class _StorePlacesChipsItemState extends StateMVC<StorePlacesChipsItem> {
  StoreController _con;
  List<String> selectedstoreCategories;

  _StorePlacesChipsItemState() : super(StoreController()) {
    _con = controller;
  }
  static String _selchip = 'none';

  @override
  void initState() {
    selectedstoreCategories = ['0'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    var _storecategory = _con.storecategories.length;
    var _selectedstore = this.selectedstoreCategories.contains(_storecategory);
    return RawChip(
      elevation: 0,
      label: Text(
        widget.storeplacesChips.stores_name,
        style: TextStyle(
            color: _selchip == widget.storeplacesChips.id
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.w500),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      selectedShadowColor: Theme.of(context).splashColor.withOpacity(0.1),
      shadowColor: Theme.of(context).hintColor.withOpacity(0.1),
      onSelected: (val) {
        applicationBloc.togglePlaceType(widget.storeplacesChips.id, val);

        setState(() {
          _selchip = widget.storeplacesChips.id;
        });
      },
      showCheckmark: false,
      avatar: (widget.storeplacesChips.id == '0')
          ? null
          : (widget.storeplacesChips.stores_image.url
                  .toLowerCase()
                  .endsWith('.svg')
              ? SvgPicture.network(
                  widget.storeplacesChips.stores_image.url,
                  color: _selchip == widget.storeplacesChips.id
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).secondaryHeaderColor,
                )
              : CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.storeplacesChips.stores_image.icon,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )),
      selected: applicationBloc.placeType == widget.storeplacesChips.id,
      disabledColor: Colors.black54,
      backgroundColor: Color(0xFF000000).withOpacity(0.1),
      selectedColor: Theme.of(context).hintColor,
    );
  }
}
