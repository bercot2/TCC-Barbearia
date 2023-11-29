import 'package:barberapp/src/model/Agendamentos.dart';
import 'package:barberapp/src/model/Barber.dart';
import 'package:barberapp/src/model/Servico.dart';
import 'package:barberapp/src/screens/home.dart';
import 'package:barberapp/src/utils/formatString.dart';
import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:barberapp/src/utils/showImageUser.dart';
import 'package:barberapp/src/widgets/dialog.dart';
import 'package:barberapp/src/widgets/miniCardBarber.dart';
import 'package:barberapp/src/widgets/miniCardService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/globals.dart' as globals;

class SchedulePage extends StatefulWidget {
  Barber barberInfo;

  SchedulePage(Barber barber) {
    this.barberInfo = barber;
  }

  ScheduleState createState() => new ScheduleState(barberInfo);
}

class ScheduleState extends State<SchedulePage> {

  Barber barberInfo;
  Servico serviceSelected = null;

  List<TimeOfDay> timeSlots = [];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = null;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  ScheduleState(Barber barber) {
    this.barberInfo = barber;
  }

  Future<void> initializeData() async {
    barberInfo = widget.barberInfo;
    selectedDate = DateTime.now();

    final result = await horariosAgendamentos(barberInfo.id);

    setState(() {
      timeSlots = result;
    });
  }

  Future<List<TimeOfDay>> horariosAgendamentos(int idBarber) async {
    List<TimeOfDay> timeSlots = [];

    String date = DateFormat('yyyy-MM-dd').format(this.selectedDate).toString();
    
    var responseHorarios = await globals.request.get(url: 'http://localhost:8000/cadastros/horarios-disponiveis/?id_funcionario=$idBarber&data_agendamento=$date');

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
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
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
      }
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        selectedTime = null;

        horariosAgendamentos(this.barberInfo.id).then((result) {
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
        title: Text('Agendamento', style: Theme.of(context).primaryTextTheme.headline5),
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
              miniCardBarber(barberInfo.nome, IconPessoa, context),
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
                                  formatDate(selectedDate ?? DateTime.now()),
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
                            GridView.builder(
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
                          ],
                        ),
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: getDeviceWidth(context) * 0.04),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        onPressed: () async {
                          if (serviceSelected == null){
                            dialog(context, "Aviso", "Selecione um Serviço!");

                            return;
                          }

                          if (selectedTime == null){
                            dialog(context, "Aviso", "Selecione um Horário!");

                            return;
                          }

                          DateTime dataAgendada = DateTime(
                            this.selectedDate.year,
                            this.selectedDate.month,
                            this.selectedDate.day,
                            this.selectedTime.hour,
                            this.selectedTime.minute
                          );

                          Agendamentos agendamento = new Agendamentos(dataHoraAgendamento: dataAgendada, barber: this.barberInfo, servico: this.serviceSelected);

                          if (await agendamento.postAgendamento()) {
                            dialog(context, "Aviso", "Agendamento Realizado!", onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }),
                              );
                            });
                          } else {
                            dialog(context, "Erro", "Ocorreu algum Erro, tente novamente!");
                          }
                        },
                        child: Text(
                          'Concluir agendamento',
                          style: Theme.of(context).primaryTextTheme.button,
                        ),
                      ),
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
