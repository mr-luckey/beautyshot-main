
import 'package:beautyshot/Views/talent_screens/pdfViewer.dart';
import 'package:beautyshot/Views/talent_screens/project_detailed_description_screen.dart';
import 'package:beautyshot/Views/talent_screens/send_message_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


//This Item is used to present a list item for project on Job proposal screen on talent side

class ProjectDescriptionScreen extends StatefulWidget {
  final String projectId;
  final String projectName;
  final String pdfLink;
  final String amount;
  final String notes;
  final String jobTitle;
  final String contractId;

  const ProjectDescriptionScreen(
      {Key? key, required this.projectId,
        required this.projectName,
        required this.pdfLink,
        required this.amount,
        required this.notes,
        required this.jobTitle,
        required this.contractId,
      }) : super(key: key);

  @override
  State<ProjectDescriptionScreen> createState() => _ProjectDescriptionScreenState();
}

class _ProjectDescriptionScreenState extends State<ProjectDescriptionScreen> {

  List projectData = [];
  bool isDidChangeRunningOnce = true;

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
                    //Ignore Accept Button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,30,10,10),
                      child: Row(
                        children: [
                          Expanded(
                            flex:1,
                              child: Buttons.whiteButton(Strings.ignore, () { }),
                          ),
                          Expanded(
                            flex:2,
                              child: Buttons.whiteButton(Strings.accept, () {Get.to(()=>ProjectDetailedDescriptionScreen(projectId: widget.projectId, projectName: widget.projectName, pdfLink: widget.pdfLink, amount: widget.amount, notes: widget.notes, jobTitle: widget.jobTitle,contractId: widget.contractId,)); })),
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

