import 'package:el_erinat/features/admin/domain/admin_entityes/upload_tree_entity.dart';

class UploadTreeModel extends UploadTreeEntity {
  UploadTreeModel({
    super.id,
    super.uID,
    super.familyName,
    super.familyLineage,
    super.pdfName,
    super.pdfUrl,
    super.pdfPath,
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

  factory UploadTreeModel.fromMap(Map<String, dynamic> map) {
    return UploadTreeModel(
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
      "pdfPath": pdfPath
    };
  }

  factory UploadTreeModel.fromRemoteMap(Map<String, dynamic> map) {
    return UploadTreeModel(
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
