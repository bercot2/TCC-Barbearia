import 'package:barberapp/src/model/Agendamentos.dart';
import '../utils/globals.dart' as globals;

class User {
  final int id;
  final String nome;
  final DateTime dataNascimento;
  final String email;
  final String cpf;
  final String telefone;
  final String password;
  final List<Agendamentos> agendamentos;

  User({
    this.id,
    this.nome,
    this.dataNascimento,
    this.cpf,
    this.email,
    this.telefone,
    this.password,
    this.agendamentos,
  });

  static Future<User> fromJson(Map<String, dynamic> json) async {
    var id = json["id"];
    List<Agendamentos> listaAgendamentos = [];

    dynamic responseAgendamentos = await globals.request.get(url: 'http://localhost:8000/cadastros/agendamento/?id_cliente=${id}');

    (responseAgendamentos as List).forEach((agendamento) {
      Agendamentos objAgendamento = Agendamentos.fromJson(agendamento);
      listaAgendamentos.add(objAgendamento);
    });

    User user = User(
      id: id,
      nome: json["nome"],
      dataNascimento: DateTime.parse(json["data_nascimento"]),
      cpf: json["cpf"],
      email: json["email"],
      telefone: json["telefone"],
      password: json["senha"],
      agendamentos: listaAgendamentos,
    );

    return user;
  }
}
