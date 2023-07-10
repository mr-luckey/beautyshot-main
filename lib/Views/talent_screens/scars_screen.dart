import 'dart:io';

import 'package:beautyshot/Views/talent_screens/tattoos_screen.dart';

import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';
import 'package:path/path.dart' as path;

class ScarsScreen extends StatefulWidget {
  const ScarsScreen({Key? key}) : super(key: key);

  @override
  State<ScarsScreen> createState() => _ScarsScreenState();
}

class _ScarsScreenState extends State<ScarsScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String imageLink;
  var _imageFile;
  final imagePicker = ImagePicker();
  bool scarVisibility = false;

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
    setState(() {
      _imageFile = File(pickedFile!.path);
      if(_imageFile != null){
          scarVisibility = true;
      }
    });
  }
  //On Forward Press
  onForwardPress()async{
    SharedPreferences prefs = await _prefs;
    if(isScar){
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
        var scarImage = prefs.getString('scarPicture')!;
        if(scarImage.isEmpty){
        uploadImageToFirebase();
        }
        else{
          Get.to(()=>const TattoosScreen());
        }
      }

    }
    else{
      prefs.setBool('isScar', isScar);
      prefs.setString('scarPicture', "");
      // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const TattoosScreen(),duration: const Duration(seconds: 1)));
      Get.to(()=>const TattoosScreen());
    }
  }
  Future uploadImageToFirebase() async {

    Get.defaultDialog(title: "Uploading Image",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    String fileName = path.basename(_imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('modelScarPictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) async{
        imageLink = value;
        SharedPreferences prefs = await _prefs;
        prefs.setBool('isScar', isScar);
        prefs.setString('scarPicture', imageLink);
        Get.back();

        Fluttertoast.showToast(
            msg: "Scar picture uploaded successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.to(()=>TattoosScreen());
        // Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: const TattoosScreen(),duration: const Duration(seconds: 1)));
      },
    );
  }
  bool isScar = false;
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
              TopRow(19, 1),
              //Body
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Text do you have any scars
                      TitleText(Strings.doYouHaveAnyScars),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(Strings.no,style: KFontStyle.kTextStyle14Black,),
                            const SizedBox(width: 3,),
                            FlutterSwitch(
                                value: isScar,
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
                                    isScar = val;
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
                       isScar = true;
                     });
                       Get.defaultDialog(title: "",titleStyle: KFontStyle.kTextStyle24Black,
                           content: Column(children: [
                             Buttons.whiteRectangularButton(Strings.camera, () {pickImage(ImageSource.camera); }),
                             Buttons.whiteRectangularButton(Strings.gallery, () {pickImage(ImageSource.gallery); }),
                       ],),
                       contentPadding: const EdgeInsets.only(left: 20,right: 20,bottom: 20));
                       // pickImage(ImageSource.gallery);
                     // }
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
                             visible: scarVisibility,
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


