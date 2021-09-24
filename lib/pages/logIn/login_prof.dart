import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;

const SERVER_IP = 'http://192.168.43.215:3000/user';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<String> _authUser(LoginData data) async {
    var res = await http.post(Uri.parse("$SERVER_IP/signin"), headers: {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    }, body: {
      "email": data.name,
      "password": data.password
    });
    if (res.statusCode == 200)
      return res.body;
    else
      return 'fail';
  }

  Future<String> _signUp(LoginData data) async {
    var res = await http.post(Uri.parse('$SERVER_IP/signup'), headers: {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    }, body: {
      "email": data.name,
      "password": data.password
    });
    return res.body;
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
      theme: LoginTheme(
        //primaryColor: Colors.teal,
        titleStyle: TextStyle(
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
