import 'package:beautyshot/Views/talent_screens/done_screen.dart';
import 'package:beautyshot/Views/talent_screens/talent_home_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/model/talent_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController{

  late FirebaseApp firebaseApp;
  late User firebaseUser;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firestore;

  CollectionReference models = FirebaseFirestore.instance.collection('models');


   Future addUserData(String userId,String userType,String firstName, String lastName,String email,String profilePicture,
       Timestamp dateOfBirth,String gender,String county,String state,String city,String postalCode,String drivingLicense,
       String idCard,String passport,String otherId,bool isDrivingLicense,bool isIdCard,bool isPassport,bool isOtherId,
       String country,String hairColor, String eyeColor,double heightCm,double heightFeet,double waistCm,double waistInches,
       double weightKg,double weightPound,String buildType,double wearSizeCm,double wearSizeInches,
       double chestCm,double chestInches,double hipCm,double hipInches,double inseamCm,double inseamInches,
       double shoesCm,double shoesInches,String scarPicture,String tattooPicture,bool isScar,
       bool isTattoo,languages,sports,hobbies,talent,portfolioImageLink,portfolioVideoLink,polaroidImageLink,int age)
   {

    return  models.doc(userId).set({
        'userId': userId,
        'userType': userType,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'profilePicture': profilePicture,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'county': county,
        'state': state,
        'city': city,
        'postalCode': postalCode,
        'drivingLicense': drivingLicense,
        'idCard': idCard,
        'passport': passport,
        'otherId': otherId,
        'isDrivingLicense': isDrivingLicense,
        'isIdCard': isIdCard,
        'isPassport': isPassport,
        'isOtherId': isOtherId,
        'country': country,
        'hairColor': hairColor,
        'eyeColor': eyeColor,
        'heightCm': heightCm,
        'heightFeet': heightFeet,
        'waistCm': waistCm,
        'waistInches': waistInches,
        'weightKg': weightKg,
        'weightPound': weightPound,
        'buildType': buildType,
        'wearSizeCm': wearSizeCm,
        'wearSizeInches': wearSizeInches,
        'chestCm': chestCm,
        'chestInches': chestInches,
        'hipCm': hipCm,
        'hipInches': hipInches,
        'inseamCm': inseamCm,
        'inseamInches': inseamInches,
        'shoesCm': shoesCm,
        'shoesInches': shoesInches,
        'scarPicture': scarPicture,
        'tattooPicture': tattooPicture,
        'isScar': isScar,
        'isTattoo': isTattoo,
        'languages': languages,
        'sports': sports,
        'hobbies': hobbies,
        'talent': talent,
        'portfolioImageLink': portfolioImageLink,
        'portfolioVideoLink': portfolioVideoLink,
        'polaroidImageLink': polaroidImageLink,
        'age': age,

      })..then((value) async{
      addUserType(userId, userType);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Get.offAll(() => const TalentHome());
        debugPrint("User Added");
      }).catchError((error) {
      debugPrint("Failed to add post: $error");
      });
    }
  CollectionReference userRole = FirebaseFirestore.instance.collection('userRole');
    Future addUserType(String userId,String userType)
   {
    return  userRole.doc(userId).set({
        'userId': userId,
        'userType': userType,
      })..then((value) {
      // Get.offAll(() => const DoneScreen());
        debugPrint("User Added");
      }).catchError((error) {
      debugPrint("Failed to add post: $error");
      });
    }

  Future getUserData(String userId) async {
     return models
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
      String eyeColor,double heightCm,double heightFeet,double waistCm,double waistInches,
      double weightKg,double weightPound,String buildType,double wearSizeCm,double wearSizeInches,
      double chestCm,double chestInches,double hipCm,double hipInches,double inseamCm,double inseamInches,
      double shoesCm,double shoesInches,String scarPicture,String tattooPicture,bool isScar,
      bool isTattoo,languages,sports,hobbies,talent,portfolioImageLink,portfolioVideoLink,polaroidImageLink) {
    Get.defaultDialog(title: "Uploading Image",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    return models
        .doc(userId)
        .update({'country': country,'hairColor': hairColor,'eyeColor' : eyeColor,'heightCm' : heightCm,'heightFeet' : heightFeet,
      'waistCm' : waistCm,'waistInches' : waistInches,'weightKg' : weightKg,'weightPound' : weightPound,'buildType' : buildType,
      'wearSizeCm' : wearSizeCm,'wearSizeInches' : wearSizeInches,'chestCm' : chestCm,'chestInches' : chestInches,
      'hipCm' : hipCm,'hipInches' : hipInches,'inseamCm' : inseamCm,'inseamInches' : inseamInches,'shoesCm' : shoesCm,'shoesInches' : shoesInches,
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
  Future updateSneakUser(String userName, String userId,String firstName,String lastName,String imageLink) {
    return models
        .doc(userId)
        .update({'userName': userName,'firstName': firstName,'lastName' : lastName,'userImage' : imageLink})
        .then((value) {
      Get.back();
      debugPrint("User Updated");
        })
        .catchError((error) {
      debugPrint("Failed to update user: $error");
        });
  }

  Future updateUserName(String userName, String userId) {
    return models
        .doc(userId)
        .update({'userName': userName,})
        .then((value) {
     // Get.to(() => const EditProfileScreen());

     Fluttertoast.showToast(
         msg: "Username updated successfully",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 2,
         backgroundColor: Colors.green,
         textColor: Colors.white,
         fontSize: 16.0
     );
     debugPrint("User Updated");
    })
        .catchError((error) {
      debugPrint("Failed to update user: $error");
        });
  }
  }
