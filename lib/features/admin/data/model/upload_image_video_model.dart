import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_erinat/features/admin/domain/admin_entityes/upload_image_video_news_entity.dart';

class UploadImageAndVideoModel extends UploadImageAndVideoEntity {
  UploadImageAndVideoModel(
      {super.id,
      super.uID,
      super.url,
      super.type,
      super.path,
      super.newsTitle,
      super.newsSubTitle,
      super.createdAt});

  factory UploadImageAndVideoModel.fromMap(Map<String, dynamic> map) {
    return UploadImageAndVideoModel(
      id: map['id'],
      uID: map['uID'],
      url: map['url'],
      type: map['type'],
      path: map['path'],
      newsTitle: map['newsTitle'],
      newsSubTitle: map['newsSubTitle'],
      //   createdAt: map['createdAt']);
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
      //  'createdAt': createdAt ?? Timestamp.now(),
    };
  }

  factory UploadImageAndVideoModel.fromLocalMap(Map<String, dynamic> map) {
    return UploadImageAndVideoModel(
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
