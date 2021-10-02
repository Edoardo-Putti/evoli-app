class Video {
  final int vid;
  final String title;
  final int duration;
  final String folder;
  final String url;
  final int uid;
  final String videoCode;
  Video(
      {required this.vid,
      required this.title,
      required this.duration,
      required this.folder,
      required this.url,
      required this.uid,
      required this.videoCode});
  factory Video.fromJson(Map<String, dynamic> video) {
    return Video(
        vid: video['vid'],
        title: video['title'],
        duration: video['duration'],
        folder: video['folder'],
        url: video['url'],
        uid: video['uid'],
        videoCode: video['video_code']);
  }
}
