class Statistics {
  String? uID;
  final int? personalInFamilies;
  final int? allFamilies;
  final int? totalMales;
  final int? totalFemales;
  final int? liveMale;
  final int? totalLive;
  final int? totalDead;

  Statistics({
    this.uID,
    this.personalInFamilies,
    this.allFamilies,
    this.totalMales,
    this.totalFemales,
    this.liveMale,
    this.totalLive,
    this.totalDead,
  });

  Map<String, dynamic> toJson() => {
        'uID': uID,
        'personalInFamilies': personalInFamilies,
        'allFamilies': allFamilies,
        'totalMales': totalMales,
        'totalFemales': totalFemales,
        'liveMale': liveMale,
        'totalLive': totalLive,
        'totalDead': totalDead,
      };

  static Statistics fromJson(Map<String, dynamic> json) => Statistics(
        uID: json['uID'],
        personalInFamilies: json['personalInFamilies'],
        allFamilies: json['allFamilies'],
        totalMales: json['totalMales'],
        totalFemales: json['totalFemales'],
        liveMale: json['liveMale'],
        totalLive: json['totalLive'],
        totalDead: json['totalDead'],
      );
}

class JobAnalitics {
  int? judge;
  int? holdsAdoctorate;
  int? holdsAmaster;
  int? doctor;
  int? engineer;
  int? pharmaceutical;
  int? oficer;
  int? accountant;
  int? teachers;
  int? pilot;
  int? student;
  int? factor;
  JobAnalitics(
      {this.judge,
      this.holdsAdoctorate,
      this.holdsAmaster,
      this.doctor,
      this.engineer,
      this.pharmaceutical,
      this.oficer,
      this.accountant,
      this.teachers,
      this.pilot,
      this.student,
      this.factor});

  Map<String, dynamic> toJson() => {
        'judge': judge,
        'holdsAdoctorate': holdsAdoctorate,
        'holdsAmaster': holdsAmaster,
        'doctor': doctor,
        'engineer': engineer,
        'pharmaceutical': pharmaceutical,
        'oficer': oficer,
        'accountant': accountant,
        'teachers': teachers,
        'pilot': pilot,
        'student': student,
        'factor': factor
      };

  static JobAnalitics fromJson(Map<String, dynamic> json) => JobAnalitics(
        judge: json['judge'],
        holdsAdoctorate: json['holdsAdoctorate'],
        holdsAmaster: json['holdsAmaster'],
        doctor: json['doctor'],
        engineer: json['engineer'],
        pharmaceutical: json['pharmaceutical'],
        oficer: json['oficer'],
        accountant: json['accountant'],
        teachers: json['teachers'],
        pilot: json['pilot'],
        student: json['student'],
        factor: json['factor'],
      );
}
