import 'dart:convert';

import 'package:evoli/pages/professor/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:evoli/models/user.dart';

/*Remember to change ip with the politecnico's ip (ipconfig)*/
const SERVER_IP = 'http://192.168.1.113:3000/user';

class LoginProfessor extends StatefulWidget {
  const LoginProfessor({Key? key}) : super(key: key);

  @override
  _LoginProfessorState createState() => _LoginProfessorState();
}

class _LoginProfessorState extends State<LoginProfessor> {
  User _user = User(0, '', '', '');

  Future<String?> _authUser(LoginData data) async {
    var res = await http.post(Uri.parse("$SERVER_IP/signin"), headers: {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    }, body: {
      "email": data.name,
      "password": data.password
    });
    var decRes = jsonDecode(res.body);
    if (res.statusCode == 200) {
      _user.uid = decRes['userdata']['uid'] - 3;
      _user.email = decRes['userdata']['email'];
      _user.token = decRes['access_token'];
      _user.typology = 'professor';
      return null;
    } else
      return decRes['error']['message'];
  }

  Future<String?> _signUp(LoginData data) async {
    var res = await http.post(Uri.parse('$SERVER_IP/signup'), headers: {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    }, body: {
      "email": data.name,
      "password": data.password
    });
    var decRes = jsonDecode(res.body);
    if (res.statusCode == 201) {
      return null;
    } else {
      return decRes['error']['message'];
    }
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(Duration(seconds: 10)).then((_) {
      return 'User not exists';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'EVOLI',
      logo: 'images/logo_512.png',
      onSignup: _signUp,
      onLogin: _authUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Dashboard(user: _user),
        ));
      },
      messages: LoginMessages(
        recoverPasswordDescription:
            'Insert your email we will send you a mail to reset the password',
        flushbarTitleSuccess: 'Succes!',
      ),
      theme: LoginTheme(
        //primaryColor: Colors.teal,
        titleStyle: TextStyle(
          fontSize: 55,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(240, 200, 33, 1),
        ),
        cardTheme: CardTheme(
          //color: Color.fromRGBO(255, 193, 7, 1),
          elevation: 5,
          margin: EdgeInsets.only(top: 25),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(150.0)),
        ),
      ),
    );
  }
}
