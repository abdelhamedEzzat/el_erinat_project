class UploadTreeEntity {
  int? id;
  String? uID;
  String? familyName;
  String? familyLineage;
  String? pdfName;
  String? pdfUrl;
  String? pdfPath;

  UploadTreeEntity({
    this.id,
    this.uID,
    this.familyName,
    this.familyLineage,
    this.pdfName,
    this.pdfUrl,
    this.pdfPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uID': uID,
      'familyName': familyName,
      'familyLineage': familyLineage,
      'pdfName': pdfName,
    };
  }

  factory UploadTreeEntity.fromMap(Map<String, dynamic> map) {
    return UploadTreeEntity(
      id: map['id'],
      uID: map['uID'],
      familyName: map['familyName'],
      familyLineage: map['familyLineage'],
      pdfName: map['pdfName'],
    );
  }

  Map<String, dynamic> toRemoteMap() {
    return {
      'id': id,
      'uID': uID,
      'familyName': familyName,
      'familyLineage': familyLineage,
      'pdfName': pdfName,
      'pdfUrl': pdfUrl,
      "pdfPath": pdfPath,
    };
  }

  factory UploadTreeEntity.fromRemoteMap(Map<String, dynamic> map) {
    return UploadTreeEntity(
      id: map['id'],
      uID: map['uID'],
      familyName: map['familyName'],
      familyLineage: map['familyLineage'],
      pdfName: map['pdfName'],
      pdfUrl: map['pdfUrl'],
      pdfPath: map['pdfPath'],
    );
  }
}
