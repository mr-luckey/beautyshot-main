import 'dart:async';
import 'package:beautyshot/Views/client_screens/client_home_screen.dart';
import 'package:beautyshot/Views/client_talent_screen.dart';
import 'package:beautyshot/Views/talent_screens/talent_home_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CollectionReference userRole = FirebaseFirestore.instance.collection('userRole');
  late String userType;

  FirebaseAuth auth = FirebaseAuth.instance;
  isUserLoggedIn() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        // print('User is currently signed out!');
        Get.off(() => const ClientTalentScreen());
      } else {
        String userId = auth.currentUser!.uid.toString();
        // print('User is signed in!');
        getUserData(userId);
      }
    });
  }
  Future getUserData(String userId) async {
    return userRole
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userType = documentSnapshot.get('userType');
        if(userType == "client" ) {
         Get.off(()=>const ClientHome());
        }
        else{
          Get.off(()=>const TalentHome());
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, callback);
  }

  Future callback() async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.camera,
    ].request();
    debugPrint(statuses[Permission.location].toString());
    isUserLoggedIn();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Image.asset(KImages.logo),
      ),),
    );
  }
}