import 'package:age_calculator/age_calculator.dart';
import 'package:beautyshot/Views/client_screens/bulk_models_list.dart';
import 'package:beautyshot/Views/client_screens/model_carousal.dart';
import 'package:beautyshot/Views/client_screens/model_portfolio_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class ModelDetailsScreen extends StatefulWidget {
  final String userId,
      firstName,
      lastName,
      email,
      profilePicture,
      gender,
      county,
      state,
      city,
      postalCode,
      drivingLicense,
      idCard,
      passport,
      otherId,
      country,
      hairColor,
      eyeColor,
      buildType,
      scarPicture,
      tattooPicture;
  final Timestamp dateOfBirth;
  final num heightCm,
      heightFeet,
      waistCm,
      waistInches,
      weightKg,
      weightPound,
      wearSizeCm,
      wearSizeInches,
      chestCm,
      chestInches,
      hipCm,
      hipInches,
      inseamCm,
      inseamInches,
      shoesCm,
      shoesInches,
      indexNumber;
  final bool isDrivingLicense, isIdCard, isPassport, isOtherId, isScar, isTattoo;
  final List languages,
      sports,
      hobbies,
      talent,
      portfolioImageLink,
      portfolioVideoLink,
      polaroidImageLink;

  const ModelDetailsScreen({
    Key? key,
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
    required this.buildType,
    required this.scarPicture,
    required this.tattooPicture,
    required this.heightCm,
    required this.heightFeet,
    required this.waistCm,
    required this.waistInches,
    required this.weightKg,
    required this.weightPound,
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
  State<ModelDetailsScreen> createState() => _ModelDetailsScreenState();
}

class _ModelDetailsScreenState extends State<ModelDetailsScreen> {
  late int initialDragTimeStamp;
  late int currentDragTimeStamp;
  late int timeDelta;
  late double initialPositionY;
  late double currentPositionY;
  late double positionYDelta;

  bool unit = false;

  void _startVerticalDragDown(details) {
    // Timestamp of when drag begins
    initialDragTimeStamp = details.sourceTimeStamp.inMilliseconds;
    debugPrint("Swiping Down");
    // Get.to(()=>ModelDetailsScreen(widget.userId, widget.firstName, widget.lastName, widget.email, widget.profilePicture, widget.dateOfBirth, widget.gender, widget.county, widget.state, widget.city, widget.postalCode, widget.drivingLicense, widget.idCard, widget.passport, widget.otherId, widget.country, widget.hairColor, widget.eyeColor, widget.heightUnit, widget.height, widget.waistUnit, widget.waist, widget.weightUnit, widget.weight, widget.buildType, widget.wearSizeUnit, widget.wearSize, widget.chestUnit, widget.chest, widget.hipUnit, widget.hip, widget.inseamUnit, widget.inseam, widget.shoeSizeUnit, widget.shoeSize, widget.scarPicture, widget.tattooPicture, widget.isDrivingLicense, widget.isIdCard, widget.isPassport, widget.isOtherId, widget.isScar, widget.isTattoo, widget.languages, widget.sports, widget.hobbies, widget.talent, widget.portfolioImageLink, widget.portfolioVideoLink, widget.polaroidImageLink));
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.topToBottom,
            child: ModelCarousalScreen(
              userId: widget.userId,
              firstName: widget.firstName,
              lastName: widget.lastName,
              email: widget.email,
              profilePicture: widget.profilePicture,
              dateOfBirth: widget.dateOfBirth,
              gender: widget.gender,
              county: widget.county,
              state: widget.state,
              city: widget.city,
              postalCode: widget.postalCode,
              drivingLicense: widget.drivingLicense,
              idCard: widget.idCard,
              passport: widget.passport,
              otherId: widget.otherId,
              country: widget.country,
              hairColor: widget.hairColor,
              eyeColor: widget.eyeColor,
              buildType: widget.buildType,
              scarPicture: widget.scarPicture,
              tattooPicture: widget.tattooPicture,
              heightCm: widget.heightCm,
              heightFeet: widget.heightFeet,
              waistCm: widget.waistCm,
              waistInches: widget.waistInches,
              weightKg: widget.weightKg,
              weightPound: widget.weightPound,
              wearSizeCm: widget.wearSizeCm,
              wearSizeInches: widget.wearSizeInches,
              chestCm: widget.chestCm,
              chestInches: widget.chestInches,
              hipCm: widget.hipCm,
              hipInches: widget.hipInches,
              inseamCm: widget.inseamCm,
              inseamInches: widget.inseamInches,
              shoesCm: widget.shoesCm,
              shoesInches: widget.shoesInches,
              isDrivingLicense: widget.isDrivingLicense,
              isIdCard: widget.isIdCard,
              isPassport: widget.isPassport,
              isOtherId: widget.isOtherId,
              isScar: widget.isScar,
              isTattoo: widget.isTattoo,
              languages: widget.languages,
              sports: widget.sports,
              hobbies: widget.hobbies,
              talent: widget.talent,
              portfolioImageLink: widget.portfolioImageLink,
              portfolioVideoLink: widget.portfolioVideoLink,
              polaroidImageLink: widget.polaroidImageLink,
              indexNumber: widget.indexNumber,
            )));
    // Screen position of pointer when drag begins
    initialPositionY = details.globalPosition.dy;
  }

  void _startVerticalDragUp(details) {
    // Timestamp of when drag begins
    initialDragTimeStamp = details.sourceTimeStamp.inMilliseconds;
    debugPrint("Swiping Up");
    // Get.to(()=>ModelDetailsScreen(widget.userId, widget.firstName, widget.lastName, widget.email, widget.profilePicture, widget.dateOfBirth, widget.gender, widget.county, widget.state, widget.city, widget.postalCode, widget.drivingLicense, widget.idCard, widget.passport, widget.otherId, widget.country, widget.hairColor, widget.eyeColor, widget.heightUnit, widget.height, widget.waistUnit, widget.waist, widget.weightUnit, widget.weight, widget.buildType, widget.wearSizeUnit, widget.wearSize, widget.chestUnit, widget.chest, widget.hipUnit, widget.hip, widget.inseamUnit, widget.inseam, widget.shoeSizeUnit, widget.shoeSize, widget.scarPicture, widget.tattooPicture, widget.isDrivingLicense, widget.isIdCard, widget.isPassport, widget.isOtherId, widget.isScar, widget.isTattoo, widget.languages, widget.sports, widget.hobbies, widget.talent, widget.portfolioImageLink, widget.portfolioVideoLink, widget.polaroidImageLink));
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop,
            child: ModelPortfolioScreen(
                userId: widget.userId,
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                profilePicture: widget.profilePicture,
                dateOfBirth: widget.dateOfBirth,
                gender: widget.gender,
                county: widget.county,
                state: widget.state,
                city: widget.city,
                postalCode: widget.postalCode,
                drivingLicense: widget.drivingLicense,
                idCard: widget.idCard,
                passport: widget.passport,
                otherId: widget.otherId,
                country: widget.country,
                hairColor: widget.hairColor,
                eyeColor: widget.eyeColor,
                heightCm: widget.heightCm,
                heightFeet: widget.heightFeet,
                waistCm: widget.waistCm,
                waistInches: widget.waistInches,
                weightKg: widget.weightKg,
                weightPound: widget.weightPound,
                buildType: widget.buildType,
                wearSizeCm: widget.wearSizeCm,
                wearSizeInches: widget.wearSizeInches,
                chestCm: widget.chestCm,
                chestInches: widget.chestInches,
                hipCm: widget.hipCm,
                hipInches: widget.hipInches,
                inseamCm: widget.inseamCm,
                inseamInches: widget.inseamInches,
                shoesCm: widget.shoesCm,
                shoesInches: widget.shoesInches,
                scarPicture: widget.scarPicture,
                tattooPicture: widget.tattooPicture,
                isDrivingLicense: widget.isDrivingLicense,
                isIdCard: widget.isIdCard,
                isPassport: widget.isPassport,
                isOtherId: widget.isOtherId,
                isScar: widget.isScar,
                isTattoo: widget.isTattoo,
                languages: widget.languages,
                sports: widget.sports,
                hobbies: widget.hobbies,
                talent: widget.talent,
                portfolioImageLink: widget.portfolioImageLink,
                portfolioVideoLink: widget.portfolioVideoLink,
                polaroidImageLink: widget.polaroidImageLink,
                indexNumber: widget.indexNumber)));
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

  List<String> languagesList = [];

  List<String> sportsList = [];

  List<String> hobbiesList = [];

  List<String> talentList = [];

  late DateDuration duration;

  @override
  void initState() {
    var date = DateTime.parse(widget.dateOfBirth.toDate().toString());
    duration = AgeCalculator.age(date);
    print(duration.years);

    widget.languages.forEach((element) {
      // languagesList= List<String>.from(element.map((x) => x.toString()));
      languagesList = widget.languages.cast();

    });
    widget.sports.forEach((element) {
      sportsList = widget.sports.cast();

    });
    widget.hobbies.forEach((element) {
      hobbiesList = widget.hobbies.cast();

    });
    widget.talent.forEach((element) {
      talentList = widget.talent.cast();

    });

    // widget.languages.forEach((element) {
    //   languagesList= List<String>.from(element.map((x) => x.toString()));
    //   print("Languages kjsdfksdjfksdjfk");
    //   print(languagesList);
    // });


    super.initState();
  }

  Future<bool> _willPopCallback() async {
    Get.off(()=>const BulkModelsList());
    // Get.to(() => ModelCarousalScreen(
    //     userId: widget.userId,
    //     firstName: widget.firstName,
    //     lastName: widget.lastName,
    //     email: widget.email,
    //     profilePicture: widget.profilePicture,
    //     dateOfBirth: widget.dateOfBirth,
    //     gender: widget.gender,
    //     county: widget.county,
    //     state: widget.state,
    //     city: widget.city,
    //     postalCode: widget.postalCode,
    //     drivingLicense: widget.drivingLicense,
    //     idCard: widget.idCard,
    //     passport: widget.passport,
    //     otherId: widget.otherId,
    //     country: widget.country,
    //     hairColor: widget.hairColor,
    //     eyeColor: widget.eyeColor,
    //     buildType: widget.buildType,
    //     scarPicture: widget.scarPicture,
    //     tattooPicture: widget.tattooPicture,
    //     heightCm: widget.heightCm,
    //     heightFeet: widget.heightFeet,
    //     waistCm: widget.waistCm,
    //     waistInches: widget.waistInches,
    //     weightKg: widget.weightKg,
    //     weightPound: widget.weightPound,
    //     wearSizeCm: widget.wearSizeCm,
    //     wearSizeInches: widget.wearSizeInches,
    //     chestCm: widget.chestCm,
    //     chestInches: widget.chestInches,
    //     hipCm: widget.hipCm,
    //     hipInches: widget.hipInches,
    //     inseamCm: widget.inseamCm,
    //     inseamInches: widget.inseamInches,
    //     shoesCm: widget.shoesCm,
    //     shoesInches: widget.shoesInches,
    //     isDrivingLicense: widget.isDrivingLicense,
    //     isIdCard: widget.isIdCard,
    //     isPassport: widget.isPassport,
    //     isOtherId: widget.isOtherId,
    //     isScar: widget.isScar,
    //     isTattoo: widget.isTattoo,
    //     languages: widget.languages,
    //     sports: widget.sports,
    //     hobbies: widget.hobbies,
    //     talent: widget.talent,
    //     portfolioImageLink: widget.portfolioImageLink,
    //     portfolioVideoLink: widget.portfolioVideoLink,
    //     polaroidImageLink: widget.polaroidImageLink,
    //     indexNumber: widget.indexNumber));
    return false;
    // return true if the route to be popped
  }

  final List<String> items = [
    'Single Person',
    'Bulk',
  ];
  String? selectedValue;
  //Vertical drag details
  late DragStartDetails startVerticalDragDetails;
  late DragUpdateDetails updateVerticalDragDetails;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onVerticalDragStart: (dragDetails) {
              startVerticalDragDetails = dragDetails;
            },
            onVerticalDragUpdate: (dragDetails) {
              updateVerticalDragDetails = dragDetails;
            },
            onVerticalDragEnd: (endDetails) {
              double dx = updateVerticalDragDetails.globalPosition.dx -
                  startVerticalDragDetails.globalPosition.dx;
              double dy = updateVerticalDragDetails.globalPosition.dy -
                  startVerticalDragDetails.globalPosition.dy;
              double? velocity = endDetails.primaryVelocity;

              //Convert values to be positive
              if (dx < 0) dx = -dx;
              if (dy < 0) dy = -dy;

              if (velocity! < 0) {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: ModelPortfolioScreen(
                            userId: widget.userId,
                            firstName: widget.firstName,
                            lastName: widget.lastName,
                            email: widget.email,
                            profilePicture: widget.profilePicture,
                            dateOfBirth: widget.dateOfBirth,
                            gender: widget.gender,
                            county: widget.county,
                            state: widget.state,
                            city: widget.city,
                            postalCode: widget.postalCode,
                            drivingLicense: widget.drivingLicense,
                            idCard: widget.idCard,
                            passport: widget.passport,
                            otherId: widget.otherId,
                            country: widget.country,
                            hairColor: widget.hairColor,
                            eyeColor: widget.eyeColor,
                            heightCm: widget.heightCm,
                            heightFeet: widget.heightFeet,
                            waistCm: widget.waistCm,
                            waistInches: widget.waistInches,
                            weightKg: widget.weightKg,
                            weightPound: widget.weightPound,
                            buildType: widget.buildType,
                            wearSizeCm: widget.wearSizeCm,
                            wearSizeInches: widget.wearSizeInches,
                            chestCm: widget.chestCm,
                            chestInches: widget.chestInches,
                            hipCm: widget.hipCm,
                            hipInches: widget.hipInches,
                            inseamCm: widget.inseamCm,
                            inseamInches: widget.inseamInches,
                            shoesCm: widget.shoesCm,
                            shoesInches: widget.shoesInches,
                            scarPicture: widget.scarPicture,
                            tattooPicture: widget.tattooPicture,
                            isDrivingLicense: widget.isDrivingLicense,
                            isIdCard: widget.isIdCard,
                            isPassport: widget.isPassport,
                            isOtherId: widget.isOtherId,
                            isScar: widget.isScar,
                            isTattoo: widget.isTattoo,
                            languages: widget.languages,
                            sports: widget.sports,
                            hobbies: widget.hobbies,
                            talent: widget.talent,
                            portfolioImageLink: widget.portfolioImageLink,
                            portfolioVideoLink: widget.portfolioVideoLink,
                            polaroidImageLink: widget.polaroidImageLink,
                            indexNumber: widget.indexNumber)));
              } else {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.topToBottom,
                        child: ModelCarousalScreen(
                          userId: widget.userId,
                          firstName: widget.firstName,
                          lastName: widget.lastName,
                          email: widget.email,
                          profilePicture: widget.profilePicture,
                          dateOfBirth: widget.dateOfBirth,
                          gender: widget.gender,
                          county: widget.county,
                          state: widget.state,
                          city: widget.city,
                          postalCode: widget.postalCode,
                          drivingLicense: widget.drivingLicense,
                          idCard: widget.idCard,
                          passport: widget.passport,
                          otherId: widget.otherId,
                          country: widget.country,
                          hairColor: widget.hairColor,
                          eyeColor: widget.eyeColor,
                          buildType: widget.buildType,
                          scarPicture: widget.scarPicture,
                          tattooPicture: widget.tattooPicture,
                          heightCm: widget.heightCm,
                          heightFeet: widget.heightFeet,
                          waistCm: widget.waistCm,
                          waistInches: widget.waistInches,
                          weightKg: widget.weightKg,
                          weightPound: widget.weightPound,
                          wearSizeCm: widget.wearSizeCm,
                          wearSizeInches: widget.wearSizeInches,
                          chestCm: widget.chestCm,
                          chestInches: widget.chestInches,
                          hipCm: widget.hipCm,
                          hipInches: widget.hipInches,
                          inseamCm: widget.inseamCm,
                          inseamInches: widget.inseamInches,
                          shoesCm: widget.shoesCm,
                          shoesInches: widget.shoesInches,
                          isDrivingLicense: widget.isDrivingLicense,
                          isIdCard: widget.isIdCard,
                          isPassport: widget.isPassport,
                          isOtherId: widget.isOtherId,
                          isScar: widget.isScar,
                          isTattoo: widget.isTattoo,
                          languages: widget.languages,
                          sports: widget.sports,
                          hobbies: widget.hobbies,
                          talent: widget.talent,
                          portfolioImageLink: widget.portfolioImageLink,
                          portfolioVideoLink: widget.portfolioVideoLink,
                          polaroidImageLink: widget.polaroidImageLink,
                          indexNumber: widget.indexNumber,
                        )));
              }
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ///Background profile picture
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.profilePicture,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ///Color opacity
                Container(
                  color: Colors.black.withOpacity(0.6),
                ),
                ///Model Name and AGE
                Positioned(
                    top: 150,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.firstName +
                              " " +
                              widget.lastName +
                              ", " +
                              duration.years.toString(),
                          style: KFontStyle.kTextStyle32WhiteNormal,
                        ),
                      ],
                    )),
                ///Country , height and other details
                Positioned(
                    left: 20,
                    top: 180,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.country,
                                style: KFontStyle.kTextStyle16White,
                              ),
                              unit == false
                                  ? Text(
                                      widget.heightCm.toStringAsFixed(0) +
                                          " cm",
                                      style: KFontStyle.kTextStyle16White,
                                    )
                                  : Text(
                                      widget.heightFeet.toStringAsFixed(0) +
                                          " feet",
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          ///Ethnicity
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ethnicity",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              Text(
                                "Caucasian",
                                style: KFontStyle.kTextStyle16White,
                              ),
                            ],
                          ),
                          ///hair
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hair",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              Text(
                                widget.hairColor,
                                style: KFontStyle.kTextStyle16White,
                              ),
                            ],
                          ),
                          ///Eyes
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Eyes",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              Text(
                                widget.eyeColor,
                                style: KFontStyle.kTextStyle16White,
                              ),
                            ],
                          ),
                          ///Height
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Height",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              unit == false
                                  ? Text(
                                      widget.heightCm.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    )
                                  : Text(
                                      widget.heightFeet.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                            ],
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          ///Chest
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Chest",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              unit == false
                                  ? Text(
                                      widget.chestCm.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    )
                                  : Text(
                                      widget.chestInches.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                            ],
                          ),
                          ///Waist
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Waist",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              unit == false
                                  ? Text(
                                      widget.waistCm.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    )
                                  : Text(
                                      widget.waistInches.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                            ],
                          ),
                          ///Hips
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hips",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              unit == false
                                  ? Text(
                                      widget.hipCm.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    )
                                  : Text(
                                      widget.hipInches.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                            ],
                          ),
                          ///Shoe
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shoe",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              unit == false
                                  ? Text(
                                      widget.shoesCm.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    )
                                  : Text(
                                      widget.shoesInches.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                            ],
                          ),
                          ///Wear Size
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Wear Size",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              unit == false
                                  ? Text(
                                      widget.wearSizeCm.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    )
                                  : Text(
                                      widget.wearSizeInches.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                            ],
                          ),
                          ///Weight
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Weight",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              unit == false
                                  ? Text(
                                      widget.weightPound.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    )
                                  : Text(
                                      widget.weightKg.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                            ],
                          ),
                          ///Inseam
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Inseam",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              unit == false
                                  ? Text(
                                      widget.inseamCm.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    )
                                  : Text(
                                      widget.inseamInches.toStringAsFixed(0),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                            ],
                          ),
                          ///Build Type
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Build Type",
                                style: KFontStyle.kTextStyle16White,
                              ),
                                  Text(
                                      widget.buildType,
                                      style: KFontStyle.kTextStyle16White,
                                    )

                            ],
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          ///Languages
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Language",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              Column(
                                children: [
                                  for (int i = 0; i < languagesList.length; i++)
                                    Text(
                                      languagesList.elementAt(i),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          ///Sports
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sports",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              Column(
                                children: [
                                  for (int i = 0; i < sportsList.length; i++)
                                    Text(
                                      sportsList.elementAt(i),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          ///Hobbies
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hobbies",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              Column(
                                children: [
                                  for (int i = 0; i < hobbiesList.length; i++)
                                    Text(
                                      hobbiesList.elementAt(i),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          ///Talent
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Talent",
                                style: KFontStyle.kTextStyle16White,
                              ),
                              Column(
                                children: [
                                  for (int i = 0; i < hobbiesList.length; i++)
                                    Text(

                                      talentList.elementAt(i),
                                      style: KFontStyle.kTextStyle16White,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                ///Swipe Up
                Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: ModelPortfolioScreen(
                                  userId: widget.userId,
                                  firstName: widget.firstName,
                                  lastName: widget.lastName,
                                  email: widget.email,
                                  profilePicture: widget.profilePicture,
                                  dateOfBirth: widget.dateOfBirth,
                                  gender: widget.gender,
                                  county: widget.county,
                                  state: widget.state,
                                  city: widget.city,
                                  postalCode: widget.postalCode,
                                  drivingLicense: widget.drivingLicense,
                                  idCard: widget.idCard,
                                  passport: widget.passport,
                                  otherId: widget.otherId,
                                  country: widget.country,
                                  hairColor: widget.hairColor,
                                  eyeColor: widget.eyeColor,
                                  heightCm: widget.heightCm,
                                  heightFeet: widget.heightFeet,
                                  waistCm: widget.waistCm,
                                  waistInches: widget.waistInches,
                                  weightKg: widget.weightKg,
                                  weightPound: widget.weightPound,
                                  buildType: widget.buildType,
                                  wearSizeCm: widget.wearSizeCm,
                                  wearSizeInches: widget.wearSizeInches,
                                  chestCm: widget.chestCm,
                                  chestInches: widget.chestInches,
                                  hipCm: widget.hipCm,
                                  hipInches: widget.hipInches,
                                  inseamCm: widget.inseamCm,
                                  inseamInches: widget.inseamInches,
                                  shoesCm: widget.shoesCm,
                                  shoesInches: widget.shoesInches,
                                  scarPicture: widget.scarPicture,
                                  tattooPicture: widget.tattooPicture,
                                  isDrivingLicense: widget.isDrivingLicense,
                                  isIdCard: widget.isIdCard,
                                  isPassport: widget.isPassport,
                                  isOtherId: widget.isOtherId,
                                  isScar: widget.isScar,
                                  isTattoo: widget.isTattoo,
                                  languages: widget.languages,
                                  sports: widget.sports,
                                  hobbies: widget.hobbies,
                                  talent: widget.talent,
                                  portfolioImageLink: widget.portfolioImageLink,
                                  portfolioVideoLink: widget.portfolioVideoLink,
                                  polaroidImageLink: widget.polaroidImageLink,
                                  indexNumber: widget.indexNumber)));
                    },
                    onVerticalDragStart: (details) =>
                        _startVerticalDragUp(details),
                    onVerticalDragUpdate: (details) =>
                        _whileVerticalDrag(details),
                    child: Image.asset(
                      "assets/images/swipe_up.png",
                      height: 62,
                      width: 120,
                    ),
                  ),
                ),
                ///Swipe Down
                Positioned(
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.topToBottom,
                              child: ModelCarousalScreen(
                                userId: widget.userId,
                                firstName: widget.firstName,
                                lastName: widget.lastName,
                                email: widget.email,
                                profilePicture: widget.profilePicture,
                                dateOfBirth: widget.dateOfBirth,
                                gender: widget.gender,
                                county: widget.county,
                                state: widget.state,
                                city: widget.city,
                                postalCode: widget.postalCode,
                                drivingLicense: widget.drivingLicense,
                                idCard: widget.idCard,
                                passport: widget.passport,
                                otherId: widget.otherId,
                                country: widget.country,
                                hairColor: widget.hairColor,
                                eyeColor: widget.eyeColor,
                                buildType: widget.buildType,
                                scarPicture: widget.scarPicture,
                                tattooPicture: widget.tattooPicture,
                                heightCm: widget.heightCm,
                                heightFeet: widget.heightFeet,
                                waistCm: widget.waistCm,
                                waistInches: widget.waistInches,
                                weightKg: widget.weightKg,
                                weightPound: widget.weightPound,
                                wearSizeCm: widget.wearSizeCm,
                                wearSizeInches: widget.wearSizeInches,
                                chestCm: widget.chestCm,
                                chestInches: widget.chestInches,
                                hipCm: widget.hipCm,
                                hipInches: widget.hipInches,
                                inseamCm: widget.inseamCm,
                                inseamInches: widget.inseamInches,
                                shoesCm: widget.shoesCm,
                                shoesInches: widget.shoesInches,
                                isDrivingLicense: widget.isDrivingLicense,
                                isIdCard: widget.isIdCard,
                                isPassport: widget.isPassport,
                                isOtherId: widget.isOtherId,
                                isScar: widget.isScar,
                                isTattoo: widget.isTattoo,
                                languages: widget.languages,
                                sports: widget.sports,
                                hobbies: widget.hobbies,
                                talent: widget.talent,
                                portfolioImageLink: widget.portfolioImageLink,
                                portfolioVideoLink: widget.portfolioVideoLink,
                                polaroidImageLink: widget.polaroidImageLink,
                                indexNumber: widget.indexNumber,
                              )));
                    },
                    onVerticalDragStart: (details) =>
                        _startVerticalDragDown(details),
                    onVerticalDragUpdate: (details) =>
                        _whileVerticalDrag(details),
                    child: Image.asset(
                      "assets/images/swipe_down.png",
                      height: 62,
                      width: 120,
                    ),
                  ),
                ),
                ///Unit Switch
                Positioned(
                    top: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          Strings.metric,
                          style: KFontStyle.kTextStyle14White,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FlutterSwitch(
                            value: unit,
                            activeColor: Color(KColors.kColorPrimary),
                            inactiveColor: Color(KColors.kColorGrey),
                            inactiveToggleColor: Color(KColors.kColorWhite),
                            activeToggleColor: Color(KColors.kColorWhite),
                            // inactiveSwitchBorder: Border.all(
                            //   color: Color(KColors.kColorPrimary),
                            //   width: 1.0,
                            // ),
                            width: 60.0,
                            height: 30.0,
                            onToggle: (val) {
                              setState(() {
                                unit = val;
                              });
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          Strings.imperial,
                          style: KFontStyle.kTextStyle14White,
                        ),
                      ],
                    )),
                ///Back Button
                Positioned(
                    top: 20,
                    left: 20,
                    child: GestureDetector(
                        onTap: () {
                          Get.off(()=>const BulkModelsList());
                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         type: PageTransitionType.topToBottom,
                          //         child: ModelCarousalScreen(
                          //             userId: widget.userId,
                          //             firstName: widget.firstName,
                          //             lastName: widget.lastName,
                          //             email: widget.email,
                          //             profilePicture: widget.profilePicture,
                          //             dateOfBirth: widget.dateOfBirth,
                          //             gender: widget.gender,
                          //             county: widget.county,
                          //             state: widget.state,
                          //             city: widget.city,
                          //             postalCode: widget.postalCode,
                          //             drivingLicense: widget.drivingLicense,
                          //             idCard: widget.idCard,
                          //             passport: widget.passport,
                          //             otherId: widget.otherId,
                          //             country: widget.country,
                          //             hairColor: widget.hairColor,
                          //             eyeColor: widget.eyeColor,
                          //             buildType: widget.buildType,
                          //             scarPicture: widget.scarPicture,
                          //             tattooPicture: widget.tattooPicture,
                          //             heightCm: widget.heightCm,
                          //             heightFeet: widget.heightFeet,
                          //             waistCm: widget.waistCm,
                          //             waistInches: widget.waistInches,
                          //             weightKg: widget.weightKg,
                          //             weightPound: widget.weightPound,
                          //             wearSizeCm: widget.wearSizeCm,
                          //             wearSizeInches: widget.wearSizeInches,
                          //             chestCm: widget.chestCm,
                          //             chestInches: widget.chestInches,
                          //             hipCm: widget.hipCm,
                          //             hipInches: widget.hipInches,
                          //             inseamCm: widget.inseamCm,
                          //             inseamInches: widget.inseamInches,
                          //             shoesCm: widget.shoesCm,
                          //             shoesInches: widget.shoesInches,
                          //             isDrivingLicense: widget.isDrivingLicense,
                          //             isIdCard: widget.isIdCard,
                          //             isPassport: widget.isPassport,
                          //             isOtherId: widget.isOtherId,
                          //             isScar: widget.isScar,
                          //             isTattoo: widget.isTattoo,
                          //             languages: widget.languages,
                          //             sports: widget.sports,
                          //             hobbies: widget.hobbies,
                          //             talent: widget.talent,
                          //             portfolioImageLink:
                          //                 widget.portfolioImageLink,
                          //             portfolioVideoLink:
                          //                 widget.portfolioVideoLink,
                          //             polaroidImageLink:
                          //                 widget.polaroidImageLink,
                          //             indexNumber: widget.indexNumber)));
                        },
                        child: Image.asset(
                          "assets/images/back_button.png",
                          height: 62,
                          width: 62,
                        ))),
                ///Menu Button
                Positioned(
                    top: 20,
                    right: 20,
                    child:  DropdownButtonHideUnderline(
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
                        ///@ uncominted
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

                    // Image.asset(
                    //   "assets/images/menu_button.png",
                    //   height: 62,
                    //   width: 62,
                    // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
