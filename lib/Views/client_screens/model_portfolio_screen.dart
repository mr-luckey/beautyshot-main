import 'package:beautyshot/Views/client_screens/bulk_models_list.dart';
import 'package:beautyshot/Views/client_screens/individual_message_screen.dart';
import 'package:beautyshot/Views/client_screens/model_carousal.dart';
import 'package:beautyshot/Views/client_screens/model_details_screen.dart';
import 'package:beautyshot/Views/client_screens/polaroid_image_view.dart';
import 'package:beautyshot/Views/client_screens/project_bubble_list.dart';
import 'package:beautyshot/Views/client_screens/scar_image_view.dart';
import 'package:beautyshot/Views/client_screens/tatto_image_view.dart';
import 'package:beautyshot/Views/client_screens/video_player_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/controller/client_controller.dart';
import 'package:beautyshot/model/talent_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class ModelPortfolioScreen extends StatefulWidget {
  final String userId,firstName,lastName,email,profilePicture,gender,county,state,city,postalCode,drivingLicense,
      idCard,passport,otherId,country,hairColor,eyeColor,buildType,scarPicture,
      tattooPicture;
  Timestamp dateOfBirth;
  num heightCm,heightFeet,waistCm,waistInches,weightKg,weightPound,wearSizeCm,wearSizeInches,chestCm,chestInches,hipCm,hipInches,inseamCm,inseamInches,
      shoesCm,shoesInches,indexNumber;
  bool isDrivingLicense,isIdCard,isPassport,isOtherId,isScar,isTattoo;
  List languages,sports,hobbies,talent,portfolioImageLink,portfolioVideoLink,polaroidImageLink;

  ModelPortfolioScreen({Key? key,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePicture,
    required this.dateOfBirth,
    required this.gender,
    required this.county,
    required this.state,
    required this.city,
    required this.postalCode,
    required this.drivingLicense,
    required this.idCard,
    required this.passport,
    required this.otherId,
    required this.country,
    required this.hairColor,
    required this.eyeColor,
    required this.heightCm,
    required this.heightFeet,
    required this.waistCm,
    required this.waistInches,
    required this.weightKg,
    required this.weightPound,
    required this.buildType,
    required this.wearSizeCm,
    required this.wearSizeInches,
    required this.chestCm,
    required this.chestInches,
    required this.hipCm,
    required this.hipInches,
    required this.inseamCm,
    required this.inseamInches,
    required this.shoesCm,
    required this.shoesInches,
    required this.scarPicture,
    required this.tattooPicture,
    required this.isDrivingLicense,
    required this.isIdCard,
    required this.isPassport,
    required this.isOtherId,
    required this.isScar,
    required this.isTattoo,
    required this.languages,
    required this.sports,
    required this.hobbies,
    required this.talent,
    required this.portfolioImageLink,
    required this.portfolioVideoLink,
    required this.polaroidImageLink,
    required this.indexNumber,
  }) : super(key: key);

  @override
  State<ModelPortfolioScreen> createState() => _ModelPortfolioScreenState();
}

class _ModelPortfolioScreenState extends State<ModelPortfolioScreen> {
  late int initialDragTimeStamp;
  late int currentDragTimeStamp;
  late int timeDelta;
  late double initialPositionY;
  late double currentPositionY;
  late double positionYDelta;
  late String thumb;
  List<TalentModel> talentData = <TalentModel>[];
  final clientController = Get.put(ClientController());
  String clientId = FirebaseAuth.instance.currentUser!.uid.toString();

  void _startVerticalDrag(details) {
    // Timestamp of when drag begins
    initialDragTimeStamp = details.sourceTimeStamp.inMilliseconds;
    debugPrint("Swiping down");
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.topToBottom,
            child: ModelDetailsScreen(userId: widget.userId, firstName: widget.firstName, lastName: widget.lastName, email: widget.email, profilePicture: widget.profilePicture, dateOfBirth: widget.dateOfBirth, gender: widget.gender, county: widget.county, state: widget.state, city: widget.city, postalCode: widget.postalCode, drivingLicense: widget.drivingLicense, idCard: widget.idCard, passport: widget.passport, otherId: widget.otherId, country: widget.country, hairColor: widget.hairColor, eyeColor: widget.eyeColor, buildType: widget.buildType, scarPicture: widget.scarPicture, tattooPicture: widget.tattooPicture, heightCm: widget.heightCm, heightFeet: widget.heightFeet, waistCm: widget.waistCm, waistInches: widget.waistInches, weightKg: widget.weightKg, weightPound: widget.weightPound, wearSizeCm: widget.wearSizeCm, wearSizeInches: widget.wearSizeInches, chestCm: widget.chestCm, chestInches: widget.chestInches, hipCm: widget.hipCm, hipInches: widget.hipInches, inseamCm: widget.inseamCm, inseamInches: widget.inseamInches, shoesCm: widget.shoesCm, shoesInches: widget.shoesInches, isDrivingLicense: widget.isDrivingLicense, isIdCard: widget.isIdCard, isPassport: widget.isPassport, isOtherId: widget.isOtherId, isScar: widget.isScar, isTattoo: widget.isTattoo, languages: widget.languages, sports: widget.sports, hobbies: widget.hobbies, talent: widget.talent, portfolioImageLink: widget.portfolioImageLink, portfolioVideoLink: widget.portfolioVideoLink, polaroidImageLink: widget.polaroidImageLink,indexNumber:widget.indexNumber)));

    // Screen position of pointer when drag begins
    initialPositionY = details.globalPosition.dy;
  }

  void _whileVerticalDrag(details) {
    // Gets current timestamp and position of the drag event
    currentDragTimeStamp = details.sourceTimeStamp.inMilliseconds;
    currentPositionY = details.globalPosition.dy;

    // How much time has passed since drag began
    timeDelta = currentDragTimeStamp - initialDragTimeStamp;

    // Distance pointer has travelled since drag began
    positionYDelta = currentPositionY - initialPositionY;

    // If pointer has moved more than 50pt in less than 50ms...
    if (timeDelta < 50 && positionYDelta > 50) {
      // close modal
    }
  }

  List<String> portfolioList = [];

  List<String> polaroidList = [];

  List<String> videoList = [];

  List<String> ignoredUser = [];

  late VideoPlayerController _controller;

  bool isDidChangeRunningOnce = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isDidChangeRunningOnce) {
      getAllTalent();
      isDidChangeRunningOnce = false;
    }
  }

  Future getAllTalent() async {
    talentData.clear();
    FirebaseFirestore.instance.collection('models').snapshots().listen((event) {
      talentData.clear();
      event.docs.forEach((element) {
        talentData.add(TalentModel.fromMap(element.data()));
      });
      setState(() {});

    });

  }

  @override
  void initState() {
    super.initState();
    debugPrint('Model Portfolio Screen');
    widget.portfolioImageLink.forEach((element) {
      // portfolioList = List<String>.from(element.map((x) => x.toString()));
      portfolioList = widget.portfolioImageLink.cast();
      debugPrint(portfolioList.toString());
    });
    widget.polaroidImageLink.forEach((element) {
      // polaroidList = List<String>.from(element.map((x) => x.toString()));
      polaroidList = widget.polaroidImageLink.cast();
      debugPrint("sadhskjd");
      debugPrint(polaroidList.length.toString());
      debugPrint(polaroidList.toString());
    });
    widget.portfolioVideoLink.forEach((element) {
      // videoList = List<String>.from(element.map((x) => x.toString()));
      videoList = widget.portfolioVideoLink.cast();
      debugPrint("Video List $videoList");
    });
    for (int i = 0; i < videoList.length; i++) {
      _controller = VideoPlayerController.network(videoList.elementAt(i))
        ..initialize().then((_) {
          setState(() {}); //when your thumbnail will show.
        });
    }

  }

  Future<bool> _willPopCallback() async {
    Get.to(()=>ModelDetailsScreen(userId: widget.userId, firstName: widget.firstName, lastName: widget.lastName, email: widget.email, profilePicture: widget.profilePicture, dateOfBirth: widget.dateOfBirth, gender: widget.gender, county: widget.county, state: widget.state, city: widget.city, postalCode: widget.postalCode, drivingLicense: widget.drivingLicense, idCard: widget.idCard, passport: widget.passport, otherId: widget.otherId, country: widget.country, hairColor: widget.hairColor, eyeColor: widget.eyeColor, buildType: widget.buildType, scarPicture: widget.scarPicture, tattooPicture: widget.tattooPicture, heightCm: widget.heightCm, heightFeet: widget.heightFeet, waistCm: widget.waistCm, waistInches: widget.waistInches, weightKg: widget.weightKg, weightPound: widget.weightPound, wearSizeCm: widget.wearSizeCm, wearSizeInches: widget.wearSizeInches, chestCm: widget.chestCm, chestInches: widget.chestInches, hipCm: widget.hipCm, hipInches: widget.hipInches, inseamCm: widget.inseamCm, inseamInches: widget.inseamInches, shoesCm: widget.shoesCm, shoesInches: widget.shoesInches, isDrivingLicense: widget.isDrivingLicense, isIdCard: widget.isIdCard, isPassport: widget.isPassport, isOtherId: widget.isOtherId, isScar: widget.isScar, isTattoo: widget.isTattoo, languages: widget.languages, sports: widget.sports, hobbies: widget.hobbies, talent: widget.talent, portfolioImageLink: widget.portfolioImageLink, portfolioVideoLink: widget.portfolioVideoLink, polaroidImageLink: widget.polaroidImageLink, indexNumber: widget.indexNumber));
    return false;
    // return true if the route to be popped
  }
  final List<String> items = [
    'Single Person',
    'Bulk',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: SafeArea(
          child: Stack(

            children: [
              ///Background image
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.profilePicture,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ///Background Opacity
              Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.6),
              ),

              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///Back Button
                        GestureDetector(
                          onTap: () {
                            Get.off(()=>const BulkModelsList());
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         type: PageTransitionType.topToBottom,
                            //         child: ModelDetailsScreen(userId: widget.userId, firstName: widget.firstName, lastName: widget.lastName, email: widget.email, profilePicture: widget.profilePicture, dateOfBirth: widget.dateOfBirth, gender: widget.gender, county: widget.county, state: widget.state, city: widget.city, postalCode: widget.postalCode, drivingLicense: widget.drivingLicense, idCard: widget.idCard, passport: widget.passport, otherId: widget.otherId, country: widget.country, hairColor: widget.hairColor, eyeColor: widget.eyeColor, buildType: widget.buildType, scarPicture: widget.scarPicture, tattooPicture: widget.tattooPicture, heightCm: widget.heightCm, heightFeet: widget.heightFeet, waistCm: widget.waistCm, waistInches: widget.waistInches, weightKg: widget.weightKg, weightPound: widget.weightPound, wearSizeCm: widget.wearSizeCm, wearSizeInches: widget.wearSizeInches, chestCm: widget.chestCm, chestInches: widget.chestInches, hipCm: widget.hipCm, hipInches: widget.hipInches, inseamCm: widget.inseamCm, inseamInches: widget.inseamInches, shoesCm: widget.shoesCm, shoesInches: widget.shoesInches, isDrivingLicense: widget.isDrivingLicense, isIdCard: widget.isIdCard, isPassport: widget.isPassport, isOtherId: widget.isOtherId, isScar: widget.isScar, isTattoo: widget.isTattoo, languages: widget.languages, sports: widget.sports, hobbies: widget.hobbies, talent: widget.talent, portfolioImageLink: widget.portfolioImageLink, portfolioVideoLink: widget.portfolioVideoLink, polaroidImageLink: widget.polaroidImageLink,indexNumber:widget.indexNumber)));
                          },
                          child: Image.asset(
                            "assets/images/back_button.png",
                            height: 62,
                            width: 62,
                          ),
                        ),
                        ///Swipe Down
                        GestureDetector(
                          onVerticalDragStart: (details) =>
                              _startVerticalDrag(details),
                          onVerticalDragUpdate: (details) =>
                              _whileVerticalDrag(details),
                          child: Image.asset(
                            "assets/images/swipe_down.png",
                            height: 62,
                            width: 120,
                          ),
                        ),
                        /// Menu Button
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            customButton: Container(
                              height: 62,
                              width: 62,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/images/menu_button.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            openWithLongPress: true,

                            ///ucomminted       error solving
                            // customItemsIndexes: const [3],
                            // customItemsHeight: 8,
                            items: items
                                .map((item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: Colors.grey,
                                      //     offset: Offset(0.0, 3.0), //(x,y)
                                      //     blurRadius: 5.0,
                                      //   ),
                                      // ],
                                      borderRadius: BorderRadius.circular(14),
                                      // border: Border.all(
                                      //   color: Colors.grey,
                                      // ),
                                    ),
                                    child: Row(

                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20,bottom: 20,left: 20),
                                          child: Text(
                                            item,
                                            style: KFontStyle.kTextStyle14Black,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                                debugPrint("selectedValue");
                                debugPrint(selectedValue);
                                if(value == "Single Person"){
                                  debugPrint("Single Person View Clicked");
                                  // Get.to(()=>ModelCarousalScreen(userId: talentDataIgnored.elementAt(0).userId, firstName: talentDataIgnored.elementAt(0).firstName, lastName: talentDataIgnored.elementAt(0).lastName, email: talentDataIgnored.elementAt(0).email, profilePicture: talentDataIgnored.elementAt(0).profilePicture, dateOfBirth: talentDataIgnored.elementAt(0).dateOfBirth, gender: talentDataIgnored.elementAt(0).gender, county: talentDataIgnored.elementAt(0).county, state: talentDataIgnored.elementAt(0).state, city: talentDataIgnored.elementAt(0).city, postalCode: talentDataIgnored.elementAt(0).postalCode, drivingLicense: talentDataIgnored.elementAt(0).drivingLicense, idCard: talentDataIgnored.elementAt(0).idCard, passport: talentDataIgnored.elementAt(0).passport, otherId: talentDataIgnored.elementAt(0).otherId, country: talentDataIgnored.elementAt(0).country, hairColor: talentDataIgnored.elementAt(0).hairColor, eyeColor: talentDataIgnored.elementAt(0).eyeColor, buildType: talentDataIgnored.elementAt(0).buildType, scarPicture: talentDataIgnored.elementAt(0).scarPicture, tattooPicture: talentDataIgnored.elementAt(0).tattooPicture, heightCm: talentDataIgnored.elementAt(0).heightCm, heightFeet: talentDataIgnored.elementAt(0).heightFeet, waistCm: talentDataIgnored.elementAt(0).waistCm, waistInches: talentDataIgnored.elementAt(0).waistInches, weightKg: talentDataIgnored.elementAt(0).weightKg, weightPound: talentDataIgnored.elementAt(0).weightPound, wearSizeCm: talentDataIgnored.elementAt(0).wearSizeCm, wearSizeInches: talentDataIgnored.elementAt(0).wearSizeInches, chestCm: talentDataIgnored.elementAt(0).chestCm, chestInches: talentDataIgnored.elementAt(0).chestInches, hipCm: talentDataIgnored.elementAt(0).hipCm, hipInches: talentDataIgnored.elementAt(0).hipInches, inseamCm: talentDataIgnored.elementAt(0).inseamCm, inseamInches: talentDataIgnored.elementAt(0).inseamInches, shoesCm: talentDataIgnored.elementAt(0).shoesCm, shoesInches: talentDataIgnored.elementAt(0).shoesInches, isDrivingLicense: talentDataIgnored.elementAt(0).isDrivingLicense, isIdCard: talentDataIgnored.elementAt(0).isIdCard, isPassport: talentDataIgnored.elementAt(0).isPassport, isOtherId: talentDataIgnored.elementAt(0).isOtherId, isScar: talentDataIgnored.elementAt(0).isScar, isTattoo: talentDataIgnored.elementAt(0).isTattoo, languages: talentDataIgnored.elementAt(0).languages, sports: talentDataIgnored.elementAt(0).sports, hobbies: talentDataIgnored.elementAt(0).hobbies, talent: talentDataIgnored.elementAt(0).talent, portfolioImageLink: talentDataIgnored.elementAt(0).portfolioImageLink, portfolioVideoLink: talentDataIgnored.elementAt(0).portfolioVideoLink, polaroidImageLink: talentDataIgnored.elementAt(0).polaroidImageLink, indexNumber: 0,));
                                }
                                else{
                                  debugPrint("Bulk View Clicked");
                                  Get.off(()=>const BulkModelsList());
                                }
                              });
                            },
                            menuItemStyleData: MenuItemStyleData(
                              height: 60,
                              padding: const EdgeInsets.only(left: 16, right: 16),
                            ),
                      dropdownStyleData: DropdownStyleData(
                        width: 160,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.transparent,
                        ),
                        elevation: 8,
                        offset: const Offset(40, -4),
                      ),

                          ),
                        ),

                      ],
                    ),
                    ///Sized box
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),

                    Column(
                      children: [
                        ///Video Column
                        Column(
                          children: [
                            ///Text Videos
                            Row(
                              children: [
                                Text(
                                  Strings.videos,
                                  style: KFontStyle.kTextStyle24White,
                                ),
                              ],
                            ),
                            ///Video Thumbnail
                            SizedBox(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: videoList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: (){
                                        debugPrint("Video Player Clicked");
                                        Get.to(()=>VideoPlayerScreen(widget.portfolioVideoLink));
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (BuildContext context) {
                                        //       return Center(
                                        //         child: AlertDialog(
                                        //           content: Container(
                                        //             height: MediaQuery.of(context).size.height,
                                        //             width: MediaQuery.of(context).size.width,
                                        //
                                        //             child: _controller.value.isInitialized
                                        //                 ? GestureDetector(
                                        //               onTap: (){
                                        //                 setState(() {
                                        //                   _controller.value.isPlaying
                                        //                       ? _controller.pause()
                                        //                       : _controller.play();
                                        //                 });
                                        //               },
                                        //               child: AspectRatio(
                                        //                 aspectRatio: _controller.value.aspectRatio,
                                        //                 child: VideoPlayer(_controller),
                                        //               ),
                                        //             )
                                        //                 : Container(),),
                                        //         ),
                                        //       );
                                        //     });
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            height: 200,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                BorderRadius.circular(14)),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(14),
                                              child: VideoPlayer(_controller),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.play_arrow_rounded,
                                            color: Colors.white,
                                            size: 80,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        ///Polaroid Column
                        Column(
                          children: [
                            ///Text Polaroids
                            Row(
                              children: [
                                Text(
                                  Strings.polaroids,
                                  style: KFontStyle.kTextStyle24White,
                                ),
                              ],
                            ),
                            ///Polaroid grid
                            polaroidList.length > 2
                                ? SizedBox(
                              height: 450,
                              child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                children: List.generate(
                                    polaroidList.length, (index) {
                                  return GestureDetector(
                                    onTap: (){
                                      Get.to(()=>PolaroidImageView(widget.polaroidImageLink));
                                      // showDialog(
                                      //     context: context,
                                      //     builder: (BuildContext context) {
                                      //       return Center(
                                      //         child: AlertDialog(
                                      //           content: Container(
                                      //
                                      //             decoration: BoxDecoration(
                                      //               color: Colors.white,
                                      //               boxShadow: const [
                                      //                 BoxShadow(
                                      //                   color: Colors.grey,
                                      //                   offset:
                                      //                   Offset(0.0, 3.0), //(x,y)
                                      //                   blurRadius: 5.0,
                                      //                 ),
                                      //               ],
                                      //               borderRadius:
                                      //               BorderRadius.circular(14),
                                      //               // border: Border.all(
                                      //               //   color: Colors.grey,
                                      //               // ),
                                      //             ),
                                      //             child: ClipRRect(
                                      //               borderRadius:
                                      //               BorderRadius.circular(14),
                                      //               child: CachedNetworkImage(
                                      //                 fit: BoxFit.cover,
                                      //                 width: 500,
                                      //                 height: 500,
                                      //                 imageUrl: polaroidList[index],
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       );
                                      //     });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset:
                                            Offset(0.0, 3.0), //(x,y)
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                        borderRadius:
                                        BorderRadius.circular(14),
                                        // border: Border.all(
                                        //   color: Colors.grey,
                                        // ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(14),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width: 200,
                                          height: 200,
                                          imageUrl: polaroidList[index],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            )
                                : SizedBox(
                              height: 225,
                              child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                children: List.generate(
                                    polaroidList.length, (index) {
                                  return GestureDetector(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: AlertDialog(
                                                content: Container(

                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        offset:
                                                        Offset(0.0, 3.0), //(x,y)
                                                        blurRadius: 5.0,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                    BorderRadius.circular(14),
                                                    // border: Border.all(
                                                    //   color: Colors.grey,
                                                    // ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(14),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      width: 500,
                                                      height: 500,
                                                      imageUrl: polaroidList[index],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset:
                                            Offset(0.0, 3.0), //(x,y)
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                        borderRadius:
                                        BorderRadius.circular(14),
                                        // border: Border.all(
                                        //   color: Colors.grey,
                                        // ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(14),
                                        child: CachedNetworkImage(
                                          width: 200,
                                          height: 200,
                                          imageUrl: polaroidList[index],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                        ///SizedBox
                        const SizedBox(
                          height: 30,
                        ),
                        ///Scars Column
                        Column(
                          children: [
                            widget.scarPicture != ""
                                ? Column(
                              children: [
                                ///Text Scars
                                Row(
                                  children: [
                                    Text(
                                      "Scars",
                                      style: KFontStyle.kTextStyle24White,
                                    ),
                                  ],
                                ),
                                ///Scar image
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=>ScarImageView(widget.scarPicture));
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return Center(
                                    //         child: AlertDialog(
                                    //           content: Container(
                                    //
                                    //             decoration: BoxDecoration(
                                    //               color: Colors.white,
                                    //               boxShadow: const [
                                    //                 BoxShadow(
                                    //                   color: Colors.grey,
                                    //                   offset:
                                    //                   Offset(0.0, 3.0), //(x,y)
                                    //                   blurRadius: 5.0,
                                    //                 ),
                                    //               ],
                                    //               borderRadius:
                                    //               BorderRadius.circular(14),
                                    //               // border: Border.all(
                                    //               //   color: Colors.grey,
                                    //               // ),
                                    //             ),
                                    //             child: ClipRRect(
                                    //               borderRadius:
                                    //               BorderRadius.circular(14),
                                    //               child: CachedNetworkImage(
                                    //                 fit: BoxFit.cover,
                                    //                 width: 500,
                                    //                 height: 500,
                                    //                 imageUrl: widget.scarPicture,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                            BorderRadius.circular(14)),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(14),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: widget.scarPicture,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                                : Container(),
                          ],
                        ),

                        ///Tattoo Column
                        Column(
                          children: [
                            widget.tattooPicture != ""
                                ? Column(
                              children: [
                                ///Text Tattoo
                                Row(
                                  children: [
                                    Text(
                                      "Tattoo",
                                      style: KFontStyle.kTextStyle24White,
                                    ),
                                  ],
                                ),
                                ///Tattoo image
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=>TattooImageView(widget.tattooPicture));
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return Center(
                                    //         child: AlertDialog(
                                    //           content: Container(
                                    //
                                    //             decoration: BoxDecoration(
                                    //               color: Colors.white,
                                    //               boxShadow: const [
                                    //                 BoxShadow(
                                    //                   color: Colors.grey,
                                    //                   offset:
                                    //                   Offset(0.0, 3.0), //(x,y)
                                    //                   blurRadius: 5.0,
                                    //                 ),
                                    //               ],
                                    //               borderRadius:
                                    //               BorderRadius.circular(14),
                                    //               // border: Border.all(
                                    //               //   color: Colors.grey,
                                    //               // ),
                                    //             ),
                                    //             child: ClipRRect(
                                    //               borderRadius:
                                    //               BorderRadius.circular(14),
                                    //               child: CachedNetworkImage(
                                    //                 fit: BoxFit.cover,
                                    //                 width: 500,
                                    //                 height: 500,
                                    //                 imageUrl: widget.tattooPicture,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                            BorderRadius.circular(14)),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(14),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: widget.tattooPicture,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                                : Container(),
                          ],
                        ),
                        ///SizedBox
                        const SizedBox(
                          height: 10,
                        ),
                        ///Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///Ignore button
                            GestureDetector(
                                onTap: (){
                                  ignoredUser.add(widget.userId);
                                  clientController.ignoreUser(clientId, ignoredUser);
                                  if(widget.indexNumber < talentData.length-1 )
                                  {
                                    Get.off(()=>ModelCarousalScreen(userId: talentData.elementAt(widget.indexNumber.toInt() + 1).userId, firstName: talentData.elementAt(widget.indexNumber.toInt() + 1).firstName, lastName: talentData.elementAt(widget.indexNumber.toInt() + 1).lastName, email: talentData.elementAt(widget.indexNumber.toInt() + 1).email, profilePicture: talentData.elementAt(widget.indexNumber.toInt() + 1).profilePicture, dateOfBirth: talentData.elementAt(widget.indexNumber.toInt() + 1).dateOfBirth, gender: talentData.elementAt(widget.indexNumber.toInt() + 1).gender, county: talentData.elementAt(widget.indexNumber.toInt() + 1).county, state: talentData.elementAt(widget.indexNumber.toInt() + 1).state, city: talentData.elementAt(widget.indexNumber.toInt() + 1).city, postalCode: talentData.elementAt(widget.indexNumber.toInt() + 1).postalCode, drivingLicense: talentData.elementAt(widget.indexNumber.toInt() + 1).drivingLicense, idCard: talentData.elementAt(widget.indexNumber.toInt() + 1).idCard, passport: talentData.elementAt(widget.indexNumber.toInt() + 1).passport, otherId: talentData.elementAt(widget.indexNumber.toInt() + 1).otherId, country: talentData.elementAt(widget.indexNumber.toInt() + 1).country, hairColor: talentData.elementAt(widget.indexNumber.toInt() + 1).hairColor, eyeColor: talentData.elementAt(widget.indexNumber.toInt() + 1).eyeColor, buildType: talentData.elementAt(widget.indexNumber.toInt() + 1).buildType, scarPicture: talentData.elementAt(widget.indexNumber.toInt() + 1).scarPicture, tattooPicture: talentData.elementAt(widget.indexNumber.toInt() + 1).tattooPicture, heightCm: talentData.elementAt(widget.indexNumber.toInt() + 1).heightCm, heightFeet: talentData.elementAt(widget.indexNumber.toInt() + 1).heightFeet, waistCm: talentData.elementAt(widget.indexNumber.toInt() + 1).waistCm, waistInches: talentData.elementAt(widget.indexNumber.toInt() + 1).waistInches, weightKg: talentData.elementAt(widget.indexNumber.toInt() + 1).weightKg, weightPound: talentData.elementAt(widget.indexNumber.toInt() + 1).weightPound, wearSizeCm: talentData.elementAt(widget.indexNumber.toInt() + 1).wearSizeCm, wearSizeInches: talentData.elementAt(widget.indexNumber.toInt() + 1).wearSizeInches, chestCm: talentData.elementAt(widget.indexNumber.toInt() + 1).chestCm, chestInches: talentData.elementAt(widget.indexNumber.toInt() + 1).chestInches, hipCm: talentData.elementAt(widget.indexNumber.toInt() + 1).hipCm, hipInches: talentData.elementAt(widget.indexNumber.toInt() + 1).hipInches, inseamCm: talentData.elementAt(widget.indexNumber.toInt() + 1).inseamCm, inseamInches: talentData.elementAt(widget.indexNumber.toInt() + 1).inseamInches, shoesCm: talentData.elementAt(widget.indexNumber.toInt() + 1).shoesCm, shoesInches: talentData.elementAt(widget.indexNumber.toInt() + 1).shoesInches, isDrivingLicense: talentData.elementAt(widget.indexNumber.toInt() + 1).isDrivingLicense, isIdCard: talentData.elementAt(widget.indexNumber.toInt() + 1).isIdCard, isPassport: talentData.elementAt(widget.indexNumber.toInt() + 1).isPassport, isOtherId: talentData.elementAt(widget.indexNumber.toInt() + 1).isOtherId, isScar: talentData.elementAt(widget.indexNumber.toInt() + 1).isScar, isTattoo: talentData.elementAt(widget.indexNumber.toInt() + 1).isTattoo, languages: talentData.elementAt(widget.indexNumber.toInt() + 1).languages, sports: talentData.elementAt(widget.indexNumber.toInt() + 1).sports, hobbies: talentData.elementAt(widget.indexNumber.toInt() + 1).hobbies, talent: talentData.elementAt(widget.indexNumber.toInt() + 1).talent, portfolioImageLink: talentData.elementAt(widget.indexNumber.toInt() + 1).portfolioImageLink, portfolioVideoLink: talentData.elementAt(widget.indexNumber.toInt() + 1).portfolioVideoLink, polaroidImageLink: talentData.elementAt(widget.indexNumber.toInt() + 1).polaroidImageLink,indexNumber:widget.indexNumber.toInt()+1));
                                  }
                                  else{

                                    Fluttertoast.showToast(
                                        msg: "No more models",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    debugPrint("No more models");
                                  }

                                },
                                child: Column(children: [
                                  Container(
                                    height: 62,
                                    width: 62,
                                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    decoration: BoxDecoration(
                                      color: Color(KColors.kColorWhite),
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 5.0,
                                        ),
                                      ],

                                    ),
                                    child: Center(child:Image.asset("assets/images/cross.png",height: 18,width: 18)),
                                  ),
                                  const SizedBox(height: 10,),
                                  Text("Ignore",style: KFontStyle.kTextStyle16White,),
                                ],)),
                            ///Add to folder button
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => ProjectBubbleList(widget.userId,
                                      widget.profilePicture, "firstOption"));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 62,
                                      width: 62,
                                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        color: Color(KColors.kColorWhite),
                                        borderRadius: BorderRadius.circular(100),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 5.0,
                                          ),
                                        ],

                                      ),
                                      child: Center(child:Image.asset("assets/images/project.png",color: Color(KColors.kColorDarkGrey),height: 18,width: 18)),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text("Folder",style: KFontStyle.kTextStyle16White,),
                                  ],
                                ),),
                            ///Chat Button
                            GestureDetector(
                                onTap: (){
                                  Get.to(()=>IndividualMessageScreen(modelId: widget.userId));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 62,
                                      width: 62,
                                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        color: Color(KColors.kColorWhite),
                                        borderRadius: BorderRadius.circular(100),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 5.0,
                                          ),
                                        ],

                                      ),
                                      child: Center(child:Image.asset("assets/images/chat_inactive.png",color: Color(KColors.kColorDarkGrey),height: 18,width: 18)),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text("Message",style: KFontStyle.kTextStyle16White,),
                                  ],
                                ),),
                          ],
                        ),
                        ///SizedBox
                        const SizedBox(
                          height: 50,
                        ),
                        ///Book now button
                        Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          // child: BlueButton(title: 'Book Now'),
                          child: Buttons.blueButton(Strings.bookNow, () { Get.to(() => ProjectBubbleList(widget.userId,
                              widget.profilePicture, "firstOption"));}),
                        ),
                        ///SizedBox
                        const SizedBox(
                          height: 10,
                        ),
                        ///Last Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///Back Button
                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Container(
                                height: 62,
                                width: 62,
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Color(KColors.kColorPrimary),
                                  borderRadius: BorderRadius.circular(100),
                                  // border: Border.all(
                                  //   color: Colors.grey,
                                  // ),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                            ///Next Model Button
                            GestureDetector(
                              onTap: (){
                                if(widget.indexNumber < talentData.length-1 )
                                {
                                  Get.off(()=>ModelCarousalScreen(userId: talentData.elementAt(widget.indexNumber.toInt() + 1).userId, firstName: talentData.elementAt(widget.indexNumber.toInt() + 1).firstName, lastName: talentData.elementAt(widget.indexNumber.toInt() + 1).lastName, email: talentData.elementAt(widget.indexNumber.toInt() + 1).email, profilePicture: talentData.elementAt(widget.indexNumber.toInt() + 1).profilePicture, dateOfBirth: talentData.elementAt(widget.indexNumber.toInt() + 1).dateOfBirth, gender: talentData.elementAt(widget.indexNumber.toInt() + 1).gender, county: talentData.elementAt(widget.indexNumber.toInt() + 1).county, state: talentData.elementAt(widget.indexNumber.toInt() + 1).state, city: talentData.elementAt(widget.indexNumber.toInt() + 1).city, postalCode: talentData.elementAt(widget.indexNumber.toInt() + 1).postalCode, drivingLicense: talentData.elementAt(widget.indexNumber.toInt() + 1).drivingLicense, idCard: talentData.elementAt(widget.indexNumber.toInt() + 1).idCard, passport: talentData.elementAt(widget.indexNumber.toInt() + 1).passport, otherId: talentData.elementAt(widget.indexNumber.toInt() + 1).otherId, country: talentData.elementAt(widget.indexNumber.toInt() + 1).country, hairColor: talentData.elementAt(widget.indexNumber.toInt() + 1).hairColor, eyeColor: talentData.elementAt(widget.indexNumber.toInt() + 1).eyeColor, buildType: talentData.elementAt(widget.indexNumber.toInt() + 1).buildType, scarPicture: talentData.elementAt(widget.indexNumber.toInt() + 1).scarPicture, tattooPicture: talentData.elementAt(widget.indexNumber.toInt() + 1).tattooPicture, heightCm: talentData.elementAt(widget.indexNumber.toInt() + 1).heightCm, heightFeet: talentData.elementAt(widget.indexNumber.toInt() + 1).heightFeet, waistCm: talentData.elementAt(widget.indexNumber.toInt() + 1).waistCm, waistInches: talentData.elementAt(widget.indexNumber.toInt() + 1).waistInches, weightKg: talentData.elementAt(widget.indexNumber.toInt() + 1).weightKg, weightPound: talentData.elementAt(widget.indexNumber.toInt() + 1).weightPound, wearSizeCm: talentData.elementAt(widget.indexNumber.toInt() + 1).wearSizeCm, wearSizeInches: talentData.elementAt(widget.indexNumber.toInt() + 1).wearSizeInches, chestCm: talentData.elementAt(widget.indexNumber.toInt() + 1).chestCm, chestInches: talentData.elementAt(widget.indexNumber.toInt() + 1).chestInches, hipCm: talentData.elementAt(widget.indexNumber.toInt() + 1).hipCm, hipInches: talentData.elementAt(widget.indexNumber.toInt() + 1).hipInches, inseamCm: talentData.elementAt(widget.indexNumber.toInt() + 1).inseamCm, inseamInches: talentData.elementAt(widget.indexNumber.toInt() + 1).inseamInches, shoesCm: talentData.elementAt(widget.indexNumber.toInt() + 1).shoesCm, shoesInches: talentData.elementAt(widget.indexNumber.toInt() + 1).shoesInches, isDrivingLicense: talentData.elementAt(widget.indexNumber.toInt() + 1).isDrivingLicense, isIdCard: talentData.elementAt(widget.indexNumber.toInt() + 1).isIdCard, isPassport: talentData.elementAt(widget.indexNumber.toInt() + 1).isPassport, isOtherId: talentData.elementAt(widget.indexNumber.toInt() + 1).isOtherId, isScar: talentData.elementAt(widget.indexNumber.toInt() + 1).isScar, isTattoo: talentData.elementAt(widget.indexNumber.toInt() + 1).isTattoo, languages: talentData.elementAt(widget.indexNumber.toInt() + 1).languages, sports: talentData.elementAt(widget.indexNumber.toInt() + 1).sports, hobbies: talentData.elementAt(widget.indexNumber.toInt() + 1).hobbies, talent: talentData.elementAt(widget.indexNumber.toInt() + 1).talent, portfolioImageLink: talentData.elementAt(widget.indexNumber.toInt() + 1).portfolioImageLink, portfolioVideoLink: talentData.elementAt(widget.indexNumber.toInt() + 1).portfolioVideoLink, polaroidImageLink: talentData.elementAt(widget.indexNumber.toInt() + 1).polaroidImageLink,indexNumber:widget.indexNumber.toInt()+1));
                                }
                                else{
                                  Fluttertoast.showToast(
                                      msg: "No more models",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
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
                                  borderRadius: BorderRadius.circular(50),
                                  // border: Border.all(
                                  //   color: Colors.grey,
                                  // ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Next Model Button
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        "Next Model",
                                        style: KFontStyle.kTextStyle16BlackRegular,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: GestureDetector(
                                        onTap: (){
                                          Get.back();
                                        },
                                        child: const Icon(
                                          Icons.navigate_next_rounded,
                                          size: 32,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
