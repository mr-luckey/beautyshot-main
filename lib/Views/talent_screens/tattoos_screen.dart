import 'dart:io';
import 'package:age_calculator/age_calculator.dart';

import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row_white.dart';

import 'package:beautyshot/controller/talent_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';
import 'package:path/path.dart' as path;

class TattoosScreen extends StatefulWidget {
  const TattoosScreen({Key? key}) : super(key: key);

  @override
  State<TattoosScreen> createState() => _TattoosScreenState();
}

class _TattoosScreenState extends State<TattoosScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final userController = Get.put(UserController());
  late String imageLink;
  var _imageFile;
  final imagePicker = ImagePicker();
  bool isTattoo = false;
  bool tattooVisibility = false;
  late bool isScar;

  late String drivingLicense;
  late String idCard;
  late String passport;
  late String otherId;
  late String profilePicture;
  late Timestamp dateOfBirth;
  late String gender;
  late String county;
  late String state;
  late String city;
  late String postalCode;
  late String firstName;
  late String lastName;
  late String email;
  late String userId;
  late String userType;
  late bool isDrivingLicense ;
  late bool isIdCard ;
  late  bool isPassport ;
  late bool isOtherId ;


  late String country;
  late String hairColor;
  late String eyeColor;
  late double heightCm;
  late double heightFeet;
  late double waistCm;
  late double waistInches;
  late double weightKg;
  late double weightPound;
  late String buildType;
  late double wearSizeCm;
  late double wearSizeInches;
  late double chestCm;
  late double chestInches;
  late double hipCm;
  late double hipInches;
  late double inseamCm;
  late double inseamInches;
  late double shoesCm;
  late double shoesInches;
  late String scarPicture;

 late int age;
   String tattooPicture = "";
  List<String> languages = <String>[];
  List<String> sports = <String>[];
  List<String> hobbies = <String>[];
  List<String> talent = <String>[];
  List<String> portfolioImageLink = <String>[];
  List<String> portfolioVideoLink = <String>[];
  List<String> polaroidImageLink = <String>[];

  late DateDuration duration;
  //Pick Scar Image
  Future pickImage(ImageSource imageSource) async {
    Get.back();
    final pickedFile = await imagePicker.pickImage(source: imageSource);
    // File? croppedFile = await ImageCropper().cropImage(
    //     sourcePath: pickedFile!.path,
    //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //     ],
    //     androidUiSettings: const AndroidUiSettings(
    //         toolbarTitle: 'Crop your image',
    //         toolbarColor: Color(0xffD33B36),
    //         toolbarWidgetColor: Colors.white,
    //         initAspectRatio: CropAspectRatioPreset.original,
    //         lockAspectRatio: true),
    //     iosUiSettings: const IOSUiSettings(
    //       title: 'Crop your image',
    //       minimumAspectRatio: 1.0,
    //       aspectRatioLockEnabled: true,
    //     ));
    setState(()async {
      _imageFile = File(pickedFile!.path);
      if(_imageFile != null){
        setState(() {
          tattooVisibility = true;
        });
      }
    });
  }
  //On Forward Press
  onForwardPress()async{
    SharedPreferences prefs = await _prefs;
    if(isTattoo){
      if(_imageFile == null){
        Fluttertoast.showToast(
            msg: "Please select picture or switch to no",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else{
        var tattooImage = prefs.getString('tattooPicture')!;
        if(tattooImage.isEmpty){
          uploadImageToFirebase();
        }
        else{
          Get.to(()=>const TattoosScreen());
        }
        // uploadImageToFirebase();
      }

    }
    else{
      prefs.setBool('isTattoo', isTattoo);
      prefs.setString('tattooPicture', tattooPicture);
      uploadUserData();
      // Get.to(()=>const TalentHome());
    }
  }
  //Upload Image
  Future uploadImageToFirebase() async {

    Get.defaultDialog(title: "Uploading Image",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    String fileName = path.basename(_imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('modelTattooPictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) async{
        imageLink = value;
        SharedPreferences prefs = await _prefs;
        prefs.setBool('isTattoo', isTattoo);
        prefs.setString('tattooPicture', imageLink);
        Get.back();

        Fluttertoast.showToast(
            msg: "Tattoo picture uploaded successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        uploadUserData();
      },
    );
  }
  uploadUserData()async{
    SharedPreferences prefs = await _prefs;
    userId = FirebaseAuth.instance.currentUser!.uid.toString();

    profilePicture = prefs.getString("profilePicture")!;
    dateOfBirth = Timestamp.fromDate(DateTime.parse(prefs.getString("dateOfBirth")!));
    gender = prefs.getString("gender")!;
    county = prefs.getString("county")!;
    state = prefs.getString("state")!;
    city = prefs.getString("city")!;
    postalCode = prefs.getString("postalCode")!;
    firstName = prefs.getString("firstName")!;
    lastName = prefs.getString("lastName")!;
    email = prefs.getString("email")!;
    userType = "model";

    var date  = DateTime.parse(dateOfBirth.toDate().toString());
    duration = AgeCalculator.age(date);
     age = duration.years;
    if(prefs.getString("drivingLicense") != null){
      drivingLicense = prefs.getString("drivingLicense")!;
      isDrivingLicense = prefs.getBool("isDrivingLicense")!;
    }
    else{
      drivingLicense = "";
      isDrivingLicense = false;
    }


    if(prefs.getString("idCard") != null){
      idCard = prefs.getString("idCard")!;
      isIdCard = prefs.getBool("isIdCard")!;
    }
    else{
      idCard = "";
      isIdCard = false;
    }



    if(prefs.getString("passport") != null){
      passport = prefs.getString("passport")!;
      isPassport = prefs.getBool("isPassport")!;
    }
    else{
      passport = "";
      isPassport = false;
    }


    if(prefs.getString("otherId") != null){
      otherId = prefs.getString("otherId")!;
      isOtherId = prefs.getBool("isOtherId")!;
    }
    else{
      otherId = "";
      isOtherId = false;
    }



    country = prefs.getString("country")!;
    hairColor = prefs.getString("hairColor")!;
    eyeColor = prefs.getString("eyeColor")!;
    heightCm = prefs.getDouble("heightCm")!;
    heightFeet = prefs.getDouble("heightFeet")!;
    waistCm = prefs.getDouble("waistCm")!;
    waistInches = prefs.getDouble("waistInches")!;
    weightKg = prefs.getDouble("weightKg")!;
    weightPound = prefs.getDouble("weightPound")!;
    buildType = prefs.getString("buildType")!;
    wearSizeCm = prefs.getDouble("wearSizeCm")!;
    wearSizeInches = prefs.getDouble("wearSizeInches")!;
    chestCm = prefs.getDouble("chestCm")!;
    chestInches = prefs.getDouble("chestInches")!;
    hipCm = prefs.getDouble("hipCm")!;
    hipInches = prefs.getDouble("hipInches")!;
    inseamCm = prefs.getDouble("inseamCm")!;
    inseamInches = prefs.getDouble("inseamInches")!;
    shoesCm = prefs.getDouble("shoesCm")!;
    shoesInches = prefs.getDouble("shoesInches")!;
    scarPicture = prefs.getString("scarPicture")!;
    tattooPicture = prefs.getString("tattooPicture")!;

    isScar = prefs.getBool("isScar")!;
    isTattoo = prefs.getBool("isTattoo")!;

    languages = prefs.getStringList('languages')!;
    sports = prefs.getStringList('sports')!;
    hobbies = prefs.getStringList('hobbies')!;
    talent = prefs.getStringList('talent')!;
    portfolioImageLink = prefs.getStringList('portfolioImageLink')!;
    portfolioVideoLink = prefs.getStringList('portfolioVideoLink')!;
    polaroidImageLink = prefs.getStringList('polaroidImageLink')!;

    // userController.updateUser(userId, , , , , , , , , , , , , , ,,,,,,,,,,,,,,,,,);
    userController.addUserData(userId, userType,firstName, lastName, email, profilePicture, dateOfBirth, gender, county,
        state, city, postalCode, drivingLicense, idCard, passport, otherId,isDrivingLicense,isIdCard,isPassport,isOtherId,
        country,hairColor,eyeColor,heightCm,heightFeet,waistCm,waistInches,weightKg,weightPound,buildType,wearSizeCm,wearSizeInches,
        chestCm,chestInches,hipCm,hipInches,inseamCm,inseamInches,shoesCm,shoesInches,scarPicture,tattooPicture,isScar,isTattoo,
        languages, sports,hobbies,talent,portfolioImageLink,portfolioVideoLink,polaroidImageLink,age);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Top Row
              TopRowWhite(20),
              //Body
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Text do you have any tattoos
                      TitleText(Strings.doYouHaveAnyTattoos),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(Strings.no,style: KFontStyle.kTextStyle14Black,),
                            const SizedBox(width: 3,),
                            FlutterSwitch(
                                value: isTattoo,
                                activeColor: Color(KColors.kColorPrimary),
                                inactiveColor: Color(KColors.kColorWhite),
                                inactiveToggleColor: Color(KColors.kColorPrimary),
                                activeToggleColor: Color(KColors.kColorWhite),
                                inactiveSwitchBorder: Border.all(
                                  color: Color(KColors.kColorPrimary),
                                  width: 1.0,
                                ),
                                width: 50.0,
                                height: 25.0,
                                onToggle: (val){
                                  setState(() {
                                    isTattoo = val;
                                  });
                                }),
                            const SizedBox(width: 3,),
                            Text(Strings.yes,style: KFontStyle.kTextStyle14Black,),
                          ],
                        ),
                      )
                    ],
                  ),
                  //SizedBox
                  const SizedBox(height: 30,),

                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isTattoo = true;
                      });
                        Get.defaultDialog(title: "",titleStyle: KFontStyle.kTextStyle24Black,
                            content: Column(children: [
                              Buttons.whiteRectangularButton(Strings.camera, () {pickImage(ImageSource.camera); }),
                              Buttons.whiteRectangularButton(Strings.gallery, () {pickImage(ImageSource.gallery); }),
                            ],),
                            contentPadding: const EdgeInsets.only(left: 20,right: 20,bottom: 20));
                        // pickImage(ImageSource.gallery);


                    },
                      // child: WhiteRectangularLargeButton(Strings.attachPicture)),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 3.0), //(x,y)
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(14),
                          // border: Border.all(
                          //   color: Colors.grey,
                          // ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30,right: 30,top: 20,bottom: 20),
                              child: Text(Strings.attachPicture,style: KFontStyle.kTextStyle16BlackRegular,),
                            ),
                            Visibility(
                              visible: tattooVisibility,
                              child: const Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                              ),
                            ),
                          ],
                        ),
                      )),
                  //SizedBox
                  const SizedBox(height: 20,),
                  //Forward Button
                  // BackForwardButton(onForwardPress),
                  Buttons.backForwardButton(onForwardPress),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


