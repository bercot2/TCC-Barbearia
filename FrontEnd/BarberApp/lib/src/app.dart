import 'package:barberapp/src/screens/login.dart';
import 'package:barberapp/src/themes/theme.dart';
import 'package:barberapp/src/utils/setNavStatusBar.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setSysColor(customTheme.primaryColor, customTheme.primaryColor);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      home: Login(),
    );
  }
}
