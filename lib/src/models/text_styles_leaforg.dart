import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../elements/CreateStoriesWidget.dart';

class TextStyleLeaforg {
  TextStyleLeaforg(
      {this.name, this.widget_name, this.text_style, this.threshold = 900});
  final String name;
  final Widget widget_name;
  final TextStyle text_style;
  final int
      threshold; // titles for indices > threshold are white, otherwise black
  bool get isValid => name != null && widget_name != null && threshold != null;
}

final List<TextStyleLeaforg> alltextstylesleaforg = <TextStyleLeaforg>[
  TextStyleLeaforg(
      name: 'Official',
      widget_name: Padding(
          padding: EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    PhosphorIcons.fire_simple_fill,
                    size: 20,
                    color: Colors.grey[400],
                  )),
              SizedBox(
                width: 5,
              ),
              Text(
                "Official".toUpperCase(),
                style: GoogleFonts.montserrat(
                  color: CreateStoriesDialogController.color,
                  backgroundColor: Colors.transparent,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  decorationStyle: TextDecorationStyle.solid,
                ).copyWith(overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          )),
      text_style: GoogleFonts.montserrat(
        //color: CreateStoriesDialogController.color,
        //backgroundColor: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        decorationStyle: TextDecorationStyle.solid,
      ).copyWith(overflow: TextOverflow.ellipsis),
      threshold: 300),
  TextStyleLeaforg(
      name: 'Simple',
      widget_name: Padding(
          padding: EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    PhosphorIcons.coffee_fill,
                    size: 20,
                    color: Colors.grey[400],
                  )),
              SizedBox(
                width: 5,
              ),
              Text(
                "Simple".toUpperCase(),
                style: GoogleFonts.ptSans(
                  color: CreateStoriesDialogController.color,
                  backgroundColor: Colors.transparent,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  decorationStyle: TextDecorationStyle.solid,
                ).copyWith(overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          )),
      text_style: GoogleFonts.ptSans(
        //color: CreateStoriesDialogController.color,
        //backgroundColor: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.overline,
        decorationStyle: TextDecorationStyle.dotted,
      ).copyWith(overflow: TextOverflow.ellipsis),
      threshold: 300),
  TextStyleLeaforg(
      name: 'Legend',
      widget_name: Padding(
          padding: EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    PhosphorIcons.smiley_wink_fill,
                    size: 20,
                    color: Colors.grey[400],
                  )),
              SizedBox(
                width: 5,
              ),
              Text(
                "Legend".toUpperCase(),
                style: GoogleFonts.stalemate(
                  color: CreateStoriesDialogController.color,
                  backgroundColor: Colors.transparent,
                  fontSize: 20.0,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.wavy,
                ).copyWith(overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          )),
      text_style: GoogleFonts.stalemate(
        // color: CreateStoriesDialogController.color,
        // backgroundColor: Colors.white,
        fontSize: 22.0,
        letterSpacing: 5,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        decorationStyle: TextDecorationStyle.solid,
      ).copyWith(overflow: TextOverflow.ellipsis),
      threshold: 300),
  TextStyleLeaforg(
      name: 'Statement',
      widget_name: Padding(
          padding: EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    PhosphorIcons.crown_simple_fill,
                    size: 20,
                    color: Colors.grey[400],
                  )),
              SizedBox(
                width: 5,
              ),
              Text(
                "Statement".toUpperCase(),
                style: GoogleFonts.merriweather(
                  color: CreateStoriesDialogController.color,
                  backgroundColor: Colors.transparent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  decorationStyle: TextDecorationStyle.solid,
                ).copyWith(overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          )),
      text_style: GoogleFonts.merriweather(
        //color: CreateStoriesDialogController.color,
        //backgroundColor: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.solid,
      ).copyWith(overflow: TextOverflow.ellipsis),
      threshold: 300),
];
