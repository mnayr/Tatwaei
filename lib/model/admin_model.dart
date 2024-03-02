import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  String? adminName;
  String? adminMail;
  String? adminId;

  AdminModel({this.adminMail, this.adminName});
  AdminModel.fromSnapSHot(DocumentSnapshot<Map<String, dynamic>> data) {
    adminId = data.id;
    adminName = data.data()!["name"] ?? "";
    adminMail = data.data()!["email"] ?? "";
  }
}
