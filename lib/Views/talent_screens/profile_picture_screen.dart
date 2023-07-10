import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:beautyshot/Views/talent_screens/date_of_birth_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';

import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class ProfilePictureScreen extends StatefulWidget {
  const ProfilePictureScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late String imageLink;
  var _imageFile;
  final imagePicker = ImagePicker();
  bool fromGallery = false;
  bool galleryIconVisibility = false;
  bool cameraIconVisibility = false;

  //Pick User Image
  Future pickImage(ImageSource imageSource) async {
    final pickedFile = await imagePicker.pickImage(source: imageSource);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            activeControlsWidgetColor: Color(0xff4B6DFC),
            toolbarTitle: 'Crop your image',
            toolbarColor: Color(0xff4B6DFC),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,


            // toolbarTitle: 'Cropper',
            // toolbarColor: Colors.red,
            // toolbarWidgetColor: Colors.white,
            // initAspectRatio: CropAspectRatioPreset.original,
            // lockAspectRatio: false
        ),
        IOSUiSettings(
            title: 'Crop your image',
            minimumAspectRatio: 1.0,
            aspectRatioLockEnabled: true,
          // title: 'Cropper',
        )
      ],
      // AndroidUiSettings: const AndroidUiSettings(
      //   activeControlsWidgetColor: Color(0xff4B6DFC),
      //   toolbarTitle: 'Crop your image',
      //   toolbarColor: Color(0xff4B6DFC),
      //   toolbarWidgetColor: Colors.white,
      //   initAspectRatio: CropAspectRatioPreset.original,
      //   lockAspectRatio: true,
      // ),
      // iosUiSettings: const IOSUiSettings(
      //   title: 'Crop your image',
      //   minimumAspectRatio: 1.0,
      //   aspectRatioLockEnabled: true,
      // ),
    );

    setState(() {
      _imageFile = File(croppedFile!.path);
      uploadImageToFirebase();
    });
  }

  Future uploadImageToFirebase() async {

    Get.defaultDialog(title: "Uploading Profile Picture",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    String fileName = path.basename(_imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('modelProfilePictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    taskSnapshot.ref.getDownloadURL().then(
          (value) async{
        imageLink = value;
        SharedPreferences prefs = await _prefs;
        prefs.setString('profilePicture', imageLink);
        // userController.addUserData(
        //     userName, userId, firstName, lastName, imageLink);
        Get.back();

        Fluttertoast.showToast(
            msg: "Profile picture uploaded successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

        if(fromGallery == true && imageLink.isNotEmpty){
          setState(() {
            galleryIconVisibility = true;
            cameraIconVisibility =false;
            prefs.setBool('fromGallery', fromGallery);
          });
        }
        else if(fromGallery == false && imageLink.isNotEmpty){
          setState(() {
            cameraIconVisibility = true;
            galleryIconVisibility = false;
            prefs.setBool('fromGallery', fromGallery);
          });
        }
        // Get.to(()=>DateOfBirthScreen());
      },
    );
  }
  @override
  void initState() {
    super.initState();
    persistLastRoute('/talentProfilePictureScreen');
    setInitialValues();
  }

  chooseFromGallery(){
    pickImage(ImageSource.gallery);
    setState(() {
      fromGallery = true;
    });
  }
  takeFromCamera(){
    pickImage(ImageSource.camera);
    setState(() {
      fromGallery = false;
    });
  }

  onForwardPress()async{
    if(imageLink.isEmpty)
      {
        Fluttertoast.showToast(
            msg: "Please select profile picture to upload",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    else{
      Get.to(()=>const DateOfBirthScreen());
    }

  }
  //Setting values if shared Preferences are not null
  setInitialValues() async{
    SharedPreferences prefs = await _prefs;

    if(prefs.getString('profilePicture') != null) {
      imageLink = prefs.getString('profilePicture')!;
    }else{
      imageLink = "";
    }

    if(prefs.getBool('fromGallery') != null){
    fromGallery = prefs.getBool('fromGallery')!;
    }
    else{
      fromGallery = false;
    }


    if(fromGallery == true && imageLink.isNotEmpty){
      setState(() {
        galleryIconVisibility = true;
        cameraIconVisibility = false;
        prefs.setBool('fromGallery', fromGallery);
      });
    }
    else if(fromGallery == false && imageLink.isNotEmpty){
      setState(() {
        cameraIconVisibility = true;
        galleryIconVisibility = false;
        prefs.setBool('fromGallery', fromGallery);
      });
    }

  }

  void persistLastRoute(String routeName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString(Strings.lastRouteKey, routeName);
    });
  }
  Future<bool> _willPopCallback() async {
      SystemNavigator.pop();
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
                TopRow(2,4),
                //Body
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(Strings.profilePicture),
                      //SizedBox
                      const SizedBox(height: 30,),
                      //Choose from Gallery
                      GestureDetector(
                        onTap: chooseFromGallery,
                          // child: PlainWhiteButton(Strings.chooseFromGallery),
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
                                  child: Text(Strings.chooseFromGallery,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Visibility(
                                  visible: galleryIconVisibility,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      //Take from Camera
                      GestureDetector(
                        onTap: takeFromCamera,
                          // child: PlainWhiteButton(Strings.takeFromCamera),
                          child:  Container(
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
                                  child: Text(Strings.takeFromCamera,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Visibility(
                                  visible: cameraIconVisibility,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      //SizedBox
                      const SizedBox(height: 30,),
                      //Backward and Forward Button
                      // ForwardButton(onForwardPress),
                      Buttons.forwardButton(onForwardPress),
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



