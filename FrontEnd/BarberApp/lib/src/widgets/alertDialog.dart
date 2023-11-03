import 'package:barberapp/src/themes/theme.dart';
import 'package:flutter/material.dart';

Future<void> alertDialog(context, String title, int key) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: customTheme.primaryTextTheme.headline6,
          ),
          backgroundColor: customTheme.backgroundColor,
          actions: [
            FlatButton(
              textColor: customTheme.buttonColor,
              highlightColor: Colors.transparent,
              onPressed: () {
                print('teste');
              },
              child: Text("Cancelar Agendamento"),
            ),
            FlatButton(
              textColor: customTheme.buttonColor,
              highlightColor: Colors.transparent,
              child: Text("Voltar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
