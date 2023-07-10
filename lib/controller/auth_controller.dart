
import 'package:beautyshot/Views/client_screens/client_home_screen.dart';
import 'package:beautyshot/Views/client_talent_screen.dart';
import 'package:beautyshot/Views/talent_screens/done_screen.dart';
import 'package:beautyshot/Views/talent_screens/profile_picture_screen.dart';
import 'package:beautyshot/Views/talent_screens/talent_home_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/controller/client_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

import '../components/loading_widget.dart';

class AuthController extends GetxController {
  // Initialize the flutter app
  late FirebaseApp firebaseApp;
  late User firebaseUser;
  late FirebaseAuth firebaseAuth;
  late String name;
  // final userController = Get.put(UserController());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final clientController = Get.put(ClientController());
  CollectionReference userRole = FirebaseFirestore.instance.collection('userRole');
  late String userType;
  Future initializeFirebaseApp() async {
    firebaseApp = await Firebase.initializeApp();
  }

  Future signInWithEmail(String email,String password) async {
    try {
      // Show loading screen till we complete our login workflow
      // Get.dialog(const Center(child: LoadingWidget()), barrierDismissible: false);
      Get.defaultDialog(title: "Signing In",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
      // for flutter fire we need to maker sure Firebase is initialized before dong any auth related activity
      await initializeFirebaseApp();
      // Create Firebase auth for storing auth related info such as logged in user etc.
      firebaseAuth = FirebaseAuth.instance;
      // Start of google sign in workflow
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String userId = firebaseAuth.currentUser!.uid.toString();
      // final SharedPreferences prefs = await _prefs;
      // prefs.setString('usertype', 'Email');
      // update the state of controller variable to be reflected throughout the app
      update();
      Get.back();
      getUserData(userId);
      // Get.off(const TalentHome());
    } on FirebaseAuthException catch (ex) {
      Get.back();
      if (ex.code == 'user-not-found') {
        debugPrint('No user found for that email.');

        Fluttertoast.showToast(
            msg: "No user found for this email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else if (ex.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        // Show Error if we catch any error
        Fluttertoast.showToast(
            msg: "Wrong Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }

  Future signUpWithEmail(String email, String password) async {
    try {
      // Show loading screen till we complete our login workflow
      // Get.dialog(const Center(child: LoadingWidget()), barrierDismissible: false);
      Get.defaultDialog(title: "Signing Up",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
      // for flutter fire we need to maker sure Firebase is initialized before dong any auth related activity
      await initializeFirebaseApp();
      // Create Firebase auth for storing auth related info such as logged in user etc.
      firebaseAuth = FirebaseAuth.instance;
      // Start of google sign in workflow
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // update the state of controller variable to be reflected throughout the app
      update();
      Get.back();

      Get.off(const ProfilePictureScreen());
    } on FirebaseAuthException catch (ex) {
      Get.back();
      if (ex.code == 'weak-password') {
        debugPrint('No user found for that email.');

        Fluttertoast.showToast(
            msg: "Weak Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
          }
      else if (ex.code == 'wrong-password') {
            debugPrint('Wrong password provided for that user.');
        // Show Error if we catch any error

            Fluttertoast.showToast(
                msg: "Wrong Password",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
      else if (ex.code == 'email-already-in-use') {
            debugPrint('User already Exist.');
        // Show Error if we catch any error

            Fluttertoast.showToast(
                msg: "User already exist",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
    }
  }
  Future clientSignUpWithEmail(String email, String password) async {
    try {
      // Show loading screen till we complete our login workflow
      // Get.dialog(const Center(child: LoadingWidget()), barrierDismissible: false);
      Get.defaultDialog(title: "Signing Up",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
      // for flutter fire we need to maker sure Firebase is initialized before dong any auth related activity
      await initializeFirebaseApp();
      // Create Firebase auth for storing auth related info such as logged in user etc.
      firebaseAuth = FirebaseAuth.instance;
      // Start of google sign in workflow
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // update the state of controller variable to be reflected throughout the app
      update();
      Get.back();
      SharedPreferences prefs = await _prefs;
       String clientId = FirebaseAuth.instance.currentUser!.uid.toString();
       String companyName = prefs.getString("companyName")!;
       String companyPhoneNumber  = prefs.getString("companyPhoneNumber")!;
       String companyEmail = prefs.getString("companyEmail")!;
       String companyDunsNumber  = prefs.getString("companyDunsNumber")!;
       String companyTaxId  = prefs.getString("companyTaxId")!;
       String companyAddress = prefs.getString("companyAddress")!;
       String userType = prefs.getString("userType")!;
       List ignoreList = [""];
      clientController.addClientData(clientId, companyName, companyPhoneNumber, companyEmail, companyDunsNumber, companyTaxId, companyAddress,userType,ignoreList);

      // Get.off(const ClientHome());
    } on FirebaseAuthException catch (ex) {
      Get.back();
      if (ex.code == 'weak-password') {
        debugPrint('No user found for that email.');

        Fluttertoast.showToast(
            msg: "Weak passowrd",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
          }
      else if (ex.code == 'wrong-password') {
            debugPrint('Wrong password provided for that user.');
        // Show Error if we catch any error
            Fluttertoast.showToast(
                msg: "Wrong Password",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
      else if (ex.code == 'email-already-in-use') {
            debugPrint('User already Exist.');
        // Show Error if we catch any error

            Fluttertoast.showToast(
                msg: "User already exist",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
    }
  }

  Future getUserData(String userId) async {
    return userRole
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
          userType = documentSnapshot.get('userType');
        if(userType == "client" ) {
          Get.off(()=>ClientHome());
        }
        else{
          Get.off(()=>TalentHome());
        }
      }
    });
  }

  Future signOut() async {
    // Show loading widget till we sign out
    // Get.dialog(const Center(child: LoadingWidget()), barrierDismissible: false);
    Get.defaultDialog(title: "Signing Out",content:const LoadingWidget(),titleStyle: KFontStyle.kTextStyle14Black  );
    await FirebaseAuth.instance.signOut();
    // Get.back();
    // Navigate to Login again
    Get.offAll(()=>const ClientTalentScreen());
  }

}