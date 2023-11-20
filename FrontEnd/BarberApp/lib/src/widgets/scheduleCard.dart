import 'package:barberapp/src/model/Agendamentos.dart';
import 'package:barberapp/src/screens/ScheduleEdit.dart';
import 'package:barberapp/src/themes/theme.dart';
import 'package:barberapp/src/widgets/alertDialog.dart';
import 'package:flutter/material.dart';

Widget scheduleCard(Agendamentos agendamento, context) {
  return Card(
    color: customTheme.cardColor,
    child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return new ScheduleEdit(agendamento);
            }),
          );
        },
        enabled: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nº ${agendamento.id}', style: TextStyle(color: Colors.white)),
            Text('Dia: ${agendamento.dataHoraAgendamento.day} às ${agendamento.dataHoraAgendamento.hour}:${agendamento.dataHoraAgendamento.minute}',
                style: TextStyle(color: Colors.white)),
          ],
        ),
        subtitle: Text('Com: ${agendamento.barber.nome}',
            style: TextStyle(color: Colors.white)),
        trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              alertDialog(context, 'Deseja realmente cancelar o agendamento?', agendamento.id);
            })),
  );
}
