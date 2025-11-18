import 'package:flutter/cupertino.dart';

class TingsColors {
  TingsColors._();
  // Black, White & Grays
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color grayLight = Color(0xffF7F7F7);
  static const Color grayMedium = Color(0xffE4E4E4);
  static const Color grayDark = Color(0xffC1C1C1);
  static const Color grayVeryDark = Color(0xff3F3D3D);

  static const Color transparent = Color(0x00000000);

  // Colors
  static const Color yellow = Color(0xffFFD872);
  static const Color yellowStrong = Color(0xffFFEFC6);
  static const Color yellowMedium = Color(0xffFAF1D9);
  static const Color yellowLight = Color(0xffFFF9EA);

  static const Color beige = Color(0xffA48868);
  static const Color beigeStrong = Color(0xffECDDCB);
  static const Color beigeMedium = Color(0xffF3EDE5);
  static const Color beigeLight = Color(0xffF3F2F0);

  static const Color orange = Color(0xffC77957);
  static const Color orangeStrong = Color(0xffEED3C7);
  static const Color orangeMedium = Color(0xffF8E4DB);
  static const Color orangeLight = Color(0xffFCF2ED);

  static const Color red = Color(0xffD75B5B);
  static const Color redStrong = Color(0xffF5C6C6);
  static const Color redMedium = Color(0xffF8DBDB);
  static const Color redLight = Color(0xffFCEDED);

  static const Color blue = Color(0xff479EC0);
  static const Color blueStrong = Color(0xffC2DFEB);
  static const Color blueMedium = Color(0xffDEEAF2);
  static const Color blueLight = Color(0xffEEF3F6);

  static const Color green = Color(0xff8AC077);
  static const Color greenStrong = Color(0xffDDE9C4);
  static const Color greenMedium = Color(0xffE9EDD9);
  static const Color greenLight = Color(0xffDDE9C4);

  // Primary, secondary
  static const Color primary = black;
  static const Color secondary = white;

  static Color textColorFromBackgroundColor(Color backgroundColor) {
    if (_backgroundColorTextColors.containsKey(backgroundColor)) {
      return _backgroundColorTextColors[backgroundColor]!;
    }

    return TingsColors.black;
  }

  static Color fromString(String color) {
    if (_textToColors.containsKey(color)) {
      return _textToColors[color]!;
    }

    return TingsColors.grayLight;
  }

  static final Map<String, Color> _textToColors = {
    'black': TingsColors.black,
    'white': TingsColors.white,
    'grayLight': TingsColors.grayLight,
    'grayMedium': TingsColors.grayMedium,
    'grayDark': TingsColors.grayDark,
    'transparent': TingsColors.transparent,
    'yellow': TingsColors.yellow,
    'yellowStrong': TingsColors.yellowStrong,
    'yellowMedium': TingsColors.yellowMedium,
    'yellowLight': TingsColors.yellowLight,
    'beige': TingsColors.beige,
    'beigeStrong': TingsColors.beigeStrong,
    'beigeMedium': TingsColors.beigeMedium,
    'beigeLight': TingsColors.beigeLight,
    'orange': TingsColors.orange,
    'orangeStrong': TingsColors.orangeStrong,
    'orangeMedium': TingsColors.orangeMedium,
    'orangeLight': TingsColors.orangeLight,
    'red': TingsColors.red,
    'redStrong': TingsColors.redStrong,
    'redMedium': TingsColors.redMedium,
    'redLight': TingsColors.redLight,
    'blue': TingsColors.blue,
    'blueStrong': TingsColors.blueStrong,
    'blueMedium': TingsColors.blueMedium,
    'blueLight': TingsColors.blueLight,
    'green': TingsColors.green,
    'greenStrong': TingsColors.greenStrong,
    'greenMedium': TingsColors.greenMedium,
    'greenLight': TingsColors.greenLight,
  };

  static final Map<Color, Color> _backgroundColorTextColors = {
    TingsColors.black: TingsColors.white,
    TingsColors.white: TingsColors.black,
    TingsColors.grayLight: TingsColors.black,
    TingsColors.grayMedium: TingsColors.black,
    TingsColors.grayDark: TingsColors.black,
    TingsColors.yellow: TingsColors.black,
    TingsColors.green: TingsColors.white,
    TingsColors.beige: TingsColors.white,
    TingsColors.orange: TingsColors.white,
    TingsColors.red: TingsColors.white,
    TingsColors.blue: TingsColors.white,
  };
}
