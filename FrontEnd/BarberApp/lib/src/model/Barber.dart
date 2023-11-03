import 'dart:convert';

import 'package:barberapp/src/utils/showImageUser.dart';
import 'package:flutter/cupertino.dart';

class Barber {

  final int id;
  final String nome;
  final String telefone;
  final String email;
  final String diasDisponiveis;
  final String horariosDisponiveis;
  final AssetImage avatarUrl = IconPessoa;

  Barber({this.id, this.nome,this.email, this.telefone, this.diasDisponiveis, this.horariosDisponiveis});

  factory Barber.fromJson(Map<String, dynamic> json){
    List<dynamic> contatosList = json["contatos"];

    String emailFuncionario = contatosList.map((element) => element["email"]).toList().join(', ');
    String telefoneFuncionario = contatosList.map((element) => element["telefone"]).join(', ');

    Barber user = Barber(
      id: json["id"],
      nome: json["nome"],
      email: emailFuncionario,
      telefone: telefoneFuncionario,
      diasDisponiveis: json["dias_disponiveis"],
      horariosDisponiveis: json["horarios_disponiveis"]
    );

    return user;
  }

}
