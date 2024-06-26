import 'package:el_erinat/features/admin/domain/admin_entityes/upload_book_entity.dart';

class UplaodBookModel extends UploadBookEntity {
  String? remoteImageUrl;
  String? remotepdfUrl;
  String? createdAt;
  UplaodBookModel({
    this.createdAt,
    super.id,
    super.uID,
    super.localImagePath,
    super.localPdFPath,
    this.remoteImageUrl,
    this.remotepdfUrl,
    super.bookTitle,
    super.bookdescription,
    super.pdfName,
  });

  factory UplaodBookModel.fromJson(Map<String, dynamic> json) {
    return UplaodBookModel(
        id: json['id'],
        uID: json['uID'],
        localImagePath: json['localImagePath'],
        localPdFPath: json['localPdFPath'],
        remoteImageUrl: json['remoteImageUrl'],
        remotepdfUrl: json['remotepdfUrl'],
        bookTitle: json['bookTitle'],
        bookdescription: json['bookdescription'],
        createdAt: json['createdAt'],
        pdfName: json['pdfName']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'localImagePath': localImagePath,
      'localPdFPath': localPdFPath,
      'remoteImageUrl': remoteImageUrl,
      'remotepdfUrl': remotepdfUrl,
      'bookTitle': bookTitle,
      'bookdescription': bookdescription,
      'createdAt': createdAt,
      'pdfName': pdfName
    };
  }

  factory UplaodBookModel.fromLocalJson(Map<String, dynamic> json) {
    return UplaodBookModel(
        id: json['id'],
        uID: json['uID'],
        localImagePath: json['localImagePath'],
        remoteImageUrl: json['remoteImageUrl'],
        remotepdfUrl: json['remotepdfUrl'],
        bookTitle: json['bookTitle'],
        bookdescription: json['bookdescription'],
        createdAt: json['createdAt']);
  }

  Map<String, dynamic> toJLocalson() {
    return {
      'id': id,
      'uID': uID,
      'localImagePath': localImagePath,
      'remoteImageUrl': remoteImageUrl,
      'remotepdfUrl': remotepdfUrl,
      'bookTitle': bookTitle,
      'bookdescription': bookdescription,
      'createdAt': createdAt
    };
  }
}
