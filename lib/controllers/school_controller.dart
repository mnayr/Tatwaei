import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatwei/constants/admin_constant.dart';
import 'package:tatwei/constants/display_message.dart';
import 'package:tatwei/controllers/auth_controller.dart';
import 'package:tatwei/model/oppertunity_model.dart';
import 'package:tatwei/model/registered_and_completed_oppertunitymode;.dart';
import 'package:tatwei/model/school_model.dart';
import 'package:tatwei/model/student_model.dart';
import 'package:tatwei/services/internet_services.dart';

class SchoolController extends GetxController {
  AuthController authController = Get.put(AuthController());

  InternetServices internetServices = InternetServices();
  DisplayMessage displayMessage = DisplayMessage();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // < ============ GET SCHOOL DATA ==================>

  Rx<SchoolModel> schooldata = SchoolModel().obs;

  SchoolModel get getSchoolData => schooldata.value;
  set getSchoolData(SchoolModel value) => schooldata.value = value;

  Future getSchoolInformation() async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection("school")
          .doc(authController.auth.currentUser?.uid)
          .get();
      schooldata.value = SchoolModel.fromSnapSHot(doc);
    } catch (e) {
      print('error is ${e.toString()}');
    }
  }

  // < ============ EDIT SCHOOL DATA ==================>

  final TextEditingController nameController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController mailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  RxBool isEdit = false.obs;
  editSchooldata() async {
    if (await internetServices.checkConnection()) {
      isEdit.value = true;
      if (getSchoolData.password != passController.text) {
        var user = authController.auth.currentUser!;

        final cred = EmailAuthProvider.credential(
            email: user.email!, password: getSchoolData.password!);

        await user.reauthenticateWithCredential(cred).then((value) async {
          await user.updatePassword(passController.text.trim()).then((_) {
            firebaseFirestore
                .collection('school')
                .doc(getSchoolData.schoolid!)
                .update({
              "password": passController.text,
              'school_name': nameController.text,
              'phone_number': phoneController.text,
              'address': locationController.text,
            }).then((value) {
              getSchoolInformation();
              isEdit.value = false;
              Get.back();
            });
          }).catchError((error) {
            isEdit.value = false;
            displayMessage.errorMessage(error.toString());

            print(error);
          });
        }).catchError((err) {
          displayMessage.errorMessage(err.toString());

          isEdit.value = false;

          print(err);
        });
      } else {
        firebaseFirestore
            .collection('school')
            .doc(getSchoolData.schoolid!)
            .update({
          "password": passController.text,
          'school_name': nameController.text,
          'phone_number': phoneController.text,
          'address': locationController.text,
        }).then((value) {
          getSchoolInformation();
          isEdit.value = false;
          Get.back();
        });
      }
    } else {
      displayMessage.errorMessage('Network not available');
    }
  }

  // <========== GET Unverified Students ==========>

  Rx<List<StudentModel>> unverifiedStudents = Rx<List<StudentModel>>([]);
  List<StudentModel> get getunverifiedStudentsList => unverifiedStudents.value;

  getUnverifiedStudents() {
    unverifiedStudents.bindStream(getUnverifiedStudentsStream());
  }

  Stream<List<StudentModel>> getUnverifiedStudentsStream() {
    return firebaseFirestore
        .collection('students')
        .where('school_id', isEqualTo: getSchoolData.schoolid)
        .where('is_verified', isEqualTo: false)
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<StudentModel> retVal = [];
      for (var element in event.docs) {
        retVal.add(StudentModel.fromSnapSHot(element));
      }
      print('===> unverified students length is ${retVal.length}');

      return retVal;
    });
  }

  // ================ ACCEPT STUDENT REQUEST ===============>

  acceptRequest(String studentId) async {
    firebaseFirestore
        .collection('students')
        .doc(studentId)
        .update({'is_verified': true});
  }

  // ================ ACCEPT STUDENT REQUEST ===============>

  declinetRequest(String studentId) async {
    firebaseFirestore.collection('students').doc(studentId).delete();
  }

  // <========== GET Unverified Students ==========>

  Rx<List<StudentModel>> verifiedStudents = Rx<List<StudentModel>>([]);
  List<StudentModel> get getverifiedStudentsList => verifiedStudents.value;

  getVerifiedStudents() {
    verifiedStudents.bindStream(getverifiedStudentsStream());
  }

  Stream<List<StudentModel>> getverifiedStudentsStream() {
    print('school id is ${getSchoolData.schoolid}');
    return firebaseFirestore
        .collection('students')
        .where('school_id', isEqualTo: getSchoolData.schoolid)
        .where('is_verified', isEqualTo: true)
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<StudentModel> retVal = [];
      for (var element in event.docs) {
        retVal.add(StudentModel.fromSnapSHot(element));
      }
      print('===> verified students length is ${retVal.length}');

      return retVal;
    });
  }

  // <========== ADD OPPORTUNITY  ==========>

  TextEditingController oppertunityNameCntr = TextEditingController();
  TextEditingController oppertunityDetailsCntr = TextEditingController();
  TextEditingController noOfHours = TextEditingController();
  TextEditingController totalSeatsCtrl = TextEditingController();
  TextEditingController benefitCtrl = TextEditingController();

  TextEditingController addressCtrl = TextEditingController();
  TextEditingController linkCtrl = TextEditingController();

  RxBool isOppertunityAdd = false.obs;

  addOppertunity(
      {required String startTime,
      required String endTime,
      required String gender,
      required String interest,
      required String imageName,
      required File file}) async {
    if (await internetServices.checkConnection()) {
      isOppertunityAdd.value = true;
      Map<String, dynamic> oppertunityData = {
        'oppertunity_name': oppertunityNameCntr.text,
        'oppertunity_detail': oppertunityDetailsCntr.text,
        'start_time': startTime,
        'end_time': endTime,
        'seats': totalSeatsCtrl.text,
        'interest': interest,
        'gender': gender,
        'no_of_hour': noOfHours.text,
        'benefits': benefitCtrl.text,
        'image_name': imageName,
        'image_url': await getImageUrl(file),
        'is_external':
            authController.auth.currentUser!.uid == AdminConstant.adminId
                ? true
                : false,
        'dateTime': DateTime.now(),
        'school_id': authController.auth.currentUser!.uid,
        'address': addressCtrl.text,
        'link': linkCtrl.text,
      };

      FirebaseFirestore.instance
          .collection('oppertunity')
          .add(oppertunityData)
          .then((value) {
        isOppertunityAdd.value = false;
        clearOportunityController();
        Get.back();
        displayMessage.errorMessage('Opportunity added successfully');
      }).catchError((e) {
        isOppertunityAdd.value = false;
        displayMessage.errorMessage(e.toString());
      });
    }
  }

  // <========== EDIT OPPORTUNITY  ==========>
  RxBool isEditOpportunity = false.obs;
  Future<void> editOppertunity(
      {required String startTime,
      required String endTime,
      required String gender,
      required String interest,
      String? imageName,
      File? file,
      String? opportunityId}) async {
    if (await internetServices.checkConnection()) {
      isEditOpportunity.value = true;
      Map<String, dynamic> oppertunityData = {};
      if (file != null) {
        oppertunityData = {
          'oppertunity_name': oppertunityNameCntr.text,
          'oppertunity_detail': oppertunityDetailsCntr.text,
          'start_time': startTime,
          'end_time': endTime,
          'seats': totalSeatsCtrl.text,
          'interest': interest,
          'gender': gender,
          'no_of_hour': noOfHours.text,
          'benefits': benefitCtrl.text,
          'image_name': imageName,
          'image_url': await getImageUrl(file),
          'is_external':
              authController.auth.currentUser!.uid == AdminConstant.adminId
                  ? true
                  : false,
          'address': addressCtrl.text,
          'link': linkCtrl.text,
        };
      } else {
        oppertunityData = {
          'oppertunity_name': oppertunityNameCntr.text,
          'oppertunity_detail': oppertunityDetailsCntr.text,
          'start_time': startTime,
          'end_time': endTime,
          'seats': totalSeatsCtrl.text,
          'interest': interest,
          'gender': gender,
          'no_of_hour': noOfHours.text,
          'benefits': benefitCtrl.text,
          'is_external': false,
        };
      }

      FirebaseFirestore.instance
          .collection('oppertunity')
          .doc(opportunityId)
          .update(oppertunityData)
          .then((value) {
        isEditOpportunity.value = false;
        getSpecificOppertunityData(opportunityId!);
        clearOportunityController();
        Get.back();
        displayMessage.errorMessage('Opportunity edit successfully');
      }).catchError((e) {
        isEditOpportunity.value = false;
        displayMessage.errorMessage(e.toString());
      });
    }
  }

  Future<String> getImageUrl(File imageFile) async {
    String imagUrl = '';
    final ref = FirebaseStorage.instance
        .ref()
        .child('post_images')
        .child(DateTime.now().toString());
    await ref.putFile(imageFile);
    imagUrl = await ref.getDownloadURL();
    return imagUrl;
  }

  clearOportunityController() {
    oppertunityDetailsCntr.clear();
    oppertunityNameCntr.clear();
    noOfHours.clear();
    totalSeatsCtrl.clear();
    benefitCtrl.clear();
  }

  // < ============ GET SPECIFIC OPPORTUNITY DATA ==================>

  Rx<OppertunityModel> opportunityData = OppertunityModel().obs;

  OppertunityModel get getOppertunityModelData => opportunityData.value;
  set getOppertunityModelData(OppertunityModel value) =>
      opportunityData.value = value;

  Future getSpecificOppertunityData(String oppertunityId) async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection("oppertunity")
          .doc(oppertunityId)
          .get();
      opportunityData.value = OppertunityModel.fromSnapSHot(doc);
    } catch (e) {
      print('error is ${e.toString()}');
    }
  }

  // <========== OPPERTUNITIES ==========>

  Rx<List<OppertunityModel>> opportunityList = Rx<List<OppertunityModel>>([]);
  List<OppertunityModel> get getOpportunityListList => opportunityList.value;

  getOppertunities() {
    opportunityList.bindStream(getOppertunityStream());
  }

  Stream<List<OppertunityModel>> getOppertunityStream() {
    print('school is ${authController.auth.currentUser!.uid}');
    return firebaseFirestore
        .collection('oppertunity')
        // .where('school_id', isEqualTo: authController.auth.currentUser!.uid)
        // .where('is_external', isEqualTo: false)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((event) {
      List<OppertunityModel> retVal = [];
      for (var element in event.docs) {
        if (element.data()['school_id'] ==
                authController.auth.currentUser!.uid ||
            element.data()['school_id'] == AdminConstant.adminId) {
          retVal.add(OppertunityModel.fromSnapSHot(element));
        }
      }
      print('===> oppertunity length is ${retVal.length}');

      return retVal;
    });
  }

  // <========== GET SCHOOL OPPERTUNITIES ==========>

  Rx<List<OppertunityModel>> schoolOpportunityList =
      Rx<List<OppertunityModel>>([]);
  List<OppertunityModel> get getschoolOpportunityListList =>
      schoolOpportunityList.value;

  getschoolOppertunities() {
    schoolOpportunityList.bindStream(getSchoolOppertunityStream());
  }

  Stream<List<OppertunityModel>> getSchoolOppertunityStream() {
    print('school is ${authController.auth.currentUser!.uid}');
    return firebaseFirestore
        .collection('oppertunity')
        .where('school_id', isEqualTo: authController.auth.currentUser!.uid)
        // .where('is_external', isEqualTo: false)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((event) {
      List<OppertunityModel> retVal = [];
      for (var element in event.docs) {
        retVal.add(OppertunityModel.fromSnapSHot(element));
      }
      print('===> oppertunity length is ${retVal.length}');

      return retVal;
    });
  }

  // < ============ GET REGISTERED OPPORTUNITY FOR STUDENT ==================>

  Rx<List<RegisteredAndCompletedOppertunityModel>> registeredOpportunityList =
      Rx<List<RegisteredAndCompletedOppertunityModel>>([]);
  List<RegisteredAndCompletedOppertunityModel>
      get getregisteredOpportunityListList => registeredOpportunityList.value;

  getALLregisteredOppertunities(String studentId) {
    registeredOpportunityList
        .bindStream(getregisteredOppertunityStream(studentId));
  }

  Stream<List<RegisteredAndCompletedOppertunityModel>>
      getregisteredOppertunityStream(String studentId) {
    print('student id is $studentId');
    return firebaseFirestore
        .collection('students')
        .doc(studentId)
        .collection('registeredandCompletedOppertinity')
        .where('status', isEqualTo: '1')
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<RegisteredAndCompletedOppertunityModel> retVal = [];
      for (var element in event.docs) {
        print('register id is ${element.id} and name is');
        retVal
            .add(RegisteredAndCompletedOppertunityModel.fromSnapSHot(element));
      }
      print('===> registered oppertunity length is ${retVal.length}');

      return retVal;
    });
  }

  // < ============ GET COMPLETED OPPORTUNITY FOR STUDENT ==================>

  Rx<List<RegisteredAndCompletedOppertunityModel>> completedOpportunityList =
      Rx<List<RegisteredAndCompletedOppertunityModel>>([]);
  List<RegisteredAndCompletedOppertunityModel>
      get getcompletedOpportunityList => completedOpportunityList.value;

  getALLCompletedOppertunities(String studentId) {
    completedOpportunityList
        .bindStream(getCompletedOppertunityStream(studentId));
  }

  Stream<List<RegisteredAndCompletedOppertunityModel>>
      getCompletedOppertunityStream(String studentId) {
    print('user id is $studentId');
    return firebaseFirestore
        .collection('students')
        .doc(studentId)
        .collection('registeredandCompletedOppertinity')
        .where('status', isEqualTo: '2')
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<RegisteredAndCompletedOppertunityModel> retVal = [];
      for (var element in event.docs) {
        print('completed id is ${element.id} and name is');

        retVal
            .add(RegisteredAndCompletedOppertunityModel.fromSnapSHot(element));
      }
      print('===> registered oppertunity length is ${retVal.length}');

      return retVal;
    });
  }

  acceptCertificate(
    StudentModel studentModel,
    RegisteredAndCompletedOppertunityModel oppertunityModel,
  ) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(studentModel.studentId)
        .collection('registeredandCompletedOppertinity')
        .doc(oppertunityModel.id)
        .update({'status': '3'}).then((value) async {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentModel.studentId)
          .update({
        'total_hours': studentModel.totalHours! +
            int.parse(oppertunityModel.noOfHours.value),
      });
    });
  }

  // < ============ GET FILTER OPPORTUNITY FOR STUDENT ==================>
//gender != null && isExternal !=null && interestList.isNotEmpty?
  List<String> interestList = [];

  bool isExternal = false;
  String gender = 'ذكر';

  getFilterOppertunities() {
    opportunityList.bindStream(getFilterOppertunityStream());
  }

  Stream<List<OppertunityModel>> getFilterOppertunityStream() {
    print(
        'school is ${authController.auth.currentUser!.uid}  $gender $isExternal');
    return interestList.isNotEmpty
        ? firebaseFirestore
            .collection('oppertunity')
            .where('interest', whereIn: interestList)
            .orderBy('dateTime', descending: true)
            .snapshots()
            .map((event) {
            List<OppertunityModel> retVal = [];
            for (var element in event.docs) {
              if (element.data()['gender'] == gender ||
                  element.data()['is_external'] == isExternal) {
                retVal.add(OppertunityModel.fromSnapSHot(element));
              }
            }
            print('===> oppertunity length is ${retVal.length}');

            return retVal;
          })
        : firebaseFirestore
            .collection('oppertunity')
            .orderBy('dateTime', descending: true)
            .snapshots()
            .map((event) {
            List<OppertunityModel> retVal = [];
            for (var element in event.docs) {
              if (element.data()['gender'] == gender &&
                  element.data()['is_external'] == isExternal) {
                retVal.add(OppertunityModel.fromSnapSHot(element));
              }
            }
            print('===> oppertunity length is ${retVal.length}');

            return retVal;
          });
  }

  deleteOppertunity(OppertunityModel oppertunityModel) {
    FirebaseFirestore.instance
        .collection('oppertunity')
        .doc(oppertunityModel.id)
        .delete()
        .then((value) {
      Get.back();
    });
  }
}
