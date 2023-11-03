import 'package:flutter/material.dart';

Future<void> dialog(
  context, 
  title,
  text, 
  {void Function() onPressed}
) async {
  onPressed ??= () {
    Navigator.of(context).pop();
  };

  return showDialog<void>(
    context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: onPressed
            ),
          ],
        );
      }
  );
}
