import 'dart:async';

import 'package:beautyshot/Views/client_screens/map_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row_white.dart';

import 'package:beautyshot/controller/project_controller.dart';
import 'package:beautyshot/model/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';
import 'package:beautyshot/components/address_search.dart';
import 'package:beautyshot/components/place_service.dart';
import 'package:uuid/uuid.dart';
// import 'package:location/location.dart' as loc;

class ProjectLocationScreen extends StatefulWidget {
  const ProjectLocationScreen({Key? key}) : super(key: key);

  @override
  State<ProjectLocationScreen> createState() => _ProjectLocationScreenState();
}

class _ProjectLocationScreenState extends State<ProjectLocationScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final projectController = Get.put(ProjectController());
  ProjectModel newProjectModel =
      ProjectModel('', '', '', '', '', '', '', '', '',[],[],[],[]);
  String projectLocation = "";
  String projectLatitude = "";
  String projectLongitude = "";
  TextEditingController projectLocationController = TextEditingController();
  TextEditingController searchLocationController = TextEditingController();
  bool mapVisibility = false;
  LatLng startLocation = const LatLng(33.6844, 73.0479);
  GoogleMapController? mapController;
   CameraPosition? cameraPosition;
  String googleApikey = "AIzaSyBPhk0NO89LXI3lou3KPRb4CQjEL4qaEBc";
  String pLocation= "Location Name:";

  bool locationIconVisibility = false;

  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

  }
  onForwardPress() async {
    if (projectLocation == "" &&
        projectLatitude == "" &&
        projectLongitude == "") {

      Fluttertoast.showToast(
          msg: "Please enter location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Get.defaultDialog(title: "Creating Project",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
      SharedPreferences prefs = await _prefs;
      newProjectModel.projectName = prefs.getString('projectName')!;
      newProjectModel.projectBudget = prefs.getString('projectBudget')!;
      newProjectModel.projectFromDate = prefs.getString('projectFromDate')!;
      newProjectModel.projectTillDate = prefs.getString('projectTillDate')!;
      newProjectModel.projectCreatedBy = FirebaseAuth.instance.currentUser!.uid.toString();
      newProjectModel.projectId = newProjectModel.projectName + newProjectModel.projectCreatedBy + DateTime.now().toString();
      newProjectModel.projectLocation = projectLocationController.text.toString();
      newProjectModel.projectLatitude = projectLatitude;
      newProjectModel.projectLongitude = projectLongitude;
      projectController.addProject(newProjectModel);
    }
    // Get.to(()=>const ProjectBudgetScreen());
  }


  @override
  void dispose() {
    projectLocationController.dispose();
    searchLocationController.dispose();
    mapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Top Row
              TopRowWhite(4),
              //Body
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  // mapVisibility == false
                  //     ? SizedBox(
                  //         height: 500,
                  //       )
                  //     : Visibility(
                  //         visible: mapVisibility,
                  //         child: ,
                  //       ),
                  const SizedBox(
                    height: 0,
                  ),
                  //Text where do you need the talent
                  TitleText(Strings.whereDoYouNeedTheTalent),
                  //SizedBox
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      style: KFontStyle.kTextStyle16BlackRegular,
                      controller: projectLocationController,
                      autofocus: false,
                      maxLines: 1,
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: "Type here",
                        hintStyle: KFontStyle.kTextStyle14Black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>MapScreen());
                      // setState(() {
                      //
                      //   showGeneralDialog(
                      //       context: context,
                      //       barrierDismissible: true,
                      //       barrierLabel:
                      //       MaterialLocalizations.of(context).modalBarrierDismissLabel,
                      //       barrierColor: Colors.black45,
                      //       transitionDuration: const Duration(milliseconds: 200),
                      //       pageBuilder: (BuildContext buildContext, Animation animation,
                      //           Animation secondaryAnimation) {
                      //         return StatefulBuilder(builder: (context, setState) {
                      //           return SafeArea(
                      //             child: Container(
                      //               height: 500,
                      //               child:  Stack(
                      //                   children:[
                      //                     GoogleMap( //Map wid
                      //                       myLocationEnabled: true,
                      //                       compassEnabled: true,
                      //                       myLocationButtonEnabled: true,// get from google_maps_flutter package
                      //                       zoomGesturesEnabled: true, //enable Zoom in, out on map
                      //                       initialCameraPosition: CameraPosition( //innital position in map
                      //                         target: startLocation, //initial position
                      //                         zoom: 16.0, //initial zoom level
                      //                       ),
                      //                       mapType: MapType.normal, //map type
                      //                       onMapCreated: (controller) { //method called when map is created
                      //                         setState(() {
                      //                           mapController = controller;
                      //
                      //                         });
                      //                       },
                      //                       onCameraMove: (CameraPosition cameraPositiona) {
                      //                         cameraPosition = cameraPositiona; //when map is dragging
                      //                       },
                      //                       onCameraIdle: () async { //when map drag stops
                      //                         SharedPreferences prefs = await _prefs;
                      //                         List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                      //                         setState(() { //get place name from lat and lang
                      //                           pLocation = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
                      //                           projectLatitude = cameraPosition!.target.latitude.toString();
                      //                           projectLongitude = cameraPosition!.target.longitude.toString();
                      //
                      //                           prefs.setString('location', pLocation);
                      //                           prefs.setBool('locationIconVisibility', true);
                      //
                      //                           // projectLocationController.text = projectLocation;
                      //
                      //                           // print(pLocation);
                      //                           //
                      //                           // locationIconVisibility = true;
                      //                         });
                      //                       },
                      //                     ),
                      //                     Center( //picker image on google map
                      //                       child: Image.asset("assets/images/marker.png", width: 80,),
                      //                     ),
                      //                     Positioned(  //widget to display location name
                      //                         bottom:100,
                      //                         child: Padding(
                      //                           padding: const EdgeInsets.all(15),
                      //                           child: Card(
                      //                             child: Container(
                      //                                 padding: const EdgeInsets.all(0),
                      //                                 width: MediaQuery.of(context).size.width - 40,
                      //                                 child: ListTile(
                      //                                   leading: Image.asset("assets/images/marker.png", width: 25,),
                      //                                   title:Text(pLocation, style: const TextStyle(fontSize: 18),),
                      //                                   dense: true,
                      //                                 )
                      //                             ),
                      //                           ),
                      //                         )
                      //                     ),
                      //                      Positioned(  //widget to display location name
                      //                         bottom:10,
                      //                         left:150,
                      //                         child: Row(
                      //                           mainAxisAlignment: MainAxisAlignment.center,
                      //                           children: [
                      //                             Padding(
                      //                               padding: const EdgeInsets.all(15),
                      //                               child: GestureDetector(
                      //                                 onTap: () async{
                      //                                   SharedPreferences prefs = await _prefs;
                      //                                   setState(() {
                      //
                      //                                     projectLocationController.text = prefs.getString('location')!;
                      //                                     locationIconVisibility = prefs.getBool('locationIconVisibility')!;
                      //                                     Get.back();
                      //                                   });
                      //
                      //                                 },
                      //                                   child: Container(
                      //                                     margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      //                                     decoration: BoxDecoration(
                      //                                       color: Colors.white,
                      //                                       boxShadow: const [
                      //                                         BoxShadow(
                      //                                           color: Colors.grey,
                      //                                           offset: Offset(0.0, 3.0), //(x,y)
                      //                                           blurRadius: 5.0,
                      //                                         ),
                      //                                       ],
                      //                                       borderRadius: BorderRadius.circular(14),
                      //                                       // border: Border.all(
                      //                                       //   color: Colors.grey,
                      //                                       // ),
                      //                                     ),
                      //                                     child: Row(
                      //                                       mainAxisAlignment: MainAxisAlignment.center,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding: const EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),
                      //                                           child: Material(child: Text("Done",style: KFontStyle.kTextStyle16BlackRegular,)),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),),
                      //                             ),
                      //                           ],
                      //                         )
                      //                     ),
                      //                     Positioned(
                      //                       top: 20,
                      //                       left: 80,
                      //                       child: Container(
                      //                         height: 60,
                      //                         width: MediaQuery.of(context).size.width/1.5,
                      //                         child: Card(
                      //                           child: TextField(
                      //                             controller: searchLocationController,
                      //                             onTap: () async {
                      //
                      //                               final sessionToken = Uuid().v4();
                      //                               final Suggestion? result = await showSearch(
                      //                                 context: context,
                      //                                 delegate: AddressSearch(sessionToken),
                      //                               );
                      //                               // This will change the text displayed in the TextField
                      //                               if (result != null) {
                      //                                 setState(() {
                      //                                   searchLocationController.text = result.description;
                      //                                 });
                      //                               }
                      //                             },
                      //                             // with some styling
                      //                             decoration: InputDecoration(
                      //                               icon: Container(
                      //                                 margin: const EdgeInsets.only(left: 20,bottom: 16),
                      //                                 width: 10,
                      //                                 height: 10,
                      //                                 child: const Icon(
                      //                                   Icons.location_on,
                      //                                   color: Colors.black,
                      //                                 ),
                      //                               ),
                      //                               hintText: "Enter your project location",
                      //                               border: InputBorder.none,
                      //                               contentPadding: const EdgeInsets.only(left: 8.0, top: 16.0,bottom: 16),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     )
                      //
                      //                   ]
                      //               ),
                      //
                      //               // child: Stack(
                      //               //   children: [
                      //               //     GoogleMap(
                      //               //       mapType: MapType.normal,
                      //               //       myLocationEnabled: true,
                      //               //       myLocationButtonEnabled: true,
                      //               //       initialCameraPosition: CameraPosition(
                      //               //           target: _initialcameraposition,
                      //               //           zoom: 15),
                      //               //       onMapCreated: (controller) {
                      //               //         //method called when map is created
                      //               //         setState(() {
                      //               //           _controller = controller;
                      //               //         });
                      //               //       },
                      //               //       onCameraMove:
                      //               //           (CameraPosition cameraPositiona) {
                      //               //         cameraPosition =
                      //               //             cameraPositiona; //when map is dragging
                      //               //       },
                      //               //       onCameraIdle: () async {
                      //               //         //when map drag stops
                      //               //         List<Placemark> placemarks =
                      //               //             await placemarkFromCoordinates(
                      //               //                 cameraPosition!.target.latitude,
                      //               //                 cameraPosition!.target.longitude);
                      //               //         setState(() {
                      //               //           //get place name from lat and lang
                      //               //           pLocation = placemarks
                      //               //                   .first.administrativeArea
                      //               //                   .toString() +
                      //               //               ", " +
                      //               //               placemarks.first.street.toString();
                      //               //           projectLatitude = cameraPosition!
                      //               //               .target.latitude
                      //               //               .toString();
                      //               //           projectLongitude = cameraPosition!
                      //               //               .target.longitude
                      //               //               .toString();
                      //               //           print(pLocation);
                      //               //           print(projectLatitude);
                      //               //           print(projectLongitude);
                      //               //         });
                      //               //       },
                      //               //     ),
                      //               //     Center(
                      //               //       //picker image on google map
                      //               //       child: Image.asset(
                      //               //         "assets/images/marker.png",
                      //               //         width: 40,
                      //               //       ),
                      //               //     ),
                      //               //     Positioned(
                      //               //         //widget to display location name
                      //               //         bottom: 80,
                      //               //         child: Padding(
                      //               //           padding: EdgeInsets.all(15),
                      //               //           child: Center(
                      //               //             child: Card(
                      //               //               child: Container(
                      //               //                   padding: EdgeInsets.all(10),
                      //               //                   width: MediaQuery.of(context)
                      //               //                           .size
                      //               //                           .width -
                      //               //                       80,
                      //               //                   child: ListTile(
                      //               //                     leading: Image.asset(
                      //               //                       "assets/images/marker.png",
                      //               //                       width: 25,
                      //               //                     ),
                      //               //                     title: Text(
                      //               //                       pLocation,
                      //               //                       style:
                      //               //                           TextStyle(fontSize: 18),
                      //               //                     ),
                      //               //                     dense: true,
                      //               //                   )),
                      //               //             ),
                      //               //           ),
                      //               //         ))
                      //               //   ],
                      //               // ),
                      //             ),
                      //           );
                      //         },);
                      //       });
                      //
                      //   // mapVisibility = true;
                      // });
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 2.0), //(x,y)
                            blurRadius: 3.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(14),
                        // border: Border.all(
                        //   color: Colors.grey,
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Strings.chooseLocationOnMap,
                              style: KFontStyle.kTextStyle18Black,
                            ),
                            Icon(
                              Icons.location_on,
                              color: Color(KColors.kColorDarkGrey),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  visible: locationIconVisibility,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                  ),
                                ),
                              ],
                            ),
                            // Image.asset("assets/images/filter.png",height: 32,width: 32,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //SizedBox
                  const SizedBox(
                    height: 20,
                  ),
                  //Forward Button
                  // BackForwardButton(onForwardPress),
                  Buttons.backForwardButton(onForwardPress),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


