import 'package:barberapp/src/themes/theme.dart';
import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:flutter/material.dart';

Widget drawerItem(String title, IconData icon, context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: getDeviceHeight(context) * 0.02),
    child: Row(
      children: [
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: getDeviceWidth(context) * 0.05),
          child: Icon(icon),
        ),
        Text(title,
            style:
                customTheme.primaryTextTheme.headline6.copyWith(fontSize: 20))
      ],
    ),
  );
}
