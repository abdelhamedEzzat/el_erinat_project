class WorkDetailsUserEntityes {
  int? id;
  String? uID;
  String? dateOfBirthday;
  String? specialization;
  String? generalSpecialization;
  String? university;
  String? dateOfCertificate;
  String? employer;
  String? city;
  String? status;
  String? title;
  String? jobSelected;

  WorkDetailsUserEntityes(
      {this.id,
      this.uID,
      this.dateOfBirthday,
      this.specialization,
      this.generalSpecialization,
      this.university,
      this.dateOfCertificate,
      this.employer,
      this.city,
      this.status,
      this.title,
      this.jobSelected});

  factory WorkDetailsUserEntityes.fromJson(Map<String, dynamic> json) {
    return WorkDetailsUserEntityes(
      id: json['id'] as int?,
      uID: json['uID'] as String?,
      dateOfBirthday: json['dateOfBirthday'] as String?,
      specialization: json['specilaization'] as String?,
      generalSpecialization: json['generalSpecialization'] as String?,
      university: json['university'] as String?,
      dateOfCertificate: json['dateOfCertificate'] as String?,
      employer: json['employer'] as String?,
      city: json['city'] as String?,
      status: json['status'] as String?,
      title: json['title'] as String?,
      jobSelected: json['jobSelected'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'uID': uID ?? '',
      'dateOfBirthday': dateOfBirthday ?? '',
      'specialization': specialization ?? '',
      'generalSpecialization': generalSpecialization ?? '',
      'university': university ?? '',
      'dateOfCertificate': dateOfCertificate ?? '',
      'employer': employer ?? '',
      'city': city ?? '',
      'status': status ?? '',
      'title': title ?? '',
      'jobSelected': jobSelected ?? '',
    };
  }
}
