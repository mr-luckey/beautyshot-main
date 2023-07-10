import 'dart:io';

import 'package:beautyshot/Views/talent_screens/polaroids_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import "package:flutter_absolute_path/flutter_absolute_path.dart";

// import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/constants.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path/path.dart' as path;

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<Asset> images = <Asset>[];
  List<String> absolutePaths = [];
  List<String> portfolioImageLink = <String>[];
  List<String> portfolioVideoLink = <String>[];
  bool picked = false;
  late String imageLink;
  late String videoLink;
   File? _videoFile1;
   File? _videoFile2;
  final videoPicker = ImagePicker();
  bool video1Visibility = false;
  bool video2Visibility = false;

  //Pick Video 1
  Future pickVideo1() async {
    final videoFile = await videoPicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _videoFile1 = File(videoFile!.path);

      Fluttertoast.showToast(
          msg: "You have selected a video to upload",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      if(!(_videoFile1 == null)){
        video1Visibility = true;
      }
      else{
        video1Visibility = false;
      }
    });
  }
  //Pick Video 2
  Future pickVideo2() async {
    final videoFile = await videoPicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _videoFile2 = File(videoFile!.path);

      Fluttertoast.showToast(
          msg: "You have selected a video to upload",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      if(!(_videoFile2 == null)){
        video2Visibility = true;
      }
      else{
        video2Visibility = false;
      }
    });
  }
  //Forward press
  onForwardPress()async{
    SharedPreferences prefs = await _prefs;

    // ignore: unnecessary_null_comparison
    if (_videoFile1 != null ) {
      uploadVideo1ToFirebase(context);
    }
    else{
      if(prefs.getStringList('portfolioImageLink')!.isEmpty){
      if(images.length < 8 ){
        Fluttertoast.showToast(
            msg: "Please select all portfolio images",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else{
          getImageFromAssetAndUpload();
      }
      }
      else{
        Get.to(()=>const PolaroidsScreen());
      }
    }
  }
  //Upload Video
  Future uploadVideo1ToFirebase(BuildContext context) async {
    Get.defaultDialog(title: "Uploading Video",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );

      String fileName = path.basename(_videoFile1!.path);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('modelPortfolioVideos/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_videoFile1!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      taskSnapshot.ref.getDownloadURL().then(
            (value) {
          videoLink = value;
          portfolioVideoLink.add(videoLink);
        },
      );
    Get.back();
    if(_videoFile2 != null){
      uploadVideo2ToFirebase(context);
    }
    else{
      getImageFromAssetAndUpload();
    }

    Fluttertoast.showToast(
        msg: "Portfolio video uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }
  //Upload Video 2
  Future uploadVideo2ToFirebase(BuildContext context) async {
    Get.defaultDialog(title: "Uploading Video",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );

      String fileName = path.basename(_videoFile2!.path);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('modelPortfolioVideos/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_videoFile2!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      taskSnapshot.ref.getDownloadURL().then(
            (value) {
          videoLink = value;
          portfolioVideoLink.add(videoLink);

        },
      );
       getImageFromAssetAndUpload();
  }
  @override
  void initState() {
    super.initState();
  }
  //Select Images
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: false,
        selectedAssets: images,

        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "done",
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: "#ff4B6DFC",
          actionBarTitle: "Portfolio",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#000000",
          autoCloseOnSelectionLimit: true,
        ),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      picked = true;
    });
  }
  //Getting Images form assets and Uploading to firebase
  getImageFromAssetAndUpload() async{

    Get.defaultDialog(title: "Uploading Images",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );

    File imageFile ;
    String fileName;

    for (int i = 0; i < images.length; i++) {
      var paths = await LecleFlutterAbsolutePath.getAbsolutePath( uri: images[i].toString());
      fileName = path.basename(paths!);
      imageFile = File(paths);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('modelPortfolioPictures/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      taskSnapshot.ref.getDownloadURL().then(
            (value) async{
          imageLink = value;
          portfolioImageLink.add(imageLink);
        },
      );
    }
    Get.back();

    Fluttertoast.showToast(
        msg: "Portfolio pictures uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    SharedPreferences prefs = await _prefs;
    prefs.setStringList('portfolioImageLink', portfolioImageLink);
    prefs.setStringList('portfolioVideoLink', portfolioVideoLink);

    Get.to(()=>const PolaroidsScreen());
}
  // Build Grid View after Selecting Images

  Widget buildGridView(){
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {

        Asset  asset = images[index];

        return   GestureDetector(
          onTap: loadAssets,
          child: Container(
            margin: const EdgeInsets.all(5),
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
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
            ),
          ),
        );
      }),
    );
  }
  Widget initialGridView(){
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      children: List.generate(9, (index) {
        return GestureDetector(
          onTap: (){
            loadAssets();
          },
          child: Container(
            height: 100,
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
          ),
        );
      }),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Top Row
                TopRow(17, 3),
                //SizedBox
                const SizedBox(height: 30,),
                //Body
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Text Portfolio
                        TitleText(Strings.portfolio),
                        Buttons.whiteRectangularButton(Strings.help, () async {
                          final Uri _url = Uri.parse('https://www.youtube.com/');
                          if (!await launchUrl(_url)) {
                            throw 'Could not launch $_url';
                          }
                        }),
                      ],
                    ),
                    //SizedBox
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 450,
                      child:
                       GestureDetector(
                         onTap: (){
                           loadAssets();
                         },
                         child: Stack(
                           children: [

                      //      GridView.count(
                      //       crossAxisCount: 3,
                      //       children: List.generate(9, (index) {
                      //         return GestureDetector(
                      //           onTap: (){
                      //             loadAssets();
                      //           },
                      //           child: Container(
                      //             height: 100,
                      //             margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               boxShadow: const [
                      //                 BoxShadow(
                      //                   color: Colors.grey,
                      //                   offset: Offset(0.0, 3.0), //(x,y)
                      //                   blurRadius: 5.0,
                      //                 ),
                      //               ],
                      //               borderRadius: BorderRadius.circular(14),
                      //               // border: Border.all(
                      //               //   color: Colors.grey,
                      //               // ),
                      //             ),
                      //             child: const Padding(
                      //               padding: EdgeInsets.all(30),
                      //               child: Icon(Icons.add),
                      //             ),
                      //           ),
                      //         );
                      //       }),
                      // ),

                             initialGridView(),
                             buildGridView(),
                           ],
                         ),
                       ),
                    ),
                    //SizedBox
                    const SizedBox(height: 30,),
                    //Video
                    TitleText(Strings.videos),
                    //SizedBox
                    const SizedBox(height: 30,),
                    //Upload Video
                    GestureDetector(
                      onTap: pickVideo1,
                        // child: WhiteRectangularLargeButton(Strings.uploadVideo)),
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
                                child: Text(Strings.uploadVideo,style: KFontStyle.kTextStyle16BlackRegular,),
                              ),
                              Visibility(
                                visible: video1Visibility,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20,right: 20),
                                  child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                ),
                              ),
                            ],
                          ),
                        )),
                    //Upload Video
                    GestureDetector(
                      onTap: pickVideo2,
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
                                child: Text(Strings.uploadVideo,style: KFontStyle.kTextStyle16BlackRegular,),
                              ),
                              Visibility(
                                visible: video2Visibility,
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
      ),
    );
  }
}


