import 'package:barberapp/src/model/Agendamentos.dart';
import 'package:barberapp/src/model/Servico.dart';
import 'package:barberapp/src/screens/ScheduleList.dart';
import 'package:barberapp/src/utils/formatString.dart';
import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:barberapp/src/utils/showImageUser.dart';
import 'package:barberapp/src/widgets/dialog.dart';
import 'package:barberapp/src/widgets/miniCardBarber.dart';
import 'package:barberapp/src/widgets/miniCardService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/globals.dart' as globals;

class ScheduleEdit extends StatefulWidget {
  Agendamentos agendamento;

  ScheduleEdit(Agendamentos agendamento) {
    this.agendamento = agendamento;
  }

  ScheduleEditState createState() => new ScheduleEditState(this.agendamento);
}

class ScheduleEditState extends State<ScheduleEdit> {
  Agendamentos agendamento;
  Servico serviceSelected = null;
  List<TimeOfDay> timeSlots = [];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  ScheduleEditState(Agendamentos agendamento) {
    this.agendamento = agendamento;
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    var date = this.agendamento.dataHoraAgendamento.toLocal();

    serviceSelected = this.agendamento.servico;
    selectedDate = date;
    selectedTime = TimeOfDay(hour: date.hour, minute: date.minute);

    final result = await horariosAgendamentos(this.agendamento.barber.id);

    setState(() {
      timeSlots = result;
    });
  }

  Future<List<TimeOfDay>> horariosAgendamentos(int idBarber) async {
    List<TimeOfDay> timeSlots = [];

    String date = DateFormat('yyyy-MM-dd').format(this.selectedDate).toString();
    
    var responseHorarios = await globals.request.get(url: 'http://localhost:8000/cadastros/horarios-disponiveis/?id_agendamento=${this.agendamento.id}&id_funcionario=$idBarber&data_agendamento=$date');

    if (responseHorarios != null && responseHorarios.isNotEmpty) {
      responseHorarios.forEach((horario) {
        int hour, minute;

        List<String> time = horario.toString().split(':');
        
        hour = int.parse(time[0]);
        minute = int.parse(time[1]);

        timeSlots.add(TimeOfDay(hour: hour, minute: minute));
      });
    }

    return timeSlots;
  }

  selectDate(BuildContext context) async {

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        helpText: 'Selecione uma data',
        cancelText: 'Cancelar',
        confirmText: 'Confirmar',
        fieldLabelText: 'Insira uma data para o agendamento',
        fieldHintText: 'Dia/Mês/Ano',
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        selectedTime = null;

        horariosAgendamentos(this.agendamento.barber.id).then((result) {
          setState(() {
            timeSlots = result;
          });
        });
      });
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        toolbarHeight: getDeviceHeight(context) * 0.10,
        centerTitle: true,
        title: Text('Edição de Agendamento', style: Theme.of(context).primaryTextTheme.headline5),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: getDeviceWidth(context) * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: getDeviceWidth(context) * 0.04),
                alignment: Alignment.topLeft,
                child: Text('Com o(a) Cabelereiro(a): ', style: Theme.of(context).primaryTextTheme.headline6),
              ),
              miniCardBarber(this.agendamento.barber.nome, IconPessoa, context),
              Container(
                padding: EdgeInsets.symmetric(vertical: getDeviceHeight(context) * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //SERVICO
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text('Serviço: ', style: Theme.of(context).primaryTextTheme.headline6),
                            ),
                            miniCardService(
                              context, 
                              serviceSelected, 
                              (service) {
                                setState(() {
                                  serviceSelected = service;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    //DATEPICKER
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Na data: ', style: Theme.of(context).primaryTextTheme.headline6),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: getDeviceHeight(context) * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDate(selectedDate),
                                  style: Theme.of(context).primaryTextTheme.headline6,
                                ),
                                RaisedButton(
                                  padding: EdgeInsets.all(10),
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  onPressed: () => selectDate(context),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Selecione uma data ',
                                        style: Theme.of(context).primaryTextTheme.button,
                                      ),
                                      Icon(Icons.calendar_today),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //TIMEPICKER
                    Padding(
                      padding: const EdgeInsets.only(top: 18, bottom: 18),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text('No horário: ', style: Theme.of(context).primaryTextTheme.headline6),
                            ),
                            NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                // Interceptar e permitir que o SingleChildScroll View gerencie o scroll
                                return true;
                              },
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                  childAspectRatio: 2.0,
                                ),
                                itemCount: timeSlots.length,
                                itemBuilder: (context, index) {
                                  TimeOfDay time = timeSlots[index];
                                  String formattedTime = '${time.hour}:${time.minute.toString().padLeft(2, '0')}';

                                  return GestureDetector(
                                    // color: Colors.transparent
                                    onTap: () {
                                      setState(() {
                                        selectedTime = time;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: selectedTime == time ? Colors.blue : Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                        color: selectedTime == time ? Colors.blue.withOpacity(0.3) : null,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        formattedTime,
                                        style: TextStyle(color: Colors.white)
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: getDeviceWidth(context) * 0.04),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              onPressed: () async {
                                DateTime dataAgendada = DateTime(
                                  this.selectedDate.year,
                                  this.selectedDate.month,
                                  this.selectedDate.day,
                                  this.selectedTime.hour,
                                  this.selectedTime.minute
                                );

                                var agendamento = globals.user.agendamentos.firstWhere((agendamento) => agendamento == this.agendamento);

                                agendamento.dataHoraAgendamento = dataAgendada;
                                agendamento.servico = serviceSelected;

                                if (await agendamento.putAgendamento()) {
                                  dialog(context, "Aviso", "Agendamento Alterado!", onPressed: (){
                                    Navigator.of(context).pop();
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
                                  });
                                } else {
                                  dialog(context, "Erro", "Ocorreu algum Erro, tente novamente!");
                                }
                              },
                              child: Text(
                                'Concluir Edição do Agendamento',
                                style: Theme.of(context).primaryTextTheme.button,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
