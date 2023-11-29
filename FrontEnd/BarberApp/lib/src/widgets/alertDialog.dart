import 'package:barberapp/src/screens/ScheduleList.dart';
import 'package:barberapp/src/themes/theme.dart';
import 'package:flutter/material.dart';
import '../utils/globals.dart' as globals;

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
              onPressed: () async {
                if (await globals.request.delete('http://127.0.0.1:8000/cadastros/agendamento/$key/')){
                  var agendamento = globals.user.agendamentos.firstWhere((element) => element.id == key);

                  globals.user.agendamentos.remove(agendamento);

                  Navigator.of(context).pop();

                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => ScheduleList(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );
                }
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
