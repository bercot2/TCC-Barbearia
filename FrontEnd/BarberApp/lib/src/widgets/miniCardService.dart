import 'package:barberapp/src/model/Servico.dart';
import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:flutter/material.dart';
import '../utils/globals.dart' as globals;

miniCardService(
  BuildContext context,
  Servico serviceSelected,
  Function(Servico) onServiceSelected
) {

  Future<Servico> showServiceDialog(BuildContext context) async {
    return showDialog<Servico>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione um Serviço'),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              itemCount: globals.servicos.length,
              separatorBuilder: (context, index) => Divider(), // Adiciona um divisor entre os itens
              itemBuilder: (context, index) {
                Servico servico = globals.servicos[index];
                return ListTile(
                  title: Text(servico.descricao),
                  onTap: () {
                    Navigator.of(context).pop(servico); // Retorna o serviço selecionado quando pressionado
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  return InkWell(
    onTap: () async {
      Servico result = await showServiceDialog(context);
      
      if (result != null) {
        onServiceSelected(result);
      }
    },
    child: Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
      child: Container(
        height: getDeviceHeight(context) * 0.08,
        width: getDeviceWidth(context) * 0.50,
        padding: EdgeInsets.symmetric(
            horizontal: getDeviceWidth(context) * 0.03,
            vertical: getDeviceHeight(context) * 0.01),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    serviceSelected?.descricao ?? "Selecione o Serviço",
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
