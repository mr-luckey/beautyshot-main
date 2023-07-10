import 'package:beautyshot/Views/talent_screens/pdfViewer.dart';
import 'package:beautyshot/Views/talent_screens/project_description_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


//This Item is used to present a list item for project on Job proposal screen on talent side

class ModelProposalItem extends StatefulWidget {
  final String projectId;
  final String projectName;
  final String pdfLink;
  final String amount;
  final String notes;
  final String jobTitle;
  final String contractId;

  const ModelProposalItem(
      {Key? key, required this.projectId,
  required this.projectName,
  required this.pdfLink,
  required this.amount,
  required this.notes,
  required this.jobTitle,
  required this.contractId,

  }) : super(key: key);

  @override
  State<ModelProposalItem> createState() => _ModelProposalItemState();
}

class _ModelProposalItemState extends State<ModelProposalItem> {

  List projectData = [];

  bool isDidChangeRunningOnce = true;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isDidChangeRunningOnce) {
      print('did change dependencies');
      getProjectDetails();
      isDidChangeRunningOnce = false;
    }
  }
  Future getProjectDetails() async {
    projectData.clear();
    print('............/////////////////////////////// 00');
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
    });/*
    await FirebaseFirestore.instance
        .collection('projects')
        .where('projectCreatedBy', isEqualTo: clientId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        projectData.add(ProjectModel.fromMap(element.data()));
        print(element.data());
      });
    });*/
    print('............/////////////////////////////// 01');
  }
  @override
  Widget build(BuildContext context) {
    if(projectData.isNotEmpty) {
      return Container(
        child: Column(children: [

          //Project Name
          Container(
            margin: EdgeInsets.only(left: 20.0, top: 10, right: 20, bottom: 0),
            child: Row(
              children: [
                Expanded(child: Divider(height: 2,
                  thickness: 2,
                  color: Color(KColors.kColorDarkGrey),)),
                Expanded(child: Text(
                  widget.projectName, style: KFontStyle.kTextStyle24Black,
                  textAlign: TextAlign.center,),),
                Expanded(child: Divider(height: 2,
                  thickness: 2,
                  color: Color(KColors.kColorDarkGrey),)),
              ],
            ),
          ),
          //View Contract Button
          GestureDetector(
            onTap: () async {

              
              String result = widget.pdfLink.substring(
                  0, widget.pdfLink.indexOf('?'));

              Get.to(()=> PDFViews(result));
              debugPrint(result);
              // if (!await launch(
              //     widget.pdfLink)) throw 'Could not launch $result';

            },
            child: Container(
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color(KColors.kColorWhite),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Color(KColors.kColorWhite),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 3.0), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  "View Contract", style: KFontStyle.kTextStyle16BlackRegular,),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Get.to(()=>ProjectDescriptionScreen(projectId: widget.projectId, projectName: widget.projectName, pdfLink: widget.pdfLink, amount: widget.amount, notes: widget.notes, jobTitle: widget.jobTitle,contractId: widget.contractId,));
            },
              child: Column(children: [
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
                Container(
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
                //Date of Shootin
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
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
                            projectData.elementAt(0)['projectFromDate'].toString() + " To ",
                            style: KFontStyle.kTextStyle16BlackRegular,
                          ),
                          Text(
                            projectData.elementAt(0)['projectTillDate'].toString(),
                            style: KFontStyle.kTextStyle16BlackRegular,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],)),

        ],),
      );
    }
    else{
      return Container();
    }
  }
}
