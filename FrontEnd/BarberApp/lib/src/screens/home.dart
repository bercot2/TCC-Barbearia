import 'package:barberapp/src/themes/theme.dart';
import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:barberapp/src/utils/setNavStatusBar.dart';
import 'package:barberapp/src/widgets/barberCard.dart';
import 'package:barberapp/src/widgets/drawer.dart';
import 'package:flutter/material.dart';
import '../utils/globals.dart' as globals;

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    List<Widget> cardsBarbeiros = [];
    
    setSysColor(customTheme.backgroundColor, customTheme.primaryColor);

    globals.barbers.forEach((barber) {
      cardsBarbeiros.add(barberCard(context, barber));
    });

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: sideMenu(context),
        appBar: AppBar(
            toolbarHeight: getDeviceHeight(context) * 0.10,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bem vindo,',
                    style: Theme.of(context).primaryTextTheme.headline6),
                Text('${globals.user.nome}',
                    style:
                        Theme.of(context).primaryTextTheme.headline6.copyWith(
                              color: Color.fromRGBO(45, 87, 253, 1),
                            )),
              ],
            )),
        body: Container(
            margin: EdgeInsets.symmetric(
                horizontal: getDeviceWidth(context) * 0.05),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: getDeviceHeight(context) * 0.03),
                    alignment: Alignment.topLeft,
                    child: Text('Cabeleireiros',
                        style: Theme.of(context).primaryTextTheme.headline5)
                ),
                Container(
                    margin: EdgeInsets.only(
                        bottom: getDeviceHeight(context) * 0.03),
                    alignment: Alignment.topLeft,
                    child: Text(
                        'Selecione um cabelereiro abaixo para agendar um atendimento:',
                        style: Theme.of(context).primaryTextTheme.headline6)
                ),
                ...cardsBarbeiros
              ],
            )));
  }
}
