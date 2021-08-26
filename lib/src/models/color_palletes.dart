import 'package:flutter/material.dart';

class Palette {
  Palette({this.name, this.primary, this.accent, this.threshold = 900});
  final String name;
  final Color primary;
  final MaterialAccentColor accent;
  final int
      threshold; // titles for indices > threshold are white, otherwise black
  bool get isValid => name != null && primary != null && threshold != null;
}

final List<Palette> allcolorPalettes = <Palette>[
  Palette(name: 'RED', primary: Colors.red, threshold: 300),
  Palette(name: 'RED A', primary: Colors.redAccent, threshold: 300),
  Palette(name: 'PINK', primary: Colors.pink, threshold: 200),
  Palette(name: 'PINK A', primary: Colors.pinkAccent, threshold: 200),
  Palette(name: 'PURPLE', primary: Colors.purple, threshold: 200),
  Palette(name: 'PURPLE A', primary: Colors.purpleAccent, threshold: 200),
  Palette(name: 'DEEP PURPLE', primary: Colors.deepPurple, threshold: 200),
  Palette(
      name: 'DEEP PURPLE A', primary: Colors.deepPurpleAccent, threshold: 200),
  Palette(name: 'INDIGO', primary: Colors.indigo, threshold: 200),
  Palette(name: 'INDIGO A', primary: Colors.indigoAccent, threshold: 200),
  Palette(name: 'BLUE', primary: Colors.blue, threshold: 400),
  Palette(name: 'BLUE A', primary: Colors.blueAccent, threshold: 400),
  Palette(name: 'LIGHT BLUE', primary: Colors.lightBlue, threshold: 500),
  Palette(
      name: 'LIGHT BLUE A', primary: Colors.lightBlueAccent, threshold: 500),
  Palette(name: 'CYAN', primary: Colors.cyan, threshold: 600),
  Palette(name: 'CYAN A', primary: Colors.cyanAccent, threshold: 600),
  Palette(name: 'TEAL', primary: Colors.teal, threshold: 400),
  Palette(name: 'TEAL A', primary: Colors.tealAccent, threshold: 400),
  Palette(name: 'GREEN', primary: Colors.green, threshold: 500),
  Palette(name: 'GREEN A', primary: Colors.greenAccent, threshold: 500),
  Palette(name: 'LIGHT GREEN', primary: Colors.lightGreen, threshold: 600),
  Palette(
      name: 'LIGHT GREEN A', primary: Colors.lightGreenAccent, threshold: 600),
  Palette(name: 'LIME', primary: Colors.lime, threshold: 800),
  Palette(name: 'LIME A', primary: Colors.limeAccent, threshold: 800),
  Palette(
    name: 'YELLOW',
    primary: Colors.yellow,
  ),
  Palette(name: 'YELLOW A', primary: Colors.yellowAccent),
  Palette(name: 'AMBER', primary: Colors.amber),
  Palette(name: 'AMBER A', primary: Colors.amberAccent),
  Palette(name: 'ORANGE', primary: Colors.orange, threshold: 700),
  Palette(name: 'ORANGE A', primary: Colors.orangeAccent, threshold: 700),
  Palette(name: 'DEEP ORANGE', primary: Colors.deepOrange, threshold: 400),
  Palette(
      name: 'DEEP ORANGE A', primary: Colors.deepOrangeAccent, threshold: 400),
  Palette(name: 'BROWN', primary: Colors.brown, threshold: 200),
  Palette(name: 'GREY', primary: Colors.grey, threshold: 500),
  Palette(name: 'WHITE', primary: Colors.white, threshold: 300),
  Palette(name: 'BLUE GREY', primary: Colors.blueGrey, threshold: 500),
  Palette(name: 'BLACK', primary: Colors.black, threshold: 300),
];
