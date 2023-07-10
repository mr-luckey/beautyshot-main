import 'dart:io';
import 'package:beautyshot/Views/client_screens/contract_screen.dart';
import 'package:beautyshot/Views/client_screens/mass_message_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/components/pendingModelItem.dart';
import 'package:beautyshot/controller/project_controller.dart';
import 'package:beautyshot/model/talent_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'client_project_folder_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


class PendingProjectDetails extends StatefulWidget {
  final String projectId;
  final String projectName;
  final String projectBudget;
  final String projectLocation;
  final String projectLatitude;
  final String projectLongitude;
  final String projectTillDate;
  final String projectFromDate;
  final String projectCreatedBy;
  final List firstOption;
  final List secondOption;
  final List pending;

  const PendingProjectDetails({
    Key? key,
    required this.projectId,
    required this.projectName,
    required this.projectBudget,
    required this.projectLocation,
    required this.projectLatitude,
    required this.projectLongitude,
    required this.projectTillDate,
    required this.projectFromDate,
    required this.projectCreatedBy,
    required this.firstOption,
    required this.secondOption,
    required this.pending,
  }) : super(key: key);

  @override
  State<PendingProjectDetails> createState() => _PendingProjectDetailsState();
}

class _PendingProjectDetailsState extends State<PendingProjectDetails> {
  final projectController = Get.put(ProjectController());
  late String projectId;
  late String projectName;
  late String projectBudget;
  late String projectLocation;
  late String projectLatitude;
  late String projectLongitude;
  late String projectTillDate;
  late String projectFromDate;
  late String projectCreatedBy;
  String newSectionName = "New Section";
  List<String> firstOption = [];
  List<String> secondOption = [];
  List<String> pendingList = [];
  List<String> selectedModels = [];
  bool isChecked = false;
  List<TalentModel> pendingUserData = <TalentModel>[];
  List<TalentModel> firstOptionData = <TalentModel>[];
  List<TalentModel> secondOptionData = <TalentModel>[];
  List<Widget> newSection = [];

  String clientId = FirebaseAuth.instance.currentUser!.uid.toString();

  // Initial Selected Value
  String dropDownValue = '';
  bool isDidChangeRunningOnce = true;

  String selectAll = "Select All";

  TextEditingController renameProjectController = TextEditingController();
  TextEditingController projectBudgetController = TextEditingController();
  TextEditingController projectFromDateController = TextEditingController();
  TextEditingController projectTillDateController = TextEditingController();
  TextEditingController newSectionNameController = TextEditingController();

  bool bottomNavigationVisibility = false;
  bool newSectionVisibility = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isDidChangeRunningOnce) {
      debugPrint('did change dependencies');
     getPendingData();
      isDidChangeRunningOnce = false;
    }
  }


  Future getPendingData() async {
    pendingUserData.clear();
    debugPrint('............/////////////////////////////// first Option');
    for (var pending in pendingList) {
      FirebaseFirestore.instance
          .collection('models')
          .where('userId', isEqualTo: pending)
          .snapshots()
          .listen((event) {
        event.docs.forEach((element) {
          pendingUserData.add(TalentModel.fromMap(element.data()));
        });
        setState(() {});
      });
    }



  }
//   Future getFirstOption() async {
//     firstOptionData.clear();
//     debugPrint('............/////////////////////////////// first Option');
//     for (var fOption in firstOption) {
//       FirebaseFirestore.instance
//           .collection('models')
//           .where('userId', isEqualTo: fOption)
//           .snapshots()
//           .listen((event) {
//         event.docs.forEach((element) {
//           firstOptionData.add(TalentModel.fromMap(element.data()));
//         });
//         setState(() {});
//       });
//     }
//
//
//
//   }
// //get second option list from server
//   Future getSecondOption() async {
//     secondOptionData.clear();
//     debugPrint('............/////////////////////////////// second Option');
//     for (var sOption in secondOption) {
//       FirebaseFirestore.instance
//           .collection('models')
//           .where('userId', isEqualTo: sOption)
//           .snapshots()
//           .listen((event) {
//         event.docs.forEach((element) {
//           secondOptionData.add(TalentModel.fromMap(element.data()));
//         });
//         setState(() {});
//       });
//     }
//   }
//Select all talent
  selectAllMethod(){
    if(firstOptionData.isNotEmpty){
      for(int i = 0 ;i < firstOptionData.length; i++) {
        // selectedModels.add(firstOptionData.elementAt(i).userId);
        if (!selectedModels.contains(
          firstOptionData.elementAt(i).userId,)) {
          setState(() {
            selectedModels.add(firstOptionData.elementAt(i).userId);
            bottomNavigationVisibility = true;
            isVisible = true;
            selectAll = "DeSelect All";
          });
        }
        //Removing Model Ids from list
        else {
          setState(() {
            selectedModels.remove(firstOptionData.elementAt(i).userId);
            bottomNavigationVisibility = false;
            isVisible = false;
            selectAll = "Select All";
          });
        }
      }
    }
    if(secondOptionData.isNotEmpty){
      for(int i = 0 ;i < secondOptionData.length; i++) {
        // selectedModels.add(firstOptionData.elementAt(i).userId);
        if (!selectedModels.contains(
          secondOptionData.elementAt(i).userId,)) {
          setState(() {
            selectedModels.add(secondOptionData.elementAt(i).userId);
            bottomNavigationVisibility = true;
            isVisible = true;
            selectAll = "DeSelect All";
          });
        }
        //Removing Model Ids from list
        else {
          setState(() {
            selectedModels.remove(secondOptionData.elementAt(i).userId);
            bottomNavigationVisibility = false;
            isVisible = false;
            selectAll = "Select All";
          });
        }
      }
    }

  }
  //Widget for new section
  Widget newWidget(){
    return Column(
      children: [
        //Text First option
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                newSectionName,
                style: KFontStyle.kTextStyle24Black,
              ),
            ),


          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.8,
          width: MediaQuery.of(context).size.width,

          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context)
                      .size
                      .height /
                      2.4,
                  width: MediaQuery.of(context)
                      .size
                      .width ,
                  // child: ListView.builder(
                  //   scrollDirection: Axis.horizontal,
                  //   // physics:
                  //   //     const NeverScrollableScrollPhysics(),
                  //   keyboardDismissBehavior:
                  //   ScrollViewKeyboardDismissBehavior
                  //       .onDrag,
                  //   itemCount: firstOptionData.length,
                  //   itemBuilder:
                  //       (BuildContext context,
                  //       int index) {
                  //     return Stack(
                  //       alignment:
                  //       Alignment.topRight,
                  //       children: [
                  //         OptionModelItem(
                  //           userId:  firstOptionData.elementAt(index).userId,
                  //           firstName: firstOptionData.elementAt(index).firstName,
                  //           lastName: firstOptionData.elementAt(index).lastName,
                  //           email: firstOptionData.elementAt(index).email,
                  //           profilePicture: firstOptionData.elementAt(index).profilePicture,
                  //           dateOfBirth: firstOptionData.elementAt(index).dateOfBirth,
                  //           gender: firstOptionData.elementAt(index).gender,
                  //           county: firstOptionData.elementAt(index).county,
                  //           state: firstOptionData.elementAt(index).state,
                  //           city: firstOptionData.elementAt(index).city,
                  //           postalCode: firstOptionData.elementAt(index).postalCode,
                  //           drivingLicense: firstOptionData.elementAt(index).drivingLicense,
                  //           idCard: firstOptionData.elementAt(index).idCard,
                  //           passport: firstOptionData.elementAt(index).passport,
                  //           otherId: firstOptionData.elementAt(index).otherId,
                  //           country: firstOptionData.elementAt(index).country,
                  //           hairColor: firstOptionData.elementAt(index).hairColor,
                  //           eyeColor: firstOptionData.elementAt(index).eyeColor,
                  //           heightCm: firstOptionData.elementAt(index).heightCm,
                  //           heightFeet: firstOptionData.elementAt(index).heightFeet,
                  //           waistCm: firstOptionData.elementAt(index).waistCm,
                  //           waistInches: firstOptionData.elementAt(index).waistInches,
                  //           weightKg: firstOptionData.elementAt(index).weightKg,
                  //           weightPound: firstOptionData.elementAt(index).weightPound,
                  //           buildType: firstOptionData.elementAt(index).buildType,
                  //           wearSizeCm: firstOptionData.elementAt(index).wearSizeCm,
                  //           wearSizeInches: firstOptionData.elementAt(index).wearSizeInches,
                  //           chestCm: firstOptionData.elementAt(index).chestCm,
                  //           chestInches: firstOptionData.elementAt(index).chestInches,
                  //           hipCm: firstOptionData.elementAt(index).hipCm,
                  //           hipInches: firstOptionData.elementAt(index).hipInches,
                  //           inseamCm: firstOptionData.elementAt(index).inseamCm,
                  //           inseamInches: firstOptionData.elementAt(index).inseamInches,
                  //           shoesCm: firstOptionData.elementAt(index).shoesCm,
                  //           shoesInches: firstOptionData.elementAt(index).shoesInches,
                  //           scarPicture: firstOptionData.elementAt(index).scarPicture,
                  //           tattooPicture: firstOptionData.elementAt(index).tattooPicture,
                  //           isDrivingLicense: firstOptionData.elementAt(index).isDrivingLicense,
                  //           isIdCard: firstOptionData.elementAt(index).isIdCard,
                  //           isPassport: firstOptionData.elementAt(index).isPassport,
                  //           isOtherId: firstOptionData.elementAt(index).isOtherId,
                  //           isScar: firstOptionData.elementAt(index).isScar,
                  //           isTattoo: firstOptionData.elementAt(index).isTattoo,
                  //           languages: firstOptionData.elementAt(index).languages,
                  //           sports: firstOptionData.elementAt(index).sports,
                  //           hobbies: firstOptionData.elementAt(index).hobbies,
                  //           talent: firstOptionData.elementAt(index).talent,
                  //           portfolioImageLink: firstOptionData.elementAt(index).portfolioImageLink,
                  //           portfolioVideoLink: firstOptionData.elementAt(index).portfolioVideoLink,
                  //           polaroidImageLink: firstOptionData.elementAt(index).polaroidImageLink,
                  //           projectId: widget.projectId,
                  //           indexNumber: index,
                  //         ),
                  //         Visibility(
                  //           visible: isVisible,
                  //           child: GestureDetector(
                  //             onTap: () {
                  //               //Adding Model Ids to list
                  //               if (!selectedModels.contains(
                  //                 firstOptionData.elementAt(index).userId,)) {
                  //                 setState(() {
                  //                   selectedModels.add(firstOptionData.elementAt(index).userId);
                  //                   bottomNavigationVisibility =
                  //                   true;
                  //                 });
                  //               }
                  //               //Removing Model Ids from list
                  //               else {
                  //                 setState(() {
                  //                   selectedModels.remove(firstOptionData.elementAt(index).userId);
                  //                   bottomNavigationVisibility =
                  //                   false;
                  //                 });
                  //               }
                  //             },
                  //             child: Container(
                  //                 height: 42,
                  //                 width: 42,
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   boxShadow: const [
                  //                     BoxShadow(
                  //                       color: Colors.grey,
                  //                       offset: Offset(0.0, 3.0),
                  //                       //(x,y)
                  //                       blurRadius: 5.0,
                  //                     ),
                  //                   ],
                  //                   borderRadius:
                  //                   BorderRadius
                  //                       .circular(
                  //                       100),
                  //
                  //                 ),
                  //                 child: selectedModels.contains(firstOptionData.elementAt(index).userId,) ?
                  //                 Image.asset("assets/images/blue_check.png",
                  //                   height: 42,
                  //                   width: 42,
                  //                   fit: BoxFit.cover,
                  //                 ) :
                  //                 Container()),
                  //           ),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // ),
                ),

                // Text(firstOption.elementAt(i),style: KFontStyle.kTextStyle16White,),
              ],
            ),
          ),
        )
      ],
    );
  }

  //Add new section
  void _addNewSection() {
    Get.defaultDialog(title: "Enter Name For New Section",content: Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(
              20, 0, 20, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Color(KColors.kColorPrimary),
            ),
          ),
          child: Padding(
            padding:
            const EdgeInsets.only(left: 10),
            child: TextField(
              textCapitalization: TextCapitalization.words,
              autofocus: false,
              controller: newSectionNameController,
              maxLines: 1,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Name",
                hintStyle: TextStyle(
                  fontFamily: "NewYork",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff6F6F6E),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          children: [
            Buttons.whiteRectangularButton(Strings.addNewSection, () { setState(() {
              newSectionName = newSectionNameController.text.toString();
              newSection.add(newWidget());
              newSectionVisibility = true;
              Get.back();
            }); }),
            Buttons.whiteRectangularButton(Strings.back, () {Get.back(); }),
          ],
        ),
      ],
    ),);

  }
  // List of items in our dropdown menu
  var items = [''];

  bool isAbsorbing = true;
  bool isVisible = false;

  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

//Send Contract Method (Done)
  sendContract() {
    //Passing Models List to contract Screen
    if (selectedModels.isEmpty) {

      Fluttertoast.showToast(
          msg: "No model selected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Get.to(() => ContractScreen(
        projectId: projectId,
        projectName: projectName,
        modelIds: selectedModels,
      ));
    }
  }

  //Add to folder method
  addToFolder() {
    debugPrint("Add to Folder Clicked");
  }

  //Chat method (Done)
  chat() {
    if (selectedModels.isEmpty) {

      Fluttertoast.showToast(
          msg: "No model selected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Get.to(() => MassMessageScreen(
        projectId: projectId,
        projectName: projectName,
        modelIds: selectedModels,
        projectPrice: double.parse(projectBudget),
      ));
    }
    debugPrint("Chat Clicked");
  }

  //delete method (Done)
  delete() {
    if (selectedModels.isEmpty) {

      Fluttertoast.showToast(
          msg: "No model selected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      setState(() {
        projectController.deleteFirstOption(projectId, selectedModels);
        projectController.deleteSecondOption(projectId, selectedModels);

        Fluttertoast.showToast(
            msg: "Model removed from project",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.to(() => const ClientProjectFolderScreen());
      });
    }
    debugPrint("Delete Clicked");
  }

  //export pdf function (Almost Done)
  exportPdf() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    // var status = await Permission.storage.status;
    if (await Permission.storage.isDenied) {
      debugPrint('Storage Permission not granted');
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }

// You can can also directly ask the permission about its status.
    if (await Permission.storage.isGranted) {
      final pdf = pw.Document();

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                  "Project Name : $projectName \n Project Budget : $projectBudget \n Project From Date : $projectFromDate \n Project Till Date : $projectTillDate"),
            ); // Center
          }));

      final outPut = await getExternalStorageDirectory();
      String path = outPut!.path + '/$projectName.pdf';
      final file = File(path);
      await file.writeAsBytes(await pdf.save());


      Fluttertoast.showToast(
          msg: "PDF created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Share.shareFiles([path], text: '');
    }
    debugPrint("Share folder is selected.");
    debugPrint("Export PDF Clicked");
  }

  //Validate Inputs for rename the project
  validateInputsForRename() {
    if (renameProjectController.text.toString() == projectName) {

      Fluttertoast.showToast(
          msg: "Entered name  already exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {


      CollectionReference projects =
      FirebaseFirestore.instance.collection('projects');
      projects.doc(projectId).update({
        'projectName': renameProjectController.text.toString(),
      }).then((value) {
        setState(() {
          projectName = renameProjectController.text.toString();
        });
        Get.back();

        // Get.off(() => const ClientProjectFolderScreen());
        // Get.offAll(() => const TalentHome());
        debugPrint("Project Renamed $projectId");
      }).catchError((error) {
        debugPrint("Failed to rename project: $error");
      });
    }
  }

  //Validate Inputs for budget of the project
  validateInputsForBudget() {
    if (projectBudgetController.text.toString() == projectBudget) {

      Fluttertoast.showToast(
          msg: "Budget already exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      CollectionReference projects =
      FirebaseFirestore.instance.collection('projects');
      projects.doc(projectId).update({
        'projectBudget': projectBudgetController.text.toString(),
      }).then((value) {
        Get.back();
        debugPrint("Project Budget Updated $projectId");
      }).catchError((error) {
        debugPrint("Failed to update budget: $error");
      });
    }
  }

  //delete project
  deleteProject() {
    CollectionReference projects =
    FirebaseFirestore.instance.collection('projects');
    projects.doc(projectId).delete().then((value) {


      Fluttertoast.showToast(
          msg: "Project $projectName is deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Get.off(() => const ClientProjectFolderScreen());
      // Get.offAll(() => const TalentHome());
      debugPrint("Project deleted $projectId");
    }).catchError((error) {
      debugPrint("Failed to delete project: $error");
    });
  }

  //Edit dates
  editDates(){

    CollectionReference projects =
    FirebaseFirestore.instance.collection('projects');
    projects.doc(projectId).update({
      'projectFromDate': projectFromDateController.text,
      'projectTillDate': projectTillDateController.text,
    }).then((value) {
      Get.back();
      debugPrint("Project Date Updated $projectId");
    }).catchError((error) {
      debugPrint("Failed to update date: $error");
    });

  }

  @override
  void initState() {
    projectId = widget.projectId;
    projectName = widget.projectName;
    projectBudget = widget.projectBudget;
    projectLocation = widget.projectLocation;
    projectLatitude = widget.projectLatitude;
    projectLongitude = widget.projectLongitude;
    projectTillDate = widget.projectTillDate;
    projectFromDate = widget.projectFromDate;
    projectCreatedBy = widget.projectCreatedBy;

    renameProjectController.text = projectName;
    projectBudgetController.text = projectBudget;
    projectFromDateController.text = projectFromDate;
    projectTillDateController.text = projectTillDate;


    widget.pending.forEach((element) {
      pendingList = List<String>.from(element.map((x) => x.toString()));
      debugPrint(pendingList.toString());

    });

    widget.firstOption.forEach((element) {
      firstOption = List<String>.from(element.map((x) => x.toString()));
      debugPrint(firstOption.toString());
    });
    widget.secondOption.forEach((element) {
      secondOption = List<String>.from(element.map((x) {
        return x.toString();
      }));
      // debugPrint(secondOption);
    });
    dropDownValue = projectName;
    items = [projectName];
    super.initState();
  }

  Future<bool> _willPopCallback() async {
    Get.back();
    return true;
    // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(KColors.kColorPrimary)),
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(KColors.kColorPrimary),
              )),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 25, top: 5, bottom: 5),
              child: Container(
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
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isDense: true,
                    // Initial Value
                    value: dropDownValue,
                    // Down Arrow Icon
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.black,
                      ),
                    ),
                    //Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: KFontStyle.kTextStyle16BlackRegular,
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          actions: const [
//             StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { return PopupMenuButton(
//                 color: Colors.transparent,
//                 // add icon, by default "3 dot" icon
//                 // icon: Icon(Icons.book)
//                 itemBuilder: (context) {
//                   return [
//                     //Make Selection
//                     PopupMenuItem<int>(
//                       value: 0,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 05),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0.0, 3.0), //(x,y)
//                               blurRadius: 5.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(14),
//                           // border: Border.all(
//                           //   color: Colors.grey,
//                           // ),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 30, top: 20, bottom: 20),
//                               child: Text(
//                                 "Make Selection",
//                                 style: KFontStyle.kTextStyle16BlackRegular,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     //Select All
//                     PopupMenuItem<int>(
//                       value: 1,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 05),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0.0, 3.0), //(x,y)
//                               blurRadius: 5.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(14),
//                           // border: Border.all(
//                           //   color: Colors.grey,
//                           // ),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 30, top: 20, bottom: 20),
//                               child: Text(
//                                 selectAll,
//                                 style: KFontStyle.kTextStyle16BlackRegular,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     //New Section
//                     PopupMenuItem<int>(
//                       value: 2,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 05),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0.0, 3.0), //(x,y)
//                               blurRadius: 5.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(14),
//                           // border: Border.all(
//                           //   color: Colors.grey,
//                           // ),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 30, top: 20, bottom: 20),
//                               child: Text(
//                                 "New Section",
//                                 style: KFontStyle.kTextStyle16BlackRegular,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     //Rename Project
//                     PopupMenuItem<int>(
//                       value: 3,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 05),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0.0, 3.0), //(x,y)
//                               blurRadius: 5.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(14),
//                           // border: Border.all(
//                           //   color: Colors.grey,
//                           // ),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 30, top: 20, bottom: 20),
//                               child: Text(
//                                 "Rename Project",
//                                 style: KFontStyle.kTextStyle16BlackRegular,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     //Edit Dates
//                     PopupMenuItem<int>(
//                       value: 4,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 05),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0.0, 3.0), //(x,y)
//                               blurRadius: 5.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(14),
//                           // border: Border.all(
//                           //   color: Colors.grey,
//                           // ),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 30, top: 20, bottom: 20),
//                               child: Text(
//                                 "Edit Dates",
//                                 style: KFontStyle.kTextStyle16BlackRegular,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     //Edit Budget
//                     PopupMenuItem<int>(
//                       value: 5,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 05),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0.0, 3.0), //(x,y)
//                               blurRadius: 5.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(14),
//                           // border: Border.all(
//                           //   color: Colors.grey,
//                           // ),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 30, top: 20, bottom: 20),
//                               child: Text(
//                                 "Edit Budget",
//                                 style: KFontStyle.kTextStyle16BlackRegular,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     //Delete Project
//                     PopupMenuItem<int>(
//                       value: 6,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 05),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0.0, 3.0), //(x,y)
//                               blurRadius: 5.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(14),
//                           // border: Border.all(
//                           //   color: Colors.grey,
//                           // ),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 30, top: 20, bottom: 20),
//                               child: Text(
//                                 "Delete Project",
//                                 style: KFontStyle.kTextStyle16BlackRegular,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     //Share folder as PDF
//                     PopupMenuItem<int>(
//                       value: 7,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 05),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0.0, 3.0), //(x,y)
//                               blurRadius: 5.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(14),
//                           // border: Border.all(
//                           //   color: Colors.grey,
//                           // ),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 30, top: 20, bottom: 20),
//                               child: Text(
//                                 "Share Folder as PDF",
//                                 style: KFontStyle.kTextStyle16BlackRegular,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     //Switch View
//                     PopupMenuItem<int>(
//                       value: 8,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 05),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0.0, 3.0), //(x,y)
//                               blurRadius: 5.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(14),
//                           // border: Border.all(
//                           //   color: Colors.grey,
//                           // ),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 30, top: 20, bottom: 20),
//                               child: Text(
//                                 "Switch View",
//                                 style: KFontStyle.kTextStyle16BlackRegular,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ];
//                 },
//                 onSelected: (value) async {
//                   //Make Selection (Done)
//                   if (value == 0) {
//                     setState(() {
//                       isAbsorbing = false;
//                       isVisible = true;
//                     });
//                     debugPrint("Make Selection is selected.");
//                   }
//                   //Select all done
//                   else if (value == 1) {
//                     debugPrint("Select all is selected.");
//                     selectAllMethod();
//                   }
//                   // New Section done
//                   else if (value == 2) {
//                     _addNewSection();
//                     debugPrint("New section is selected.");
//                   }
//                   //Rename Project (Done)
//                   else if (value == 3) {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Center(
//                             child: SingleChildScrollView(
//                               child: AlertDialog(
//                                 content: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 20, right: 20),
//                                       child: const Text(
//                                         "Rename Project",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontSize: 21,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "NewYork",
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 50,
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.fromLTRB(
//                                           20, 0, 20, 0),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(14),
//                                         border: Border.all(
//                                           color: Color(KColors.kColorPrimary),
//                                         ),
//                                       ),
//                                       child: Padding(
//                                         padding:
//                                         const EdgeInsets.only(left: 10),
//                                         child: TextField(
//                                           autofocus: false,
//                                           controller: renameProjectController,
//                                           maxLines: 1,
//                                           decoration: const InputDecoration(
//                                             border: InputBorder.none,
//                                             hintText: "Enter Name",
//                                             hintStyle: TextStyle(
//                                               fontFamily: "NewYork",
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.normal,
//                                               color: Color(0xff6F6F6E),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 50),
//                                     Row(
//                                       children: [
//                                         GestureDetector(
//                                             onTap: () {
//                                               validateInputsForRename();
//                                             },
//                                             child: const WhiteRectangularButton(
//                                                 "Rename Project")),
//                                         GestureDetector(
//                                             onTap: () {
//                                               Get.back();
//                                             },
//                                             child:
//                                             const WhiteRectangularButton("Back")),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         });
//                     debugPrint("Rename Project is selected.");
//                   }
//                   // Edit Project Dates
//                   else if (value == 4) {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Center(
//                             child: SingleChildScrollView(
//                               child: AlertDialog(
//                                 content: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   // crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 20, right: 20),
//                                       child: const Text(
//                                         "Edit Project Dates",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontSize: 21,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "NewYork",
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 50,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 20),
//                                           child: Text("From : ",style: KFontStyle.kTextStyle14Black
//                                             ,),
//                                         ),
//                                       ],
//                                     ),
//                                     GestureDetector(
//                                       onTap: (){
//                                         DatePicker.showDatePicker(context,
//
//                                             showTitleActions: true,
//                                             minTime: DateTime(1950, 1, 1),
//                                             maxTime: DateTime(2099,1,1), onChanged: (date) {
//                                               // print('change $date');
//                                             }, onConfirm: (date) {
//                                               final DateFormat formatter = DateFormat('yyyy-MM-dd');
//                                               setState(() {
//                                                 projectFromDate = formatter.format(date);
//                                                 projectFromDateController.text = projectFromDate;
//                                               });
//                                               // print('confirm $date');
//                                             }, currentTime: DateTime.now(), locale: LocaleType.en);
//                                       },
//                                       child: Container(
//                                         margin: const EdgeInsets.fromLTRB(
//                                             20, 0, 20, 0),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(14),
//                                           border: Border.all(
//                                             color: Color(KColors.kColorPrimary),
//                                           ),
//                                         ),
//                                         child: Padding(
//                                           padding:
//                                           const EdgeInsets.only(left: 10),
//                                           child: TextField(
//                                             enabled: false,
//                                             autofocus: false,
//                                             controller: projectFromDateController,
//                                             maxLines: 1,
//                                             decoration: const InputDecoration(
//                                               border: InputBorder.none,
//                                               hintText: "Enter Starting Date",
//                                               hintStyle: TextStyle(
//                                                 fontFamily: "NewYork",
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.normal,
//                                                 color: Color(0xff6F6F6E),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 20),
//                                           child: Text("Till : ",style: KFontStyle.kTextStyle14Black
//                                             ,),
//                                         ),
//                                       ],
//                                     ),
//
//                                     GestureDetector(
//                                       onTap: (){
//                                         DatePicker.showDatePicker(context,
//
//                                             showTitleActions: true,
//                                             minTime: DateTime(1950, 1, 1),
//                                             maxTime: DateTime(2099,1,1), onChanged: (date) {
//                                               // print('change $date');
//                                             }, onConfirm: (date) {
//                                               final DateFormat formatter = DateFormat('yyyy-MM-dd');
//                                               setState(() {
//                                                 projectTillDate = formatter.format(date);
//                                                 projectTillDateController.text = projectTillDate;
//
//                                               });
//                                               // print('confirm $date');
//                                             }, currentTime: DateTime.now(), locale: LocaleType.en);
//                                       },
//                                       child: Container(
//                                         margin: const EdgeInsets.fromLTRB(
//                                             20, 0, 20, 0),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(14),
//                                           border: Border.all(
//                                             color: Color(KColors.kColorPrimary),
//                                           ),
//                                         ),
//                                         child: Padding(
//                                           padding:
//                                           const EdgeInsets.only(left: 10),
//                                           child: TextField(
//                                             enabled: false,
//                                             autofocus: false,
//                                             controller: projectTillDateController,
//                                             maxLines: 1,
//                                             decoration: const InputDecoration(
//                                               border: InputBorder.none,
//                                               hintText: "Enter Ending Date",
//                                               hintStyle: TextStyle(
//                                                 fontFamily: "NewYork",
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.normal,
//                                                 color: Color(0xff6F6F6E),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 50),
//                                     Row(
//                                       children: [
//                                         GestureDetector(
//                                             onTap: () {
//                                               editDates();
//                                             },
//                                             child: const WhiteRectangularButton(
//                                                 "Edit Dates")),
//                                         GestureDetector(
//                                             onTap: () {
//                                               Get.back();
//                                             },
//                                             child:
//                                             const WhiteRectangularButton("Back")),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         });
//                     debugPrint("Edit Dates is selected.");
//                   }
//                   //Edit budget (Done)
//                   else if (value == 5) {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Center(
//                             child: SingleChildScrollView(
//                               child: AlertDialog(
//                                 content: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 20, right: 20),
//                                       child: const Text(
//                                         "Edit Budget",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontSize: 21,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "NewYork",
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 50,
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.fromLTRB(
//                                           20, 0, 20, 0),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(14),
//                                         border: Border.all(
//                                           color: Color(KColors.kColorPrimary),
//                                         ),
//                                       ),
//                                       child: Padding(
//                                         padding:
//                                         const EdgeInsets.only(left: 10),
//                                         child: TextField(
//                                           autofocus: false,
//                                           controller: projectBudgetController,
//                                           maxLines: 1,
//                                           decoration: const InputDecoration(
//                                             border: InputBorder.none,
//                                             hintText: "Enter budet",
//                                             hintStyle: TextStyle(
//                                               fontFamily: "NewYork",
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.normal,
//                                               color: Color(0xff6F6F6E),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 50),
//                                     Row(
//                                       children: [
//                                         GestureDetector(
//                                             onTap: () {
//                                               validateInputsForBudget();
//                                               projectBudget = projectBudgetController.text.toString();
//                                             },
//                                             child: const WhiteRectangularButton(
//                                                 "Edit Budget")),
//                                         GestureDetector(
//                                             onTap: () {
//                                               Get.back();
//                                             },
//                                             child:
//                                             const WhiteRectangularButton("Back")),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         });
//                     debugPrint("Edit Budget is selected.");
//                   }
//                   //Delete project (Done)
//                   else if (value == 6) {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Center(
//                             child: SingleChildScrollView(
//                               child: AlertDialog(
//                                 content: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 20, right: 20),
//                                       child: const Text(
//                                         "Delete Project",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontSize: 21,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "NewYork",
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 50,
//                                     ),
//                                     const Padding(
//                                       padding: EdgeInsets.only(left: 10),
//                                       child:  Text(
//                                         "Are you sure to delete this project",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "NewYork",
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 50),
//                                     Row(
//                                       children: [
//                                         GestureDetector(
//                                             onTap: () {
//                                               deleteProject();
//                                             },
//                                             child: const WhiteRectangularButton(
//                                                 "Delete Project")),
//                                         GestureDetector(
//                                             onTap: () {
//                                               Get.back();
//                                             },
//                                             child:
//                                             const WhiteRectangularButton("Back")),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         });
//                     debugPrint("Delete project is selected.");
//                   }
//                   //Share Folder (Done)
//                   else if (value == 7) {
//                     Map<Permission, PermissionStatus> statuses = await [
//                       Permission.storage,
//                     ].request();
//                     // var status = await Permission.storage.status;
//                     if (await Permission.storage.isDenied) {
//                       debugPrint('Storage Permission not granted');
//                       // We didn't ask for permission yet or the permission has been denied before but not permanently.
//                     }
//
// // You can can also directly ask the permission about its status.
//                     if (await Permission.storage.isGranted) {
//                       final pdf = pw.Document();
//
//                       pdf.addPage(pw.Page(
//                           pageFormat: PdfPageFormat.a4,
//                           build: (pw.Context context) {
//                             return pw.Center(
//                               child: pw.Text(
//                                   "Project Name : $projectName \n Project Budget : $projectBudget \n Project From Date : $projectFromDate \n Project Till Date : $projectTillDate"),
//                             ); // Center
//                           }));
//
//                       final outPut = await getExternalStorageDirectory();
//                       String path = outPut!.path + '/$projectName.pdf';
//                       final file = File(path);
//                       await file.writeAsBytes(await pdf.save());
//
//                       Share.shareFiles([path], text: '');
//                     }
//                     debugPrint("Share folder is selected.");
//                   }
//                   //Switch View
//                   else if (value == 8) {
//                     debugPrint("switch view is selected.");
//                   }
//                 }); },)
          ],
        ),
        body: SafeArea(
          child: pendingList.isNotEmpty
              ?GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0  ),
                      itemCount: pendingUserData.length,
                      itemBuilder: (BuildContext ctx, index) {
                                return PendingModelItem(
                                  userId:  pendingUserData.elementAt(index).userId,
                                  firstName: pendingUserData.elementAt(index).firstName,
                                  lastName: pendingUserData.elementAt(index).lastName,
                                  email: pendingUserData.elementAt(index).email,
                                  profilePicture: pendingUserData.elementAt(index).profilePicture,
                                  dateOfBirth: pendingUserData.elementAt(index).dateOfBirth,
                                  gender: pendingUserData.elementAt(index).gender,
                                  county: pendingUserData.elementAt(index).county,
                                  state: pendingUserData.elementAt(index).state,
                                  city: pendingUserData.elementAt(index).city,
                                  postalCode: pendingUserData.elementAt(index).postalCode,
                                  drivingLicense: pendingUserData.elementAt(index).drivingLicense,
                                  idCard: pendingUserData.elementAt(index).idCard,
                                  passport: pendingUserData.elementAt(index).passport,
                                  otherId: pendingUserData.elementAt(index).otherId,
                                  country: pendingUserData.elementAt(index).country,
                                  hairColor: pendingUserData.elementAt(index).hairColor,
                                  eyeColor: pendingUserData.elementAt(index).eyeColor,
                                  heightCm: pendingUserData.elementAt(index).heightCm,
                                  heightFeet: pendingUserData.elementAt(index).heightFeet,
                                  waistCm: pendingUserData.elementAt(index).waistCm,
                                  waistInches: pendingUserData.elementAt(index).waistInches,
                                  weightKg: pendingUserData.elementAt(index).weightKg,
                                  weightPound: pendingUserData.elementAt(index).weightPound,
                                  buildType: pendingUserData.elementAt(index).buildType,
                                  wearSizeCm: pendingUserData.elementAt(index).wearSizeCm,
                                  wearSizeInches: pendingUserData.elementAt(index).wearSizeInches,
                                  chestCm: pendingUserData.elementAt(index).chestCm,
                                  chestInches: pendingUserData.elementAt(index).chestInches,
                                  hipCm: pendingUserData.elementAt(index).hipCm,
                                  hipInches: pendingUserData.elementAt(index).hipInches,
                                  inseamCm: pendingUserData.elementAt(index).inseamCm,
                                  inseamInches: pendingUserData.elementAt(index).inseamInches,
                                  shoesCm: pendingUserData.elementAt(index).shoesCm,
                                  shoesInches: pendingUserData.elementAt(index).shoesInches,
                                  scarPicture: pendingUserData.elementAt(index).scarPicture,
                                  tattooPicture: pendingUserData.elementAt(index).tattooPicture,
                                  isDrivingLicense: pendingUserData.elementAt(index).isDrivingLicense,
                                  isIdCard: pendingUserData.elementAt(index).isIdCard,
                                  isPassport: pendingUserData.elementAt(index).isPassport,
                                  isOtherId: pendingUserData.elementAt(index).isOtherId,
                                  isScar: pendingUserData.elementAt(index).isScar,
                                  isTattoo: pendingUserData.elementAt(index).isTattoo,
                                  languages: pendingUserData.elementAt(index).languages,
                                  sports: pendingUserData.elementAt(index).sports,
                                  hobbies: pendingUserData.elementAt(index).hobbies,
                                  talent: pendingUserData.elementAt(index).talent,
                                  portfolioImageLink: pendingUserData.elementAt(index).portfolioImageLink,
                                  portfolioVideoLink: pendingUserData.elementAt(index).portfolioVideoLink,
                                  polaroidImageLink: pendingUserData.elementAt(index).polaroidImageLink,
                                  projectId: widget.projectId,
                                  indexNumber: index,
                                );
            })
          // projectData.elementAt(0).firstOption.isNotEmpty ?
          // Column(
          //   children: [
          //
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height / 2.8,
          //       width: MediaQuery.of(context).size.width,
          //       // margin: EdgeInsets.only(
          //       //   left: 20,
          //       //   right: 20,
          //       //   top: 10,
          //       // ),
          //       child: SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             SizedBox(
          //               height: MediaQuery.of(context).size.height / 3.2,
          //               width: MediaQuery.of(context).size.width ,
          //               child: ListView.builder(
          //                 scrollDirection: Axis.horizontal,
          //                 // physics:
          //                 //     const NeverScrollableScrollPhysics(),
          //                 keyboardDismissBehavior:
          //                 ScrollViewKeyboardDismissBehavior
          //                     .onDrag,
          //                 itemCount: pendingUserData.length,
          //                 itemBuilder:
          //                     (BuildContext context,
          //                     int index) {
          //                   return PendingModelItem(
          //                     userId:  pendingUserData.elementAt(index).userId,
          //                     firstName: pendingUserData.elementAt(index).firstName,
          //                     lastName: pendingUserData.elementAt(index).lastName,
          //                     email: pendingUserData.elementAt(index).email,
          //                     profilePicture: pendingUserData.elementAt(index).profilePicture,
          //                     dateOfBirth: pendingUserData.elementAt(index).dateOfBirth,
          //                     gender: pendingUserData.elementAt(index).gender,
          //                     county: pendingUserData.elementAt(index).county,
          //                     state: pendingUserData.elementAt(index).state,
          //                     city: pendingUserData.elementAt(index).city,
          //                     postalCode: pendingUserData.elementAt(index).postalCode,
          //                     drivingLicense: pendingUserData.elementAt(index).drivingLicense,
          //                     idCard: pendingUserData.elementAt(index).idCard,
          //                     passport: pendingUserData.elementAt(index).passport,
          //                     otherId: pendingUserData.elementAt(index).otherId,
          //                     country: pendingUserData.elementAt(index).country,
          //                     hairColor: pendingUserData.elementAt(index).hairColor,
          //                     eyeColor: pendingUserData.elementAt(index).eyeColor,
          //                     heightCm: pendingUserData.elementAt(index).heightCm,
          //                     heightFeet: pendingUserData.elementAt(index).heightFeet,
          //                     waistCm: pendingUserData.elementAt(index).waistCm,
          //                     waistInches: pendingUserData.elementAt(index).waistInches,
          //                     weightKg: pendingUserData.elementAt(index).weightKg,
          //                     weightPound: pendingUserData.elementAt(index).weightPound,
          //                     buildType: pendingUserData.elementAt(index).buildType,
          //                     wearSizeCm: pendingUserData.elementAt(index).wearSizeCm,
          //                     wearSizeInches: pendingUserData.elementAt(index).wearSizeInches,
          //                     chestCm: pendingUserData.elementAt(index).chestCm,
          //                     chestInches: pendingUserData.elementAt(index).chestInches,
          //                     hipCm: pendingUserData.elementAt(index).hipCm,
          //                     hipInches: pendingUserData.elementAt(index).hipInches,
          //                     inseamCm: pendingUserData.elementAt(index).inseamCm,
          //                     inseamInches: pendingUserData.elementAt(index).inseamInches,
          //                     shoesCm: pendingUserData.elementAt(index).shoesCm,
          //                     shoesInches: pendingUserData.elementAt(index).shoesInches,
          //                     scarPicture: pendingUserData.elementAt(index).scarPicture,
          //                     tattooPicture: pendingUserData.elementAt(index).tattooPicture,
          //                     isDrivingLicense: pendingUserData.elementAt(index).isDrivingLicense,
          //                     isIdCard: pendingUserData.elementAt(index).isIdCard,
          //                     isPassport: pendingUserData.elementAt(index).isPassport,
          //                     isOtherId: pendingUserData.elementAt(index).isOtherId,
          //                     isScar: pendingUserData.elementAt(index).isScar,
          //                     isTattoo: pendingUserData.elementAt(index).isTattoo,
          //                     languages: pendingUserData.elementAt(index).languages,
          //                     sports: pendingUserData.elementAt(index).sports,
          //                     hobbies: pendingUserData.elementAt(index).hobbies,
          //                     talent: pendingUserData.elementAt(index).talent,
          //                     portfolioImageLink: pendingUserData.elementAt(index).portfolioImageLink,
          //                     portfolioVideoLink: pendingUserData.elementAt(index).portfolioVideoLink,
          //                     polaroidImageLink: pendingUserData.elementAt(index).polaroidImageLink,
          //                     projectId: widget.projectId,
          //                     indexNumber: index,
          //                   );
          //                 },
          //               ),
          //             ),
          //
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // )
              : Container(),
        ),
        //
      ),
    );
  }
}
