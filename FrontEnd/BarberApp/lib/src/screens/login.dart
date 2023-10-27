import 'package:barberapp/src/screens/SignUp.dart';
import 'package:barberapp/src/themes/theme.dart';
import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:barberapp/src/widgets/showLogo.dart';
import 'package:flutter/material.dart';

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
            Text('Faça seu login',
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
                                style: TextStyle(fontSize: 14)
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.black12
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
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  print('Teste');
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
                                      color: Color.fromRGBO(45, 87, 253, 1)
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
