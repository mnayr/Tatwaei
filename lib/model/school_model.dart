import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolModel {
  String? schoolName;
  String? schoolid;
  String? phoneNumber;
  String? address;
  String? email;
  String? password;

  SchoolModel({this.schoolid, this.schoolName});
  SchoolModel.fromSnapSHot(DocumentSnapshot<Map<String, dynamic>> data) {
    schoolid = data.id;
    schoolName = data.data()!["school_name"] ?? "";
    phoneNumber = data.data()!["phone_number"] ?? "";
    address = data.data()!["address"] ?? "";
    email = data.data()!["email"] ?? "";
    password = data.data()!["password"] ?? "";
  }
}
