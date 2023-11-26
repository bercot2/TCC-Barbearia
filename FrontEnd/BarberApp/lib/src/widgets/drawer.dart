import 'package:barberapp/src/screens/ScheduleList.dart';
import 'package:barberapp/src/screens/ServicesList.dart';
import 'package:barberapp/src/screens/login.dart';
import 'package:barberapp/src/themes/theme.dart';
import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:barberapp/src/widgets/aboutDialog.dart';
import 'package:barberapp/src/widgets/drawerItem.dart';
import 'package:barberapp/src/widgets/showLogo.dart';
import 'package:flutter/material.dart';
import '../utils/globals.dart' as globals;

Widget sideMenu(context) {
  return Drawer(
      child: Container(
    color: customTheme.backgroundColor,
    child: ListView(
      children: [
        DrawerHeader(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: SizedBox(
              width: getDeviceWidth(context) * 0.70,
              child: appLogo,
            ),
          ),
        ),
        ListTile(
          title: drawerItem('Serviços', Icons.content_cut_outlined, context),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return new ServicesList();
            }));
          },
        ),
        ListTile(
          title: drawerItem('Meus Horários', Icons.calendar_today, context),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return new ScheduleList();
            }));
          },
        ),
        ListTile(
          title: drawerItem('Meus Dados', Icons.account_circle_outlined, context),
          onTap: () {
            Navigator.of(context).pop();
            aboutDialog(context);
          }
        ),
        ListTile(
          title: drawerItem('Sobre', Icons.info_outline, context),
          onTap: () {
            Navigator.of(context).pop();
            aboutDialog(context);
          }
        ),
        ListTile(
          title: drawerItem('Sair', Icons.exit_to_app, context),
          onTap: () {
            globals.barbers.clear();
            globals.servicos.clear();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Login();
              }),
            );
          }
        )
      ],
    ),
  ));
}
