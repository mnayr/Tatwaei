import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolsNameModel {
  String? schoolName;
  String? schoolid;

  SchoolsNameModel({this.schoolid, this.schoolName});
  SchoolsNameModel.fromSnapSHot(DocumentSnapshot<Map<String, dynamic>> data) {
    schoolid = data.id;
    schoolName = data.data()!["school_name"] ?? "";
  }
}
