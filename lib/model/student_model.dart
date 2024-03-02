import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  String? studenName;
  String? schoolid;
  String? studentId;
  String? phoneNumber;
  String? studentGrade;
  String? email;
  String? password;
  String? schoolName;
  bool? isVerified;
  int? totalHours;

  StudentModel(
      {this.schoolid,
      this.studenName,
      this.email,
      this.password,
      this.phoneNumber,
      this.schoolName,
      this.studentId,
      this.totalHours,
      this.isVerified,
      this.studentGrade});
  StudentModel.fromSnapSHot(DocumentSnapshot<Map<String, dynamic>> data) {
    studentId = data.id;
    schoolid = data.data()!["school_id"] ?? "";
    studenName = data.data()!["sutdent_name"] ?? "";
    phoneNumber = data.data()!["sutdent_phone"] ?? "";
    studentGrade = data.data()!["sutdent_grade"] ?? "";
    email = data.data()!["sutdent_mail"] ?? "";
    password = data.data()!["password"] ?? "";
    isVerified = data.data()!["is_verified"] ?? "";
    schoolName = data.data()!['school_name'] ?? '';
    totalHours = data.data()!['total_hours'];
    print('email is $email');
  }
}
