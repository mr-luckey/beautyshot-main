import 'dart:io';

import 'package:beautyshot/Views/talent_screens/contract_terms_and_conditions.dart';
import 'package:beautyshot/Views/talent_screens/pdfViewer.dart';
import 'package:beautyshot/Views/talent_screens/send_message_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/controller/project_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;


//This Item is used to present a list item for project on Job proposal screen on talent side

class ProjectDetailedDescriptionScreen extends StatefulWidget {
  final String projectId;
  final String projectName;
  final String pdfLink;
  final String amount;
  final String notes;
  final String jobTitle;
  final String contractId;

  const ProjectDetailedDescriptionScreen(
      {Key? key, required this.projectId,
        required this.projectName,
        required this.pdfLink,
        required this.amount,
        required this.notes,
        required this.jobTitle,
        required this.contractId,
      }) : super(key: key);

  @override
  State<ProjectDetailedDescriptionScreen> createState() => _ProjectDetailedDescriptionScreenState();
}

class _ProjectDetailedDescriptionScreenState extends State<ProjectDetailedDescriptionScreen> {
  final projectController = Get.put(ProjectController());
  List projectData = [];
  bool isDidChangeRunningOnce = true;
  File? file;
  String pdfLink = "";
  bool pdfIconVisibility = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isDidChangeRunningOnce) {
      debugPrint('did change dependencies');
      getProjectDetails();
      isDidChangeRunningOnce = false;
    }
  }
  Future getProjectDetails() async {
    projectData.clear();
    debugPrint('............/////////////////////////////// 00');
    FirebaseFirestore.instance
        .collection('projects')
        .where('projectId', isEqualTo: widget.projectId).snapshots().listen((event) {
      projectData.clear();
      event.docs.forEach((element) {
        projectData.add(element.data());
        // print(projectData.elementAt(0)["projectLocation"]);

      });
      setState(() {

      });
    });
  }

  attachPDF()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
        if(file != null){
          pdfIconVisibility = true;
        }
      });

      debugPrint(file.toString());
    } else {
      // User canceled the picker
    }
  }

  validateInputs(){
    if(file == null )
    {

      Fluttertoast.showToast(
          msg: "Please upload signed contract file",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      uploadPDFToFirebase();

    }
  }
  Future uploadPDFToFirebase() async {

    Get.defaultDialog(title: "Uploading Signed Contract",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    String fileName = path.basename(file!.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Contracts/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(file!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    taskSnapshot.ref.getDownloadURL().then(
          (value) async{
        setState(() {
          pdfLink = value;
        });
        Get.back();
        projectController.updateContract(widget.contractId, pdfLink);

        Fluttertoast.showToast(
            msg: "Contract file uploaded successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.to(() =>  ContractTermsAndConditions( contractId: widget.contractId,projectId: widget.projectId,));
      },
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.projectName,style: KFontStyle.newYorkSemiBold22,),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_rounded,color: Color(KColors.kColorPrimary),)),
        backgroundColor: Color(KColors.kColorWhite),
      ),
      body: Container(

        child:
        // projectData.length > 0?
        projectData.isNotEmpty?
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                //Job Title
                Container(
                  height: 30,
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Row(
                      children: [
                        Text(
                          "Job Title  : ",
                          style: KFontStyle.kTextStyle16BlackRegular,
                        ),
                        Text(
                          widget.jobTitle,
                          style: KFontStyle.kTextStyle16BlackRegular,
                        ),
                      ],
                    ),
                  ),
                ),
                //Budget
                Container(
                  height: 30,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Row(
                      children: [
                        Text(
                          "Amount : ",
                          style: KFontStyle.kTextStyle16BlackRegular,
                        ),
                        Text(
                          "\$" + widget.amount,
                          style: KFontStyle.kTextStyle16BlackRegular,
                        ),
                      ],
                    ),
                  ),
                ),
                //Notes
                Container(
                  height: 30,
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Row(
                      children: [
                        Text(
                          "Notes : ",
                          style: KFontStyle.kTextStyle16BlackRegular,
                        ),
                        Text(
                          widget.notes,
                          style: KFontStyle.kTextStyle16BlackRegular,
                        ),
                      ],
                    ),
                  ),
                ),
                //Location of Shooting
                SizedBox(
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  "Shooting Location : ",
                                  style: KFontStyle.kTextStyle16BlackRegular,
                                ),
                                Text(
                                  projectData.elementAt(0)['projectLocation'],
                                  style: KFontStyle.kTextStyle16BlackRegular,
                                ),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                            onTap: () async {
                              String longitude = projectData.elementAt(
                                  0)['projectLongitude'];
                              String latitude = projectData.elementAt(
                                  0)['projectLatitude'];

                              var uri = Uri.parse(
                                  "google.navigation:q=$latitude,$longitude&mode=d");
                              if (await canLaunch(uri.toString())) {
                                await launch(uri.toString());
                              } else {
                                throw 'Could not launch ${uri.toString()}';
                              }
                            },
                            child: Image.asset(
                              "assets/images/location.png", height: 32, width: 32,)),
                      ],
                    ),
                  ),
                ),
                //Date of Shooting
                Container(
                  height: 30,
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            "Shooting Dates : ",
                            style: KFontStyle.kTextStyle16BlackRegular,
                          ),
                          Text(
                            projectData.elementAt(0)['projectFromDate'] + " To ",
                            style: KFontStyle.kTextStyle16BlackRegular,
                          ),
                          Text(
                            projectData.elementAt(0)['projectTillDate'],
                            style: KFontStyle.kTextStyle16BlackRegular,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],),


            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Column(
                children: [
                  //Send Message
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>SendMessageScreen(clientId: projectData.elementAt(0)['projectCreatedBy'], projectName: widget.projectName));
                    },
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_outline,color: Color(KColors.kColorDarkGrey),),
                            const SizedBox(width: 20,),
                            Text("Send Message",style: KFontStyle.kTextStyle16BlackRegular,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //View Contract
                  InkWell(
                    onTap: (){
                      String result = widget.pdfLink.substring(
                          0, widget.pdfLink.indexOf('?'));

                      Get.to(()=> PDFViews(result));
                      debugPrint(result);
                    },
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(Icons.remove_red_eye,color: Color(KColors.kColorDarkGrey),),
                            const SizedBox(width: 20,),
                            Text("View Contract",style: KFontStyle.kTextStyle16BlackRegular,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Download Contract as PDF Button
                  GestureDetector(
                    onTap: ()async{
                      String result = widget.pdfLink.substring(
                          0, widget.pdfLink.indexOf('?'));
                      if (!await launch(
                          widget.pdfLink)) throw 'Could not launch $result';
                    },
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(Icons.download,color: Color(KColors.kColorDarkGrey),),
                            const SizedBox(width: 20,),
                            Text("Download Contract as PDF",style: KFontStyle.kTextStyle16BlackRegular,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Upload Contract as PDF Button
                  GestureDetector(
                    onTap: ()async{
                      attachPDF();
                      debugPrint("Upload PDF clicked");
                      // String result = widget.pdfLink.substring(
                      //     0, widget.pdfLink.indexOf('?'));
                      // if (!await launch(
                      //     widget.pdfLink)) throw 'Could not launch $result';
                    },
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(Icons.upload_sharp,color: Color(KColors.kColorDarkGrey),),
                            const SizedBox(width: 20,),
                            Text("Upload Signed Document",style: KFontStyle.kTextStyle16BlackRegular,),
                            Visibility(
                              visible: pdfIconVisibility,
                              child: const Padding(
                                padding: EdgeInsets.only(left: 10,right: 10),
                                child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Ignore Accept Button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0,30,10,10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Buttons.blueButton(Strings.kContinue, validateInputs())),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ):Container(),
      ),
    );
  }

}

