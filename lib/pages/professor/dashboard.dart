import 'dart:convert';
import 'package:evoli/models/user.dart';
import 'package:evoli/models/video.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const SERVER_IP = 'http://192.168.43.215:3000/video';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<Video>> _retriveVideo(User user) async {
    print('Called');
    var res = await http.post(Uri.parse("$SERVER_IP/retriveVideo"), headers: {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    }, body: {
      "uid": user.uid,
    });
    if (res.statusCode == 200) {
      final parsed = json.decode(res.body).cast<Map<String, dynamic>>();
      print(parsed.map<Video>((item) => Video.fromJson(item)).toList());
      return parsed.map<Video>((item) => Video.fromJson(item)).toList();
    } else
      throw Exception(jsonDecode(res.body)['error']['message']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Video>>(
        future: _retriveVideo(widget.user),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  return Card(
                      child: ListTile(
                    title: Text(snapshot.data?[i].title),
                  ));
                });
          } else if (snapshot.hasError) {}
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
