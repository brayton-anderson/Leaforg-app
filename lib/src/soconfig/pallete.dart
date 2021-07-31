import 'package:flutter/material.dart';

class Palette {
  static const Color scaffold = Color(0xFF1aff7d
      //F0F2F5
      );

  static const Color facebookBlue = Color(0xFF003a19
      //004d21
      //FFAA00
      );

  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [
      Color(0xFFb3ffd4
          //ffd480
          ),
      Color(0xFF003a19)
    ],
  );

  static const Color online = Color(0xFF009942);

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );
}
