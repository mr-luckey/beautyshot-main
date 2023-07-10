import 'package:beautyshot/Views/client_screens/client_home_screen.dart';
import 'package:beautyshot/model/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController{

  late FirebaseApp firebaseApp;
  late User firebaseUser;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firestore;

  CollectionReference projects = FirebaseFirestore.instance.collection('projects');





  Future getUserData(String userId) async {
    return projects
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

  //Future addProject(String projectId,String projectName,String projectBudget, String projectFromDate,String projectTillDate,String projectCreatedBy,String projectLocation,String projectLatitude,String projectLongitude)
  Future addProject(ProjectModel newProjectModel)
  {

    return  projects.doc(newProjectModel.projectId).set(
      newProjectModel.toMap()
     /* 'projectId': newProjectModel.projectId,
      'projectName': newProjectModel.projectName,
      'projectBudget': newProjectModel.projectBudget,
      'projectFromDate': newProjectModel.projectFromDate,
      'projectTillDate': newProjectModel.projectTillDate,
      'projectCreatedBy': newProjectModel.projectCreatedBy,
      'projectLocation': newProjectModel.projectLocation,
      'projectLatitude': newProjectModel.projectLatitude,
      'projectLongitude': newProjectModel.projectLongitude,*/

    )..then((value) {

      Fluttertoast.showToast(
          msg: "Project created successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Get.offAll(() => const ClientHome());
      debugPrint("User Added");
    }).catchError((error) {
      debugPrint("Failed to add post: $error");
    });
  }

  Future addFirstOption(String projectId, List<String> modelId) {
    // Get.defaultDialog(title: "Adding User",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    return projects
        .doc(projectId)
        .update({'firstOption': FieldValue.arrayUnion(modelId),'pending': FieldValue.arrayUnion(modelId),
    })
        .then((value) {

      // Get.back();
      // Get.offAll(() => const TalentHome());
      debugPrint("Model added to Project $projectId");
    })
        .catchError((error) {
      debugPrint("Failed to update user: $error");
    });
  }
  Future addSecondOption(String projectId,List<String> modelId) {
    // Get.defaultDialog(title: "Adding User",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    return projects
        .doc(projectId)
        .update({'secondOption': FieldValue.arrayUnion(modelId),'pending': FieldValue.arrayUnion(modelId),
    })
        .then((value) {

      // Get.back();
      // Get.offAll(() => const TalentHome());
      debugPrint("Model added to Project $projectId");
    })
        .catchError((error) {
      debugPrint("Failed to update user: $error");
    });
  }

  Future deleteFirstOption(String projectId, modelId) {
    // Get.defaultDialog(title: "Adding User",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    return projects
        .doc(projectId)
        .update({'firstOption': FieldValue.arrayRemove(modelId),
    })
        .then((value) {

      // Get.back();
      // Get.offAll(() => const TalentHome());
      debugPrint("Model Deleted from Project $projectId");
    })
        .catchError((error) {
      debugPrint("Failed to delete user: $error");
    });
  }
  Future deleteSecondOption(String projectId, modelId) {
    // Get.defaultDialog(title: "Adding User",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    return projects
        .doc(projectId)
        .update({'secondOption': FieldValue.arrayRemove(modelId),
    })
        .then((value) {

      // Get.back();
      // Get.offAll(() => const TalentHome());
      debugPrint("Model deleted from to Project $projectId");
    })
        .catchError((error) {
      debugPrint("Failed to update user: $error");
    });
  }

  CollectionReference contracts = FirebaseFirestore.instance.collection('contracts');

  Future addContract(
      {required String contractId, required String clientId, required String projectId, required String projectName, required String jobTitle, required String amount, required String notes, required String clientPdf, required List modelIds, required String status, required String modelPdf,
      })
  {
    return  contracts.doc(contractId).set({
      'contractId': contractId,
      'clientId': clientId,
      'projectId': projectId,
      'projectName': projectName,
      'jobTitle': jobTitle,
      'amount': amount,
      'notes': notes,
      'pdfLink': clientPdf,
      'modelIds': modelIds,
      'status': status,
      'modelPdf': modelPdf,
    })..then((value) {

      Fluttertoast.showToast(
          msg: "Contract sent successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Get.offAll(() => const ClientHome());
      debugPrint("Contract Added");
    }).catchError((error) {
      debugPrint("Failed to add post: $error");
    });
  }

  Future updateContract(String contractId, String modelPdf) {
    // Get.defaultDialog(title: "Adding User",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    return contracts
        .doc(contractId)
        .update({'modelPdf': modelPdf,
    })
        .then((value) {
      Get.back();
      debugPrint("Contract Updated $contractId");
    })
        .catchError((error) {
      debugPrint("Failed to update contract: $error");
    });
  }

  Future updatePendingProject(String projectId, modelId) {
    // Get.defaultDialog(title: "Adding User",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    return projects
        .doc(projectId)
        .update({'pending': FieldValue.arrayRemove(modelId),
    })
        .then((value) {

      // Get.back();
      // Get.offAll(() => const TalentHome());
      debugPrint("Model removed from to pending list $projectId");
    })
        .catchError((error) {
      debugPrint("Failed to remove user: $error");
    });
  }

  Future updateConfirmedProject(String projectId,modelId) {
    // Get.defaultDialog(title: "Adding User",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    return projects
        .doc(projectId)
        .update({'confirmed': FieldValue.arrayUnion(modelId),
    })
        .then((value) {

      // Get.back();
      // Get.offAll(() => const TalentHome());
      debugPrint("Model added to Confirmed list $projectId");
    })
        .catchError((error) {
      debugPrint("Failed to update user: $error");
    });
  }


}
