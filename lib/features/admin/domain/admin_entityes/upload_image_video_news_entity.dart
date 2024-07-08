class UploadImageAndVideoEntity {
  int? id;
  String ?uID;
  String ?url;
  String? type;
  String? path;
  String ?newsTitle;
  String ?newsSubTitle;
  String? createdAt;

  UploadImageAndVideoEntity(
      {required this.id,
      required this.uID,
      required this.url,
      required this.type,
      required this.path,
      required this.newsTitle,
      required this.newsSubTitle,
       this.createdAt , 
    });

  factory UploadImageAndVideoEntity.fromMap(Map<String, dynamic> map) {
    return UploadImageAndVideoEntity(
      id: map['id'],
      uID: map['uID'],
      url: map['url'],
      type: map['type'],
      path: map['path'],
      newsTitle: map['newsTitle'],
      newsSubTitle: map['newsSubTitle'], 
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uID': uID,
      'url': url,
      'type': type,
      'path': path,
      'newsTitle': newsTitle,
      'newsSubTitle': newsSubTitle,
      'createdAt': createdAt,
    };
  }

  factory UploadImageAndVideoEntity.fromLocalMap(Map<String, dynamic> map) {
    return UploadImageAndVideoEntity(
      id: map['id'],
      uID: map['uID'],
      url: map['url'],
      type: map['type'],
      path: map['path'],
      newsTitle: map['newsTitle'],
      newsSubTitle: map['newsSubTitle'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toLocalMap() {
    return {
      'id': id,
      'uID': uID,
      'url': url,
      'type': type,
      'path': path,
      'newsTitle': newsTitle,
      'newsSubTitle': newsSubTitle,
      'createdAt': createdAt,
    };
  }
}
