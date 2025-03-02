import 'package:flutter/material.dart';

/// #FFFFF9D2
const bgPrimaryColor = Color(0xFFFFF9D2);

/// #8EACCD
const actionPrimaryColor = Color(0xFF8EACCD);

const textColorWhite = Colors.white;

const fontSizeHeadingMedium = 18.0;
const fontSizeHeadingSmall = 16.0;
const fontSizeBodySmall = 13.0;
const fontSizeBodyMedium = 14.0;
const fontSizeBodyLarge = 16.0;
const fontSizeCaptionMd = 12.0;
const fontSizeCaptionSmall = 10.0;
const fontSizeTitleLg = 24.0;

TextStyle textStyleTitleLg = TextStyle(
  fontSize: fontSizeTitleLg,
  fontWeight: FontWeight.bold,
);

TextStyle textStyleHeadingMedium = TextStyle(
  fontSize: fontSizeHeadingMedium,
  fontWeight: FontWeight.bold,
  height: 1,
);

TextStyle textStyleHeadingSmall = TextStyle(
  fontSize: fontSizeHeadingSmall,
  fontWeight: FontWeight.w600,
);

TextStyle textStyleBodySmall = TextStyle(
  fontSize: fontSizeBodySmall,
  fontWeight: FontWeight.w400,
);

TextStyle textStyleBodyMedium = TextStyle(
  fontSize: fontSizeBodyMedium,
  fontWeight: FontWeight.w400,
);

TextStyle textStyleBodyLarge = TextStyle(
  fontSize: fontSizeBodyLarge,
  fontWeight: FontWeight.w400,
);

TextStyle textStyleCaptionMd = TextStyle(
  fontSize: fontSizeCaptionMd,
);
TextStyle textStyleCaptionSmall = TextStyle(
  fontSize: fontSizeCaptionSmall,
  fontWeight: FontWeight.bold,
  height: 1,
);

/// #8EACCD primary color
Color colorPrimary = const Color(0xFF8EACCD);
Color colorPrimaryDark = const Color(0xFF637386);

Color bgColorSecondary = const Color(0xFF8EACCD);

Color colorSecondary = const Color(0xFFEBBA8D);
Color colorSecondaryDark = const Color(0xFFB7804E);

Color colorTertiary = const Color(0xFFDEE5D4);
Color colorTertiaryDark = const Color(0xFF859372);

Color colorBlack = const Color(0xFF160D08);
Color colorWhite = const Color(0xFFFFFFFF);

Color colorTextDisabled = const Color(0xFFA1AEB1);

BoxShadow buttonShadowDefault = BoxShadow(
  color: colorBlack.withAlpha(90),
  blurRadius: 10,
  offset: Offset(0, 10),
);
