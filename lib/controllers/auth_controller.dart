import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatwei/constants/display_message.dart';
import 'package:tatwei/services/internet_services.dart';
import 'package:tatwei/views/pages/admin_panel/admin_home/admin_home_page.dart';
import 'package:tatwei/views/pages/authentication/login_page.dart';
import 'package:tatwei/views/pages/coordinator_panel/teacher_home/teacher_home_page.dart';
import 'package:tatwei/views/pages/student_panel/home/home_page.dart';

class AuthController extends GetxController {
  InternetServices internetServices = InternetServices();
  DisplayMessage displayMessage = DisplayMessage();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final firebaseUser = Rxn<User>();
  User get users => firebaseUser.value!;

  RxInt selectedUsertype = 0.obs;

  @override
  void onInit() {
    //  firebaseUser.bindStream(auth.authStateChanges());

    super.onInit();
  }

  // <========== USER LOGIN ==========>
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  RxBool isUserLogin = false.obs;
  login(BuildContext context) async {
    if (await internetServices.checkConnection()) {
      try {
        isUserLogin.value = true;
        auth
            .signInWithEmailAndPassword(
                email: loginEmail.text.trim(),
                password: loginPasswordController.text.trim())
            .then((value) async {
          if (await isStudent(value.user!.uid, context)) {
            Get.offAll(() => const HomePage());
          } else if (await isSchollCoordinate(value.user!.uid)) {
            Get.offAll(() => const TeacherHomePage());
          } else if (await isADMINLOGIN(value.user!.uid)) {
            Get.offAll(() => const AdminHomePage());
          } else {
            print('user not found');
          }
          isUserLogin.value = false;
        }).catchError((e) {
          isUserLogin.value = false;
          displayMessage.errorMessage(e.toString());
        });
      } catch (e) {
        isUserLogin.value = false;
        displayMessage.errorMessage(e.toString());
      }
    } else {
      displayMessage.errorMessage('Student register successfully');
    }
  }

  // <========== CHECK STUDENT LOGIN ==========>
  bool isStudentLogin = false;

  Future<bool> isStudent(String id, BuildContext context) async {
    bool isUserfound = false;
    DocumentSnapshot documentSnapshot =
        await firestore.collection('students').doc(id).get();
    if (documentSnapshot.exists) {
      if (documentSnapshot['is_verified']) {
        print('exist');
        isUserfound = true;
        isStudentLogin = true;
        isSchollCoordinatelogin = false;
        isAdminLogin = false;
      } else {
        showAccountNotApprovedDialog(context);
        isUserfound = false;
      }
    }
    return isUserfound;
  }

  showAccountNotApprovedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('الحساب غير معتمد'),
          content: const Text(
              'لم تتم الموافقة على حسابك بعد. يرجى الانتظار للحصول على الموافقة.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // <========== CHECK SCHOOL COORDINATE LOGIN ==========>
  bool isSchollCoordinatelogin = false;

  Future<bool> isSchollCoordinate(String id) async {
    bool isUserfound = false;

    DocumentSnapshot documentSnapshot =
        await firestore.collection('school').doc(id).get();
    if (documentSnapshot.exists) {
      isUserfound = true;
      isSchollCoordinatelogin = true;
      isStudentLogin = false;
      isAdminLogin = false;
    }
    return isUserfound;
  }

  // <========== CHECK ADMIN  LOGIN ==========>
  bool isAdminLogin = false;

  Future<bool> isADMINLOGIN(String id) async {
    bool isUserfound = false;

    DocumentSnapshot documentSnapshot =
        await firestore.collection('admin').doc(id).get();
    if (documentSnapshot.exists) {
      isUserfound = true;
      isAdminLogin = true;
      isSchollCoordinatelogin = false;
      isStudentLogin = false;
    }
    return isUserfound;
  }

  /// ========== log out ========
  Future<void> logOut() async {
    await auth.signOut().then((value) async {
      Get.offAll(() => LoginPage());
    });
  }
}
