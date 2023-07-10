import 'package:age_calculator/age_calculator.dart';
import 'package:beautyshot/Views/client_screens/model_details_screen.dart';
import 'package:beautyshot/Views/client_screens/bulk_models_list.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class ModelCarousalScreen extends StatefulWidget {
  final String userId,firstName,lastName,email,profilePicture,gender,county,state,city,postalCode,drivingLicense,
      idCard,passport,otherId,country,hairColor,eyeColor,buildType,scarPicture,
      tattooPicture;
 final Timestamp dateOfBirth;
 final num heightCm,heightFeet,waistCm,waistInches,weightKg,weightPound,wearSizeCm,wearSizeInches,chestCm,chestInches,hipCm,hipInches,inseamCm,inseamInches,
      shoesCm,shoesInches,indexNumber;
 final bool isDrivingLicense,isIdCard,isPassport,isOtherId,isScar,isTattoo;
 final List languages,sports,hobbies,talent,portfolioImageLink,portfolioVideoLink,polaroidImageLink;

  const ModelCarousalScreen({Key? key,
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
  }) : super(key: key) ;

  @override
  State<ModelCarousalScreen> createState() => _ModelCarousalScreenState();
}

class _ModelCarousalScreenState extends State<ModelCarousalScreen> {

  List<String> images= [];

  int _current = 0;
  final CarouselController _controller = CarouselController();
  late int initialDragTimeStamp;
  late int currentDragTimeStamp;
  late int timeDelta;
  late double initialPositionY ;
  late double currentPositionY;
  late double positionYDelta;

  late DateDuration duration;

  void _startVerticalDrag(details) {
    // Timestamp of when drag begins
    initialDragTimeStamp = details.sourceTimeStamp.inMilliseconds;
    debugPrint("Swiping Up");
    images.removeAt(0);
    Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child:ModelDetailsScreen(userId: widget.userId, firstName: widget.firstName, lastName: widget.lastName, email: widget.email, profilePicture: widget.profilePicture, dateOfBirth: widget.dateOfBirth, gender: widget.gender, county: widget.county, state: widget.state, city: widget.city, postalCode: widget.postalCode, drivingLicense: widget.drivingLicense, idCard: widget.idCard, passport: widget.passport, otherId: widget.otherId, country: widget.country, hairColor: widget.hairColor, eyeColor: widget.eyeColor, buildType: widget.buildType, scarPicture: widget.scarPicture, tattooPicture: widget.tattooPicture, heightCm: widget.heightCm, heightFeet: widget.heightFeet, waistCm: widget.waistCm, waistInches: widget.waistInches, weightKg: widget.weightKg, weightPound: widget.weightPound, wearSizeCm: widget.wearSizeCm, wearSizeInches: widget.wearSizeInches, chestCm: widget.chestCm, chestInches: widget.chestInches, hipCm: widget.hipCm, hipInches: widget.hipInches, inseamCm: widget.inseamCm, inseamInches: widget.inseamInches, shoesCm: widget.shoesCm, shoesInches: widget.shoesInches, isDrivingLicense: widget.isDrivingLicense, isIdCard: widget.isIdCard, isPassport: widget.isPassport, isOtherId: widget.isOtherId, isScar: widget.isScar, isTattoo: widget.isTattoo, languages: widget.languages, sports: widget.sports, hobbies: widget.hobbies, talent: widget.talent, portfolioImageLink: widget.portfolioImageLink, portfolioVideoLink: widget.portfolioVideoLink, polaroidImageLink: widget.polaroidImageLink,indexNumber:widget.indexNumber)));
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

  @override
  void initState() {
    super.initState();
    var date  = DateTime.parse(widget.dateOfBirth.toDate().toString());
    duration = AgeCalculator.age(date);
    // print(duration.years);
     // images= List<String>.from(widget.portfolioImageLink.map((x) => x.toString()));
     // for (var element in widget.portfolioImageLink) {
     //   images= List<String>.from(element.map((x) => x.toString()));
     //   // images.add(element);
     // }

    // widget.portfolioImageLink.forEach((element) {
    //   images = List<String>.from(element.map((x) => x.toString()));
    //   debugPrint(images.toString());
    // });

    images.clear();
    widget.portfolioImageLink.forEach((element) {
          images = widget.portfolioImageLink.cast();

          debugPrint(images.toString());
        });
    setState(() {
      images.insert(0, widget.profilePicture);
    });
    debugPrint(images.length.toString());

  }

  @override
  void dispose() {
    super.dispose();

  }

  Future<bool> _willPopCallback() async {
    Get.to(()=>const BulkModelsList());
    return true;
    // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [

                CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                      height: MediaQuery.of(context).size.height,
                  enableInfiniteScroll: false,
                    onPageChanged: (index,reason){
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  carouselController: _controller,
                  items: images.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onVerticalDragStart: (details) => _startVerticalDrag(details),
                          onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: const BoxDecoration(
                                      // color: Colors.amber
                                  ),
                                child: CachedNetworkImage(
                                  fit:BoxFit.cover ,
                                  width: MediaQuery.of(context).size.width,
                                  imageUrl: i,
                                  placeholder: (context, url) => const SizedBox(height: 32, width: 32, child: Center(child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>  const Icon(Icons.error),
                                ),
                              ),


                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: images.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.white)
                                  .withOpacity(_current == entry.key ? 0.8 : 0.3)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                  bottom: 150,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.firstName+" "+widget.lastName+", " +duration.years.toString(),style: KFontStyle.newYorkExtraLarge33,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.country,style: KFontStyle.kTextStyle16White,),
                            Text(widget.heightCm.toStringAsFixed(0)+" cm",style: KFontStyle.kTextStyle16White,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Swipe Up
                Positioned(

                  bottom: 0,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child:ModelDetailsScreen(userId: widget.userId, firstName: widget.firstName, lastName: widget.lastName, email: widget.email, profilePicture: widget.profilePicture, dateOfBirth: widget.dateOfBirth, gender: widget.gender, county: widget.county, state: widget.state, city: widget.city, postalCode: widget.postalCode, drivingLicense: widget.drivingLicense, idCard: widget.idCard, passport: widget.passport, otherId: widget.otherId, country: widget.country, hairColor: widget.hairColor, eyeColor: widget.eyeColor, buildType: widget.buildType, scarPicture: widget.scarPicture, tattooPicture: widget.tattooPicture, heightCm: widget.heightCm, heightFeet: widget.heightFeet, waistCm: widget.waistCm, waistInches: widget.waistInches, weightKg: widget.weightKg, weightPound: widget.weightPound, wearSizeCm: widget.wearSizeCm, wearSizeInches: widget.wearSizeInches, chestCm: widget.chestCm, chestInches: widget.chestInches, hipCm: widget.hipCm, hipInches: widget.hipInches, inseamCm: widget.inseamCm, inseamInches: widget.inseamInches, shoesCm: widget.shoesCm, shoesInches: widget.shoesInches, isDrivingLicense: widget.isDrivingLicense, isIdCard: widget.isIdCard, isPassport: widget.isPassport, isOtherId: widget.isOtherId, isScar: widget.isScar, isTattoo: widget.isTattoo, languages: widget.languages, sports: widget.sports, hobbies: widget.hobbies, talent: widget.talent, portfolioImageLink: widget.portfolioImageLink, portfolioVideoLink: widget.portfolioVideoLink, polaroidImageLink: widget.polaroidImageLink,indexNumber:widget.indexNumber)));
                    },
                    onVerticalDragStart: (details) => _startVerticalDrag(details),
                    onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
                    child: Image.asset("assets/images/swipe_up.png",height: 62,width: 120,),),),
                //Swipe down
                Positioned(
                    top: 20,
                    left: 20,
                    child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, PageTransition(type: PageTransitionType.topToBottom, child: const BulkModelsList()));
                        },
                        child: Image.asset("assets/images/back_button.png",height: 62,width: 62,))),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
