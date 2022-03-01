import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:area/constants.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = pf5;
  static const Color loginGradientEnd = pc5;

  static const primaryGradient = LinearGradient(
    colors: [loginGradientStart, loginGradientEnd],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}