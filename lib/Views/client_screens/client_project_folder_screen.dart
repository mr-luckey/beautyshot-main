import 'package:beautyshot/Views/client_screens/client_home_screen.dart';
import 'package:beautyshot/Views/client_screens/project_name_screen.dart';
import 'package:beautyshot/components/client_project_item.dart';
import 'package:beautyshot/model/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/constants.dart';

class ClientProjectFolderScreen extends StatefulWidget {
  const ClientProjectFolderScreen({Key? key}) : super(key: key);

  @override
  State<ClientProjectFolderScreen> createState() =>
      _ClientProjectFolderScreenState();
}

class _ClientProjectFolderScreenState extends State<ClientProjectFolderScreen> {
  String clientId = FirebaseAuth.instance.currentUser!.uid.toString();
  List<ProjectModel> projectData = <ProjectModel>[];

  @override
  void initState() {
    // getAllProjects();
    super.initState();
  }

  bool isDidChangeRunningOnce = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isDidChangeRunningOnce) {
      print('did change dependencies');
      getAllProjects();
      isDidChangeRunningOnce = false;
    }
  }

  Future getAllProjects() async {
    projectData.clear();
    print('............/////////////////////////////// 00');
    FirebaseFirestore.instance
        .collection('projects')
        .where('projectCreatedBy', isEqualTo: clientId).snapshots().listen((event) {
      projectData.clear();
          event.docs.forEach((element) {
            projectData.add(ProjectModel.fromMap(element.data()));
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
  Future<bool> _willPopCallback() async {
    Get.to(() => ClientHome());
    return false;
    // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            Strings.projectFolder,
            style: KFontStyle.kTextStyle24Black,
          ),
          toolbarHeight: 80,
          centerTitle: false,
          backgroundColor: Color(KColors.kColorWhite),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 80),
          child: Center(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('projects')
                    .where('projectCreatedBy', isEqualTo: clientId)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot>
                    streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    if(streamSnapshot
                        .data!.docs.isEmpty){
                      return Text("No Project",style: KFontStyle.newYorkSemiBold22);
                    }
                    else {
                      return ListView.builder(
                        reverse: true,
                        keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior
                            .onDrag,
                        itemCount: streamSnapshot
                            .data?.docs.length,
                        itemBuilder: (BuildContext context,
                            int index) {
                          return ClientProjectItem(
                            projectId: streamSnapshot.data?.docs[index]['projectId'],
                            projectName:  streamSnapshot.data?.docs[index]['projectName'],
                            projectBudget:  streamSnapshot.data?.docs[index]['projectBudget'],
                            projectLocation: streamSnapshot.data?.docs[index]['projectLocation'],
                            projectLatitude: streamSnapshot.data?.docs[index]['projectLatitude'],
                            projectLongitude: streamSnapshot.data?.docs[index]['projectLongitude'],
                            projectTillDate: streamSnapshot.data?.docs[index]['projectTillDate'],
                            projectFromDate: streamSnapshot.data?.docs[index]['projectFromDate'],
                            projectCreatedBy: streamSnapshot.data?.docs[index]['projectCreatedBy'],
                            firstOption: streamSnapshot.data?.docs[index]['firstOption'],
                            secondOption: streamSnapshot.data?.docs[index]['secondOption'],
                          );
                        },
                      );
                    }
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const ProjectNameScreen());
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Color(KColors.kColorPrimary),
          ),
        ),
      ),
    );
  }
}
