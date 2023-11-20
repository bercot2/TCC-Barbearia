import 'package:barberapp/src/model/Servico.dart';
import 'package:barberapp/src/themes/theme.dart';
import 'package:flutter/material.dart';
import '../utils/globals.dart' as globals;

class ServicesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serviços'),
      ),
      backgroundColor: customTheme.backgroundColor,
      body: ListView.builder(
        itemCount: globals.servicos.length,
        itemBuilder: (context, index) {
          Servico servico = globals.servicos[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(servico.descricao, style: TextStyle(color: Colors.white)),
              trailing: Text('\R${servico.valor.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}
