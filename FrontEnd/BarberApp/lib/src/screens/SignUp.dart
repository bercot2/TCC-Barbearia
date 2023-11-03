import 'package:barberapp/src/screens/login.dart';
import 'package:barberapp/src/themes/theme.dart';
import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:barberapp/src/widgets/dialog.dart';
import 'package:barberapp/src/widgets/inputDate.dart';
import 'package:barberapp/src/widgets/showLogo.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../utils/globals.dart' as globals;

class SignUp extends StatefulWidget {
  SignUpState createState() => SignUpState();
}

class SignUpState extends State {
  final TextEditingController inputEmailController = TextEditingController();
  final TextEditingController inputNameController = TextEditingController();
  final TextEditingController inputDateController = TextEditingController();
  final TextEditingController inputCpfController = TextEditingController();
  final TextEditingController inputTelefoneController = TextEditingController();
  final TextEditingController inputPWController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime selectedDate;

  String getData() {
    List<String> partes = inputDateController.text.split('/');
    int dia = int.parse(partes[0]);
    int mes = int.parse(partes[1]);
    int ano = int.parse(partes[2]);

    DateTime data = DateTime(ano, mes, dia);
    String novaData = "${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}";

    return novaData;
  }

  void _onDateSelected(DateTime date) {

    setState(() {
      selectedDate = date;
      inputDateController.text = "${date.day}/${date.month}/${date.year}";
    });
  }

  var maskFormatterCPF = MaskTextInputFormatter(
    mask: '###.###.###-##', // A máscara do CPF
    filter: {"#": RegExp(r'[0-9]')}, // O filtro para aceitar apenas números
  );

  var maskFormatterPhone = MaskTextInputFormatter(
    mask: '(##) # ####-####', // A máscara do CPF
    filter: {"#": RegExp(r'[0-9]')}, // O filtro para aceitar apenas números
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black38, //Theme.of(context).backgroundColor,
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: getDeviceWidth(context) * 0.60,
              child: appLogo,
            ),
            Text('Crie sua Conta',
                style: Theme.of(context).primaryTextTheme.headline6),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: inputNameController,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Esta campo não pode estar vazio';
                          }
                          return null;
                        },
                        style: customTheme.primaryTextTheme.headline6,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline,
                              color: customTheme.iconTheme.color),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'Nome',
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none),
                          fillColor: Color.fromRGBO(35, 33, 41, 1),
                          filled: true,
                        ),
                      ),
                    ),
                    inputData(inputDateController, context, selectedDate, _onDateSelected),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number, // Especifica o tipo de teclado como numérico
                        controller: inputCpfController,
                        inputFormatters: [maskFormatterCPF], // Adiciona o formatter
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Este campo não pode estar vazio';
                          }
                          return null;
                        },
                        style: customTheme.primaryTextTheme.headline6,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline,
                              color: customTheme.iconTheme.color),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'CPF',
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none),
                          fillColor: Color.fromRGBO(35, 33, 41, 1),
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: inputEmailController,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Esta campo não pode estar vazio';
                          }
                          if (!value.contains('@')) {
                            return 'Insira um email válido';
                          }

                          return null;
                        },
                        style: customTheme.primaryTextTheme.headline6,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline,
                              color: customTheme.iconTheme.color),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'E-mail',
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none),
                          fillColor: Color.fromRGBO(35, 33, 41, 1),
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: inputTelefoneController,
                        inputFormatters: [maskFormatterPhone],
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'Telefone',
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color.fromRGBO(35, 33, 41, 1),
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        obscureText: true,
                        controller: inputPWController,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Esta campo não pode estar vazio';
                          }
                          return null;
                        },
                        style: customTheme.primaryTextTheme.headline6,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.lock_outline, color: Colors.white),
                          hintStyle:
                              TextStyle(color: customTheme.iconTheme.color),
                          hintText: 'Senha',
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none),
                          fillColor: Color.fromRGBO(35, 33, 41, 1),
                          filled: true,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none),
                            child: Text('Cadastrar',
                              style: TextStyle(
                                fontSize: customTheme.primaryTextTheme.button.fontSize,
                                color: Colors.white
                              )
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var jsonPost = {
                                  "nome": inputNameController.text,
                                  "data_nascimento": getData(),
                                  "cpf": inputCpfController.text,
                                  "email": inputEmailController.text,
                                  "telefone": inputTelefoneController.text,
                                  "senha": inputPWController.text
                                };

                                var response = await globals.request.post(url: 'http://localhost:8000/cadastros/clientes/', body: jsonPost);

                                if (response.statusCode == 201){
                                  dialog(context, 'Aviso', 'Usuário Cadastrado', onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return Login();
                                      }),
                                    );
                                  });
                                } else {
                                  dialog(context, 'Erro', 'Ocorreu um Erro, Tente Novamente!');
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                            child: RaisedButton(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                color: Colors.black12,
                                shape: Border(
                                    top: BorderSide(
                                        color: Color.fromRGBO(35, 33, 41, 1))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_back,
                                        color: Color.fromRGBO(45, 87, 253, 1)),
                                    Text(
                                      'Voltar para o login',
                                      style: TextStyle(
                                          color: Color.fromRGBO(45, 87, 253, 1),
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                })),
                      ],
                    )))
          ],
        )));
  }
}
