import 'package:barberapp/src/model/Barber.dart';
import 'package:barberapp/src/model/Servico.dart';
import '../utils/globals.dart' as globals;

class Agendamentos {
  
  final int id;
  final DateTime dataHoraAgendamento;
  final Barber barber;
  final Servico servico;

  Agendamentos({this.id, this.dataHoraAgendamento, this.barber, this.servico});

  factory Agendamentos.fromJson(Map<String, dynamic> json){

    Barber barber = globals.barbers.firstWhere((barber) => barber.id == json["id_funcionario"]);
    Servico servico = globals.servicos.firstWhere((servico) => servico.id == json["id_servico"]);

    Agendamentos user = Agendamentos(
      id: json["id"],
      dataHoraAgendamento: DateTime.parse(json["data_hora_agendamento"]),
      barber: barber,
      servico: servico
    );

    return user;
  }
}