import 'package:cloud_firestore/cloud_firestore.dart';

class OppertunityModel {
  String? id;
  String? oppertunityName;
  String? oppertunityDetail;
  String? startTime;
  String? endTime;
  String? totalSeats;
  String? interest;
  String? gender;
  String? noOfHours;
  String? benefits;
  String? imageName;
  String? imageUrl;
  String? schoolId;
  bool? isExternal;
  String? link;
  String? address;

  OppertunityModel(
      {this.oppertunityDetail,
      this.oppertunityName,
      this.benefits,
      this.endTime,
      this.gender,
      this.imageName,
      this.imageUrl,
      this.interest,
      this.isExternal,
      this.noOfHours});
  OppertunityModel.fromSnapSHot(DocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    oppertunityDetail = data.data()!["oppertunity_detail"] ?? "";
    oppertunityName = data.data()!["oppertunity_name"] ?? "";
    startTime = data.data()!["start_time"] ?? "";
    endTime = data.data()!["end_time"] ?? "";
    totalSeats = data.data()!["seats"] ?? "";
    interest = data.data()!["interest"] ?? "";
    gender = data.data()!["gender"] ?? "";
    noOfHours = data.data()!["no_of_hour"] ?? "";
    benefits = data.data()!["benefits"] ?? "";
    imageName = data.data()!["image_name"] ?? "";
    imageUrl = data.data()!["image_url"] ?? "";
    isExternal = data.data()!["is_external"] ?? "";
    schoolId = data.data()!["school_id"] ?? "";
    link = data.data()!['link'] ?? '';
    address = data.data()!['address'] ?? '';
  }
}
