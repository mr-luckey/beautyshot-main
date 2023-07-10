import 'package:beautyshot/Views/client_screens/model_carousal.dart';
import 'package:beautyshot/Views/client_screens/project_bubble_list.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/controller/client_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ModelItem extends StatelessWidget {

  final String userId,firstName,lastName,email,profilePicture,gender,county,state,city,postalCode,drivingLicense,
      idCard,passport,otherId,country,hairColor,eyeColor,buildType,scarPicture,
      tattooPicture;
 final Timestamp dateOfBirth;
  final num heightCm,heightFeet,waistCm,waistInches,weightKg,weightPound,wearSizeCm,wearSizeInches,chestCm,chestInches,hipCm,hipInches,inseamCm,inseamInches,
      shoesCm,shoesInches,indexNumber;
  final bool isDrivingLicense,isIdCard,isPassport,isOtherId,isScar,isTattoo;
  final List languages,sports,hobbies,talent,portfolioImageLink,portfolioVideoLink,polaroidImageLink;

  ModelItem(
      {Key? key, required this.userId,
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
        required this.heightCm,
        required this.heightFeet,
        required this.waistCm,
        required this.waistInches,
        required  this.weightKg,
        required this.weightPound,

        required  this.wearSizeCm,
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

  final clientController = Get.put(ClientController());
  final String clientId = FirebaseAuth.instance.currentUser!.uid.toString();

  final List<String> ignoredUser = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
      ),
      child: Row(children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GestureDetector(
              onTap: (){
                Get.to(()=>ModelCarousalScreen(userId: userId, firstName: firstName, lastName: lastName, email: email, profilePicture: profilePicture, dateOfBirth: dateOfBirth, gender: gender, county: county, state: state, city: city, postalCode: postalCode, drivingLicense: drivingLicense, idCard: idCard, passport: passport, otherId: otherId, country: country, hairColor: hairColor, eyeColor: eyeColor, buildType: buildType, scarPicture: scarPicture, tattooPicture: tattooPicture, heightCm: heightCm, heightFeet: heightFeet, waistCm: waistCm, waistInches: waistInches, weightKg: weightKg, weightPound: weightPound, wearSizeCm: wearSizeCm, wearSizeInches: wearSizeInches, chestCm: chestCm, chestInches: chestInches, hipCm: hipCm, hipInches: hipInches, inseamCm: inseamCm, inseamInches: inseamInches, shoesCm: shoesCm, shoesInches: shoesInches, isDrivingLicense: isDrivingLicense, isIdCard: isIdCard, isPassport: isPassport, isOtherId: isOtherId, isScar: isScar, isTattoo: isTattoo, languages: languages, sports: sports, hobbies: hobbies, talent: talent, portfolioImageLink: portfolioImageLink, portfolioVideoLink: portfolioVideoLink, polaroidImageLink: polaroidImageLink,indexNumber: indexNumber, ));
              },
              child: Container(
                height:MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    fit:BoxFit.cover ,
                    imageUrl: profilePicture,
                    placeholder: (context, url) => const SizedBox(height: 32, width: 32, child: Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) =>  Icon(Icons.error),
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
            ),
            Align(alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                height:60,
                width:MediaQuery.of(context).size.width/2,

                child: Center(child: Text(firstName+" "+lastName,style: KFontStyle.kTextStyle18White,)),
              ),),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10,top: 10,right: 5,bottom: 10),
              width: MediaQuery.of(context).size.width/3,
              child: Column(children: [
                //Hair Color
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hair",style: KFontStyle.kTextStyle16BlackRegular,),
                    // SizedBox(width: 50,),
                    Text(hairColor,style: KFontStyle.kTextStyle16BlackRegular,),
                  ],),
                Divider(
                  thickness: 1,
                  color: Color(KColors.kColorDarkGrey),
                ),
                //Eyes Color
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Eyes",style: KFontStyle.kTextStyle16BlackRegular,),
                    // SizedBox(width: 50,),
                    Text(eyeColor,style: KFontStyle.kTextStyle16BlackRegular,),
                  ],),
                Divider(
                  thickness: 1,
                  color: Color(KColors.kColorDarkGrey),
                ),
                //Chest
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chest",style: KFontStyle.kTextStyle16BlackRegular,),
                    // SizedBox(width: 50,),
                    Text(chestCm.toStringAsFixed(0),style: KFontStyle.kTextStyle16BlackRegular,),
                  ],),
                Divider(
                  thickness: 1,
                  color: Color(KColors.kColorDarkGrey),
                ),
                // Waist
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Waist",style: KFontStyle.kTextStyle16BlackRegular,),
                    // SizedBox(width: 50,),
                    Text(waistCm.toStringAsFixed(0),style: KFontStyle.kTextStyle16BlackRegular,),
                  ],),
                Divider(
                  thickness: 1,
                  color: Color(KColors.kColorDarkGrey),
                ),
                // Hips
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hips",style: KFontStyle.kTextStyle16BlackRegular,),
                    // SizedBox(width: 50,),
                    Text(hipCm.toStringAsFixed(0),style: KFontStyle.kTextStyle16BlackRegular,),
                  ],),
                Divider(
                  thickness: 1,
                  color: Color(KColors.kColorDarkGrey),
                ),
                // shoes
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shoes",style: KFontStyle.kTextStyle16BlackRegular,),
                    // SizedBox(width: 50,),
                    Text(shoesCm.toStringAsFixed(0),style: KFontStyle.kTextStyle16BlackRegular,),
                  ],),
                Divider(
                  thickness: 1,
                  color: Color(KColors.kColorDarkGrey),
                ),
                // Height
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Height",style: KFontStyle.kTextStyle16BlackRegular,),
                    // SizedBox(width: 50,),
                    Text(heightCm.toStringAsFixed(0),style: KFontStyle.kTextStyle16BlackRegular,),
                  ],),
                Divider(
                  thickness: 1,
                  color: Color(KColors.kColorDarkGrey),
                ),
              ],),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                //Ignore Button
                Buttons.ignoreButton(() { ignoredUser.add(userId);
                clientController.ignoreUser(clientId, ignoredUser);
                Fluttertoast.showToast(
                    msg: "Model added to ignore list",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                debugPrint("Ignore clicked");}),
                //1st option Button
                Buttons.optionButton(Strings.firstOption, () { Get.to(()=>ProjectBubbleList(userId, profilePicture,"firstOption"));
                debugPrint("1st Option clicked clicked");}),
                //Second Option Button
                Buttons.optionButton(Strings.secondOption, () { Get.to(()=>ProjectBubbleList(userId, profilePicture,"secondOption"));
                debugPrint("Second option clicked"); }),
              ],),
            const SizedBox(height: 20,),
          ],
        ),
      ],),
    );
  }
}