
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/components/model_project_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PendingOffersScreen extends StatefulWidget {
  const PendingOffersScreen({Key? key}) : super(key: key);

  @override
  State<PendingOffersScreen> createState() => _PendingOffersScreenState();
}

class _PendingOffersScreenState extends State<PendingOffersScreen> {
  String userId = FirebaseAuth.instance.currentUser!.uid.toString();
  // List projectData = [];

  // bool isDidChangeRunningOnce = true;
  //
  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   if (isDidChangeRunningOnce) {
  //     print('did change dependencies');
  //     getProjectDetails();
  //     isDidChangeRunningOnce = false;
  //   }
  // }
  // Future getProjectDetails() async {
  //   projectData.clear();
  //   print('............/////////////////////////////// 00');
  //   FirebaseFirestore.instance
  //       .collection('projects')
  //       .where('projectId', isEqualTo: userId).snapshots().listen((event) {
  //     projectData.clear();
  //     event.docs.forEach((element) {
  //       projectData.add(element.data());
  //       print(element.data());
  //
  //     });
  //     setState(() {
  //
  //     });
  //   });/*
  //    await FirebaseFirestore.instance
  //        .collection('projects')
  //        .where('projectCreatedBy', isEqualTo: clientId)
  //        .get()
  //        .then((value) {
  //      value.docs.forEach((element) {
  //        projectData.add(ProjectModel.fromMap(element.data()));
  //        print(element.data());
  //      });
  //    });*/
  //   print('............/////////////////////////////// 01');
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(Strings.pendingOffers,style: KFontStyle.newYorkSemiBold22,),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Color(KColors.kColorWhite),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('contracts')
                  .where('modelIds', arrayContains: userId).where('status', isEqualTo: 'pending')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot>
                  streamSnapshot) {
                if (streamSnapshot.hasData) {
                  if(streamSnapshot
                      .data!.docs.isEmpty){
                    return Text("No Proposal",style: KFontStyle.kTextStyle24Black);
                  }
                  else {
                    return ListView.builder(
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior
                          .onDrag,
                      itemCount: (streamSnapshot
                          .data?.docs.length ?? 0) + 1 ,
                      itemBuilder: (BuildContext context,
                          int index) {
                        if(index == (streamSnapshot
                            .data?.docs.length)){
                          return Column(
                            children: [
                              const SizedBox(height: 20,),
                              Image.asset("assets/images/dots.png",height: 32,width: 32,)
                            ],
                          );
                        }
                        else {
                          return ModelProposalItem(

                            projectId: streamSnapshot.data
                                ?.docs[index]['projectId'],
                            projectName: streamSnapshot.data
                                ?.docs[index]['projectName'],
                            pdfLink: streamSnapshot.data
                                ?.docs[index]['pdfLink'],
                            amount: streamSnapshot.data
                                ?.docs[index]['amount'],
                            notes: streamSnapshot.data
                                ?.docs[index]['notes'],
                            jobTitle: streamSnapshot.data
                                ?.docs[index]['jobTitle'],
                            contractId: streamSnapshot.data
                                ?.docs[index]['contractId'],

                          );
                        }
                      },
                    );
                  }
                }
                else  if(!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty) {
                  return  Text("No Project",style: KFontStyle.kTextStyle24Black);
                }
                else {
                  return const CircularProgressIndicator();
                }
              }),

          // child: (projectData.isNotEmpty)
          //     ? ListView.builder(
          //   reverse: true,
          //         keyboardDismissBehavior:
          //             ScrollViewKeyboardDismissBehavior.onDrag,
          //         itemCount: projectData.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return ClientProjectItem(
          //             projectId: projectData.elementAt(index).projectId,
          //             projectName: projectData.elementAt(index).projectName,
          //             projectBudget: projectData.elementAt(index).projectBudget,
          //             projectLocation:
          //                 projectData.elementAt(index).projectLocation,
          //             projectLatitude:
          //                 projectData.elementAt(index).projectLatitude,
          //             projectLongitude:
          //                 projectData.elementAt(index).projectLongitude,
          //             projectTillDate:
          //                 projectData.elementAt(index).projectTillDate,
          //             projectFromDate:
          //                 projectData.elementAt(index).projectFromDate,
          //             projectCreatedBy:
          //                 projectData.elementAt(index).projectCreatedBy,
          //            firstOption: [projectData.elementAt(index).firstOption],
          //            secondOption: [projectData.elementAt(index).secondOption],
          //           );
          //         },
          //       )
          //     : Text("Create New Project", style: KFontStyle.kTextStyle24Black),
        ),
      ),
    );
  }
}
