import 'package:beautyshot/Views/client_screens/bulk_models_list.dart';
import 'package:beautyshot/Views/client_screens/filter_screen.dart';
import 'package:beautyshot/Views/client_screens/project_name_screen.dart';
import 'package:beautyshot/Views/client_screens/test_filter_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ClientMainScreen extends StatefulWidget {
  const ClientMainScreen({Key? key}) : super(key: key);

  @override
  State<ClientMainScreen> createState() => _ClientMainScreenState();
}

class _ClientMainScreenState extends State<ClientMainScreen> {

  final List<String> items = [
    'Single Person',
    'Bulk',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(KColors.kColorPrimary)),
        leading: Container(),
        title: Text(
          Strings.home,
          style: KFontStyle.kTextStyle24Black,
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children:  [
                    Text(
                      'View',
                      style: KFontStyle.kTextStyle14Black,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                items: items
                    .map((item) =>
                    DropdownMenuItem<String>(
                      value: item,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
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
                iconStyleData: IconStyleData(icon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                ),
                  iconSize: 24,
                  iconEnabledColor: Color(KColors.kColorDarkGrey),
                  iconDisabledColor: Color(KColors.kColorLightGrey),),
                buttonStyleData: ButtonStyleData(height: 40,
                  width: 160,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  elevation: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.white,
                  ),),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 400,
                  width: 200,
                  padding: null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.transparent,
                  ),
                  offset: Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all(6),
                    isAlwaysShown: true,
                  ),
                  elevation: 8,
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: 60,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                ),
                // offset: Offset(-20, 0),



              ),
            ),
          ),
        ],
        toolbarHeight: 80,
        centerTitle: false,
        backgroundColor: Color(KColors.kColorWhite),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Filter and Search Button
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Get.to(()=>FilterScreen());
                      Get.to(()=>TestFilterScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 5, 10),
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
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.lookingFor,
                              style: KFontStyle.kTextStyle18Black,
                            ),
                            Image.asset(
                              "assets/images/filter.png",
                              height: 32,
                              width: 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => BulkModelsList());
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 10, 10),
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
                          left: 20, right: 20, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/search.png",
                            height: 32,
                            width: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //Create Project Folder
            GestureDetector(
              onTap: () {
                Get.to(() => const ProjectNameScreen());
              },
              child: Container(
                height: 62,
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                  color: Color(KColors.kColorWhite),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Color(KColors.kColorPrimary),
                  ),
                ),
                child: Center(
                    child: Text(
                  Strings.createProjectFolder,
                  style: KFontStyle.kTextStyle18Black,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
