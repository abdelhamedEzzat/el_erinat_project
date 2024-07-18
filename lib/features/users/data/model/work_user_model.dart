import 'package:el_erinat/features/users/domain/user_layer/entityes/work_details_user_entityes.dart';

class WorkModel extends WorkDetailsUserEntityes {
  WorkModel(
      {super.id,
      super.uID,
      super.city,
      super.dateOfBirthday,
      super.dateOfCertificate,
      super.employer,
      super.generalSpecialization,
      super.specialization,
      super.status,
      super.title,
      super.university,
      super.jobSelected});

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      id: json['id'],
      uID: json['uID'],
      dateOfBirthday: json['dateOfBirthday'],
      specialization: json['specialization'],
      generalSpecialization: json['generalSpecialization'],
      university: json['university'],
      dateOfCertificate: json['dateOfCertificate'],
      employer: json['employer'],
      city: json['city'],
      status: json['status'],
      title: json['title'],
      jobSelected: json['jobSelected'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uID': uID,
      'dateOfBirthday': dateOfBirthday,
      'specialization': specialization,
      'generalSpecialization': generalSpecialization,
      'university': university,
      'dateOfCertificate': dateOfCertificate,
      'employer': employer,
      'city': city,
      'status': status,
      'title': title,
      'jobSelected': jobSelected
    };
  }
}
