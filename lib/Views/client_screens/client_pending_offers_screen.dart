import 'package:beautyshot/components/client_project_item.dart';
import 'package:beautyshot/components/confirmed_project_item.dart';
import 'package:beautyshot/model/contract_model.dart';
import 'package:beautyshot/model/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/constants.dart';
import '../../components/pending_project_item.dart';

class ClientPendingOffersScreen extends StatefulWidget {
  const ClientPendingOffersScreen({Key? key}) : super(key: key);

  @override
  State<ClientPendingOffersScreen> createState() => _ClientPendingOffersScreenState();
}

class _ClientPendingOffersScreenState extends State<ClientPendingOffersScreen> {
  String clientId = FirebaseAuth.instance.currentUser!.uid.toString();
  int tabIndex = 0;
  List<ProjectModel> allProjectData = <ProjectModel>[];
  List<ProjectModel> confirmedProjectData = <ProjectModel>[];
  List<ProjectModel> pendingProjectData = <ProjectModel>[];

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
    allProjectData.clear();
    debugPrint('All projects in confirmed and pending offer');
    FirebaseFirestore.instance
        .collection('projects')
        .where('projectCreatedBy', isEqualTo: clientId)
        .snapshots()
        .listen((event) {
      // projectData.clear();
      event.docs.forEach((element) {
        allProjectData.add(ProjectModel.fromMap(element.data()));
      });
      setState(() {});

      getConfirmedProject();
      getPendingProject();
    });
  }

  Future getConfirmedProject() async {

    setState(() {
      confirmedProjectData = allProjectData.where((element) {
        return (
            //Gender
            (element.confirmed.isNotEmpty)
            // (element.gender == male)
        );
      }).toList();
    });

  }
  Future getPendingProject() async {

    setState(() {
      pendingProjectData = allProjectData.where((element) {
        return (
            //Gender
            (element.pending.isNotEmpty)
            // (element.gender == male)
        );
      }).toList();
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
      child: Column(
        children: [
          Expanded(
           child: DefaultTabController(

             initialIndex: tabIndex,
             length: 2,
             child: Column(children: [
               Container(
                 decoration: const BoxDecoration(
                   color: Colors.white,
                   // boxShadow: [
                   //   BoxShadow(
                   //     color: Color(KColors.kColorGrey),
                   //     offset: Offset(0.0, 1.0), //(x,y)
                   //     blurRadius: 5.0,
                   //   ),
                   // ],
                 ),
                 child: TabBar(
                   indicatorWeight: 3.0,
                     labelPadding: const EdgeInsets.only(
                         left: 0, right: 0, top: 18, bottom: 18),
                   labelStyle: KFontStyle.kTextStyle24Black,
                     // indicatorSize: TabBarIndicatorSize.label,
                     indicatorColor: Color(KColors.kColorPrimary),
                     tabs: [
                   Tab(child: Text("Confirmed",style: KFontStyle.kTextStyle24Black,),),
                   Tab(child: Text("Pending",style: KFontStyle.kTextStyle24Black,),)
                 ]),
               ),
               Expanded(
                 child: TabBarView(
                   children: <Widget>[
                     //Confirmed Projects
                     Container(
                       margin: const EdgeInsets.all( 40),
                       child:  Center(
                         // child: StreamBuilder(
                         //     stream: FirebaseFirestore.instance
                         //         .collection('projects')
                         //         .where('projectCreatedBy', isEqualTo: clientId).where('status',isEqualTo: 'confirmed')
                         //         .snapshots(),
                         //     builder: (context,
                         //         AsyncSnapshot<QuerySnapshot>
                         //         streamSnapshot) {
                         //       if (streamSnapshot.hasData) {
                         //         if(streamSnapshot
                         //             .data!.docs.isEmpty){
                         //           return Text("No Project",style: KFontStyle.kTextStyle24Black);
                         //         }
                         //         else {
                                   child: confirmedProjectData.isNotEmpty ? ListView.builder(
                                     reverse: true,
                                     keyboardDismissBehavior:
                                     ScrollViewKeyboardDismissBehavior
                                         .onDrag,
                                     itemCount: confirmedProjectData.length,
                                     itemBuilder: (BuildContext context,
                                         int index) {
                                       return ConfirmedProjectItem(
                                         projectId: confirmedProjectData.elementAt(index).projectId,
                                         projectName:  confirmedProjectData.elementAt(index).projectName,
                                         projectBudget:  confirmedProjectData.elementAt(index).projectBudget,
                                         projectLocation: confirmedProjectData.elementAt(index).projectLocation,
                                         projectLatitude: confirmedProjectData.elementAt(index).projectLatitude,
                                         projectLongitude: confirmedProjectData.elementAt(index).projectLongitude,
                                         projectTillDate: confirmedProjectData.elementAt(index).projectTillDate,
                                         projectFromDate: confirmedProjectData.elementAt(index).projectFromDate,
                                         projectCreatedBy: confirmedProjectData.elementAt(index).projectCreatedBy,
                                         firstOption: confirmedProjectData.elementAt(index).firstOption,
                                         secondOption: confirmedProjectData.elementAt(index).secondOption,
                                         confirmed: confirmedProjectData.elementAt(index).confirmed,
                                       );
                                     },
                                   ):Center(child: Text("No Confirmed Project",style: KFontStyle.newYorkSemiBold22,),),
                             //     }
                             //   }
                             //   else {
                             //     return const CircularProgressIndicator();
                             //   }
                             // }),
                       ),
                     ),
                     //Pending Projects
                     Container(
                       margin: const EdgeInsets.all( 40),
                       child:  Center(
                         child: pendingProjectData.isNotEmpty? ListView.builder(
                                     reverse: true,
                                     keyboardDismissBehavior:
                                     ScrollViewKeyboardDismissBehavior
                                         .onDrag,
                                     itemCount: pendingProjectData.length,
                                     itemBuilder: (BuildContext context,
                                         int index) {
                                       return PendingProjectItem(
                                         projectId: pendingProjectData.elementAt(index).projectId,
                                         projectName:  pendingProjectData.elementAt(index).projectName,
                                         projectBudget:  pendingProjectData.elementAt(index).projectBudget,
                                         projectLocation: pendingProjectData.elementAt(index).projectLocation,
                                         projectLatitude: pendingProjectData.elementAt(index).projectLatitude,
                                         projectLongitude: pendingProjectData.elementAt(index).projectLongitude,
                                         projectTillDate: pendingProjectData.elementAt(index).projectTillDate,
                                         projectFromDate: pendingProjectData.elementAt(index).projectFromDate,
                                         projectCreatedBy: pendingProjectData.elementAt(index).projectCreatedBy,
                                         firstOption: pendingProjectData.elementAt(index).firstOption,
                                         secondOption: pendingProjectData.elementAt(index).secondOption,
                                         pending: pendingProjectData.elementAt(index).pending,
                                       );
                                     },
                                   ):Center(child: Text("No Pending Project",style: KFontStyle.newYorkSemiBold22,),),

                       ),
                     ),
                   ],
                 ),
               ),
             ],),
           ),
          ),
        ],
      ),
      ),
    );

  }
}
