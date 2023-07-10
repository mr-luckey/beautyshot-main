import 'package:beautyshot/model/hair_color_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api extends GetxController{
  late FirebaseApp firebaseApp;
  late User firebaseUser;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firestore;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  CollectionReference eyeColor = FirebaseFirestore.instance.collection('eyeColor');
  CollectionReference gender = FirebaseFirestore.instance.collection('gender');
  CollectionReference buildType = FirebaseFirestore.instance.collection('buildType');

  List<String> hairColorList = [];
  final List<HairColorModel> hairColorData = <HairColorModel>[];


  Future getHairColor() async {

 return FirebaseFirestore.instance.collection('hairColor').snapshots().listen((event) async {
   hairColorList.clear();
   SharedPreferences prefs = await _prefs;

      for (var element in event.docs) {
        hairColorList.add(element.data().toString());
        hairColorData.add(HairColorModel.fromMap(element.data()));
      }
   prefs.setStringList('hairColorList',hairColorList);

      debugPrint(prefs.getStringList('hairColorList').toString());
    });
  }

}