import 'dart:io';

import 'package:beautyshot/Views/talent_screens/address_screen.dart';
import 'package:beautyshot/Views/talent_screens/terms_and_conditions_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/components/title_text.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import '../../components/constants.dart';
import '../../components/top_row_white.dart';

class IdentityScreen extends StatefulWidget {
  const IdentityScreen({Key? key}) : super(key: key);

  @override
  State<IdentityScreen> createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var _drivingLicense;
  var _idCard;
  var _passport;
  var _otherId;
  bool drivingLicenseVisibility = false;
  bool idCardVisibility = false;
  bool passportVisibility = false;
  bool otherIdVisibility = false;
  final imagePicker = ImagePicker();
   String drivingLicense = '';
   String idCard = '';
   String passport = '';
   String otherId = '';
   bool isDrivingLicense = false;
   bool isIdCard = false;
   bool isPassport = false;
   bool isOtherId = false;

  //Pick DrivingLicense
  Future pickDrivingLicense(ImageSource imageSource) async {
    final pickedFile = await imagePicker.pickImage(source: imageSource);
    File? croppedFile = (await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
        activeControlsWidgetColor: Color(0xff4B6DFC),
        toolbarTitle: 'Crop your image',
        toolbarColor: Color(0xff4B6DFC),
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
         IOSUiSettings(
          title: 'Crop your image',
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: false,
        ),],

    )) as File?;
    // File? croppedFile = await ImageCropper().cropImage(
    //     sourcePath: pickedFile!.path,
    //     // aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //       CropAspectRatioPreset.ratio3x2,
    //       CropAspectRatioPreset.original,
    //       CropAspectRatioPreset.ratio4x3,
    //       CropAspectRatioPreset.ratio16x9
    //     ],
    //     androidUiSettings: const AndroidUiSettings(
    //       activeControlsWidgetColor: Color(0xff4B6DFC),
    //         toolbarTitle: 'Crop your image',
    //         toolbarColor: Color(0xff4B6DFC),
    //         toolbarWidgetColor: Colors.white,
    //         initAspectRatio: CropAspectRatioPreset.original,
    //         lockAspectRatio: false),
    //     iosUiSettings: const IOSUiSettings(
    //       title: 'Crop your image',
    //       minimumAspectRatio: 1.0,
    //       aspectRatioLockEnabled: false,
    //     ));
    setState(()async {
      _drivingLicense = File(croppedFile!.path);
      Get.back();
      uploadDrivingLicenseToFirebase();
    });
  }
  //Pick IdCard
  Future pickIdCard(ImageSource imageSource) async {
    final pickedFile = await imagePicker.pickImage(source: imageSource);
    File? croppedFile = (await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,

        // aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            activeControlsWidgetColor: Color(0xff4B6DFC),
            toolbarTitle: 'Crop your image',
            toolbarColor: Color(0xff4B6DFC),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop your image',
            minimumAspectRatio: 1.0,
            aspectRatioLockEnabled: false,
          )],
       )) as File?;
    setState(()async {
      _idCard = File(croppedFile!.path);
      Get.back();
      uploadIdCardToFirebase();
    });
  }
  //Pick Passport
  Future pickPassport(ImageSource imageSource) async {
    final pickedFile = await imagePicker.pickImage(source: imageSource);
    File? croppedFile = (await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        // aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            activeControlsWidgetColor: Color(0xff4B6DFC),
            toolbarTitle: 'Crop your image',
            toolbarColor: Color(0xff4B6DFC),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop your image',
            minimumAspectRatio: 1.0,
            aspectRatioLockEnabled: false,
          )],
      )) as File?;
    setState(()async {
      _passport = File(croppedFile!.path);
      Get.back();
      uploadPassportToFirebase();
    });
  }
  //Pick OtherId
  Future pickOtherId(ImageSource imageSource) async {
    final pickedFile = await imagePicker.pickImage(source: imageSource);
    File? croppedFile = (await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        // aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
         aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              activeControlsWidgetColor: Color(0xff4B6DFC),
              toolbarTitle: 'Crop your image',
              toolbarColor: Color(0xff4B6DFC),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop your image',
            minimumAspectRatio: 1.0,
            aspectRatioLockEnabled: false,
          )
        ],
        )) as File?;
    setState(()async {
      _otherId = File(croppedFile!.path);
      Get.back();
      uploadOtherIdToFirebase();
    });
  }
  //Upload Driving License
  Future uploadDrivingLicenseToFirebase() async {

    Get.defaultDialog(title: "Uploading Driving License",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    String fileName = path.basename(_drivingLicense.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('modelIdentityPictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_drivingLicense);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) async{
            SharedPreferences prefs = await _prefs;
        setState(() {
          drivingLicense = value;
          isDrivingLicense = true;
          drivingLicenseVisibility = true;
          prefs.setString('drivingLicense', drivingLicense);
          prefs.setBool('isDrivingLicense', isDrivingLicense);
        });
        Get.back();
        Fluttertoast.showToast(
                msg: "Driving License Picture Uploaded Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
      },
    );
  }
  //Upload IdCard
  Future uploadIdCardToFirebase() async {

    Get.defaultDialog(title: "Uploading IdCard",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    String fileName = path.basename(_idCard.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('modelIdentityPictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_idCard);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) async{
            SharedPreferences prefs = await _prefs;
        setState(() {
          idCard = value;
          isIdCard = true;
          idCardVisibility = true;
          prefs.setString('idCard', idCard);
          prefs.setBool('isIdCard', isIdCard);
        });

        Get.back();
        Fluttertoast.showToast(
                msg: "ID Card Picture Uploaded Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
      },
    );
  }
  //Upload Passport
  Future uploadPassportToFirebase() async {

    Get.defaultDialog(title: "Uploading Passport",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    String fileName = path.basename(_passport.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('modelIdentityPictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_passport);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) async{
            SharedPreferences prefs = await _prefs;
        setState(() {
          passport = value;
          isPassport = true;
          passportVisibility = true;
          prefs.setString('passport', passport);
          prefs.setBool('isPassport', isPassport);
        });
        Get.back();
        Fluttertoast.showToast(
                msg: "Passport Picture Uploaded Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
      },
    );
  }
  //Upload Other Id
  Future uploadOtherIdToFirebase() async {

    Get.defaultDialog(title: "Uploading Other ID",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    String fileName = path.basename(_otherId.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('modelIdentityPictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_otherId);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) async{
            SharedPreferences prefs = await _prefs;
        setState(() {
          otherId = value;
          isOtherId = true;
          otherIdVisibility = true;
          prefs.setString('otherId', otherId);
          prefs.setBool('isOtherId', isOtherId);
        });
        Get.back();
            Fluttertoast.showToast(
                msg: "Other ID Picture Uploaded Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
      },
    );
  }


  selectDrivingLicense(){
    pickDrivingLicense(ImageSource.gallery);
  }
  selectIdCard(){
    pickIdCard(ImageSource.gallery);
  }
  selectPassport(){
    pickPassport(ImageSource.gallery);
  }
  selectOther(){
    pickOtherId(ImageSource.gallery);
  }

  onForwardPress()async{

    if(drivingLicense == "" && idCard == "" && passport == "" && otherId == ""){
      Fluttertoast.showToast(
          msg: "At least one Id is required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    else {
      Get.to(() => const TermsAndConditions());
    }
  }
  void persistLastRoute(String routeName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Strings.lastRouteKey, routeName);
  }
  setInitialValues() async{
    SharedPreferences prefs = await _prefs;

    setState(() {


    if(prefs.getString('drivingLicense') != null && prefs.getString('drivingLicense') != ""){
      drivingLicense = prefs.getString('drivingLicense')!;
      drivingLicenseVisibility = true;
    }
    else{ drivingLicense = '';}

    if(prefs.getString('idCard') != null && prefs.getString('idCard') != ""){
      idCard = prefs.getString('idCard')!;
      idCardVisibility = true;
    }
    else{idCard = '';}

    if(prefs.getString('passport') != null && prefs.getString('passport') != ""){
      passport = prefs.getString('passport')!;
      passportVisibility = true;
    }
    else{passport = '';}

    if(prefs.getString('otherId') != null && prefs.getString('otherId') != ""){
      otherId = prefs.getString('otherId')!;
      otherIdVisibility = true;
    }
    else{otherId = '';}

    });


  }
  @override
  void initState() {
    super.initState();
    setInitialValues();
    persistLastRoute('/talentIdentity');
  }
  Future<bool> _willPopCallback() async {
    Get.to(()=>const AddressScreen());
    return false;
    // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Top Row
                TopRowWhite(6),
                //Body
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text Identity
                      TitleText(Strings.identity),
                      //SizedBox
                      const SizedBox(height: 30,),
                      //Driving License
                      GestureDetector(
                        onTap: (){
                          Get.defaultDialog(title: "",titleStyle: KFontStyle.kTextStyle24Black,
                              content: Column(children: [
                                Buttons.whiteRectangularButton(Strings.camera, () {pickDrivingLicense(ImageSource.camera); }),
                                Buttons.whiteRectangularButton(Strings.gallery, () {pickDrivingLicense(ImageSource.gallery); }),
                              ],),
                              contentPadding: const EdgeInsets.only(left: 40,right: 40,bottom: 20));
                        },
                          // child: PlainWhiteButton(Strings.drivingLicense)),
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
                              borderRadius: BorderRadius.circular(50),
                              // border: Border.all(
                              //   color: Colors.grey,
                              // ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(Strings.drivingLicense,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Visibility(
                                  visible: drivingLicenseVisibility,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      //ID Card
                      GestureDetector(
                        onTap: (){
                          Get.defaultDialog(title: "",titleStyle: KFontStyle.kTextStyle24Black,
                              content: Column(children: [
                                Buttons.whiteRectangularButton(Strings.camera, () {pickIdCard(ImageSource.camera); }),
                                Buttons.whiteRectangularButton(Strings.gallery, () {pickIdCard(ImageSource.gallery); }),
                              ],),
                              contentPadding: const EdgeInsets.only(left: 40,right: 40,bottom: 20));
                        },
                          // child: PlainWhiteButton(Strings.idCard)),
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
                              borderRadius: BorderRadius.circular(50),
                              // border: Border.all(
                              //   color: Colors.grey,
                              // ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(Strings.idCard,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Visibility(
                                  visible: idCardVisibility,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                  ),
                                ),
                              ],
                            ),
                          ),),
                      //Passport
                      GestureDetector(
                        onTap: (){
                          Get.defaultDialog(title: "",titleStyle: KFontStyle.kTextStyle24Black,
                              content: Column(children: [
                                Buttons.whiteRectangularButton(Strings.camera, () {pickPassport(ImageSource.camera); }),
                                Buttons.whiteRectangularButton(Strings.gallery, () {pickPassport(ImageSource.gallery); }),
                              ],),
                              contentPadding: const EdgeInsets.only(left: 40,right: 40,bottom: 20));
                        },
                          // child: PlainWhiteButton(Strings.passport)),
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
                              borderRadius: BorderRadius.circular(50),
                              // border: Border.all(
                              //   color: Colors.grey,
                              // ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(Strings.passport,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Visibility(
                                  visible: passportVisibility,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                  ),
                                ),
                              ],
                            ),
                          ),),
                      //Other
                      GestureDetector(
                        onTap: (){
                          Get.defaultDialog(title: "",titleStyle: KFontStyle.kTextStyle24Black,
                              content: Column(children: [
                                Buttons.whiteRectangularButton(Strings.camera, () {pickOtherId(ImageSource.camera); }),
                                Buttons.whiteRectangularButton(Strings.gallery, () {pickOtherId(ImageSource.gallery); }),
                              ],),
                              contentPadding: const EdgeInsets.only(left: 40,right: 40,bottom: 20));
                        },
                          // child: PlainWhiteButton(Strings.other)),
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
                              borderRadius: BorderRadius.circular(50),
                              // border: Border.all(
                              //   color: Colors.grey,
                              // ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(Strings.other,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Visibility(
                                  visible: otherIdVisibility,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                  ),
                                ),
                              ],
                            ),
                          ),),
                      //SizedBox
                      const SizedBox(height: 20,),
                      //Back and Forward Button
                      // BackForwardButton(onForwardPress),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>const AddressScreen());
                            },
                            child: Container(
                              height: 56,
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                color: Color(KColors.kColorWhite),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Color(KColors.kColorPrimary),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40.0,right: 40,top: 20,bottom: 20),
                                child: Center(child: Text(Strings.back,style: KFontStyle.kTextStyle14Blue,)),
                              ),
                            ),
                          ),
                          //Forward Button
                          GestureDetector(
                            onTap: onForwardPress,
                            child: const Icon(Icons.navigate_next_rounded,size: 52,),
                          ),
                        ],),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


