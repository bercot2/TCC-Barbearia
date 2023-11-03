import 'package:barberapp/src/themes/theme.dart';
import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:barberapp/src/widgets/scheduleCard.dart';
import 'package:flutter/material.dart';
import '../utils/globals.dart' as globals;

class ScheduleList extends StatefulWidget {
  ScheduleListState createState() => new ScheduleListState();
}

class ScheduleListState extends State<ScheduleList> {

  @override
  Widget build(BuildContext context) {
    List<Widget> scheduleCards = [];

    globals.user.agendamentos.forEach((agendamento) {
       scheduleCards.add(scheduleCard(agendamento, context));
    });

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: getDeviceHeight(context) * 0.10,
          centerTitle: true,
          title: Text('Agendamentos',
              style: Theme.of(context).primaryTextTheme.headline5),
        ),
        backgroundColor: customTheme.backgroundColor,
        body: Column(
          children: scheduleCards,
        ));
  }
}
