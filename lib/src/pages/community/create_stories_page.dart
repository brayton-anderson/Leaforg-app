import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import '../../elements/GradientBackgroundCardList.dart';
import '../../elements/GradientPalleteLeaforg.dart';
import '../../models/gradient_palletes.dart';
import '../../models/text_styles_leaforg.dart';
import '../../elements/ColorPalleteLeaforg.dart';
import '../../models/color_palletes.dart';
import '../../elements/CreateStoriesWidget.dart';
import '../../controllers/community_controlers/compress.dart';
import '../../helpers/snackbar_notifications.dart';
import '../../widgets/current_user_card.dart';
import '../../models/userstories.dart';
import '../../widgets/widgets.dart';
import 'view_stories.dart';
import '../../helpers/responcive_app.dart' as devices;

class CreateStoriesPage extends StatefulWidget {
  final StoriesuserModel users;

  @override
  _CreateStoriesPageState createState() => _CreateStoriesPageState();
  const CreateStoriesPage({
    Key key,
    @required this.users,
  }) : super(key: key);
}

class _CreateStoriesPageState extends State<CreateStoriesPage> {
  //TextEditingController storyEditingController = new TextEditingController();

  //TextStyle get _option => _controller.textStyle.value;
  // static double _inputHeight = 50;
  static String createStory = 'closed';
  ValueNotifier<String> _createLeaforgStory = ValueNotifier(createStory);
  static var postImageFile;
  static String createtextstory = 'disabled';
  static String createtextwithoutimage = 'disabled';
  static String creategradienttextstory = 'closedgradienttext';
  // static String textboxstories = 'nottapped';
  static String selectedtextstyleItem = 'Official';
  static TextAlign textAlign = TextAlign.center;
  static TextStyle textStyle = GoogleFonts.lato(
    //color: Colors.grey[400],
    //backgroundColor: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    decoration: TextDecoration.none,
    decorationStyle: TextDecorationStyle.solid,
  ).copyWith(overflow: TextOverflow.ellipsis);
  ValueNotifier<TextEditingController> storytextController =
      new ValueNotifier(TextEditingController());

  @override
  void initState() {
    super.initState();
    //setState(() {
    checkTextStyleValue(selectedtextstyleItem);
    storytextController.value.addListener(_printLatestValue);
    //storyEditingController;
    //_controller.storyEditingController.addListener(_checkInputHeight);

    //});
  }

  TextStyle textstylenamelist;
  Future<TextStyle> checkTextStyleValue(String textstylevalue) async {
    var userdataid = await alltextstylesleaforg.map((e) => e);
    var useridtext = userdataid.toList();
    for (var usertimestampsingle in useridtext)
      if (usertimestampsingle.name == textstylevalue) {
        setState(() {
          textstylenamelist = usertimestampsingle.text_style;
        });
        print('Brayton Anderson');
        print(usertimestampsingle.name);
      }

    return textstylenamelist;

    // for (var textstylenamesingle in textstylenamelist)
  }

  // @override
  // void dispose() {
  //   //super.dispose();
  //   //startconts();
  // }

  // void _checkInputHeight() async {
  //   int count = _controller.storyEditingController.text.split('\n').length;

  //   if (count == 0 && _inputHeight == 50.0) {
  //     return;
  //   }
  //   if (count <= 5) {
  //     // use a maximum height of 6 rows
  //     // height values can be adapted based on the font size
  //     var newHeight = count == 0 ? 50.0 : 28.0 + (count * 18.0);
  //     setState(() {
  //       _inputHeight = newHeight;
  //     });
  //   }
  // }

  //var texteditor = storyEditingController;

  ValueNotifier<Offset> position = new ValueNotifier(Offset(100, 100));

  //Offset position = Offset(100, 100);
  static double prevScales = 1;
  static double scales = 1;

  ValueNotifier<double> prevScaleNew = new ValueNotifier(prevScales);

  ValueNotifier<double> scaleNew = new ValueNotifier(scales);

  void updateScale(double zoom) =>
      setState(() => scaleNew.value = prevScaleNew.value * zoom);
  void commitScale() => setState(() => prevScaleNew.value = scaleNew.value);
  void updatePosition(Offset newPosition) =>
      setState(() => position.value = newPosition);
  String newvalue;
  void _printLatestValue() {
    print('Second text field:');
    newvalue = storytextController.value.text;
  }

  @override
  void dispose() {
    storytextController.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      //key: _con.scaffoldKey,
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: _createLeaforgStory,
            builder: (context, value, widget) {
              return Container(
                width: mediaQuery.width,
                height: mediaQuery.height,
                color: Colors.grey[100],
                child: devices.Responsive.isMobile(context)
                    ? ViewStoriesScreen()
                    : Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 70,
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            width: mediaQuery.width,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4),
                                    blurRadius: 10,
                                    offset: Offset(0.0, 0.75)),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width: 300,
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                            height: 60,
                                            child: CircleButton(
                                              icon: PhosphorIcons.x_fill,
                                              iconSize: 30.0,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                            height: 60,
                                            child: CircleAvatar(
                                              radius: 40,
                                              child: Image.asset(
                                                  'assets/img/leaforg_icon_green.png'),
                                              backgroundColor:
                                                  Colors.transparent,
                                            )),
                                      ],
                                    )),
                                Container(
                                    alignment: Alignment.centerRight,
                                    width: 300,
                                    height: 70,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              SizedBox(
                                                  height: 60,
                                                  child: CircleButton(
                                                    icon: PhosphorIcons
                                                        .bell_simple_fill,
                                                    iconSize: 30.0,
                                                    onPressed: () =>
                                                        print('Search'),
                                                  )),
                                              Container(
                                                height: 30.0,
                                                width: 30.0,
                                                alignment: Alignment.topRight,
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  '20+',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                                              )
                                            ]),
                                        Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              SizedBox(
                                                  height: 60,
                                                  child: CircleButton(
                                                    icon: PhosphorIcons
                                                        .chat_teardrop_text_fill,
                                                    iconSize: 30.0,
                                                    onPressed: () =>
                                                        print('Messenger'),
                                                  )),
                                              Container(
                                                height: 30.0,
                                                width: 30.0,
                                                alignment: Alignment.topRight,
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  '20+',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                                              )
                                            ]),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 420,
                            width: mediaQuery.width,
                            color: Colors.transparent,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _createLeaforgStory.value == 'closed'
                                      ? GestureDetector(
                                          onTap: () {
                                            _getImageAndCrop();
                                            // setState(() {
                                            //   createStory = 'openedtextstory';
                                            // });
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 250,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                stops: [
                                                  0.1,
                                                  0.4,
                                                  0.6,
                                                  0.9,
                                                ],
                                                colors: [
                                                  Colors.yellow,
                                                  Colors.red,
                                                  Colors.indigo,
                                                  Colors.teal,
                                                ],
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Theme.of(context)
                                                        .focusColor
                                                        .withOpacity(0.4),
                                                    blurRadius: 15,
                                                    offset: Offset(2.0, 4.75)),
                                              ],
                                            ),
                                            child: Center(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                  CircleButton(
                                                    icon: PhosphorIcons
                                                        .image_square_fill,
                                                    iconSize: 30.0,
                                                    onPressed: () =>
                                                        _getImageAndCrop(),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    'Create a Photo Story',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ])),
                                          ))
                                      : SizedBox(
                                          height: 0,
                                          width: 0,
                                        ),
                                  SizedBox(
                                    width: _createLeaforgStory.value == 'closed'
                                        ? 40
                                        : 0,
                                  ),
                                  _createLeaforgStory.value == 'closed'
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              createtextwithoutimage = 'opened';
                                              creategradienttextstory =
                                                  'closedgradienttext';
                                              _createLeaforgStory.value =
                                                  'openedtextstory';
                                              createtextstory = 'disabled';
                                              _createLeaforgStory
                                                  .notifyListeners();
                                            });
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 250,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                stops: [
                                                  0.1,
                                                  0.4,
                                                  0.6,
                                                  0.9,
                                                ],
                                                colors: [
                                                  Theme.of(context)
                                                      .secondaryHeaderColor,
                                                  Colors.redAccent[700],
                                                  Colors.amberAccent,
                                                  Theme.of(context).hintColor,
                                                ],
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Theme.of(context)
                                                        .focusColor
                                                        .withOpacity(0.4),
                                                    blurRadius: 15,
                                                    offset: Offset(2.0, 4.75)),
                                              ],
                                            ),
                                            child: Center(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                  CircleButton(
                                                    icon: PhosphorIcons
                                                        .text_aa_fill,
                                                    iconSize: 30.0,
                                                    onPressed: () {
                                                      setState(() {
                                                        creategradienttextstory =
                                                            'closedgradienttext';
                                                        createtextstory =
                                                            'disabled';
                                                        _createLeaforgStory
                                                                .value =
                                                            'openedtextstory';
                                                        createtextwithoutimage =
                                                            'opened';
                                                        _createLeaforgStory
                                                            .notifyListeners();
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    'Create a Text Story',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ])),
                                          ))
                                      : SizedBox(
                                          height: 0,
                                          width: 0,
                                        ),
                                  _createLeaforgStory.value == 'closed'
                                      ? SizedBox(
                                          height: 0,
                                          width: 0,
                                        )
                                      : createtextwithoutimage == 'opened' ||
                                              createtextstory == 'opened'
                                          ? Container(
                                              height: 390,
                                              width: 300,
                                              padding: EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 5,
                                                  bottom: 5),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Theme.of(context)
                                                          .focusColor
                                                          .withOpacity(0.4),
                                                      blurRadius: 10,
                                                      offset:
                                                          Offset(0.0, 0.75)),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ValueListenableBuilder(
                                                      valueListenable:
                                                          textColorPallete,
                                                      builder: (context, value,
                                                          child) {
                                                        return Container(
                                                            height: 150,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3,
                                                                    right: 3),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .transparent,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: creategradienttextstory ==
                                                                              'openedgradienttext'
                                                                          ? Colors
                                                                              .black
                                                                          : createtextwithoutimage == 'opened'
                                                                              ? Colors.black
                                                                              : textColorPallete.value ?? Theme.of(context).secondaryHeaderColor,
                                                                      width:
                                                                          1.5,
                                                                    )),
                                                            child: Center(
                                                                child:
                                                                    Container(
                                                              height: 142,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey[400],
                                                                        width:
                                                                            0.8,
                                                                      )),
                                                              child: Center(
                                                                child: Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child:
                                                                        TextField(
                                                                      autofocus:
                                                                          true,
                                                                      controller:
                                                                          storytextController
                                                                              .value,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .newline,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .multiline,
                                                                      minLines:
                                                                          1,
                                                                      maxLines:
                                                                          5,
                                                                      style: textstylenamelist.copyWith(
                                                                              color: creategradienttextstory == 'openedgradienttext'
                                                                                  ? Colors.black
                                                                                  : createtextwithoutimage == 'opened'
                                                                                      ? Colors.black
                                                                                      : textColorPallete.value ?? Colors.grey[400]) ??
                                                                          textStyle.copyWith(
                                                                              color: creategradienttextstory == 'openedgradienttext'
                                                                                  ? Colors.black
                                                                                  : createtextwithoutimage == 'opened'
                                                                                      ? Colors.black
                                                                                      : textColorPallete.value ?? Colors.grey[400]),
                                                                      onChanged:
                                                                          (text) {
                                                                        storytextController
                                                                            .notifyListeners();
                                                                      },
                                                                      decoration:
                                                                          InputDecoration
                                                                              .collapsed(
                                                                        hintText:
                                                                            'Your best Story',
                                                                        hintStyle:
                                                                            textstylenamelist.copyWith(color: textColorPallete.value ?? Colors.grey[400]) ??
                                                                                textStyle.copyWith(color: textColorPallete.value ?? Colors.grey[400]),
                                                                      ),
                                                                    )),
                                                                //})
                                                              ),
                                                            )));
                                                      }),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[400],
                                                          width: 0.8,
                                                        )),
                                                    child: Center(
                                                        child: SizedBox(
                                                            width: 230,
                                                            height: 35,
                                                            child: Center(
                                                                child:
                                                                    DropdownButton<
                                                                        String>(
                                                              value:
                                                                  selectedtextstyleItem,
                                                              dropdownColor: Theme
                                                                      .of(context)
                                                                  .primaryColor,
                                                              icon: Icon(
                                                                PhosphorIcons
                                                                    .text_aa_fill,
                                                              ),
                                                              iconDisabledColor:
                                                                  Colors.grey,
                                                              iconSize: 20,
                                                              iconEnabledColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .secondaryHeaderColor,
                                                              // hint: Text(
                                                              //   'Cool'.toUpperCase(),
                                                              //   style: GoogleFonts.lato(
                                                              //     color:
                                                              //         CreateStoriesDialogController
                                                              //             .color,
                                                              //     backgroundColor:
                                                              //         Colors.transparent,
                                                              //     fontSize: 18.0,
                                                              //     fontWeight: FontWeight.w400,
                                                              //     fontStyle: FontStyle.normal,
                                                              //     decoration:
                                                              //         TextDecoration.none,
                                                              //     decorationStyle:
                                                              //         TextDecorationStyle
                                                              //             .solid,
                                                              //   ).copyWith(
                                                              //       overflow: TextOverflow
                                                              //           .ellipsis),
                                                              // ),
                                                              isExpanded: true,
                                                              focusColor: Theme
                                                                      .of(context)
                                                                  .primaryColor,

                                                              // borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              underline:
                                                                  SizedBox(),
                                                              onChanged: (String
                                                                  string) {
                                                                setState(() =>
                                                                    selectedtextstyleItem =
                                                                        string);
                                                                checkTextStyleValue(
                                                                    selectedtextstyleItem);
                                                              },
                                                              selectedItemBuilder:
                                                                  (BuildContext
                                                                      context) {
                                                                return alltextstylesleaforg.map<
                                                                        Widget>(
                                                                    (TextStyleLeaforg
                                                                        item) {
                                                                  return item
                                                                      .widget_name;
                                                                }).toList();
                                                              },
                                                              items: alltextstylesleaforg.map(
                                                                  (TextStyleLeaforg
                                                                      item) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  child: item
                                                                      .widget_name,
                                                                  value:
                                                                      item.name,
                                                                );
                                                              }).toList(),
                                                            )))),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[400],
                                                          width: 0.8,
                                                        )),
                                                    child: creategradienttextstory ==
                                                            'openedgradienttext'
                                                        ? GradientPalleteLeaforgList(
                                                            gradientPalleteLeaforgitems:
                                                                allgradientPalettesval
                                                                    .toList(),
                                                          )
                                                        : createtextwithoutimage ==
                                                                'opened'
                                                            ? GradientPalleteBackgroundLeaforgList(
                                                                gradientPalleteLeaforgitems:
                                                                    allgradientPalettesval
                                                                        .toList(),
                                                              )
                                                            : ColorPalleteLeaforgList(
                                                                colorPalleteLeaforgitems:
                                                                    allcolorPalettes
                                                                        .toList(),
                                                              ),
                                                  )
                                                ],
                                              ))
                                          : SizedBox(
                                              height: 0,
                                              width: 0,
                                            ),
                                  SizedBox(
                                      width:
                                          createtextwithoutimage == 'opened' ||
                                                  _createLeaforgStory.value ==
                                                      'openedcreateimage'
                                              ? 50
                                              : 0),
                                  createtextwithoutimage == 'opened' ||
                                          _createLeaforgStory.value ==
                                              'openedcreateimage'
                                      ?

                                      // _CreateStoryCard(
                                      //     storyimage: _controller.postImageFile,
                                      //     storystate: _controller.createStory,
                                      //     textstory: _controller.createtextstory,
                                      //     child:

                                      //     // child: storiestextwidget(
                                      //     //   // context,
                                      //     //   _controller.storyEditingController
                                      //     //       .toString(),
                                      //     //   _controller.textStyle,
                                      //     //   _controller.textAlign,
                                      //     // ),
                                      //   )
                                      //])
                                      Container(
                                          height: 390,
                                          width: 760,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context)
                                                      .focusColor
                                                      .withOpacity(0.4),
                                                  blurRadius: 10,
                                                  offset: Offset(0.0, 0.75)),
                                            ],
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      color: Colors.transparent,
                                                      child: Text(
                                                        'Preview',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Theme.of(
                                                                    context)
                                                                .splashColor),
                                                      )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Center(
                                                      child: Container(
                                                    height: 340,
                                                    width: 680,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .splashColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Theme.of(
                                                                    context)
                                                                .focusColor
                                                                .withOpacity(
                                                                    0.2),
                                                            blurRadius: 10,
                                                            offset: Offset(
                                                                0.0, 0.75)),
                                                      ],
                                                    ),
                                                    child:
                                                        ValueListenableBuilder(
                                                            valueListenable:
                                                                textGradientPallete,
                                                            builder: (context,
                                                                value, child) {
                                                              return Center(
                                                                  child: createtextwithoutimage ==
                                                                          'opened'
                                                                      ? Container(
                                                                          height:
                                                                              340,
                                                                          width:
                                                                              255,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            gradient:
                                                                                textGradientPallete.value ?? Gradients.hotLinear,
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            border:
                                                                                Border.all(color: Theme.of(context).primaryColor, width: 1.5),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                storiestextwidget(),
                                                                          )
                                                                          // : SizedBox(
                                                                          //     height: 0,
                                                                          //     width: 0,
                                                                          //   )

                                                                          )
                                                                      : Container(
                                                                          height:
                                                                              340,
                                                                          width:
                                                                              255,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            gradient:
                                                                                LinearGradient(
                                                                              begin: Alignment.topRight,
                                                                              end: Alignment.bottomLeft,
                                                                              stops: [
                                                                                0.1,
                                                                                0.4,
                                                                                0.6,
                                                                                0.9,
                                                                              ],
                                                                              colors: [
                                                                                Colors.grey[200],
                                                                                Colors.grey[350],
                                                                                Colors.amberAccent[400],
                                                                                Theme.of(context).secondaryHeaderColor,
                                                                              ],
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            border:
                                                                                Border.all(color: Theme.of(context).primaryColor, width: 1.5),
                                                                          ),
                                                                          child: createtextstory == 'disabled'
                                                                              ? Image.memory(
                                                                                  postImageFile,
                                                                                  fit: BoxFit.contain,
                                                                                  alignment: Alignment.center,
                                                                                )
                                                                              // : SizedBox(
                                                                              //     height: 0,
                                                                              //     width: 0,
                                                                              //   )
                                                                              : ValueListenableBuilder(
                                                                                  valueListenable: textColorPallete,
                                                                                  builder: (context, value, child) {
                                                                                    return Stack(
                                                                                      alignment: Alignment.center,
                                                                                      children: [
                                                                                        Image.memory(
                                                                                          postImageFile,
                                                                                          fit: BoxFit.contain,
                                                                                          alignment: Alignment.center,
                                                                                        ),
                                                                                        _DiscreteResizableComponent(
                                                                                          child: storiestextwidget(),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  }),
                                                                        ));
                                                            }),
                                                  )),
                                                ],
                                              )),
                                        )
                                      : SizedBox(
                                          height: 0,
                                          width: 0,
                                        ),
                                ]),
                          ),
                          Container(
                            height: mediaQuery.height - 480,
                            // padding: EdgeInsets.all(20),
                            width: mediaQuery.width,
                            color: Theme.of(context).primaryColor,
                            child: Column(children: [
                              Container(
                                height: 60,
                                padding: EdgeInsets.only(left: 20),
                                width: mediaQuery.width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.4),
                                        blurRadius: 10,
                                        offset: Offset(0.0, 0.75)),
                                  ],
                                ),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: 400,
                                        alignment: Alignment.centerLeft,
                                        color: Colors.transparent,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 400,
                                              color: Colors.transparent,
                                              child: Center(
                                                child: Text(
                                                  'Your Stories',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Theme.of(context)
                                                          .splashColor),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: mediaQuery.width - 800,
                                    ),
                                    Container(
                                        width: 400,
                                        alignment: Alignment.centerRight,
                                        color: Colors.transparent,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              width: 400,
                                              color: Colors.transparent,
                                              child: Center(
                                                child: CurrentUserCard(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                height: mediaQuery.height - 510,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: mediaQuery.width,
                                color: Colors.transparent,
                                child: Row(
                                    // crossAxisAlignment:
                                    //                   CrossAxisAlignment.center,
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: mediaQuery.height - 510,
                                        alignment: Alignment.topLeft,
                                        // padding: EdgeInsets.all(20),
                                        color: Colors.transparent,
                                        child: Row(children: [
                                          Container(
                                              height: mediaQuery.height - 510,
                                              alignment: Alignment.topLeft,
                                              // padding: EdgeInsets.all(20),
                                              color: Colors.transparent,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      _createLeaforgStory
                                                                      .value ==
                                                                  'closed' ||
                                                              createtextwithoutimage ==
                                                                  'opened'
                                                          ? SizedBox(
                                                              height: 0,
                                                              width: 0,
                                                            )
                                                          : GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  creategradienttextstory =
                                                                      'closedgradienttext';
                                                                  createtextstory =
                                                                      'opened';
                                                                });
                                                              },
                                                              child:
                                                                  CircleButton(
                                                                icon: PhosphorIcons
                                                                    .text_aa_fill,
                                                                iconSize: 30.0,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    creategradienttextstory =
                                                                        'closedgradienttext';
                                                                    createtextstory =
                                                                        'opened';
                                                                  });
                                                                },
                                                                //_getImageAndCrop(),
                                                              )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      _createLeaforgStory
                                                                      .value ==
                                                                  'closed' ||
                                                              createtextwithoutimage ==
                                                                  'opened'
                                                          ? SizedBox(
                                                              height: 0,
                                                              width: 0,
                                                            )
                                                          : GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  creategradienttextstory =
                                                                      'closedgradienttext';
                                                                  createtextstory =
                                                                      'opened';
                                                                });
                                                              },
                                                              child: Text(
                                                                'Add Text',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .splashColor),
                                                              )),
                                                      SizedBox(width: 20),
                                                      _createLeaforgStory
                                                                      .value ==
                                                                  'closed' ||
                                                              createtextwithoutimage ==
                                                                  'opened'
                                                          ? SizedBox(
                                                              height: 0,
                                                              width: 0,
                                                            )
                                                          : GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  createtextstory =
                                                                      'opened';
                                                                  creategradienttextstory =
                                                                      'openedgradienttext';
                                                                });
                                                              },
                                                              child:
                                                                  CircleButton(
                                                                icon: PhosphorIcons
                                                                    .text_t_fill,
                                                                iconSize: 30.0,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    createtextstory =
                                                                        'opened';
                                                                    creategradienttextstory =
                                                                        'openedgradienttext';
                                                                  });
                                                                },
                                                                //_getImageAndCrop(),
                                                              )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      _createLeaforgStory
                                                                      .value ==
                                                                  'closed' ||
                                                              createtextwithoutimage ==
                                                                  'opened'
                                                          ? SizedBox(
                                                              height: 0,
                                                              width: 0,
                                                            )
                                                          : GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  createtextstory =
                                                                      'opened';
                                                                  creategradienttextstory =
                                                                      'openedgradienttext';
                                                                });
                                                              },
                                                              child: GradientText(
                                                                  'Add Gradient Text',
                                                                  shaderRect: Rect
                                                                      .fromLTWH(
                                                                          0.0,
                                                                          0.0,
                                                                          50.0,
                                                                          50.0),
                                                                  gradient:
                                                                      Gradients
                                                                          .hotLinear,
                                                                  style:
                                                                      textStyle)),
                                                      SizedBox(
                                                        width: _createLeaforgStory
                                                                        .value ==
                                                                    'closed' ||
                                                                createtextwithoutimage ==
                                                                    'opened'
                                                            ? 900
                                                            : 500,
                                                      ),
                                                      _createLeaforgStory
                                                                  .value ==
                                                              'closed'
                                                          ? SizedBox(
                                                              height: 0,
                                                              width: 0)
                                                          : GestureDetector(
                                                              onTap: () =>
                                                                  showDiscardDialog(
                                                                      context),
                                                              child: Container(
                                                                height: 40,
                                                                width: 120,
                                                                // alignment: Alignment
                                                                //     .centerRight,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Theme.of(context)
                                                                            .focusColor
                                                                            .withOpacity(
                                                                                0.4),
                                                                        blurRadius:
                                                                            4,
                                                                        offset: Offset(
                                                                            1.2,
                                                                            1.75)),
                                                                  ],
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Discard',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color: Theme.of(context)
                                                                            .splashColor),
                                                                  ),
                                                                ),
                                                              )),
                                                      SizedBox(width: 20),
                                                      _createLeaforgStory
                                                                  .value ==
                                                              'closed'
                                                          ? SizedBox(
                                                              height: 0,
                                                              width: 0,
                                                            )
                                                          : Container(
                                                              height: 40,
                                                              width: 170,
                                                              // alignment:
                                                              //     Alignment.centerRight,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .secondaryHeaderColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .focusColor
                                                                          .withOpacity(
                                                                              0.4),
                                                                      blurRadius:
                                                                          4,
                                                                      offset: Offset(
                                                                          1.2,
                                                                          1.75)),
                                                                ],
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'Share to story',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                ),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  // ),

                                                  //Divider(),
                                                ],
                                              )),
                                        ]),
                                      ),
                                    ]),
                              ),
                            ]),
                          ),
                        ],
                      ),
              );
            }),
      ),
    );
  }

  Widget storiestextwidget(
      // BuildContext context,
      ) {
    // return StatefulBuilder(builder: (context, setState) {
    return Container(
      color: Colors.transparent,
      child: ValueListenableBuilder(
          valueListenable: storytextController,
          builder: (context, value, child) {
            return creategradienttextstory == 'openedgradienttext'
                ? GradientText(newvalue ?? 'Your best Story',
                    shaderRect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
                    maxLines: 10,
                    textAlign: textAlign,
                    gradient: textGradientPallete.value ?? Gradients.hotLinear,
                    style: textstylenamelist ?? textStyle)
                : createtextwithoutimage == 'opened'
                    ? Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Center(
                        child: Text(
                        newvalue ?? 'Your best Story',
                        // text,
                        maxLines: 10,
                        textAlign: textAlign,
                        style: textstylenamelist.copyWith(
                              color: Colors.white ?? Colors.black,
                              backgroundColor: Colors.transparent,
                            ) ??
                            textStyle.copyWith(
                              color: Colors.white ?? Colors.black,
                              backgroundColor: Colors.transparent,
                            ),
                      )))
                    : Text(
                        newvalue ?? 'Your best Story',
                        // text,
                        maxLines: 10,
                        textAlign: textAlign,
                        style: textstylenamelist.copyWith(
                              color: textColorPallete.value ?? Colors.grey[400],
                              backgroundColor: Colors.white,
                            ) ??
                            textStyle.copyWith(
                              color: textColorPallete.value ?? Colors.grey[400],
                              backgroundColor: Colors.white,
                            ),
                      );
          }),
    );
    // });
    // });
  }

  Future<void> _getImageAndCrop() async {
    // choose the size here, it will maintain aspect ratio
    // webhtml.InputElement uploadInput = webhtml.FileUploadInputElement()
    //   ..accept = 'image/*';
    // uploadInput.click();

    // // uploadInput.onChange.listen((event) {
    // //   final file = uploadInput.files.first;
    // //   final reader = webhtml.FileReader();
    // //   reader.readAsDataUrl(file);
    // //   reader.onLoadEnd.listen((event) async {
    final String cropImageFile = await takeCompressedPicture(context);
    // final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    //  if (result == null) return;
    //final path = result.files;
    // final name = result.files.single.path;
    //webFile.File cropImageFile =  webFile.File(path, name);

    //print(path + 'nanananananananana');

    //setState(() => file = );
    // if (kIsWeb) {
    //final file = await FilePicker.platform.pickFiles(allowMultiple: false);
    // if (file == null) return;
    //
    //final webFile.File
    // final reader = webFile.FileReader();
    // reader.readAsText(file);

    // await reader.onLoad.first;

    // String data = reader.result;
//}
    if (cropImageFile != null) {
      setState(() {
        postImageFile = cropImageFile;
        _createLeaforgStory.value = 'openedcreateimage';
        //creategradienttextstory = 'closedgradienttext';
        _createLeaforgStory.notifyListeners();
        final messages = 'Image has been uploaded';
        final button = "";
        final route = "";
        final request = "success_snack";

        getSnackbarNotification(messages, request, button, route);
      });
    }
    //    });
    //  });

    //await getcropImage cropImageFile(imageFileFromGallery);
  }

  Future<void> showDiscardDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Theme.of(context).primaryColor.withOpacity(0.43),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                padding: EdgeInsets.only(
                  top: 3,
                  bottom: 15,
                ),
                constraints: BoxConstraints(
                  minHeight: 200,
                  maxHeight: 250,
                  minWidth: 620,
                  maxWidth: 620,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color:
                            Theme.of(Get.context).focusColor.withOpacity(0.2),
                        blurRadius: 15,
                        offset: Offset(0, 5)),
                  ],
                  color: Theme.of(Get.context).primaryColor,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        constraints: BoxConstraints(
                          minHeight: 60,
                          maxHeight: 60,
                          minWidth: 620,
                          maxWidth: 620,
                        ),
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        //mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Discard Story',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(Get.context)
                                                  .splashColor,
                                            ),
                                          ),
                                        ]),
                                    SizedBox(
                                      width: 390,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        //mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          CircleButton(
                                            icon: PhosphorIcons.x_fill,
                                            iconSize: 26.0,
                                            onPressed: () =>
                                                Navigator.pop(Get.context),
                                          ),
                                        ]),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ]),
                              SizedBox(
                                height: 3,
                              ),
                              Divider(height: 10.0, thickness: 0.5),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          height: 80,
                          color: Colors.transparent,
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          constraints: BoxConstraints(
                            minHeight: 80,
                            maxHeight: 80,
                            minWidth: 620,
                            maxWidth: 620,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Center(
                                child: Text(
                              'Are you sure you want to discard this story? Your story won\'t be saved',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).splashColor),
                            )),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 120,
                              height: 20,
                              color: Colors.transparent,
                            ),
                          ]),
                      SizedBox(
                        width: 150,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          //mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  height: 40,
                                  width: 170,
                                  alignment: Alignment.centerRight,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Text(
                                      'Continue Editing',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                    ),
                                  ),
                                )),
                            SizedBox(width: 20),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    createtextstory = 'disabled';
                                    createtextwithoutimage = 'disabled';
                                    _createLeaforgStory.value = 'closed';
                                    creategradienttextstory =
                                        'closedgradienttext';
                                    _createLeaforgStory.notifyListeners();
                                    postImageFile = null;
                                    storytextController.value.clear();
                                    //storyEditingController.text =
                                    'Your best story';
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.4),
                                          blurRadius: 4,
                                          offset: Offset(1.2, 1.75)),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Discard',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                          ]),
                      SizedBox(
                        width: 20,
                      ),

                      //WritePost(),
                    ]),
              ),
            );
          });
        });
  }
}

class _DiscreteResizableComponent extends StatefulWidget {
  const _DiscreteResizableComponent({Key key, this.child}) : super(key: key);

  final Widget child;
  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

const ballDiameter = 30.0;
const discreteStepSize = 50;

class _ResizebleWidgetState extends State<_DiscreteResizableComponent> {
  double height = 340;
  double width = 255;
  // height:
  // width: ,
  double top = 0;
  double left = 0;

  double cumulativeDy = 0;
  double cumulativeDx = 0;
  double cumulativeMid = 0;

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Draggable(
        //     maxSimultaneousDrags: 1,
        //     feedback: widget.child,
        //     childWhenDragging: Opacity(
        //       opacity: .3,
        //       child: widget.child,
        //     ),
        //     onDragEnd: (details) {
        //       details.offset.dx;
        //       details.offset.dy;
        //       onDrag(details.offset.dx, details.offset.dy);
        //     },

        //     // setState(
        //     //     () => position.value = details.offset),
        //     // updatePosition(details.offset),
        //     child: Stack(children: <Widget>[

        Positioned(
          top: top,
          left: left,
          child: Center(
              child: Container(
                  alignment: Alignment.center,
                  height: height,
                  width: width,
                  color: Theme.of(context).primaryColor.withOpacity(0.003),
                  child: Center(
                    child: widget.child,
                  ))),
        ),
        // top left
        Positioned(
          top: top - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: _ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;
              cumulativeMid -= 2 * mid;
              if (cumulativeMid >= discreteStepSize) {
                setState(() {
                  var newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  var newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeMid = 0;
                });
              } else if (cumulativeMid <= -discreteStepSize) {
                setState(() {
                  var newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  var newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeMid = 0;
                });
              }
            },
          ),
        ),
        // top middle
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: _ManipulatingBall(
            onDrag: (dx, dy) {
              cumulativeDy -= dy;
              if (cumulativeDy >= discreteStepSize) {
                setState(() {
                  var newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  cumulativeDy = 0;
                });
              } else if (cumulativeDy <= -discreteStepSize) {
                setState(() {
                  var newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  cumulativeDy = 0;
                });
              }
            },
          ),
        ),
        // top right
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: _ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + (dy * -1)) / 2;
              cumulativeMid += 2 * mid;
              if (cumulativeMid >= discreteStepSize) {
                setState(() {
                  var newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  var newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeMid = 0;
                });
              } else if (cumulativeMid <= -discreteStepSize) {
                setState(() {
                  var newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  var newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeMid = 0;
                });
              }
            },
          ),
        ),
        // center right
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: _ManipulatingBall(
            onDrag: (dx, dy) {
              cumulativeDx += dx;

              if (cumulativeDx >= discreteStepSize) {
                setState(() {
                  var newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeDx = 0;
                });
              } else if (cumulativeDx <= -discreteStepSize) {
                setState(() {
                  var newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeDx = 0;
                });
              }
            },
          ),
        ),
        // bottom right
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: _ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;

              cumulativeMid += 2 * mid;
              if (cumulativeMid >= discreteStepSize) {
                setState(() {
                  var newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  var newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeMid = 0;
                });
              } else if (cumulativeMid <= -discreteStepSize) {
                setState(() {
                  var newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  var newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeMid = 0;
                });
              }
            },
          ),
        ),
        // bottom center
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: _ManipulatingBall(
            onDrag: (dx, dy) {
              cumulativeDy += dy;

              if (cumulativeDy >= discreteStepSize) {
                setState(() {
                  var newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  cumulativeDy = 0;
                });
              } else if (cumulativeDy <= -discreteStepSize) {
                setState(() {
                  var newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  cumulativeDy = 0;
                });
              }
            },
          ),
        ),
        // bottom left
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: _ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = ((dx * -1) + dy) / 2;

              cumulativeMid += 2 * mid;
              if (cumulativeMid >= discreteStepSize) {
                setState(() {
                  var newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  var newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeMid = 0;
                });
              } else if (cumulativeMid <= -discreteStepSize) {
                setState(() {
                  var newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  var newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeMid = 0;
                });
              }
            },
          ),
        ),
        //left center
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: _ManipulatingBall(
            onDrag: (dx, dy) {
              cumulativeDx -= dx;

              if (cumulativeDx >= discreteStepSize) {
                setState(() {
                  var newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeDx = 0;
                });
              } else if (cumulativeDx <= -discreteStepSize) {
                setState(() {
                  var newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeDx = 0;
                });
              }
            },
          ),
        ),
        // ])),
      ],
    );
  }
}

class _ManipulatingBall extends StatefulWidget {
  _ManipulatingBall({Key key, this.onDrag});

  final Function onDrag;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<_ManipulatingBall> {
  double initX;
  double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
