class Folder {
  final int fid;
  final String name;

  final int uid;

  Folder({
    required this.fid,
    required this.name,
    required this.uid,
  });
  factory Folder.fromJson(Map<String, dynamic> folder) {
    return Folder(
      fid: folder['fid'],
      name: folder['name'],
      uid: folder['uid'],
    );
  }
}
