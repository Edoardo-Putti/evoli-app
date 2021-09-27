import 'dart:convert';
import 'dart:io';
import 'package:evoli/models/user.dart';
import 'package:evoli/models/video.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const SERVER_IP = 'http://192.168.43.215:3000/video';

Future<List<Video>> _retriveVideo(User user) async {
  print('Called');
  final res = await http.post(Uri.parse("$SERVER_IP/retriveVideo"), headers: {
    "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    HttpHeaders.authorizationHeader: user.token,
  }, body: {
    "uid": user.uid,
  });
  if (res.statusCode == 200) {
    List jsonRes = jsonDecode(res.body);
    return jsonRes.map((video) => new Video.fromJson(video)).toList();
  } else
    throw Exception(jsonDecode(res.body)['error']['message']);
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<Video>> videos;

  @override
  void initState() {
    super.initState();
    videos = _retriveVideo(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Video>>(
        future: videos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Video> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Text(data[index].title),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 80,
                  height: 80,
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
