class Video {
  final String vid;
  final String title;
  final int duration;
  final String folder;
  final String url;
  final String uid;
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
        vid: video['data']['vid'],
        title: video['data']['title'],
        duration: video['data']['duration'],
        folder: video['data']['folder'],
        url: video['data']['url'],
        uid: video['data']['uid'],
        videoCode: video['videoCode']);
  }
}
