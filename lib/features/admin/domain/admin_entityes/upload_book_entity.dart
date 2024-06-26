class UploadBookEntity {
  int? id;
  String? uID;
  String? localImagePath;
  String? localPdFPath;
  String? bookTitle;
  String? bookdescription;

  UploadBookEntity(
      {this.id,
      this.uID,
      this.localImagePath,
      this.localPdFPath,
      this.bookTitle,
      this.bookdescription});

  factory UploadBookEntity.fromJson(Map<String, dynamic> json) {
    return UploadBookEntity(
      id: json['id'],
      uID: json['uID'],
      localImagePath: json['localImagePath'],
      localPdFPath: json['localPdFPath'],
      bookTitle: json['bookTitle'],
      bookdescription: json['bookdescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'localImagePath': localImagePath,
      'localPdFPath': localPdFPath,
      'bookTitle': bookTitle,
      'bookdescription': bookdescription
    };
  }
}
