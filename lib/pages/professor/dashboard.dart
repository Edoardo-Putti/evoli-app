import 'dart:convert';
import 'dart:io';
import 'package:evoli/models/folder.dart';
import 'package:evoli/models/user.dart';
import 'package:evoli/models/video.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const SERVER_IP = 'http://192.168.1.113:3000/video';
var currentFolder;

Future<List<dynamic>> _retriveFolders(User user) async {
  final res = await http.post(Uri.parse("$SERVER_IP/retriveFolder"), headers: {
    "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    HttpHeaders.authorizationHeader: user.token,
  }, body: {
    "uid": user.uid.toString(),
  });
  if (res.statusCode == 200) {
    var jsonRes = jsonDecode(res.body);
    print(jsonRes);
    currentFolder = jsonRes[0]['name'];
    print(currentFolder);
    return jsonRes.map((folder) => new Folder.fromJson(folder)).toList();
  } else
    throw Exception(jsonDecode(res.body)['error']['message']);
}

Future<List<dynamic>> _retriveVideo(User user) async {
  final res = await http.post(Uri.parse("$SERVER_IP/retriveVideo"), headers: {
    "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    HttpHeaders.authorizationHeader: user.token,
  }, body: {
    "uid": user.uid.toString(),
  });

  if (res.statusCode == 200) {
    var jsonRes = jsonDecode(res.body)['data'];
    currentFolder = jsonRes[0]['folder'];
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
  late Future<List<dynamic>> allVideos;
  late Future<List<dynamic>> folders;

  @override
  void initState() {
    super.initState();
    folders = _retriveFolders(widget.user);
    allVideos = _retriveVideo(widget.user);
    print(folders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F8),
      appBar: AppBar(
        title: Text(widget.user.email),
        centerTitle: true,
      ),
      drawer: Drawer(
        semanticLabel: 'FOLDER',
        child: ListView(
          children: [
            Container(
              height: 80,
              child: DrawerHeader(
                child: ListTile(
                  title: Text('folders'),
                  leading: Icon(Icons.folder),
                ),
                decoration: BoxDecoration(color: Colors.amber),
              ),
            ),
            FutureBuilder<List<dynamic>>(
              future: folders,
              builder: (context, snapshot) {
                List<dynamic> folders = snapshot.data!;
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(folders[index].name),
                          onTap: () => {
                            setState(() {
                              currentFolder = folders[index].name;
                            })
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: folders.length),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: allVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                if (data[index].folder.toLowerCase().replaceAll(' ', '') ==
                    currentFolder.toLowerCase().replaceAll(' ', '')) {
                  return Card(
                    child: Column(children: [
                      Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        textScaleFactor: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 8, bottom: 8),
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F3F8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                        ),
                      ),
                    ]),
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(150.0)),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            );
          } else if (snapshot.hasError) {
            print(snapshot);
            return Center(
                child: Text(
              "${snapshot.error}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red, fontSize: 24),
            ));
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
