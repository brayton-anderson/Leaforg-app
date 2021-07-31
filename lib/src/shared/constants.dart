import 'package:flutter/material.dart';

class AppConst {
  AppConst._();

  static const String appName = 'Leaforg';
  static const String version = '1.0.0';
  static const String packageVersion = 'Leaforg $version';
  static const String packageUrl = 'https://andie.co.ke';
  static const String flutterVersion =
      'Channel dev, 2.3.0-1.0.pre, build 2.14.0-48.0.dev';
  static const String copyright = '© 2021';
  static const String developer_org = 'Built by Andie';

  static const String author_1 = 'Brayton Anderson';
  static const String author_1_dept = 'Developer';
  static const String author_1_strength =
      'Hardware & Software Engineer[Python, Dart, JavaScript, C#, C++, PHP]';
  static const String author_1_image = 'assets/images/brayton.jpg';
  static const String author_1_url =
      'https://www.linkedin.com/in/brayton-anderson-512557142/';

  static const String author_2 = 'Mira Gayed';
  static const String author_2_dept = 'Developer';
  static const String author_2_strength = 'Hardware Engineer[Python, C#, C++]';
  static const String author_2_image = 'assets/images/mira_gayed.jpg';
  static const String author_2_url =
      'https://www.linkedin.com/in/mira-gayed-3b959b152/';

  static const String author_3 = 'Ghada Halawa';
  static const String author_3_dept = 'Research & Development';
  static const String author_3_strength =
      'Civil Engineer ll Researcher II EMIT®';
  static const String author_3_image = 'assets/images/ghada_halawa.jpg';
  static const String author_3_url =
      'https://www.linkedin.com/in/ghada-halawa-681561142/';

  static const String author_4 = 'Sagal Ibraahim';
  static const String author_4_dept = 'Finance';
  static const String author_4_strength =
      'Undergraduate Business Administration Student at Doshisha university';
  static const String author_4_image = 'assets/images/sagal.jpg';
  static const String author_4_url =
      'https://www.linkedin.com/in/sagal-ibraahim-ba4b75128/';

  static const String author_5 = 'Adem Şems Asha';
  static const String author_5_dept = 'Marketing';
  static const String author_5_strength =
      'Business & Entrepreneurship Teacher at Tarabya British Schools';
  static const String author_5_image = 'assets/images/adem.jpg';
  static const String author_5_url =
      'https://www.linkedin.com/in/adem-%C5%9Fems-asha-471736111/';

  static const String license = 'MIT License';
  static const String icon = 'assets/images/app_icon.png';

  static const double maxBodyWidth = 1200;

  static const double edgePadding = 5;

  static const double expandWidth = 225;

  static const double shrinkWidth = 60;
}

class AppFonts {
  AppFonts._();

  static const String mainFont = fontRoboto;

  static const String fontRoboto = 'Roboto';
}

class AppScale {
  const AppScale(this._context);

  final BuildContext _context;

  double ofWidth(double pct) {
    return MediaQuery.of(_context).size.width * pct;
  }

  double ofHeight(double pct) {
    return MediaQuery.of(this._context).size.height * pct;
  }
}
