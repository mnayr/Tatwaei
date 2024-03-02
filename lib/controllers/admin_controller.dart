import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatwei/constants/display_message.dart';
import 'package:tatwei/controllers/auth_controller.dart';
import 'package:tatwei/model/admin_model.dart';
import 'package:tatwei/model/oppertunity_model.dart';
import 'package:tatwei/model/schools_name_model.dart';
import 'package:tatwei/services/internet_services.dart';

class AdminController extends GetxController {
  AuthController authController = Get.put(AuthController());
  InternetServices internetServices = InternetServices();
  DisplayMessage displayMessage = DisplayMessage();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // <================= REGISTER SCHOOL ====================>
  final TextEditingController schoollocationContr = TextEditingController();
  final TextEditingController schoolphoneContr = TextEditingController();
  final TextEditingController schoolMailContr = TextEditingController();
  final TextEditingController schoolPassContr = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();

  RxBool isSchoolRegister = false.obs;
  registerSchool(SchoolsNameModel schoolModel) async {
    if (await internetServices.checkConnection()) {
      isSchoolRegister.value = true;
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: schoolMailContr.text.trim(),
              password: schoolPassContr.text.trim())
          .then((value) {
        addSchoolData(schoolModel, value.user!.uid).then((value) {
          isSchoolRegister.value = false;
          Get.back();
          displayMessage.errorMessage('School register successfully');
        });
      }).catchError((e) {
        isSchoolRegister.value = false;
        displayMessage.errorMessage(e.toString());
      });
    } else {
      displayMessage.errorMessage('Internet connection not available');
    }
  }

  Future addSchoolData(SchoolsNameModel schoolModel, String authId) async {
    Map<String, dynamic> schoolData = {
      'school_name': schoolModel.schoolName,
      'phone_number': schoolphoneContr.text,
      'address': schoollocationContr.text,
      'email': schoolMailContr.text,
      'date_time': DateTime.now(),
      'password': schoolPassContr.text
    };

    firebaseFirestore
        .collection('school')
        .doc(authId)
        .set(schoolData)
        .then((value) {
      FirebaseFirestore.instance
          .collection('schools_name')
          .doc(schoolModel.schoolid!)
          .delete();
    });
  }

// <========== GET ALL School Name ==========>

  Rx<List<SchoolsNameModel>> schoolList = Rx<List<SchoolsNameModel>>([]);
  List<SchoolsNameModel> get getSchoolList => schoolList.value;

  getAllSchool() {
    schoolList.bindStream(getAuthorStream());
  }

  Stream<List<SchoolsNameModel>> getAuthorStream() {
    return firebaseFirestore
        .collection('schools_name')
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<SchoolsNameModel> retVal = [];
      for (var element in event.docs) {
        retVal.add(SchoolsNameModel.fromSnapSHot(element));
      }
      print('===> school length is ${retVal.length}');

      return retVal;
    });
  }

// <========== REGISTER STUDENT ==========>
  String? selectedGrade;

  final TextEditingController studentphoneContr = TextEditingController();
  final TextEditingController studentMailContr = TextEditingController();
  final TextEditingController studentPassContr = TextEditingController();
  final TextEditingController studentNameController = TextEditingController();
  RxBool isStudentRegister = false.obs;
  registerStudent(String studentGrade, SchoolsNameModel selectedSchool) async {
    if (await internetServices.checkConnection()) {
      try {
        isSchoolRegister.value = true;
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: studentMailContr.text.trim(),
                password: studentPassContr.text.trim())
            .then((value) {
          addStudentData(studentGrade, selectedSchool, value.user!.uid)
              .then((value) {
            isSchoolRegister.value = false;
            Get.back();
            displayMessage.errorMessage('Student register successfully');
          });
        }).catchError((e) {
          isSchoolRegister.value = false;

          displayMessage.errorMessage(e.toString());
        });
      } catch (e) {
        isSchoolRegister.value = false;

        displayMessage.errorMessage(e.toString());
      }
    } else {
      displayMessage.errorMessage('Internet connection not available');
    }
  }
  // <========== ADD STUDENT DATA ==========>

  Future addStudentData(String studentGrade, SchoolsNameModel selectedSchool,
      String authId) async {
    Map<String, dynamic> studentData = {
      'sutdent_name': studentNameController.text,
      'sutdent_grade': studentGrade,
      'sutdent_phone': studentphoneContr.text,
      'sutdent_mail': studentMailContr.text,
      'school_name': selectedSchool.schoolName,
      'school_id': selectedSchool.schoolid,
      'is_verified': false,
      'password': schoolPassContr.text,
      'total_hours': 0,
      'date_time': DateTime.now()
    };

    FirebaseFirestore.instance
        .collection('students')
        .doc(authId)
        .set(studentData);
  }

  // <========== GET REGISTER SCHOOLS ==========>

  Rx<List<SchoolsNameModel>> registerschoolList =
      Rx<List<SchoolsNameModel>>([]);
  List<SchoolsNameModel> get getRegisterSchoolList => registerschoolList.value;

  getAllRegisterSchool() {
    registerschoolList.bindStream(getRegisterSchoolStream());
  }

  Stream<List<SchoolsNameModel>> getRegisterSchoolStream() {
    return firebaseFirestore
        .collection('school')
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((event) {
      List<SchoolsNameModel> retVal = [];
      for (var element in event.docs) {
        retVal.add(SchoolsNameModel.fromSnapSHot(element));
      }
      print('===> register school length is ${retVal.length}');

      return retVal;
    });
  }

  // < ============ GET ADMIN DATA ==================>

  Rx<AdminModel> adminData = AdminModel().obs;

  AdminModel get getAdminData => adminData.value;
  set getAdminData(AdminModel value) => adminData.value = value;

  Future getAdminInformation() async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection("admin")
          .doc(authController.auth.currentUser?.uid)
          .get();
      adminData.value = AdminModel.fromSnapSHot(doc);
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
    print('admin id is ${authController.auth.currentUser!.uid}');
    return firebaseFirestore
        .collection('oppertunity')
        // .where('school_id', isEqualTo: authController.auth.currentUser!.uid)
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
}
