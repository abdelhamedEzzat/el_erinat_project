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
      'pdfUrl': pdfUrl,
    };
  }

  factory UploadTreeModel.fromMap(Map<String, dynamic> map) {
    return UploadTreeModel(
      id: map['id'],
      uID: map['uID'],
      familyName: map['familyName'],
      familyLineage: map['familyLineage'],
      pdfName: map['pdfName'],
      pdfUrl: map['pdfUrl'],
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
  Map<String, dynamic> toUpdateMap() {
    final Map<String, dynamic> map = {};
    if (uID != null) map['uID'] = uID;
    if (familyName != null) map['familyName'] = familyName;
    if (familyLineage != null) map['familyLineage'] = familyLineage;
    if (pdfName != null) map['pdfName'] = pdfName;
    if (pdfUrl != null) map['pdfUrl'] = pdfUrl;
    return map;
  }
}
