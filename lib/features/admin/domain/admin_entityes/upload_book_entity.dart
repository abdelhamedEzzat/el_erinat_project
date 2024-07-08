class UploadBookEntity {
  int? id;
  String? uID;
  String? localImagePath;
  String? localPdFPath;
  String? bookTitle;
  String? bookdescription;
  String? pdfName;
  String? remoteImageUrl;
  String? remotepdfUrl;
  String? createdAt;

  UploadBookEntity(
      {this.id,
      this.uID,
      this.localImagePath,
      this.localPdFPath,
      this.bookTitle,
      this.bookdescription,
      this.pdfName,
      this.remoteImageUrl,
      this.remotepdfUrl,
      this.createdAt});

  factory UploadBookEntity.fromJson(Map<String, dynamic> json) {
    return UploadBookEntity(
      id: json['id'],
      uID: json['uID'],
      localImagePath: json['localImagePath'],
      localPdFPath: json['localPdFPath'],
      bookTitle: json['bookTitle'],
      bookdescription: json['bookdescription'],
      pdfName: json['pdfName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'localImagePath': localImagePath,
      'localPdFPath': localPdFPath,
      'bookTitle': bookTitle,
      'bookdescription': bookdescription,
      'pdfName': pdfName
    };
  }
}
