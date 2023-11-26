import 'package:barberapp/src/model/Barber.dart';
import 'package:barberapp/src/model/Servico.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../utils/globals.dart' as globals;

class Agendamentos {
  
  int id;
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

  postAgendamento() async {
    Map<String, dynamic> json = {
        "data_hora_agendamento": DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(this.dataHoraAgendamento),
        "id_cliente": globals.user.id,
        "id_funcionario": this.barber.id,
        "id_servico": this.servico.id
    };

    var responsePost = await globals.request.post(url: "http://localhost:8000/cadastros/agendamento/", body: json);

    if (responsePost.body.isNotEmpty) {

      this.id = jsonDecode(responsePost.body)["id"];

      globals.user.agendamentos.add(this);

      return true;
    }

    return false;
  }
}