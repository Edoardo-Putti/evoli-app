class Video {
  String vid;
  String title;
  int duration;
  String folder;
  String url;
  String uid;
  String videoCode;
  Video(
      {required this.vid,
      required this.title,
      required this.duration,
      required this.folder,
      required this.url,
      required this.uid,
      required this.videoCode});
  factory Video.fromJson(Map<String, dynamic> video) => Video(
      vid: video['vid'],
      title: video['title'],
      duration: video['duration'],
      folder: video['folder'],
      url: video['url'],
      uid: video['uid'],
      videoCode: video['videoCode']);
  Map<String, dynamic> toJson() => {
        'vid': vid,
        'title': title,
        'duration': duration,
        'folder': folder,
        'url': url,
        'uid': uid,
        'videoCode': videoCode
      };
}
