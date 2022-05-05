import 'package:flutter/material.dart';

// ThemeData GenerateTheme(){
//   ThemeData myTheme = ThemeData(
//     primarySwatch: Colors.purple,
//     colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange,primary: Colors.purple)
//   );
//   myTheme.copyWith(
//     colorScheme: myTheme.colorScheme.copyWith(secondary: Colors.deepOrange)
//   );
//   return myTheme;
// }
ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.deepOrange, primary: Colors.purple),
  fontFamily: 'Lato',
);
