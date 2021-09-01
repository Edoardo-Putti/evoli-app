import 'package:flutter/material.dart';

class HomeStud extends StatelessWidget {
  const HomeStud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey();
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Student Home",
            style: TextStyle(fontSize: 30.0),
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
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        builder: (BuildContext contex) => HomeStud(),
                      ),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          'Log-in',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                            color: Color.fromRGBO(245, 245, 245, 1),
                          ),
                        ),
                      ),
                      Image.asset(
                        'images/read.png',
                        fit: BoxFit.fill,
                        scale: 2.5,
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        builder: (BuildContext contex) => HomeStud(),
                      ),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          'Incognito',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                            color: Color.fromRGBO(245, 245, 245, 1),
                          ),
                        ),
                      ),
                      Image.asset(
                        'images/hacker.png',
                        fit: BoxFit.fill,
                        scale: 2.5,
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
