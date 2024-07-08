class UploadImageEntityes {
  int? id;
  String? uID;
  String? uploadedIdentityImage; // Corrected name

  UploadImageEntityes({this.uploadedIdentityImage, this.id, this.uID});

  factory UploadImageEntityes.fromJson(Map<String, dynamic> json) {
    return UploadImageEntityes(
      id: json['id'] as int?,
      uID: json['uID'] as String?,
      uploadedIdentityImage:
          json['uploadedIdentityImage'] as String?, // Corrected name
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'uID': uID ?? "",
      'uploadedIdentityImage': uploadedIdentityImage ?? "", // Corrected name
    };
  }
}
