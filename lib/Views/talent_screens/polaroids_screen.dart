import 'dart:io';

import 'package:beautyshot/Views/talent_screens/scars_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/constants.dart';
import 'package:path/path.dart' as path;

class PolaroidsScreen extends StatefulWidget {
  const PolaroidsScreen({Key? key}) : super(key: key);

  @override
  State<PolaroidsScreen> createState() => _PolaroidsScreenState();
}

class _PolaroidsScreenState extends State<PolaroidsScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List images = [];
  List<String> polaroidImageLink = <String>[];
  bool picked = false;
  late String imageLink;
  final imagePicker = ImagePicker();
  var _imageFile1;
  var _imageFile2;
  var _imageFile3;
  var _imageFile4;

  Future pickImage1(ImageSource imageSource) async {
    final pickedFile = await imagePicker.pickImage(source: imageSource);
    // File? croppedFile = await ImageCropper().cropImage(
    //     sourcePath: pickedFile!.path,
    //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //     ],
    //     androidUiSettings: const AndroidUiSettings(
    //         activeControlsWidgetColor: Color(0xff4B6DFC),
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
      _imageFile1 = File(pickedFile!.path);
      images.add(_imageFile1);
    });
  }

 //Pick User Image 2
  Future pickImage2(ImageSource imageSource) async {
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
      _imageFile2 = File(pickedFile!.path);
      images.add(_imageFile2);
      // uploadImage2ToFirebase();
    });
  }

  //Pick User Image 3
  Future pickImage3(ImageSource imageSource) async {
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
      _imageFile3 = File(pickedFile!.path);
      images.add(_imageFile3);
      // uploadImage3ToFirebase();
    });
  }

//Pick User Image 4
  Future pickImage4(ImageSource imageSource) async {
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
      _imageFile4 = File(pickedFile!.path);
      images.add(_imageFile4);
      // uploadImage4ToFirebase();
    });
  }


  //Getting Images form assets and Uploading to firebase
  getImageFromAssetAndUpload() async{

    Get.defaultDialog(title: "Uploading Polaroids",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );

    File imageFile ;
    String fileName;

    for (int i = 0; i < images.length; i++) {
      // var pPath = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      fileName = path.basename(images[i].path);
      // imageFile = File(pPath);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('modelPolaroidPictures/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(images[i]);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      taskSnapshot.ref.getDownloadURL().then(
            (value) async{
          imageLink = value;
          polaroidImageLink.add(imageLink);
        },
      );
    }
    Get.back();
    Fluttertoast.showToast(
        msg: "Polaroids uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    SharedPreferences prefs = await _prefs;
    prefs.setStringList('polaroidImageLink', polaroidImageLink);
    // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const ScarsScreen(),duration: const Duration(seconds: 1)));
    Get.to(()=>const ScarsScreen());
  }
  onForwardPress()async {

    if(_imageFile1 == null || _imageFile2 == null || _imageFile3 == null || _imageFile4 == null){

      Fluttertoast.showToast(
          msg: "Please select all polaroids",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else {
      SharedPreferences prefs = await _prefs;
      var imageLink = prefs.getStringList('polaroidImageLink')!;
      if(imageLink.isNotEmpty){
        Get.to(()=>const ScarsScreen());
      }
      else{
        getImageFromAssetAndUpload();
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Top Row
              TopRow(18, 2),
              //SizedBox
              const SizedBox(height: 30,),
              //Body
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Text polaroids
                        TitleText(Strings.polaroids),
                        Buttons.whiteRectangularButton(Strings.help, ()async {
                          final Uri _url = Uri.parse('https://www.youtube.com/');
                          if (!await launchUrl(_url)) {
                            throw 'Could not launch $_url';
                          }
                        }),
                      ],
                    ),
                    //SizedBox
                    const SizedBox(height: 10,),

                    Expanded(
                      child: Column(
                        children: [

                          Row(children: [
                            Expanded(child: InkWell(
                              onTap: (){
                                pickImage1(ImageSource.camera);
                              },
                              child: _imageFile1 == null ?Container(
                                height: 225,
                                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                          child: const Padding(
                                            padding: EdgeInsets.all(30),
                                            child: Icon(Icons.add),
                                          ),
                                        ) :
                              Container(
                                height: 225,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.file(_imageFile1,fit: BoxFit.fill,)),
                              ),
                            ),),
                            Expanded(child: InkWell(
                              onTap: (){
                                pickImage2(ImageSource.camera);
                              },
                              child: _imageFile2 == null ? Container(
                                height: 225,
                                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                          child: const Padding(
                                            padding: EdgeInsets.all(30),
                                            child: Icon(Icons.add),
                                          ),
                                        ):
                              Container(
                                height: 225,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.file(_imageFile2,fit: BoxFit.fill,)),
                              ),
                            ),),
                          ],),
                          Row(children: [
                            Expanded(child: InkWell(
                              onTap: (){
                                pickImage3(ImageSource.camera);
                              },
                              child: _imageFile3 == null ? Container(
                                height: 225,
                                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                          child: const Padding(
                                            padding: EdgeInsets.all(30),
                                            child: Icon(Icons.add),
                                          ),
                                        ):
                              Container(
                                height: 225,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.file(_imageFile3,fit: BoxFit.fill,)),
                              ),
                            ),),
                            Expanded(child: InkWell(
                              onTap: (){
                                pickImage4(ImageSource.camera);
                              },
                              child: _imageFile4 == null ? Container(
                                height: 225,
                                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                          child: const Padding(
                                            padding: EdgeInsets.all(30),
                                            child: Icon(Icons.add),
                                          ),
                                        ):
                              Container(
                                height: 225,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.file(_imageFile4,fit: BoxFit.fill,)),
                              ),
                            ),),
                          ],),
                        ],
                      ),
                    ),
                   
                    //Forward Button
                    // BackForwardButton(onForwardPress),
                    Buttons.backForwardButton(onForwardPress),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


