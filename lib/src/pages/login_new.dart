import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../repository/user_repository.dart';
import 'package:ud_design/ud_design.dart';
import '../helpers/responsive.dart';

import '../shared/constants.dart';
import '../shared/utils.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../helpers/helper.dart';
import '../repository/user_repository.dart' as userRepo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  UserController _con;

  _LoginWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }
  }

  final TextEditingController _controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  static String _login_ready = 'notready';

  @override
  Widget build(BuildContext context) {
    String userToken = currentUser.value.deviceToken;
    if (userToken == null) {
      FirebaseMessaging.instance.getToken().then((val) async {
        print('Token: ' + val);
        _con.user.deviceToken = val;
      });
    }
    final mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    AppScale scale = AppScale(context);
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          color: themeData.hintColor,
          child: Center(
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
                  image: checkingDevice(mediaQuery) == 'mobile'
                      ? DecorationImage(
                          image: AssetImage(
                              'assets/images/leaforg_login_form.jpg'),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        )
                      : checkingDevice(mediaQuery) == 'small_tab'
                          ? DecorationImage(
                              image: AssetImage(
                                  'assets/images/leaforg_login_form.jpg'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            )
                          : null,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).splashColor.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 2)),
                  ],
                  color: checkingDevice(mediaQuery) == 'mobile'
                      ? Colors.transparent
                      : checkingDevice(mediaQuery) == 'small_tab'
                          ? Colors.transparent
                          : themeData.primaryColor,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          //user input
                          Container(
                            height: checkingDevice(mediaQuery) == 'mobile'
                                ? (mediaQuery.size.height - 180)
                                : checkingDevice(mediaQuery) == 'small_tab'
                                    ? (mediaQuery.size.height - 200)
                                    : (mediaQuery.size.height - 100),
                            width: checkingDevice(mediaQuery) == 'mobile'
                                ? mediaQuery.size.width - 40
                                : checkingDevice(mediaQuery) == 'small_tab'
                                    ? mediaQuery.size.width - 80
                                    : (mediaQuery.size.width - 200) / 2 - 100,
                            decoration: BoxDecoration(
                              borderRadius: checkingDevice(mediaQuery) ==
                                      'mobile'
                                  ? BorderRadius.circular(0)
                                  : checkingDevice(mediaQuery) == 'small_tab'
                                      ? BorderRadius.circular(0)
                                      : BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                        ),
                              color: checkingDevice(mediaQuery) == 'mobile'
                                  ? themeData.primaryColor
                                  : checkingDevice(mediaQuery) == 'small_tab'
                                      ? themeData.primaryColor
                                      : Colors.transparent,
                            ),
                            child: Form(
                              key: _con.loginFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    child: Text('Sign in to Leaforg',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: UdDesign.fontSize(25.0),
                                            color: themeData.hintColor,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0,
                                          left: 20.0,
                                          right: 20.0,
                                          bottom: 3.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 45,
                                            width: checkingDevice(mediaQuery) ==
                                                    'mobile'
                                                ? 140
                                                : checkingDevice(mediaQuery) ==
                                                        'small_tab'
                                                    ? 160
                                                    : 180,
                                            child: Utils.getButton(
                                                text: checkingDevice(
                                                            mediaQuery) ==
                                                        'mobile'
                                                    ? 'Facebook'
                                                    : checkingDevice(
                                                                mediaQuery) ==
                                                            'small_tab'
                                                        ? '.. Facebook'
                                                        : '   .. with Facebook',
                                                color: Color(0xFF3b5998),
                                                textColor: Colors.white,
                                                icon: Image.asset(
                                                    'assets/img/fb.png',
                                                    width:
                                                        scale.ofHeight(0.0490)),
                                                onPressed: () =>
                                                    Navigator.pushNamed(
                                                        context, '/fb-auth')),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            height: 45,
                                            width: checkingDevice(mediaQuery) ==
                                                    'mobile'
                                                ? 135
                                                : checkingDevice(mediaQuery) ==
                                                        'small_tab'
                                                    ? 160
                                                    : 180,
                                            child: Utils.getButton(
                                                text: checkingDevice(
                                                            mediaQuery) ==
                                                        'mobile'
                                                    ? 'Google'
                                                    : checkingDevice(
                                                                mediaQuery) ==
                                                            'small_tab'
                                                        ? '.. Google'
                                                        : '   .. with Google',
                                                color: Color(0xFFDB4437),
                                                textColor: Colors.white,
                                                icon: Image.asset(
                                                    'assets/img/google_logo.png',
                                                    width:
                                                        scale.ofHeight(0.0490)),
                                                onPressed: () =>
                                                    Navigator.pushNamed(context,
                                                        '/google-auth')),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5.0,
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    child: Text('Or',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: themeData.splashColor
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w700)),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 3.0),
                                    child: TextFormField(
                                      // name: 'employer_name',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      decoration: new InputDecoration(
                                        prefixIcon: Icon(Icons.alternate_email,
                                            color: Theme.of(context).hintColor),
                                        // suffixIcon: IconButton(
                                        //   onPressed: () {
                                        //     setState(() {
                                        //       _con.hidePassword =
                                        //           !_con.hidePassword;
                                        //     });
                                        //   },
                                        //   color: Theme.of(context).splashColor,
                                        //   icon: Icon(_con.hidePassword
                                        //       ? Icons.visibility
                                        //       : Icons.visibility_off),
                                        // ),
                                        filled: true,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.4),
                                              width: 1.5),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.4),
                                              width: 1.5),
                                        ),
                                        alignLabelWithHint: true,
                                        hintText: 'johndoe@gmail.com',
                                        hintStyle: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        fillColor: Colors.white,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (input) =>
                                          _con.user.email = input,
                                      validator: (input) => !input.contains('@')
                                          ? S
                                              .of(context)
                                              .should_be_a_valid_email
                                          : null,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 3.0),
                                    child: InternationalPhoneNumberInput(
                                      onInputChanged: (PhoneNumber number) {
                                        print(number.phoneNumber);
                                      },
                                      onInputValidated: (bool value) {
                                        print(value);
                                      },
                                      selectorConfig: SelectorConfig(
                                        selectorType:
                                            PhoneInputSelectorType.BOTTOM_SHEET,
                                      ),
                                      ignoreBlank: false,
                                      autoValidateMode:
                                          AutovalidateMode.disabled,
                                      selectorTextStyle:
                                          TextStyle(color: Colors.black),
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      initialValue: number,
                                      textFieldController: _controller,
                                      formatInput: false,
                                      inputDecoration: InputDecoration(
                                        prefixIcon: Icon(Icons.phone,
                                            color: Theme.of(context).hintColor),
                                        filled: true,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.4),
                                              width: 1.5),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.4),
                                              width: 1.5),
                                        ),
                                        alignLabelWithHint: true,
                                        hintText: 'Phone number',
                                        hintStyle: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        fillColor: Colors.white,
                                      ),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      inputBorder: OutlineInputBorder(),
                                      onSaved: (PhoneNumber number) {
                                        _con.user.password = '123456789';

                                        _con.user.phone = number.toString();
                                        print('On Saved: $number');
                                      },
                                      validator: (input) => input.length >= 10
                                          ? 'Phone number should only be 9char, start with 7xxx not 07xxx.'
                                          : null,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  ////////////////////////////////////////////////////////////
                                  ///
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 45,
                                              width:
                                                  checkingDevice(mediaQuery) ==
                                                          'mobile'
                                                      ? 80
                                                      : checkingDevice(
                                                                  mediaQuery) ==
                                                              'small_tab'
                                                          ? 160
                                                          : 180,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          '/Pages',
                                                          arguments: 2);
                                                },
                                                child: checkingDevice(
                                                            mediaQuery) ==
                                                        'mobile'
                                                    ? Center(
                                                        child: Icon(
                                                          PhosphorIcons
                                                              .house_bold,
                                                          color: Colors.black,
                                                          size: 28,
                                                        ),
                                                      )
                                                    : checkingDevice(
                                                                mediaQuery) ==
                                                            'small_tab'
                                                        ? Center(
                                                            child: Icon(
                                                              PhosphorIcons
                                                                  .house_bold,
                                                              color:
                                                                  Colors.black,
                                                              size: 28,
                                                            ),
                                                          )
                                                        : Text(
                                                            'Go to home',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF000000),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                style: ButtonStyle(
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                          EdgeInsets.all(15)),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Color(
                                                              0xFF000000)
                                                          .withOpacity(0.75)),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.0),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Color(
                                                                      0xFFffffff)
                                                                  .withOpacity(
                                                                      0.2)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 40),
                                            Center(
                                              child: SizedBox(
                                                height: 45,
                                                width: 180,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _login_ready = 'ready';
                                                    });
                                                    _con.login();
                                                    new Timer(
                                                        Duration(seconds: 2),
                                                        () {
                                                      setState(() {
                                                        _login_ready =
                                                            'notready';
                                                      });
                                                    });
                                                  },
                                                  child: _login_ready ==
                                                          'notready'
                                                      ? Text(
                                                          'Login now',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      : Center(
                                                          child: SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Color(
                                                                    0xFFffffff),
                                                              )),
                                                        ),
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all<EdgeInsets>(
                                                                EdgeInsets.all(
                                                                    15)),
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(Color(
                                                                0xFFF0F1F1)),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                      ),
                                                    ),
                                                    backgroundColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            themeData
                                                                .secondaryHeaderColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ])),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Or..',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: themeData.splashColor
                                              .withOpacity(0.5),
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      RawMaterialButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/ForgetPassword');
                                        },
                                        fillColor:
                                            Theme.of(context).primaryColor,
                                        child: Text(
                                          '     Forgot your credantials?   Change     ',
                                          style: TextStyle(
                                              color: themeData.splashColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        splashColor: themeData.primaryColor,
                                        elevation: 0,
                                      ),
                                      RawMaterialButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed('/SignUp');
                                        },
                                        highlightColor: themeData.primaryColor,
                                        fillColor:
                                            Theme.of(context).primaryColor,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '     New to Leaforg?',
                                                style: TextStyle(
                                                    color: themeData.splashColor
                                                        .withOpacity(0.5),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Register     ',
                                                style: TextStyle(
                                                    color: themeData
                                                        .secondaryHeaderColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ]),
                                        splashColor: themeData.primaryColor,
                                        elevation: 0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                                      height: (mediaQuery.size.height - 100),
                                      width: (mediaQuery.size.width - 200) / 2 -
                                          100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        color: themeData.hintColor,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/leaforg_login_form.jpg'),
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                          ),
                                          color: themeData.hintColor,
                                        ),
                                      ),
                                    ),
                        ],
                      ),
                    ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'KE');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
