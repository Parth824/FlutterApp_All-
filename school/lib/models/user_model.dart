class UserModel {
  String busNumber;
  String guardianName;
  String guardianPhNo;
  String studentName;
  String lat;
  String schoolId;
  String long;
  String schoolName;
  String subsEndDate;
  String standard;
  String address;
  UserModel({
    required this.long,
    required this.address,
    required this.subsEndDate,
    required this.guardianPhNo,
    required this.lat,
    required this.busNumber,
    required this.guardianName,
    required this.schoolName,
    required this.schoolId,
    required this.standard,
    required this.studentName,
  });
}
