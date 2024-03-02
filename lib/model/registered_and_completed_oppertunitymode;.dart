import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RegisteredAndCompletedOppertunityModel {
  String? id;
  RxString oppertunityName = ''.obs;
  RxString oppertunityDetail = ''.obs;
  RxString startTime = ''.obs;
  RxString endTime = ''.obs;
  RxString totalSeats = ''.obs;
  RxString interest = ''.obs;
  RxString gender = ''.obs;
  RxString noOfHours = ''.obs;
  RxString benefits = ''.obs;
  RxString imageName = ''.obs;
  RxString imageUrl = ''.obs;
  RxString schoolId = ''.obs;
  RxBool isExternal = false.obs;
  String? certificatImage;

  DocumentReference? documentReference;
  String? status;

  RegisteredAndCompletedOppertunityModel.fromSnapSHot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    status = data.data()!["status"] ?? "";
    documentReference = data.data()!["opportunityReferance"];
    certificatImage = data.data()!['certificate_image'];

    documentReference!.get().then((value) {
      oppertunityDetail.value = value["oppertunity_detail"] ?? "";
      oppertunityName.value = value["oppertunity_name"] ?? "";
      startTime.value = value["start_time"] ?? "";
      endTime.value = value["end_time"] ?? "";
      totalSeats.value = value["seats"] ?? "";
      interest.value = value["interest"] ?? "";
      gender.value = value["gender"] ?? "";
      noOfHours.value = value["no_of_hour"] ?? "";
      benefits.value = value["benefits"] ?? "";
      imageName.value = value["image_name"] ?? "";
      imageUrl.value = value["image_url"] ?? "";
      isExternal.value = value["is_external"];
      schoolId.value = value["school_id"] ?? "";
    });
  }
}
