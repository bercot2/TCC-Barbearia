import 'dart:convert';

import 'package:barberapp/src/model/Barber.dart';
import 'package:barberapp/src/model/Servico.dart';
import 'package:barberapp/src/model/User.dart';
import 'package:barberapp/src/screens/SignUp.dart';
import 'package:barberapp/src/screens/home.dart';
import 'package:barberapp/src/themes/theme.dart';
import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:barberapp/src/widgets/dialog.dart';
import 'package:barberapp/src/widgets/showLogo.dart';
import 'package:flutter/material.dart';
import '../utils/globals.dart' as globals;

class Login extends StatefulWidget {
  LoginState createState() => LoginState();
}

class LoginState extends State {
  final TextEditingController inputEmailController = TextEditingController();
  final TextEditingController inputPWController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey[50],
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: getDeviceWidth(context) * 0.60,
              child: appLogo,
            ),
            Text('Faça seu login',
              style: Theme.of(context).primaryTextTheme.headline6.copyWith(color: Colors.black)
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: inputEmailController,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Esta campo não pode estar vazio';
                          }
                          return null;
                        },
                        style: customTheme.primaryTextTheme.headline6,
                        //textAlign: TextAlign.start,
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
                          child: 
                            ElevatedButton(
                              child: Text(
                                "Entrar".toUpperCase(),
                                style: TextStyle(
                                  fontSize: customTheme.primaryTextTheme.button.fontSize
                                )
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  customTheme.buttonColor
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 15)
                                ),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white)
                                ),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide.none
                                  )
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (globals.barbers.isEmpty){
                                    var responseBarbers = await globals.request.get(url: 'http://localhost:8000/cadastros/funcionarios/');

                                    responseBarbers.forEach((barber) {
                                      Barber objbarber = Barber.fromJson(barber);

                                      globals.barbers.add(objbarber);
                                    });
                                  }

                                  if (globals.servicos.isEmpty){
                                    var responseServicos = await globals.request.get(url: 'http://localhost:8000/cadastros/servico/?e_ativo=true');

                                    responseServicos.forEach((servico) {
                                      Servico objServico = Servico.fromJson(servico);

                                      globals.servicos.add(objServico);
                                    });
                                  }

                                  var responseUser = await globals.request.get(url: 'http://localhost:8000/cadastros/clientes/' + '?email=' + inputEmailController.text);

                                  if (responseUser.isEmpty) {
                                    dialog(context, 'Erro', 'Usuário Incorreto');
                                  } else {
                                    User user = await User.fromJson(responseUser.first);

                                    globals.user = user;

                                    var json = {
                                      "email": user.email,
                                      "senha": inputPWController.text
                                    };

                                    var response = await globals.request.post(url: 'http://localhost:8000/cadastros/clientes/validar-senha/', body: json);

                                    Map<String, dynamic> responseAutentication = jsonDecode(response.body);

                                    if(responseAutentication['mensagem'] is String){
                                      dialog(context, 'Erro', 'Senha Incorreta');
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return Home();
                                        }),
                                      );
                                    }
                                  }
                                }
                              }
                            )
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
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.black12
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 20)
                              ),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(fontSize: 14, color: Colors.white)
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: const BorderSide(color: Color.fromRGBO(35, 33, 41, 1))
                                )
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.subdirectory_arrow_right,
                                    color: Color.fromRGBO(45, 87, 253, 1)),
                                Text(
                                  'Criar uma conta',
                                  style: TextStyle(
                                      color: Color.fromRGBO(45, 87, 253, 1),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return SignUp();
                                }),
                              );
                            }
                          )
                        ),
                      ],
                    )))
          ],
        )));
  }
}
