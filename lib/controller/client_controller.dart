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

class ClientController extends GetxController{

  late FirebaseApp firebaseApp;
  late User firebaseUser;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firestore;
  final userController = Get.put(UserController());

  CollectionReference clients = FirebaseFirestore.instance.collection('clients');

  Future addClientData(String clientId,String companyName,String companyPhone, String companyEmail,String dunsNumber,String taxId,String address,String userType,List ignoreList)
  {

    return  clients.doc(clientId).set({
      'clientId': clientId,
      'companyName': companyName,
      'companyPhone': companyPhone,
      'companyEmail': companyEmail,
      'dunsNumber': dunsNumber,
      'taxId': taxId,
      'address': address,
      'userType': userType,
      'ignoreList': ignoreList,
    })..then((value) {

      Fluttertoast.showToast(
          msg: "User signed up successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      userController.addUserType(clientId, userType);
      Get.offAll(() => const ClientHome());
      debugPrint("User Added");
    }).catchError((error) {
      debugPrint("Failed to add post: $error");
    });
  }

  Future getUserData(String userId) async {
    return clients
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {

        // Get.offAll(()=> const HomeScreen());
      }
      else{

        // Get.offAll(()=> const ProfileScreen());
      }
    });
  }

  Future updateUser(String userId, String country,String hairColor,
      String eyeColor,String heightUnit,String height,String waistUnit,String waist,
      String weightUnit,String weight,String buildType,String wearSizeUnit,String wearSize,
      String chestUnit,String chest,String hipUnit,String hip,String inseamUnit,String inseam,
      String shoeSizeUnit,String shoeSize,String scarPicture,String tattooPicture,bool isScar,
      bool isTattoo,languages,sports,hobbies,talent,portfolioImageLink,portfolioVideoLink,polaroidImageLink) {
    Get.defaultDialog(title: "Uploading Image",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    return clients
        .doc(userId)
        .update({'country': country,'hairColor': hairColor,'eyeColor' : eyeColor,'heightUnit' : heightUnit,'height' : height,
      'waistUnit' : waistUnit,'waist' : waist,'weightUnit' : weightUnit,'weight' : weight,'buildType' : buildType,
      'wearSizeUnit' : wearSizeUnit,'wearSize' : wearSize,'chestUnit' : chestUnit,'chest' : chest,
      'hipUnit' : hipUnit,'hip' : hip,'inseamUnit' : inseamUnit,'inseam' : inseam,'shoeSizeUnit' : shoeSizeUnit,'shoeSize' : shoeSize,
      'scarPicture' : scarPicture,'tattooPicture' : tattooPicture,'isScar' : isScar,'isTattoo' : isTattoo,'languages' : languages,
      'sports' : sports,'hobbies' : hobbies,'talent' : talent,'portfolioImageLink' : portfolioImageLink,'portfolioVideoLink' : portfolioVideoLink,'polaroidImageLink' : polaroidImageLink,
    })
        .then((value) {

      Get.back();
      Get.offAll(() => const TalentHome());
      debugPrint("User Updated");
    })
        .catchError((error) {
      debugPrint("Failed to update user: $error");
    });
  }
  //Add user to ignore list
  Future ignoreUser(String clientId, List<String> modelId) {
    // Get.defaultDialog(title: "Adding User",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    return clients
        .doc(clientId)
        .update({'ignoreList': FieldValue.arrayUnion(modelId),
    })
        .then((value) {
      // Get.back();
      // Get.offAll(() => const TalentHome());
      debugPrint("Model added to ignoreList $clientId");
    })
        .catchError((error) {
      debugPrint("Failed to add user: $error");
    });
  }
}
