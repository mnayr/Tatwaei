import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatwei/constants/admin_constant.dart';
import 'package:tatwei/constants/display_message.dart';
import 'package:tatwei/controllers/admin_controller.dart';
import 'package:tatwei/controllers/auth_controller.dart';
import 'package:tatwei/controllers/school_controller.dart';
import 'package:tatwei/model/oppertunity_model.dart';
import 'package:tatwei/model/registered_and_completed_oppertunitymode;.dart';
import 'package:tatwei/model/student_model.dart';
import 'package:tatwei/services/internet_services.dart';

class StudentController extends GetxController {
  SchoolController schoolController = Get.put(SchoolController());
  AdminController adminController = Get.put(AdminController());
  AuthController authController = Get.put(AuthController());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  InternetServices internetServices = InternetServices();
  DisplayMessage displayMessage = DisplayMessage();

  // < ============ GET SCHOOL DATA ==================>

  Rx<StudentModel> studentData = StudentModel().obs;

  StudentModel get getstudentData => studentData.value;
  set getstudentData(StudentModel value) => studentData.value = value;

  Future getStudentData() async {
    print('studend data call');
    try {
      var doc = await FirebaseFirestore.instance
          .collection("students")
          .doc(authController.auth.currentUser?.uid)
          .get();
      studentData.value = StudentModel.fromSnapSHot(doc);
    } catch (e) {
      print('error is ${e.toString()}');
    }
  }

  // <======================= UPDATE USER PROFILE ========================>

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  RxBool isEdit = false.obs;

  updateUserProfile(String grade) async {
    if (await internetServices.checkConnection()) {
      isEdit.value = true;

      if (getstudentData.password != passController.text) {
        var user = authController.auth.currentUser!;

        final cred = EmailAuthProvider.credential(
            email: user.email!, password: getstudentData.password!);

        await user.reauthenticateWithCredential(cred).then((value) async {
          await user.updatePassword(passController.text.trim()).then((_) {
            firebaseFirestore
                .collection('students')
                .doc(getstudentData.studentId)
                .update({
              'sutdent_name': nameController.text,
              'sutdent_grade': grade,
              'sutdent_phone': phoneController.text,
              'password': passController.text,
            }).then((value) {
              getStudentData();
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
            .collection('students')
            .doc(getstudentData.studentId!)
            .update({
          'sutdent_name': nameController.text,
          'sutdent_grade': grade,
          'sutdent_phone': phoneController.text,
        }).then((value) {
          getStudentData();
          isEdit.value = false;
          Get.back();
        });
      }
    } else {
      displayMessage.errorMessage('Network not available');
    }
  }

  // < ============ GET OPPORTUNITY FOR STUDENT ==================>

  Rx<List<OppertunityModel>> opportunityList = Rx<List<OppertunityModel>>([]);
  List<OppertunityModel> get getOpportunityListList => opportunityList.value;

  getOppertunities() {
    opportunityList.bindStream(getOppertunityStream());
  }

  Stream<List<OppertunityModel>> getOppertunityStream() {
    print('school is ${authController.auth.currentUser!.uid}');
    return firebaseFirestore
        .collection('oppertunity')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((event) {
      List<OppertunityModel> retVal = [];
      for (var element in event.docs) {
        if (element.data()['school_id'] == getstudentData.schoolid ||
            element.data()['school_id'] == AdminConstant.adminId) {
          retVal.add(OppertunityModel.fromSnapSHot(element));
        }
      }
      print('===> oppertunity length is ${retVal.length}');

      return retVal;
    });
  }

  // < ============ GET OPPORTUNITY FOR STUDENT ==================>
  Future<void> registeredandCompletedOppertinity(String opportunityId) async {
    print('student id is ${getstudentData.studentId}');
    if (await internetServices.checkConnection()) {
      FirebaseFirestore.instance
          .collection('students')
          .doc(getstudentData.studentId!)
          .collection('registeredandCompletedOppertinity')
          .doc(opportunityId)
          .set({
        'opportunityReferance': await getDocumentReferance(opportunityId),
        'status': '1',
        'certificate_image': '',
        'date_time': DateTime.now()
      }).then((value) {
        Get.back();
        displayMessage.successMessage('Registered successfully');
      });
    }
  }

  // <========== GET DOCUMENT REFERANCE ==========>
  Future<DocumentReference> getDocumentReferance(String docId) async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("oppertunity").doc(docId);
    return documentReference;
  }

  // < ============ GET APPLIED OPPORTUNITY ID ==================>

  Rx<List<String>> oppertunityId = Rx<List<String>>([]);
  List<String> get getoppertunityId => oppertunityId.value;

  getAlloppertunityId() {
    oppertunityId.bindStream(getOppertunityIdStream());
  }

  Stream<List<String>> getOppertunityIdStream() {
    print('school is ${authController.auth.currentUser!.uid}');
    return firebaseFirestore
        .collection('students')
        .doc(getstudentData.studentId!)
        .collection('registeredandCompletedOppertinity')
        .snapshots()
        .map((event) {
      List<String> retVal = [];
      for (var element in event.docs) {
        retVal.add(element.id);
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

  getALLregisteredOppertunities() {
    registeredOpportunityList.bindStream(getregisteredOppertunityStream());
  }

  Stream<List<RegisteredAndCompletedOppertunityModel>>
      getregisteredOppertunityStream() {
    print('school is ${authController.auth.currentUser!.uid}');
    return firebaseFirestore
        .collection('students')
        .doc(getstudentData.studentId!)
        .collection('registeredandCompletedOppertinity')
        .where('status', isEqualTo: '1')
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<RegisteredAndCompletedOppertunityModel> retVal = [];
      for (var element in event.docs) {
        DocumentReference documentReference =
            element.data()["opportunityReferance"];
        documentReference.get().then((value) {
          checkOppertunityDeadline(value['end_time'], element.id);
        });

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

  getALLCompletedOppertunities() {
    completedOpportunityList.bindStream(getCompletedOppertunityStream());
  }

  Stream<List<RegisteredAndCompletedOppertunityModel>>
      getCompletedOppertunityStream() {
    print('school is ${authController.auth.currentUser!.uid}');
    return firebaseFirestore
        .collection('students')
        .doc(getstudentData.studentId!)
        .collection('registeredandCompletedOppertinity')
        .where('status', isEqualTo: '2')
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<RegisteredAndCompletedOppertunityModel> retVal = [];
      for (var element in event.docs) {
        retVal
            .add(RegisteredAndCompletedOppertunityModel.fromSnapSHot(element));
      }
      print('===> registered oppertunity length is ${retVal.length}');

      return retVal;
    });
  }

  checkOppertunityDeadline(String oppertunityEndDate, String id) async {
    print('end date is $oppertunityEndDate');
    DateTime now = DateTime.now();
    DateTime endTime = DateTime.parse(oppertunityEndDate);

    int day = endTime.difference(now).inDays;

    if (day < 0) {
      firebaseFirestore
          .collection('students')
          .doc(getstudentData.studentId!)
          .collection('registeredandCompletedOppertinity')
          .doc(id)
          .update({'status': '2'}).then((value) {
        print('opportunity completed');
      });
    }

    print('difference in days is $day and Id is $id');
  }

  // ========== UPLOAD CERTIFICATE =============
  RxBool isCertificateUpload = false.obs;
  Future uploadCertificate(File imageFile, String docId) async {
    isCertificateUpload.value = true;
    firebaseFirestore
        .collection('students')
        .doc(getstudentData.studentId!)
        .collection('registeredandCompletedOppertinity')
        .doc(docId)
        .update({'certificate_image': await uploadImage(imageFile)}).then(
            (value) {
      isCertificateUpload.value = false;
      print('certificate added');
    });
  }

  Future<String> uploadImage(File imageFile) async {
    String imageUrl = '';
    final ref = FirebaseStorage.instance
        .ref()
        .child('crtificate_images')
        .child(DateTime.now().toString());
    await ref.putFile(imageFile);
    imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  // < ============ GET COMPLETED OPPORTUNITY FOR STUDENT ==================>

  Rx<List<RegisteredAndCompletedOppertunityModel>> verifiedOpportunityList =
      Rx<List<RegisteredAndCompletedOppertunityModel>>([]);
  List<RegisteredAndCompletedOppertunityModel> get getVerifiedOpportunityList =>
      verifiedOpportunityList.value;

  getALLVerifiedOpportunityList() {
    verifiedOpportunityList.bindStream(getVerifiedOpportunityListStream());
  }

  Stream<List<RegisteredAndCompletedOppertunityModel>>
      getVerifiedOpportunityListStream() {
    print('school is ${authController.auth.currentUser!.uid}');
    return firebaseFirestore
        .collection('students')
        .doc(getstudentData.studentId!)
        .collection('registeredandCompletedOppertinity')
        .where('status', isEqualTo: '3')
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<RegisteredAndCompletedOppertunityModel> retVal = [];
      for (var element in event.docs) {
        retVal
            .add(RegisteredAndCompletedOppertunityModel.fromSnapSHot(element));
      }
      print('===> verified oppertunity length is ${retVal.length}');

      return retVal;
    });
  }

// < ============ GET FILTER OPPORTUNITY FOR STUDENT ==================>
//gender != null && isExternal !=null && interestList.isNotEmpty?
  List<String> interestList = [];

  bool isExternal = false;
  String gender = 'ذكر';

  getFilterOppertunities() {
    print(
        'student ${authController.isStudentLogin}, School ${authController.isSchollCoordinatelogin}, Admin ${authController.isAdminLogin}');
    if (authController.isStudentLogin) {
      opportunityList.bindStream(getStudentFilterOppertunityStream());
    } else if (authController.isSchollCoordinatelogin) {
      schoolController.opportunityList
          .bindStream(getSchoolFilterOppertunityStream());
    } else if (authController.isAdminLogin) {
      adminController.opportunityList
          .bindStream(getAdminFilterOppertunityStream());
    }
  }

  Stream<List<OppertunityModel>> getStudentFilterOppertunityStream() {
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
              if (element.data()['school_id'] == getstudentData.schoolid ||
                  element.data()['school_id'] == AdminConstant.adminId) {
                if (element.data()['gender'] == gender ||
                    element.data()['is_external'] == isExternal) {
                  retVal.add(OppertunityModel.fromSnapSHot(element));
                }
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
              if (element.data()['school_id'] == getstudentData.schoolid ||
                  element.data()['school_id'] == AdminConstant.adminId) {
                if (element.data()['gender'] == gender ||
                    element.data()['is_external'] == isExternal) {
                  retVal.add(OppertunityModel.fromSnapSHot(element));
                }
              }
            }
            print('===> oppertunity length is ${retVal.length}');

            return retVal;
          });
  }

  Stream<List<OppertunityModel>> getSchoolFilterOppertunityStream() {
    return interestList.isNotEmpty
        ? firebaseFirestore
            .collection('oppertunity')
            .where('interest', whereIn: interestList)
            .orderBy('dateTime', descending: true)
            .snapshots()
            .map((event) {
            List<OppertunityModel> retVal = [];
            for (var element in event.docs) {
              if (element.data()['school_id'] ==
                      authController.auth.currentUser!.uid ||
                  element.data()['school_id'] == AdminConstant.adminId) {
                if (element.data()['gender'] == gender ||
                    element.data()['is_external'] == isExternal) {
                  retVal.add(OppertunityModel.fromSnapSHot(element));
                }
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
              if (element.data()['school_id'] ==
                      authController.auth.currentUser!.uid ||
                  element.data()['school_id'] == AdminConstant.adminId) {
                if (element.data()['gender'] == gender ||
                    element.data()['is_external'] == isExternal) {
                  retVal.add(OppertunityModel.fromSnapSHot(element));
                }
              }
            }
            print('===> oppertunity length is ${retVal.length}');

            return retVal;
          });
  }

  Stream<List<OppertunityModel>> getAdminFilterOppertunityStream() {
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
              if (element.data()['gender'] == gender ||
                  element.data()['is_external'] == isExternal) {
                retVal.add(OppertunityModel.fromSnapSHot(element));
              }
            }
            print('===> oppertunity length is ${retVal.length}');

            return retVal;
          });
  }
}
