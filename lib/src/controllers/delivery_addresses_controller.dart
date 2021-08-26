import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/snackbar_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/address.dart' as model;
import '../models/cart.dart';
import '../repository/cart_repository.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;
import 'check_network/network_controller.dart';

class DeliveryAddressesController extends ControllerMVC with ChangeNotifier {
  List<model.Address> addresses = <model.Address>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  Cart cart;
  final CreateNetworkController _networkController =
      Get.find<CreateNetworkController>();
  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFCCCCCC);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;

  DeliveryAddressesController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForAddresses();
    listenForCart();
  }

  void listenForAddresses({String message}) async {
    final Stream<model.Address> stream = await userRepo.getAddresses();
    stream.listen((model.Address _address) {
      setState(() {
        addresses.add(_address);
      });
    }, onError: (a) {
      print(a);
      final messages = "";
      final button = "";
      final route = "";
      final request = "check internet";

     getSnackbarNotification(messages, request, button, route);

    }, onDone: () {
      if (message != null) {
          // final messages = "";
      final button = "";
      final route = "";
      final request = "success_snack";

     getSnackbarNotification(message, request, button, route);
      }
    });
  }

  void listenForCart() async {
    final Stream<Cart> stream = await getCart();
    stream.listen((Cart _cart) {
      cart = _cart;
    });
  }

  Future<void> refreshAddresses() async {
    addresses.clear();
    listenForAddresses(
        message: S.of(Get.context).addresses_refreshed_successfuly);
  }

  Future<void> changeDeliveryAddress(model.Address address) async {
    await settingRepo.changeCurrentLocation(address);
    setState(() {
      settingRepo.deliveryAddress.value = address;
    });
    settingRepo.deliveryAddress.notifyListeners();
  }

  Future<void> changeDeliveryAddressToCurrentLocation() async {
    model.Address _address = await settingRepo.setCurrentLocation();
    setState(() {
      settingRepo.deliveryAddress.value = _address;
    });
    settingRepo.deliveryAddress.notifyListeners();
  }

  void addAddress(model.Address address) {
    userRepo.addAddress(address).then((value) {
      setState(() {
        this.addresses.insert(0, value);
      });
      final messages = S.of(Get.context).new_address_added_successfully;
      final button = "";
      final route = "";
      final request = "success_snack";

     getSnackbarNotification(messages, request, button, route);
    });
  }

  void chooseDeliveryAddress(model.Address address) {
    setState(() {
      settingRepo.deliveryAddress.value = address;
    });
    settingRepo.deliveryAddress.notifyListeners();
  }

  void updateAddress(model.Address address) {
    userRepo.updateAddress(address).then((value) {
      setState(() {});
      addresses.clear();
      listenForAddresses(
          message: S.of(Get.context).the_address_updated_successfully);
    });
  }

  void removeDeliveryAddress(model.Address address) async {
    userRepo.removeDeliveryAddress(address).then((value) {
      setState(() {
        this.addresses.remove(address);
      });
      final messages = S.of(Get.context).delivery_address_removed_successfully;
      final button = "";
      final route = "";
      final request = "success_snack";

     getSnackbarNotification(messages, request, button, route);
    });
  }
}
