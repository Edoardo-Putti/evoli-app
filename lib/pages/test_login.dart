import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../main.dart';

const SERVER_IP = 'http://192.168.1.167:5000';
final storage = FlutterSecureStorage();

class LoginForm extends StatelessWidget {
  //const LoginForm({Key? key}) : super(key: key);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<String> attemptLogIn(String username, String password) async {
    var res = await http.post(Uri.parse("$SERVER_IP/login"),
        body: {"email": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return 'fail';
  }

  Future<int> attemptSignUp(String username, String password) async {
    var res = await http.post(Uri.parse('$SERVER_IP/signup'),
        body: {"email": username, "password": password});
    return res.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey();

    return Theme(
      data: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        primaryColorDark: const Color(0xFF0097A7),
        primaryColorLight: const Color(0xFFB2EBF2),
        primaryColor: const Color(0xFF00BCD4),
        colorScheme: const ColorScheme.light(secondary: Color(0xFF009688)),
        scaffoldBackgroundColor: const Color(0xFFE0F2F1),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Log In",
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(245, 245, 245, 1),
              size: 50.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        key: _scaffoldKey,
        body: Align(
          alignment: const Alignment(0, -1 / 3),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/logo_512.png',
                  height: 120,
                  cacheHeight: 120,
                  cacheWidth: 120,
                ),

                const SizedBox(height: 40),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'email',
                    helperText: '',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                    onPressed: () async {
                      var username = _usernameController.text;
                      var password = _passwordController.text;
                      var jwt = await attemptLogIn(username, password);
                      if (jwt != null) {
                        storage.write(key: "jwt", value: jwt);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EvoliHome()));
                      } else {
                        displayDialog(context, "An Error Occurred",
                            "No account was found matching that username and password");
                      }
                    },
                    child: Text("Log In")),
                const SizedBox(height: 8),
                //_GoogleLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
