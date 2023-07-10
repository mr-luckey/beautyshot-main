import 'package:beautyshot/Views/client_screens/client_home_screen.dart';
import 'package:beautyshot/Views/talent_screens/done_screen.dart';
import 'package:beautyshot/Views/talent_screens/talent_home_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/controller/talent_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{

  late FirebaseApp firebaseApp;
  late User firebaseUser;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firestore;
  final userController = Get.put(UserController());

  CollectionReference chats = FirebaseFirestore.instance.collection('chats');

  Future addChat(String clientId,String message,time, String modelId,String projectName, double price,String contract)
  {

    return  chats.doc().set({
      'clientId': clientId,
      'message': message,
      'time': time,
      'modelIds': modelId,
      'projectName': projectName,
      'price': price,
      'contract': contract,
    })..then((value) {
      Fluttertoast.showToast(
          msg: "Message sent successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Get.offAll(() => const ClientHome());
      debugPrint("Chat Created");
    }).catchError((error) {
      debugPrint("Failed to add post: $error");
    });
  }

  Future addTalentChat(String clientId,String message,time, String modelId)
  {

    return  chats.doc().set({
      'clientId': clientId,
      'message': message,
      'time': time,
      'modelIds': modelId,
    })..then((value) {

      Fluttertoast.showToast(
          msg: "Message sent successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // Get.offAll(() => const TalentHome());
      debugPrint("Chat Created");
    }).catchError((error) {
      debugPrint("Failed to add post: $error");
    });
  }

}
