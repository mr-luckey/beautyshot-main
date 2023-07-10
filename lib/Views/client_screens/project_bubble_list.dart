import 'package:beautyshot/Views/client_screens/project_name_screen.dart';
import 'package:beautyshot/components/project_bubble_item.dart';
import 'package:beautyshot/model/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/constants.dart';

class ProjectBubbleList extends StatefulWidget {
  final String userId;
  final String profilePicture;
 final String option;

  const ProjectBubbleList(this.userId, this.profilePicture, this.option, {Key? key})
      : super(key: key);

  @override
  State<ProjectBubbleList> createState() => _ProjectBubbleListState();
}

class _ProjectBubbleListState extends State<ProjectBubbleList> {
 final String clientId = FirebaseAuth.instance.currentUser!.uid.toString();
 final List<ProjectModel> projectData = <ProjectModel>[];

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
      debugPrint('did change dependencies');
      getAllProjects();
      isDidChangeRunningOnce = false;
    }
  }

  Future getAllProjects() async {
    projectData.clear();
    debugPrint('............/////////////////////////////// 00');
    FirebaseFirestore.instance
        .collection('projects')
        .where('projectCreatedBy', isEqualTo: clientId)
        .snapshots()
        .listen((event) {
      projectData.clear();
      event.docs.forEach((element) {
        projectData.add(ProjectModel.fromMap(element.data()));
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  // opacity: 0.5,
                  image: NetworkImage(
                    widget.profilePicture,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.6),
            ),
            Container(
              margin:
              const EdgeInsets.only(left: 80,right: 80,bottom: 20,top: 20),
              child: Center(
                child: (projectData.isNotEmpty)
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        reverse: true,
                        itemCount: projectData.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                        ),
                        itemBuilder: (BuildContext context, int index){

                          for(int i = index ; i <= index; i++ ){
                            if(i % 2 == 0){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Expanded(
                                    flex:1,
                                      child: SizedBox()),
                                  ProjectBubbleItem(
                                    projectId:
                                    projectData.elementAt(index).projectId,
                                    projectName:
                                    projectData.elementAt(index).projectName,
                                    projectBudget:
                                    projectData.elementAt(index).projectBudget,
                                    projectLocation: projectData
                                        .elementAt(index)
                                        .projectLocation,
                                    projectLatitude: projectData
                                        .elementAt(index)
                                        .projectLatitude,
                                    projectLongitude: projectData
                                        .elementAt(index)
                                        .projectLongitude,
                                    projectTillDate: projectData
                                        .elementAt(index)
                                        .projectTillDate,
                                    projectFromDate: projectData
                                        .elementAt(index)
                                        .projectFromDate,
                                    projectCreatedBy: projectData
                                        .elementAt(index)
                                        .projectCreatedBy,
                                    firstOption: [projectData
                                        .elementAt(index)
                                        .firstOption],
                                    secondOption: [projectData
                                        .elementAt(index)
                                        .secondOption],
                                    modelId: [widget.userId],
                                    option: widget.option,
                                  ),
                                  // SizedBox(height: 10,),
                                ],
                              );
                            }
                            else{
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProjectBubbleItem(
                                    projectId:
                                    projectData.elementAt(index).projectId,
                                    projectName:
                                    projectData.elementAt(index).projectName,
                                    projectBudget:
                                    projectData.elementAt(index).projectBudget,
                                    projectLocation: projectData
                                        .elementAt(index)
                                        .projectLocation,
                                    projectLatitude: projectData
                                        .elementAt(index)
                                        .projectLatitude,
                                    projectLongitude: projectData
                                        .elementAt(index)
                                        .projectLongitude,
                                    projectTillDate: projectData
                                        .elementAt(index)
                                        .projectTillDate,
                                    projectFromDate: projectData
                                        .elementAt(index)
                                        .projectFromDate,
                                    projectCreatedBy: projectData
                                        .elementAt(index)
                                        .projectCreatedBy,
                                    firstOption: [projectData
                                        .elementAt(index)
                                        .firstOption],
                                    secondOption: [projectData
                                        .elementAt(index)
                                        .secondOption],
                                    modelId: [widget.userId],
                                    option: widget.option,
                                  ),
                                  const Expanded(
                                      flex:2,
                                      child: const SizedBox(height: 30,)),
                                ],
                              );
                            }
                          }
                          return Container();



                        },
                      ),

                // ListView.builder(
                        //   reverse: true,
                        //   keyboardDismissBehavior:
                        //   ScrollViewKeyboardDismissBehavior.onDrag,
                        //   itemCount: projectData.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return ProjectBubbleItem(
                        //       projectId:
                        //       projectData.elementAt(index).projectId,
                        //       projectName:
                        //       projectData.elementAt(index).projectName,
                        //       projectBudget:
                        //       projectData.elementAt(index).projectBudget,
                        //       projectLocation: projectData
                        //           .elementAt(index)
                        //           .projectLocation,
                        //       projectLatitude: projectData
                        //           .elementAt(index)
                        //           .projectLatitude,
                        //       projectLongitude: projectData
                        //           .elementAt(index)
                        //           .projectLongitude,
                        //       projectTillDate: projectData
                        //           .elementAt(index)
                        //           .projectTillDate,
                        //       projectFromDate: projectData
                        //           .elementAt(index)
                        //           .projectFromDate,
                        //       projectCreatedBy: projectData
                        //           .elementAt(index)
                        //           .projectCreatedBy,
                        //       firstOption: [projectData
                        //           .elementAt(index)
                        //           .firstOption],
                        //       secondOption: [projectData
                        //           .elementAt(index)
                        //           .secondOption],
                        //       modelId: [widget.userId],
                        //       option: widget.option,
                        //     );
                        //   },
                        // ),
                      ),

                    Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: const [
                            //   BoxShadow(
                            //     color: Colors.grey,
                            //     offset: Offset(0.0, 3.0), //(x,y)
                            //     blurRadius: 5.0,
                            //   ),
                            // ],
                            borderRadius: BorderRadius.circular(100),
                            // border: Border.all(
                            //   color: Colors.grey,
                            // ),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/project.png",
                              color: Color(KColors.kColorDarkGrey),
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                        Text("Folder",style: KFontStyle.kTextStyle16White,),
                      ],
                    ),
                  ],
                )
                    : InkWell(
                  onTap: (){
                    Get.to(() => const ProjectNameScreen());
                  },
                  child: Text("Create New Project",
                      style: KFontStyle.kTextStyle24Black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
