import 'package:flutter/material.dart';
import 'helpers/custom_route.dart';

ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.deepOrange, primary: Colors.purple),
  fontFamily: 'Lato',
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: CustomPageTransitionBuilder(),
    TargetPlatform.iOS: CustomPageTransitionBuilder()
  }),
);
