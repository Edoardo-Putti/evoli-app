import 'package:evoli/pages/test_login.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/logStud.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Evoli app',
      // theme: ThemeData(
      //   scaffoldBackgroundColor: Color.fromRGBO(36, 61, 112, 1),
      //   fontFamily: 'Poppins',
      //   primaryColor: Colors.white,
      //   floatingActionButtonTheme: FloatingActionButtonThemeData(
      //     elevation: 0,
      //     foregroundColor: Colors.white,
      //   ),
      //   accentColor: Colors.redAccent,
      //   textTheme: TextTheme(
      //     headline1: TextStyle(fontSize: 22.0, color: Colors.redAccent),
      //     headline2: TextStyle(
      //       fontSize: 24.0,
      //       fontWeight: FontWeight.w700,
      //       color: Colors.redAccent,
      //     ),
      //     bodyText1: TextStyle(
      //       fontSize: 14.0,
      //       fontWeight: FontWeight.w400,
      //       color: Colors.blueAccent,
      //     ),
      //   ),
      // ),
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(36, 61, 112, 1),
      ),
      home: EvoliHome(),
    ),
  );
}

class EvoliHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromRGBO(13, 39, 95, 1),
              const Color.fromRGBO(30, 83, 197, 1),
            ],
            stops: [0.1, 1.0],
            tileMode: TileMode.repeated),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent, //Color.fromRGBO(36, 61, 112, 1),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Color.fromRGBO(245, 245, 245, 1),
              size: MediaQuery.of(context).size.width * 0.1,
            ),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          actions: <Widget>[
            Image.asset(
              'images/logo.png',
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
          //title: const Text('EVOLI'),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        body: Container(
          child: Column(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 0),
                child: Text.rich(
                  TextSpan(
                    text: 'Welcome to',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.15,
                        color: Color.fromRGBO(245, 245, 245, 1)),
                    children: [
                      TextSpan(
                        text: ' EVOLI \n',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 193, 7, 1),
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width * 0.23,
                        ),
                      ),
                      // TextSpan(
                      //   text:
                      //       '\nA video-tagging tool to collect\n students\' feedback',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: MediaQuery.of(context).size.width * 0.075,
                      //     color: Color.fromRGBO(245, 245, 245, 1),
                      //   ),
                      // ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext contex) => LoginForm(),
                          ),
                        ),
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
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext contex) => Login(),
                          ),
                        ),
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
            children: [
              Container(
                height: 120.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(36, 61, 112, 1),
                  ),
                  child: Text(
                    'HOME',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.import_contacts),
                title: Text('Instruction'),
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About'),
              ),
              ListTile(
                leading: Icon(Icons.alternate_email),
                title: Text('Credits'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
