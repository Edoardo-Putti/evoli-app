import 'package:flutter/material.dart';

void main() {
  runApp(EvoliHome());
}

class EvoliHome extends StatelessWidget {
  const EvoliHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evoli app',
      theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(36, 61, 112, 1)),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(36, 61, 112, 1),
          actions: <Widget>[
            Image.asset(
              'images/logo.png',
              scale: 0.1,
              height: 100.0,
              width: 100.0,
            ),
          ],
          //title: const Text('EVOLI'),
          toolbarHeight: 120.0,
        ),
        body: Container(
          child: Column(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  clipBehavior: Clip.hardEdge,
                  child: Text.rich(
                    TextSpan(
                      text: 'Welcome to',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 38.0,
                          color: Color.fromRGBO(245, 245, 245, 1)),
                      children: [
                        TextSpan(
                            text: ' EVOLI \n',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 193, 7, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 45.0)),
                        TextSpan(
                          text:
                              '\nA video-tagging tool to collect students\' feedback',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Color.fromRGBO(245, 245, 245, 1),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          overlayColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(255, 193, 7, 1)),
                        ),
                        onPressed: () {},
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              'Student',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                                color: Color.fromRGBO(245, 245, 245, 1),
                              ),
                            ),
                          ),
                          Image.asset(
                            'images/student_512.png',
                            fit: BoxFit.fill,
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          overlayColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(255, 193, 7, 1)),
                        ),
                        onPressed: () {},
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              'Teacher',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                                color: Color.fromRGBO(245, 245, 245, 1),
                              ),
                            ),
                          ),
                          Image.asset(
                            'images/teacher_512.png',
                            fit: BoxFit.fill,
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
