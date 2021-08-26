import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:leaforgapp/src/models/color_palletes.dart';
import 'package:leaforgapp/src/models/gradient_palletes.dart';
import '../helpers/custom_trace.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/widgets.dart';

class CreateStoriesDialogController extends GetxController {
  //final contrllr = Get.put(CreateStoriesDialogController());
  String createStory = 'closed';
  var postImageFile;
  String createtextstory = 'disabled';
  String text = 'Your Great Story';
  ColorSwatch tempMainColor;
  ColorSwatch mainColor = Colors.blue;
  static Color color = Colors.grey[400];
  static Color background_color = Colors.transparent;
  static double fontsize = 18.0;
  static FontWeight fontWeight = FontWeight.bold;
  static FontStyle fontStyle = FontStyle.italic;
  static TextDecoration textDecoration = TextDecoration.underline;
  static TextDecorationStyle textDecorationStyle = TextDecorationStyle.solid;
  TextAlign textAlign = TextAlign.center;
  // final ValueNotifier<TextStyle> textStyle = GoogleFonts.lato(
  //   color: Colors.grey[400],
  //   backgroundColor: Colors.white,
  //   fontSize: 18.0,
  //   fontWeight: FontWeight.bold,
  //   fontStyle:FontStyle.normal,
  //   decoration: TextDecoration.underline,
  //   decorationStyle: TextDecorationStyle.solid,
  // ).copyWith(overflow: TextOverflow.ellipsis) as ValueNotifier<TextStyle>;

  // @override
  // void onInit() {
  //   super.onInit();
  // var createStory = 'closed';
  // var createtextstory = 'disabled';
  // var text = 'Your Great Story';
  // }

  Future<void> showDiscardDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Theme.of(context).primaryColor.withOpacity(0.23),
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
                                    createStory = 'closed';
                                    postImageFile = Uint8List(null);
                                    // storyEditingController.clear();
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

  //  @override
  // void onClose() {
  //   super.onClose();
  //   storyEditingController.clear();
  // }

  // Future selectFile() async {

  // }
}

void setCurrentColors(jsonString) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_colors', jsonString);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: jsonString).toString());
    throw new Exception(e);
  }
}

void setCurrentGradient(jsonString) async {
  print(jsonString);
 
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_gradient_name', jsonString);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: jsonString).toString());
    throw new Exception(e);
  }
}

void setCurrentShadowGradient(jsonInt) async {
  print(jsonInt);
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_gradient_shadowcolor', jsonInt);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: jsonInt).toString());
    throw new Exception(e);
  }
}

int colorvalue;
ValueNotifier<Color> textColorPallete = new ValueNotifier(Color(colorvalue));

Future<Color> getCurrentColors() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (prefs.containsKey('current_colors')) {
    colorvalue = await prefs.get('current_colors');
    textColorPallete.value = Color(colorvalue);
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  textColorPallete.notifyListeners();
  return textColorPallete.value;
}

int shadowvalue;
ValueNotifier<Color> textShadowPallete = new ValueNotifier(Color(shadowvalue));

Future<Color> getCurrentShadowColors() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (prefs.containsKey('current_gradient_shadowcolor')) {
    shadowvalue = await prefs.get('current_gradient_shadowcolor');
    textShadowPallete.value = Color(shadowvalue);
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  textShadowPallete.notifyListeners();
  return textShadowPallete.value;
}

//String gradientvalue;
ValueNotifier<LinearGradient> textGradientPallete =
    new ValueNotifier(Gradients.hotLinear);

Future<LinearGradient> getCurrentGradients() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (prefs.containsKey('current_gradient_name')) {
    String gradientvalue = await prefs.get('current_gradient_name');

    print(gradientvalue);

    var userdataidss = await allgradientPalettesval.map((e) => e);
    var useridtextss = userdataidss.toList();
    for (var selectedgradientsingle in useridtextss)
      if (selectedgradientsingle.name == gradientvalue) {
        textGradientPallete.value = await selectedgradientsingle.gradient;
        print('Brayton Anderson');
        print(selectedgradientsingle.name);
      }
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  textGradientPallete.notifyListeners();
  return textGradientPallete.value;
}
