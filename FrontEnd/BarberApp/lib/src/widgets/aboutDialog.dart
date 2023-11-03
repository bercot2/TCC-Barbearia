import 'package:barberapp/src/themes/theme.dart';
import 'package:flutter/material.dart';

Future<void> aboutDialog(context) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                "Aplicação feita por: \nBruno Mendes\n",
                style: customTheme.primaryTextTheme.bodyText1
                    .copyWith(fontSize: 20),
              ),
            ],
          ),
          backgroundColor: customTheme.backgroundColor,
          actions: [
            FlatButton(
              textColor: customTheme.buttonColor,
              highlightColor: Colors.transparent,
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
