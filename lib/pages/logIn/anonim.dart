import 'package:flutter/material.dart';
import 'package:evoli/background/background.dart';
import 'package:english_words/english_words.dart';

class Anonim extends StatefulWidget {
  const Anonim({Key? key}) : super(key: key);

  @override
  _AnonimState createState() => _AnonimState();
}

class _AnonimState extends State<Anonim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Card(
                    color: Colors.white30,
                    child: Row(
                      children: [Text(WordPair.random().asPascalCase)],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
