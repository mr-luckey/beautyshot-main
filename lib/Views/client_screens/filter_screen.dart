import 'dart:async';
import 'package:beautyshot/Views/client_screens/filtered_view_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/model/talent_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:vertical_tabs/vertical_tabs.dart';
import 'package:vertical_tabs_flutter/vertical_tabs.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController genderController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController ethnicityController = TextEditingController();
  TextEditingController hairColorController = TextEditingController();
  TextEditingController eyeColorController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageRangeController = TextEditingController();

  List<TalentModel> talentData = <TalentModel>[];
  List<TalentModel> filteredTalentData = <TalentModel>[];

  List<String> genderList = [];
  List<String> hairColorList = [];
  List<String> eyeColorList = [];
  List<String> buildTypeList = [];
  List<String> ethnicityList = [];

  

  final num heightMin = 2;
  final num heightMax = 8;
  final num ageMin = 10;
  final num ageMax = 80;

  String countryValue = '';
  String cityValue = '';
  String stateValue = '';

  String titleText = "Filters";
  bool isFilter = false;

  SfRangeValues heightValues = const SfRangeValues(4, 6);
  SfRangeValues ageValues = const SfRangeValues(20, 40);
  bool isDidChangeRunningOnce = true;
  bool isSwitchWidget = true;

  //Gender Filter parameters
  bool isMale = false;
  bool isFemale = false;
  bool isGenderNonConforming = false;
  bool isNonBinary = false;
  bool isTransFemale = false;
  bool isTransMale = false;
  bool isUnspecified = false;

  String male = '';
  String feMale = '';
  String genderNonConforming = '';
  String nonBinary = '';
  String transFemale = '';
  String transMale = '';
  String unspecified = '';

  //Hair Color Filter parameters
  bool isBlackHair = false;
  bool isBlondeHair = false;
  bool isBrownHair = false;
  bool isAuburnHair = false;
  bool isChestNutHair = false;
  bool isRedHair = false;
  bool isGrayHair = false;
  bool isWhiteHair = false;
  bool isBaldHair = false;
  bool isSaltPepperHair = false;
  bool isStrawberryBlondeHair = false;
  bool isMulticoloredHair = false;

  String blackHair = '';
  String blondeHair = '';
  String brownHair = '';
  String auburnHair = '';
  String chestNutHair = '';
  String redHair = '';
  String grayHair = '';
  String whiteHair = '';
  String baldHair = '';
  String saltPepperHair = '';
  String strawberryBlondeHair = '';
  String multicoloredHair = '';

  //Eye Color Filter Parameters
  bool isBlackEye = false;
  bool isBlondeEye = false;
  bool isBrownEye = false;
  bool isAuburnEye = false;
  bool isChestNutEye = false;
  bool isRedEye = false;
  bool isGrayEye = false;
  bool isWhiteEye = false;
  bool isSaltPepperEye = false;
  bool isStrawberryBlondeEye = false;
  bool isMulticoloredEye = false;

  String blackEye = '';
  String blondeEye = '';
  String brownEye = '';
  String auburnEye = '';
  String chestNutEye = '';
  String redEye = '';
  String grayEye = '';
  String whiteEye = '';
  String saltPepperEye = '';
  String strawberryBlondeEye = '';
  String multicoloredEye = '';

  //Body Type Filter Parameter
  bool isAverageBody = false;
  bool isSlimBody = false;
  bool isAthleticTonedBody = false;
  bool isMuscularBody = false;
  bool isCurvyBody = false;
  bool isHeavySetBody = false;
  bool isPlusSizedBody = false;

  String averageBody = '';
  String slimBody = '';
  String athleticTonedBody = '';
  String muscularBody = '';
  String curvyBody = '';
  String heavySetBody = '';
  String plusSizedBody = '';

  //Ethnicity
  bool isIndian = false;
  bool isPakistani = false;
  bool isBangladeshi = false;
  bool isChinese = false;
  bool isAnyOtherAsian = false;
  bool isCaribbean = false;
  bool isAfrican = false;
  bool isAnyOtherBlack = false;
  bool isBlackBritish = false;
  bool isCaribbeanBackground = false;
  bool isWhiteAndBlackCaribbean = false;
  bool isWhiteAndBlackAfrican = false;
  bool isWhiteAndAsian = false;
  bool isAnyOtherMixed = false;
  bool isMultipleEthnicBackground = false;
  bool isEnglish = false;
  bool isWelsh = false;
  bool isScottish = false;
  bool isNorthernIrish = false;
  bool isIrish = false;
  bool isGypsy = false;
  bool isRoma = false;
  bool isAnyOtherWhiteBackground = false;
  bool isFilipino = false;

  String indian = '';
  String pakistani = '';
  String bangladeshi = '';
  String chinese = '';
  String anyOtherAsian = '';
  String caribbean = '';
  String african = '';
  String anyOtherBlack = '';
  String blackBritish = '';
  String caribbeanBackground = '';
  String whiteAndBlackCaribbean = '';
  String whiteAndBlackAfrican = '';
  String whiteAndAsian = '';
  String anyOtherMixed = '';
  String multipleEthnicBackground = '';
  String english = '';
  String welsh = '';
  String scottish = '';
  String northernIrish = '';
  String irish = '';
  String gypsy = '';
  String roma = '';
  String anyOtherWhiteBackground = '';
  String filipino = '';

  clearFilters(){
    setState(() {

      titleText = 'Filters';

      //Gender Filter parameters
      isMale = false;
      isFemale = false;
      isGenderNonConforming = false;
      isNonBinary = false;
      isTransFemale = false;
      isTransMale = false;
      isUnspecified = false;

       // male = '';
       // feMale = '';
       // genderNonConforming = '';
       // nonBinary = '';
       // transFemale = '';
       // transMale = '';
       // unspecified = '';

      //Hair Color Filter parameters
      isBlackHair = false;
      isBlondeHair = false;
      isBrownHair = false;
      isAuburnHair = false;
      isChestNutHair = false;
      isRedHair = false;
      isGrayHair = false;
      isWhiteHair = false;
      isBaldHair = false;
      isSaltPepperHair = false;
      isStrawberryBlondeHair = false;
      isMulticoloredHair = false;

       // blackHair = '';
       // blondeHair = '';
       // brownHair = '';
       // auburnHair = '';
       // chestNutHair = '';
       // redHair = '';
       // grayHair = '';
       // whiteHair = '';
       // baldHair = '';
       // saltPepperHair = '';
       // strawberryBlondeHair = '';
       // multicoloredHair = '';

      //Eye Color Filter Parameters
      isBlackEye = false;
      isBlondeEye = false;
       isBrownEye = false;
       isAuburnEye = false;
       isChestNutEye = false;
       isRedEye = false;
       isGrayEye = false;
       isWhiteEye = false;
       isSaltPepperEye = false;
       isStrawberryBlondeEye = false;
       isMulticoloredEye = false;

       // blackEye = '';
       // blondeEye = '';
       // brownEye = '';
       // auburnEye = '';
       // chestNutEye = '';
       // redEye = '';
       // grayEye = '';
       // whiteEye = '';
       // saltPepperEye = '';
       // strawberryBlondeEye = '';
       // multicoloredEye = '';

      //Body Type Filter Parameter
      isAverageBody = false;
      isSlimBody = false;
      isAthleticTonedBody = false;
      isMuscularBody = false;
      isCurvyBody = false;
      isHeavySetBody = false;
      isPlusSizedBody = false;

      //  averageBody = '';
      //  slimBody = '';
      //  athleticTonedBody = '';
      //  muscularBody = '';
      //  curvyBody = '';
      //  heavySetBody = '';
      //  plusSizedBody = '';
      //
      // //Ethnicity
       isIndian = false;
       isPakistani = false;
       isBangladeshi = false;
       isChinese = false;
       isAnyOtherAsian = false;
       isCaribbean = false;
       isAfrican = false;
       isAnyOtherBlack = false;
       isBlackBritish = false;
       isCaribbeanBackground = false;
       isWhiteAndBlackCaribbean = false;
       isWhiteAndBlackAfrican = false;
       isWhiteAndAsian = false;
       isAnyOtherMixed = false;
       isMultipleEthnicBackground = false;
       isEnglish = false;
       isWelsh = false;
       isScottish = false;
       isNorthernIrish = false;
       isIrish = false;
       isGypsy = false;
       isRoma = false;
       isAnyOtherWhiteBackground = false;
       isFilipino = false;

       // indian = '';
       // pakistani = '';
       // bangladeshi = '';
       // chinese = '';
       // anyOtherAsian = '';
       // caribbean = '';
       // african = '';
       // anyOtherBlack = '';
       // blackBritish = '';
       // caribbeanBackground = '';
       // whiteAndBlackCaribbean = '';
       // whiteAndBlackAfrican = '';
       // whiteAndAsian = '';
       // anyOtherMixed = '';
       // multipleEthnicBackground = '';
       // english = '';
       // welsh = '';
       // scottish = '';
       // northernIrish = '';
       // irish = '';
       // gypsy = '';
       // roma = '';
       // anyOtherWhiteBackground = '';
       // filipino = '';
       filteredTalentData.clear();
      // getFilteredTalent();
    });

  }

  Future getAllTalent() async {
    setState(() {
      talentData.clear();
      debugPrint('............/////////////////////////////// 00');
      FirebaseFirestore.instance.collection('models').snapshots().listen((event) {
        talentData.clear();
        event.docs.forEach((element) {
          talentData.add(TalentModel.fromMap(element.data()));
        });
        setState(() {});

      });
    });

  }

  // Future getFilteredTalent() async {
  //
  //   setState(() {
  //     filteredTalentData.clear();
  //     filteredTalentData = talentData.where((element) {
  //       return (
  //           //Gender
  //           (element.gender == male)
  //               || (element.gender == feMale)
  //               || (element.gender == genderNonConforming)
  //               || (element.gender == nonBinary)
  //               || (element.gender == transFemale)
  //               || (element.gender == transMale)
  //               || (element.gender == unspecified)
  //               //Hair Color
  //               || (element.hairColor == blackHair)
  //               || (element.hairColor == blondeHair)
  //               || (element.hairColor == brownHair)
  //               || (element.hairColor == auburnHair)
  //               || (element.hairColor == chestNutHair)
  //               || (element.hairColor == redHair)
  //               || (element.hairColor == grayHair)
  //               || (element.hairColor == whiteHair)
  //               || (element.hairColor == baldHair)
  //               || (element.hairColor == saltPepperHair)
  //               || (element.hairColor == strawberryBlondeHair)
  //               || (element.hairColor == multicoloredHair)
  //               //Eye Color
  //               || (element.eyeColor == blackEye)
  //               || (element.eyeColor == blondeEye)
  //               || (element.eyeColor == brownEye)
  //               || (element.eyeColor == auburnEye)
  //               || (element.eyeColor == chestNutEye)
  //               || (element.eyeColor == redEye)
  //               || (element.eyeColor == grayEye)
  //               || (element.eyeColor == whiteEye)
  //               || (element.eyeColor == saltPepperEye)
  //               || (element.eyeColor == strawberryBlondeEye)
  //               || (element.eyeColor == multicoloredEye)
  //               //Body Type
  //               || (element.buildType == averageBody)
  //               || (element.buildType == slimBody)
  //               || (element.buildType == athleticTonedBody)
  //               || (element.buildType == muscularBody)
  //               || (element.buildType == curvyBody)
  //               || (element.buildType == heavySetBody)
  //               || (element.buildType == plusSizedBody)
  //               //Country
  //               || (element.country == countryValue)
  //               //State
  //               || (element.state == stateValue)
  //               // //Height
  //               || (element.heightFeet >= heightValues.start && element.heightFeet <= heightValues.end)
  //               // //Age
  //               || (element.age >= ageValues.start && element.age <= ageValues.end)
  //
  //       );
  //     }).toList();
  //   });
  //
  //
  //
  // }


  Future getFilteredTalent() async {

    setState(() {
      filteredTalentData.clear();
      filteredTalentData = talentData.where((element) {
        return (
            //Gender
            (element.gender == male)
                || (element.gender == feMale)
                || (element.gender == genderNonConforming)
                || (element.gender == nonBinary)
                || (element.gender == transFemale)
                || (element.gender == transMale)
                || (element.gender == unspecified)
                //Hair Color
                || (element.hairColor == blackHair)
                || (element.hairColor == blondeHair)
                || (element.hairColor == brownHair)
                || (element.hairColor == auburnHair)
                || (element.hairColor == chestNutHair)
                || (element.hairColor == redHair)
                || (element.hairColor == grayHair)
                || (element.hairColor == whiteHair)
                || (element.hairColor == baldHair)
                || (element.hairColor == saltPepperHair)
                || (element.hairColor == strawberryBlondeHair)
                || (element.hairColor == multicoloredHair)
                //Eye Color
                || (element.eyeColor == blackEye)
                || (element.eyeColor == blondeEye)
                || (element.eyeColor == brownEye)
                || (element.eyeColor == auburnEye)
                || (element.eyeColor == chestNutEye)
                || (element.eyeColor == redEye)
                || (element.eyeColor == grayEye)
                || (element.eyeColor == whiteEye)
                || (element.eyeColor == saltPepperEye)
                || (element.eyeColor == strawberryBlondeEye)
                || (element.eyeColor == multicoloredEye)
                //Body Type
                || (element.buildType == averageBody)
                || (element.buildType == slimBody)
                || (element.buildType == athleticTonedBody)
                || (element.buildType == muscularBody)
                || (element.buildType == curvyBody)
                || (element.buildType == heavySetBody)
                || (element.buildType == plusSizedBody)
                //Country
                || (element.country == countryValue)
                //State
                || (element.state == stateValue)
                // //Height
                || (element.heightFeet >= heightValues.start && element.heightFeet <= heightValues.end)
                // //Age
                || (element.age >= ageValues.start && element.age <= ageValues.end)

        );
      }).toList();
    });



  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isDidChangeRunningOnce) {
      debugPrint('did change dependencies');
      getAllTalent();
      isDidChangeRunningOnce = false;
    }
  }

    Future? filterWidget(){
    return showMaterialModalBottomSheet(
      barrierColor: Colors.white.withOpacity(0.5),
       context: context,
       builder: (BuildContext c) {
         return StatefulBuilder(
           builder: (BuildContext context,
               void Function(void Function()) setState) {
             return SizedBox(
               height: MediaQuery.of(context).size.height / 1.6,
               child: Column(
                 children: [
                   //Filters List
                   Expanded(
                     child: VerticalTabs(
                       indicatorColor: Colors.white,
                       selectedTabBackgroundColor:
                       Colors.white,
                       backgroundColor: Colors.white,
                       tabsWidth: 150,
                       tabsElevation: 5.0,
                       tabs: <Tab>[
                         //Gender Tab
                         Tab(
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text(
                                 'Gender',
                                 style:
                                 KFontStyle.kTextStyle18Black,
                               ),
                             )),
                         //Location Tab
                         Tab(
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text(
                                 'Location',
                                 style:
                                 KFontStyle.kTextStyle18Black,
                               ),
                             )),
                         //Ethnicity Tab
                         Tab(
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text(
                                 'Ethnicity',
                                 style:
                                 KFontStyle.kTextStyle18Black,
                               ),
                             )),
                         //Hair Color Tab
                         Tab(
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text(
                                 'Hair Color',
                                 style:
                                 KFontStyle.kTextStyle18Black,
                               ),
                             )),
                         //Eye Color Tab
                         Tab(
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text(
                                 'Eye Color',
                                 style:
                                 KFontStyle.kTextStyle18Black,
                               ),
                             )),
                         //Body Type Tab
                         Tab(
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text(
                                 'Body Type',
                                 style:
                                 KFontStyle.kTextStyle18Black,
                               ),
                             )),
                         //Height Tab
                         Tab(
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text(
                                 'Height',
                                 style:
                                 KFontStyle.kTextStyle18Black,
                               ),
                             )),
                         //Age Range Tab
                         Tab(
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text(
                                 'Age Range',
                                 style:
                                 KFontStyle.kTextStyle18Black,
                               ),
                             )),
                       ],
                       contents: <Widget>[
                         //Gender Tab Content
                         Container(
                           margin: const EdgeInsets.all(20),
                           child: SingleChildScrollView(
                             child: Column(
                               children: [
                                 //Male
                                 ListTile(
                                   title:  Text('Male',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isMale,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isMale = value!;
                                         if(isMale == true){
                                           // male = 'male';
                                           genderList.add('male');
                                           debugPrint("Male Seerwrwerwlected");
                                           debugPrint(genderList.length.toString());
                                         }
                                         else{
                                           // male = '';
                                           genderList.remove('male');
                                           debugPrint("Male UnSelected");
                                           debugPrint(genderList.length.toString());
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Female
                                 ListTile(
                                   title:  Text('Female',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isFemale,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isFemale = value!;
                                         if(isFemale == true){
                                           // feMale = 'female';
                                           genderList.add('female');
                                           debugPrint("Female Selected");
                                           debugPrint(genderList.toString());
                                         }
                                         else{
                                           // feMale = '';
                                           genderList.remove('female');
                                           debugPrint("Female UnSelected ");
                                           debugPrint(genderList.toString());
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 // Gender-Nonconforming
                                 ListTile(
                                   title:  Text('Gender-Nonconforming',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isGenderNonConforming,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isGenderNonConforming = value!;
                                         if(isGenderNonConforming == true){
                                           // genderNonConforming = 'genderNonConforming';
                                           genderList.add('genderNonConforming');
                                           debugPrint("genderNonConforming Selected $genderList");
                                         }
                                         else{
                                           // genderNonConforming = '';
                                           genderList.remove('genderNonConforming');
                                           debugPrint("genderNonConforming UnSelected $genderList");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 // Non-Binary
                                 ListTile(
                                   title:  Text('Non-Binary',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isNonBinary,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isNonBinary = value!;
                                         if(isNonBinary == true){
                                           // nonBinary = 'nonBinary';
                                           genderList.add('nonBinary');
                                           debugPrint("nonBinary Selected $genderList");
                                         }
                                         else{
                                           // nonBinary = '';
                                           genderList.remove('nonBinary');
                                           debugPrint("nonBinary UnSelected $genderList");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 // Trans Female
                                 ListTile(
                                   title:  Text('Trans Female',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isTransFemale,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isTransFemale = value!;
                                         if(isTransFemale == true){
                                           // transFemale = 'transFemale';
                                           genderList.add('transFemale');
                                           debugPrint("transFemale Selected $genderList");
                                         }
                                         else{
                                           // transFemale = '';
                                           genderList.remove('transFemale');
                                           debugPrint("transFemale UnSelected $genderList");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 // Trans Male
                                 ListTile(
                                   title:  Text('Trans Male',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isTransMale,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isTransMale = value!;
                                         if(isTransMale == true){
                                           // transMale = 'transMale';
                                           genderList.add('transMale');
                                           debugPrint("transMale Selected $genderList");
                                         }
                                         else{
                                           // transMale = '';
                                           genderList.remove('transMale');
                                           debugPrint("transMale UnSelected $genderList");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 // Unspecified
                                 ListTile(
                                   title:  Text('Unspecified',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isUnspecified,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isUnspecified = value!;
                                         if(isUnspecified == true){
                                           // unspecified = 'unspecified';
                                           genderList.add('unspecified');
                                           debugPrint("unspecified Selected $genderList");
                                         }
                                         else{
                                           // unspecified = '';
                                           genderList.remove('unspecified');
                                           debugPrint("unspecified UnSelected $genderList");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         //Location Tab Content
                         Container(
                           margin: const EdgeInsets.all(20),
                           child: Column(
                             children: [

                               CSCPicker(
                                 onCountryChanged: (value) {
                                   setState(() {
                                     countryValue = value;
                                   });
                                 },
                                 onStateChanged:(value) {
                                   setState(() {
                                     stateValue = value!;
                                   });
                                 },
                                 onCityChanged:(value) {
                                   setState(() {
                                     cityValue = value!;
                                   });
                                 },
                               ),
                             ],
                           ),
                         ),
                         //Ethnicity Tab Content
                         Container(
                           margin: const EdgeInsets.all(20),
                           child: SingleChildScrollView(
                             child: Column(
                               children: [
                                 //Pakistani
                                 ListTile(
                                   title:  Text('Pakistani',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isPakistani,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isPakistani = value!;
                                         if(isPakistani == true){
                                           pakistani = 'pakistani';
                                           debugPrint("Pakistani Ethnicity Selected");
                                         }
                                         else{
                                           pakistani = '';
                                           debugPrint("Pakistani Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Indian
                                 ListTile(
                                   title:  Text('Indian',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isIndian,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isIndian = value!;
                                         if(isIndian == true){
                                           indian = 'indian';
                                           debugPrint("Indian Ethnicity Selected");
                                         }
                                         else{
                                           indian = '';
                                           debugPrint("Indian Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Bangladeshi
                                 ListTile(
                                   title:  Text('Bangladeshi',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isBangladeshi,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isBangladeshi = value!;
                                         if(isBangladeshi == true){
                                           bangladeshi = 'bangladeshi';
                                           debugPrint("Bangladeshi Ethnicity Selected");
                                         }
                                         else{
                                           bangladeshi = '';
                                           debugPrint("Bangladeshi Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Chinese
                                 ListTile(
                                   title:  Text('Chinese',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isChinese,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isChinese = value!;
                                         if(isChinese == true){
                                           chinese = 'chinese';
                                           debugPrint("Chinese Ethnicity Selected");
                                         }
                                         else{
                                           chinese = '';
                                           debugPrint("Chinese Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Any Other Asian Background
                                 ListTile(
                                   title:  Text('Any Other Asian Background',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isAnyOtherAsian,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isAnyOtherAsian = value!;
                                         if(isAnyOtherAsian == true){
                                           anyOtherAsian = 'anyOtherAsian';
                                           debugPrint("Any Other Asian Background Ethnicity Selected");
                                         }
                                         else{
                                           anyOtherAsian = '';
                                           debugPrint("Any Other Asian Background Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Caribbean
                                 ListTile(
                                   title:  Text('Caribbean',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isCaribbean,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isCaribbean = value!;
                                         if(isCaribbean == true){
                                           caribbean = 'caribbean';
                                           debugPrint("Caribbean Ethnicity Selected");
                                         }
                                         else{
                                           caribbean = '';
                                           debugPrint("Caribbean Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //African
                                 ListTile(
                                   title:  Text('African',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isAfrican,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isAfrican = value!;
                                         if(isAfrican == true){
                                           african = 'african';
                                           debugPrint("African Ethnicity Selected");
                                         }
                                         else{
                                           african = '';
                                           debugPrint("African Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Any Other Black
                                 ListTile(
                                   title:  Text('Any Other Black',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isAnyOtherBlack,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isAnyOtherBlack = value!;
                                         if(isAnyOtherBlack == true){
                                           anyOtherBlack = 'anyOtherBlack';
                                           debugPrint("AnyOtherBlack Ethnicity Selected");
                                         }
                                         else{
                                           anyOtherBlack = '';
                                           debugPrint("AnyOtherBlack Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Black British
                                 ListTile(
                                   title:  Text('Black British',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isBlackBritish,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isBlackBritish = value!;
                                         if(isBlackBritish == true){
                                           blackBritish = 'blackBritish';
                                           debugPrint("Black British Ethnicity Selected");
                                         }
                                         else{
                                           blackBritish = '';
                                           debugPrint("Black British Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Caribbean Background
                                 ListTile(
                                   title:  Text('Caribbean Background',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isCaribbeanBackground,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isCaribbeanBackground = value!;
                                         if(isCaribbeanBackground == true){
                                           caribbeanBackground = 'caribbeanBackground';
                                           debugPrint("CaribbeanBackground Ethnicity Selected");
                                         }
                                         else{
                                           caribbeanBackground = '';
                                           debugPrint("CaribbeanBackground Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //White and Black Caribbean
                                 ListTile(
                                   title:  Text('White and Black Caribbean',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isWhiteAndBlackCaribbean,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isWhiteAndBlackCaribbean = value!;
                                         if(isWhiteAndBlackCaribbean == true){
                                           whiteAndBlackCaribbean = 'whiteAndBlackCaribbean';
                                           debugPrint("White and Black Caribbean Ethnicity Selected");
                                         }
                                         else{
                                           whiteAndBlackCaribbean = '';
                                           debugPrint("White and Black Caribbean Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //White and Black African
                                 ListTile(
                                   title:  Text('White and Black African',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isWhiteAndBlackAfrican,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isWhiteAndBlackAfrican = value!;
                                         if(isWhiteAndBlackAfrican == true){
                                           whiteAndBlackAfrican = 'whiteAndBlackAfrican';
                                           debugPrint("White and Black African Ethnicity Selected");
                                         }
                                         else{
                                           whiteAndBlackAfrican = '';
                                           debugPrint("White and Black African Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //White and Asian
                                 ListTile(
                                   title:  Text('White and Asian',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isWhiteAndAsian,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isWhiteAndAsian = value!;
                                         if(isWhiteAndAsian == true){
                                           whiteAndAsian = 'whiteAndAsian';
                                           debugPrint("White and Asian Ethnicity Selected");
                                         }
                                         else{
                                           whiteAndAsian = '';
                                           debugPrint("White and Asian Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Any Other Mixed
                                 ListTile(
                                   title:  Text('Any Other Mixed',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isAnyOtherMixed,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isAnyOtherMixed = value!;
                                         if(isAnyOtherMixed == true){
                                           anyOtherMixed = 'anyOtherMixed';
                                           debugPrint("Any Other Mixed Ethnicity Selected");
                                         }
                                         else{
                                           anyOtherMixed = '';
                                           debugPrint("Any Other Mixed Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Multiple Ethnic Background
                                 ListTile(
                                   title:  Text('Multiple Ethnic Background',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isMultipleEthnicBackground,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isMultipleEthnicBackground = value!;
                                         if(isMultipleEthnicBackground == true){
                                           multipleEthnicBackground = 'multipleEthnicBackground';
                                           debugPrint("Multiple Ethnic Background Ethnicity Selected");
                                         }
                                         else{
                                           multipleEthnicBackground = '';
                                           debugPrint("Multiple Ethnic Background Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //English
                                 ListTile(
                                   title:  Text('English',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isEnglish,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isEnglish = value!;
                                         if(isEnglish == true){
                                           english = 'english';
                                           debugPrint("English Ethnicity Selected");
                                         }
                                         else{
                                           english = '';
                                           debugPrint("English Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Welsh
                                 ListTile(
                                   title:  Text('Welsh',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isWelsh,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isWelsh = value!;
                                         if(isWelsh == true){
                                           welsh = 'welsh';
                                           debugPrint("Welsh Ethnicity Selected");
                                         }
                                         else{
                                           welsh = '';
                                           debugPrint("Welsh Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Scottish
                                 ListTile(
                                   title:  Text('Scottish',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isScottish,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isScottish = value!;
                                         if(isScottish == true){
                                           scottish = 'scottish';
                                           debugPrint("Scottish Ethnicity Selected");
                                         }
                                         else{
                                           scottish = '';
                                           debugPrint("Scottish Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Northern Irish
                                 ListTile(
                                   title:  Text('Northern Irish',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isNorthernIrish,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isNorthernIrish = value!;
                                         if(isNorthernIrish == true){
                                           northernIrish = 'northernIrish';
                                           debugPrint("Northern Irish Ethnicity Selected");
                                         }
                                         else{
                                           northernIrish = '';
                                           debugPrint("Northern Irish Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Irish
                                 ListTile(
                                   title:  Text('Irish',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isIrish,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isIrish = value!;
                                         if(isIrish == true){
                                           irish = 'irish';
                                           debugPrint("Irish Ethnicity Selected");
                                         }
                                         else{
                                           irish = '';
                                           debugPrint("Irish Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Gypsy
                                 ListTile(
                                   title:  Text('Gypsy',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isGypsy,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isGypsy = value!;
                                         if(isGypsy == true){
                                           gypsy = 'gypsy';
                                           debugPrint("Gypsy Ethnicity Selected");
                                         }
                                         else{
                                           gypsy = '';
                                           debugPrint("Gypsy Ethnicity UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Roma
                                 ListTile(
                                   title:  Text('Roma',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isRoma,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isRoma = value!;
                                         if(isRoma == true){
                                           roma = 'roma';
                                           debugPrint("Roma Ethnicity Selected");
                                         }
                                         else{
                                           roma = '';
                                           debugPrint("Roma Ethnicity UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Any Other White Background
                                 ListTile(
                                   title:  Text('Any Other White Background',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isAnyOtherWhiteBackground,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isAnyOtherWhiteBackground = value!;
                                         if(isAnyOtherWhiteBackground == true){
                                           anyOtherWhiteBackground = 'anyOtherWhiteBackground';
                                           debugPrint("Any Other White Background Ethnicity Selected");
                                         }
                                         else{
                                           anyOtherWhiteBackground = '';
                                           debugPrint("Any Other White Background Ethnicity UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Filipino
                                 ListTile(
                                   title:  Text('Filipino',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isFilipino,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isFilipino = value!;
                                         if(isFilipino == true){
                                           filipino = 'filipino';
                                           debugPrint("Filipino Ethnicity Selected");
                                         }
                                         else{
                                           filipino = '';
                                           debugPrint("Filipino Ethnicity UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),

                                 // Container(
                                 //   decoration: BoxDecoration(
                                 //     color: Colors.white,
                                 //     boxShadow: const [
                                 //       BoxShadow(
                                 //         color: Colors.grey,
                                 //         offset:
                                 //         Offset(0.0, 3.0),
                                 //         //(x,y)
                                 //         blurRadius: 5.0,
                                 //       ),
                                 //     ],
                                 //     borderRadius:
                                 //     BorderRadius.circular(
                                 //         14),
                                 //     // border: Border.all(
                                 //     //   color: Colors.grey,
                                 //     // ),
                                 //   ),
                                 //   child: Row(
                                 //     mainAxisAlignment:
                                 //     MainAxisAlignment
                                 //         .spaceBetween,
                                 //     children: [
                                 //       Expanded(
                                 //         child: TextField(
                                 //           style: KFontStyle
                                 //               .kTextStyle18Black,
                                 //           textCapitalization:
                                 //           TextCapitalization
                                 //               .words,
                                 //           controller:
                                 //           ethnicityController,
                                 //           decoration:
                                 //           InputDecoration(
                                 //             border: OutlineInputBorder(
                                 //                 borderRadius:
                                 //                 BorderRadius
                                 //                     .circular(
                                 //                     14),
                                 //                 borderSide: const BorderSide(
                                 //                     color: Colors
                                 //                         .white)),
                                 //             focusedBorder:
                                 //             OutlineInputBorder(
                                 //               borderRadius:
                                 //               BorderRadius
                                 //                   .circular(
                                 //                   14.0),
                                 //               borderSide:
                                 //               const BorderSide(
                                 //                 color: Colors
                                 //                     .white,
                                 //               ),
                                 //             ),
                                 //             enabledBorder:
                                 //             OutlineInputBorder(
                                 //               borderRadius:
                                 //               BorderRadius
                                 //                   .circular(
                                 //                   14.0),
                                 //               borderSide:
                                 //               const BorderSide(
                                 //                 color: Colors
                                 //                     .white,
                                 //               ),
                                 //             ),
                                 //             hintText:
                                 //             "Search Ethnicity",
                                 //             hintStyle: KFontStyle
                                 //                 .kTextStyle18Black,
                                 //             suffixIcon: Padding(
                                 //               padding:
                                 //               const EdgeInsets
                                 //                   .only(
                                 //                   left:
                                 //                   20.0,
                                 //                   right: 20,
                                 //                   top: 10,
                                 //                   bottom:
                                 //                   10),
                                 //               child: FittedBox(
                                 //                   fit: BoxFit
                                 //                       .cover,
                                 //                   child:
                                 //                   ImageIcon(
                                 //                     const AssetImage(
                                 //                       "assets/images/search.png",
                                 //                     ),
                                 //                     color: Color(
                                 //                         KColors
                                 //                             .kColorDarkGrey),
                                 //                   )),
                                 //             ),
                                 //           ),
                                 //         ),
                                 //       ),
                                 //       // Image.asset("assets/images/search.png",height: 32,width: 32,),
                                 //     ],
                                 //   ),
                                 // ),
                                 // Container(
                                 //     child:
                                 //     const Text('Ethnicity'),
                                 //     padding:
                                 //     const EdgeInsets.all(
                                 //         20)),
                               ],
                             ),
                           ),
                         ),
                         //Hair Color Tab Content
                         Container(
                           margin: const EdgeInsets.all(20),
                           child: SingleChildScrollView(
                             child: Column(
                               children: [
                                 //Black
                                 ListTile(
                                   title:  Text('Black',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isBlackHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isBlackHair = value!;
                                         if(isBlackHair == true){
                                           blackHair = 'black';
                                           debugPrint("Black Hair Selected");
                                         }
                                         else{
                                           blackHair = '';
                                           debugPrint("Black Hair UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Blonde
                                 ListTile(
                                   title:  Text('Blonde',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isBlondeHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isBlondeHair = value!;
                                         if(isBlondeHair == true){
                                           blondeHair = 'blonde';
                                           debugPrint("Blonde Hair Selected");
                                         }
                                         else{
                                           blondeHair = '';
                                           debugPrint("Blonde Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Brown
                                 ListTile(
                                   title:  Text('Brown',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isBrownHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isBrownHair = value!;
                                         if(isBrownHair == true){
                                           brownHair = 'brown';
                                           debugPrint("Brown Hair Selected");
                                         }
                                         else{
                                           brownHair = '';
                                           debugPrint("Brown Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Auburn
                                 ListTile(
                                   title:  Text('Auburn',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isAuburnHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isAuburnHair = value!;
                                         if(isAuburnHair == true){
                                           auburnHair = 'auburn';
                                           debugPrint("AuBurn Hair Selected");
                                         }
                                         else{
                                           auburnHair = '';
                                           debugPrint("AuBurn Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //ChestNut
                                 ListTile(
                                   title:  Text('Chestnut',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isChestNutHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isChestNutHair = value!;
                                         if(isChestNutHair == true){
                                           chestNutHair = 'chestnut';
                                           debugPrint("chestNut Hair Selected");
                                         }
                                         else{
                                           chestNutHair = '';
                                           debugPrint("chestNut Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Red
                                 ListTile(
                                   title:  Text('Red',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isRedHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isRedHair = value!;
                                         if(isRedHair == true){
                                           redHair = 'red';
                                           debugPrint("red Hair Selected");
                                         }
                                         else{
                                           redHair = '';
                                           debugPrint("red Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Gray
                                 ListTile(
                                   title:  Text('Gray',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isGrayHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isGrayHair = value!;
                                         if(isGrayHair == true){
                                           grayHair = 'gray';
                                           debugPrint("gray Hair Selected");
                                         }
                                         else{
                                           grayHair = '';
                                           debugPrint("gray Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //White
                                 ListTile(
                                   title:  Text('White',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isWhiteHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isWhiteHair = value!;
                                         if(isWhiteHair == true){
                                           whiteHair = 'white';
                                           debugPrint("white Hair Selected");
                                         }
                                         else{
                                           whiteHair = '';
                                           debugPrint("white Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Bald
                                 ListTile(
                                   title:  Text('Bald',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isBaldHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isBaldHair = value!;
                                         if(isBaldHair == true){
                                           baldHair = 'bald';
                                           debugPrint("bald Hair Selected");
                                         }
                                         else{
                                           baldHair = '';
                                           debugPrint("bald Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Salt & Pepper
                                 ListTile(
                                   title:  Text('Salt & Pepper',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isSaltPepperHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isSaltPepperHair = value!;
                                         if(isSaltPepperHair == true){
                                           saltPepperHair = 'saltPepper';
                                           debugPrint("saltPepper Hair Selected");
                                         }
                                         else{
                                           saltPepperHair = '';
                                           debugPrint("saltPepper Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Strawberry Blond
                                 ListTile(
                                   title:  Text('Strawberry Blonde',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isStrawberryBlondeHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isStrawberryBlondeHair = value!;
                                         if(isStrawberryBlondeHair == true){
                                           strawberryBlondeHair = 'strawberryBlonde';
                                           debugPrint("strawberryBlondeHair Hair Selected");
                                         }
                                         else{
                                           strawberryBlondeHair = '';
                                           debugPrint("strawberryBlondeHair Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Multicolored / Dyed
                                 ListTile(
                                   title:  Text('Multicolored / Dyed',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isMulticoloredHair,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isMulticoloredHair = value!;
                                         if(isMulticoloredHair == true){
                                           multicoloredHair = 'multicolored';
                                           debugPrint("multicoloredHair Hair Selected");
                                         }
                                         else{
                                           multicoloredHair = '';
                                           debugPrint("multicoloredHair Hair UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),

                               ],
                             ),
                           ),
                         ),
                         //Eye Color Tab Content
                         Container(
                           margin: const EdgeInsets.all(20),
                           child: SingleChildScrollView(
                             child: Column(
                               children: [
                                 //Black
                                 ListTile(
                                   title:  Text('Black',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isBlackEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isBlackEye = value!;
                                         if(isBlackEye == true){
                                           blackEye = 'black';
                                           debugPrint("Black Eye Selected");
                                         }
                                         else{
                                           blackEye = '';
                                           debugPrint("Black Eye UnSelected");
                                         }

                                       });
                                     },
                                   ),
                                 ),
                                 //Blonde
                                 ListTile(
                                   title:  Text('Blonde',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isBlondeEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isBlondeEye = value!;
                                         if(isBlondeEye == true){
                                           blondeEye = 'blonde';
                                           debugPrint("Blonde Eye Selected");
                                         }
                                         else{
                                           blondeEye = '';
                                           debugPrint("Blonde Eye UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Brown
                                 ListTile(
                                   title:  Text('Brown',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isBrownEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isBrownEye = value!;
                                         if(isBrownEye == true){
                                           brownEye = 'brown';
                                           debugPrint("Brown Eye Selected");
                                         }
                                         else{
                                           brownEye = '';
                                           debugPrint("Brown Eye UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Auburn
                                 ListTile(
                                   title:  Text('Auburn',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isAuburnEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isAuburnEye = value!;
                                         if(isAuburnEye == true){
                                           auburnEye = 'auburn';
                                           debugPrint("AuBurn Eye Selected");
                                         }
                                         else{
                                           auburnEye = '';
                                           debugPrint("AuBurn Eye UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //ChestNut
                                 ListTile(
                                   title:  Text('Chestnut',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isChestNutEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isChestNutEye = value!;
                                         if(isChestNutEye == true){
                                           chestNutEye = 'chestnut';
                                           debugPrint("chestNut Eye Selected");
                                         }
                                         else{
                                           chestNutEye = '';
                                           debugPrint("chestNut Eye UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Red
                                 ListTile(
                                   title:  Text('Red',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isRedEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isRedEye = value!;
                                         if(isRedEye == true){
                                           redEye = 'red';
                                           debugPrint("red eye Selected");
                                         }
                                         else{
                                           redEye = '';
                                           debugPrint("red eye UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Gray
                                 ListTile(
                                   title:  Text('Gray',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isGrayEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isGrayEye = value!;
                                         if(isGrayEye == true){
                                           grayEye = 'gray';
                                           debugPrint("gray eye Selected");
                                         }
                                         else{
                                           grayEye = '';
                                           debugPrint("gray eye UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //White
                                 ListTile(
                                   title:  Text('White',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isWhiteEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isWhiteEye = value!;
                                         if(isWhiteEye == true){
                                           whiteEye = 'white';
                                           debugPrint("white eye Selected");
                                         }
                                         else{
                                           whiteEye = '';
                                           debugPrint("white eye UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Salt & Pepper
                                 ListTile(
                                   title:  Text('Salt & Pepper',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isSaltPepperEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isSaltPepperEye = value!;
                                         if(isSaltPepperEye == true){
                                           saltPepperEye = 'saltPepper';
                                           debugPrint("saltPepper Eye Selected");
                                         }
                                         else{
                                           saltPepperEye = '';
                                           debugPrint("saltPepper Eye UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Strawberry Blond
                                 ListTile(
                                   title:  Text('Strawberry Blonde',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isStrawberryBlondeEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isStrawberryBlondeEye = value!;
                                         if(isStrawberryBlondeEye == true){
                                           strawberryBlondeEye = 'strawberryBlonde';
                                           debugPrint("strawberryBlonde Eye Selected");
                                         }
                                         else{
                                           strawberryBlondeEye = '';
                                           debugPrint("strawberryBlonde eye UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Multicolored / Dyed
                                 ListTile(
                                   title:  Text('Multicolored / Dyed',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value:  isMulticoloredEye,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isMulticoloredEye = value!;
                                         if(isMulticoloredEye == true){
                                           multicoloredEye = 'multicolored';
                                           debugPrint("multicoloredHair eye Selected");
                                         }
                                         else{
                                           multicoloredEye = '';
                                           debugPrint("multicoloredHair eye UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         //Body Type Tab Content
                         Container(
                           margin: const EdgeInsets.all(20),
                           child: SingleChildScrollView(
                             child: Column(
                               children: [
                                 //Average
                                 ListTile(
                                   title:  Text('Average',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isAverageBody,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isAverageBody = value!;
                                         if(isAverageBody == true){
                                           averageBody = 'average';
                                           debugPrint("Average Body Selected");
                                         }
                                         else{
                                           averageBody = '';
                                           debugPrint("Average Body UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Slim
                                 ListTile(
                                   title:  Text('Slim',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isSlimBody,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isSlimBody = value!;
                                         if(isSlimBody == true){
                                           slimBody = 'slim';
                                           debugPrint("Slim Body Selected");
                                         }
                                         else{
                                           slimBody = '';
                                           debugPrint("Slim Body UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Athletic / Toned
                                 ListTile(
                                   title:  Text('Athletic / Toned',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isAthleticTonedBody,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isAthleticTonedBody = value!;
                                         if(isAthleticTonedBody == true){
                                           athleticTonedBody = 'athletic';
                                           debugPrint("Athletic Body Selected");
                                         }
                                         else{
                                           athleticTonedBody = '';
                                           debugPrint("Athletic Body UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Muscular
                                 ListTile(
                                   title:  Text('Muscular',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isMuscularBody,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isMuscularBody = value!;
                                         if(isMuscularBody == true){
                                           muscularBody = 'muscular';
                                           debugPrint("Muscular Body Selected");
                                         }
                                         else{
                                           muscularBody = '';
                                           debugPrint("Muscular Body UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Curvy
                                 ListTile(
                                   title:  Text('Curvy',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isCurvyBody,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isCurvyBody = value!;
                                         if(isCurvyBody == true){
                                           curvyBody = 'curvy';
                                           debugPrint("Curvy Body Selected");
                                         }
                                         else{
                                           curvyBody = '';
                                           debugPrint("Curvy Body UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Heavyset / Stocky
                                 ListTile(
                                   title:  Text('Heavyset / Stocky',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isHeavySetBody,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isHeavySetBody = value!;
                                         if(isHeavySetBody == true){
                                           heavySetBody = 'heavyset';
                                           debugPrint("HeavySet Body Selected");
                                         }
                                         else{
                                           heavySetBody = '';
                                           debugPrint("HeavySet Body UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                                 //Plus-Sized / Full-Figured
                                 ListTile(
                                   title:  Text('Plus-Sized / Full-Figured',style: KFontStyle.kTextStyle14Black,),
                                   leading: Checkbox(
                                     value: isPlusSizedBody,
                                     onChanged: (bool? value) {
                                       setState(() {
                                         isPlusSizedBody = value!;
                                         if(isPlusSizedBody == true){
                                           plusSizedBody = 'plusSized';
                                           debugPrint("PlusSized Body Selected");
                                         }
                                         else{
                                           plusSizedBody = '';
                                           debugPrint("PlusSized Body UnSelected");
                                         }
                                       });
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         //Height
                         Container(
                           margin: const EdgeInsets.all(20),
                           child: Column(
                             crossAxisAlignment:
                             CrossAxisAlignment.center,
                             mainAxisAlignment:
                             MainAxisAlignment.end,
                             children: [

                               //height slider
                               Padding(
                                 padding: const EdgeInsets.all(
                                     10.0),
                                 child: SfRangeSlider(
                                     activeColor: Color(KColors
                                         .kColorPrimary),
                                     inactiveColor: Color(
                                         KColors
                                             .kColorDarkGrey),
                                     trackShape:
                                     const SfTrackShape(),
                                     enableTooltip: true,
                                     showLabels: true,
                                     showTicks: true,
                                     stepSize: 1.0,
                                     min: heightMin,
                                     max: heightMax,
                                     values: heightValues,
                                     onChanged: (SfRangeValues
                                     newValues) {
                                       setState(() {
                                         heightValues =
                                             newValues;
                                       });
                                     }),
                               )
                             ],
                           ),
                         ),
                         //Age
                         Container(
                           margin: const EdgeInsets.all(20),
                           child: Column(
                             crossAxisAlignment:
                             CrossAxisAlignment.center,
                             mainAxisAlignment:
                             MainAxisAlignment.end,
                             children: [
                               // Expanded(
                               //   child: TextField(
                               //     style: KFontStyle
                               //         .kTextStyle18Black,
                               //     textCapitalization:
                               //     TextCapitalization
                               //         .words,
                               //     textAlign: TextAlign.center,
                               //     controller:
                               //     bodyTypeController,
                               //     decoration: InputDecoration(
                               //       border: OutlineInputBorder(
                               //           borderRadius:
                               //           BorderRadius
                               //               .circular(14),
                               //           borderSide:
                               //           const BorderSide(
                               //               color: Colors
                               //                   .white)),
                               //       focusedBorder:
                               //       OutlineInputBorder(
                               //         borderRadius:
                               //         BorderRadius
                               //             .circular(14.0),
                               //         borderSide:
                               //         const BorderSide(
                               //           color: Colors.white,
                               //         ),
                               //       ),
                               //       enabledBorder:
                               //       OutlineInputBorder(
                               //         borderRadius:
                               //         BorderRadius
                               //             .circular(14.0),
                               //         borderSide:
                               //         const BorderSide(
                               //           color: Colors.white,
                               //         ),
                               //       ),
                               //       hintText: "Search By Age",
                               //       hintStyle: KFontStyle
                               //           .kTextStyle18Black,
                               //     ),
                               //   ),
                               // ),
                               //age slider
                               Padding(
                                 padding: const EdgeInsets.all(
                                     10.0),
                                 child: SfRangeSlider(
                                     activeColor: Color(KColors
                                         .kColorPrimary),
                                     inactiveColor: Color(
                                         KColors
                                             .kColorDarkGrey),
                                     trackShape:
                                     const SfTrackShape(),
                                     enableTooltip: true,
                                     showLabels: true,
                                     showTicks: true,
                                     stepSize: 1.0,
                                     min: ageMin,
                                     max: ageMax,
                                     values: ageValues,
                                     onChanged: (SfRangeValues
                                     newValues) {
                                       setState(() {
                                         ageValues = newValues;
                                       });
                                     }),
                               )
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                   //Filter Buttons
                   Container(
                     height: 80,
                     decoration: const BoxDecoration(
                       color: Colors.white,
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey,
                           offset: Offset(0.0, 3.0), //(x,y)
                           blurRadius: 5.0,
                         ),
                       ],
                     ),
                     child: Row(
                       mainAxisAlignment:
                       MainAxisAlignment.center,
                       children: [
                         //Clear Button
                         GestureDetector(
                           onTap: () {
                             clearFilters();
                             filteredTalentData.clear();
                             Get.back();
                           },
                           child: Container(
                             margin: const EdgeInsets.fromLTRB(
                                 10, 10, 10, 10),
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius:
                               BorderRadius.circular(14),
                               border: Border.all(
                                 color: Color(
                                     KColors.kColorPrimary),
                               ),
                             ),
                             child: Row(
                               mainAxisAlignment:
                               MainAxisAlignment.center,
                               children: [
                                 Padding(
                                   padding:
                                   const EdgeInsets.only(
                                       left: 30,
                                       right: 30,
                                       top: 15,
                                       bottom: 15),
                                   child: Text(
                                     "Clear",
                                     style: KFontStyle
                                         .kTextStyle16Blue,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         //Apply Button
                         GestureDetector(
                           onTap: () {
                             setState(() {
                               debugPrint("Filters are applied ");
                               debugPrint(countryValue);
                               debugPrint(stateValue);
                               debugPrint(cityValue);
                               Get.back();
                               getFilteredTalent();
                             });

                             // Get.back();

                             // Navigator.pop(context);
                           },
                           child: Container(
                             margin: const EdgeInsets.fromLTRB(
                                 10, 10, 10, 10),
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius:
                               BorderRadius.circular(14),
                               border: Border.all(
                                 color: Color(
                                     KColors.kColorPrimary),
                               ),
                             ),
                             child: Row(
                               mainAxisAlignment:
                               MainAxisAlignment.center,
                               children: [
                                 Padding(
                                   padding:
                                   const EdgeInsets.only(
                                       left: 30,
                                       right: 30,
                                       top: 15,
                                       bottom: 15),
                                   child: Text(
                                     "Apply",
                                     style: KFontStyle
                                         .kTextStyle16Blue,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         // Image.asset("assets/images/search.png",height: 32,width: 32,),
                       ],
                     ),
                   ),
                 ],
               ),
             );
           },
         );
       },
     );
  }

  @override
  void initState() {
    super.initState();
    // startTime();

  }
  startTime() async {
    var duration = const Duration(seconds: 0);
    return Timer(duration, filterWidget);
  }

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
       leading:  Padding(
         padding: const EdgeInsets.only(left: 20,right: 20),
         child: GestureDetector(
           onTap: (){
             Get.back();
           },
             child: Icon(Icons.arrow_back_ios,color: const Color(0xff4B6DFC),)),
       ),
        title: Text(
          titleText,
          style: KFontStyle.kTextStyle24Black,
        ),
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Color(KColors.kColorWhite),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height:
            MediaQuery.of(context).size.height / 1.6,
            child: Column(

              children: [
                //Filters List
                Expanded(
                  child: VerticalTabs(
                    indicatorColor: Colors.white,
                    selectedTabBackgroundColor:
                    Colors.white,
                    backgroundColor: Colors.white,
                    tabsWidth: 150,
                    tabsElevation: 5.0,
                    contentScrollAxis: Axis.vertical,
                    tabs: <Tab>[
                      //Gender Tab
                      Tab(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Gender',
                              style:
                              KFontStyle.kTextStyle18Black,
                            ),
                          )),
                      //Location Tab
                      Tab(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Location',
                              style:
                              KFontStyle.kTextStyle18Black,
                            ),
                          )),
                      //Ethnicity Tab
                      Tab(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Ethnicity',
                              style:
                              KFontStyle.kTextStyle18Black,
                            ),
                          )),
                      //Hair Color Tab
                      Tab(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Hair Color',
                              style:
                              KFontStyle.kTextStyle18Black,
                            ),
                          )),
                      //Eye Color Tab
                      Tab(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Eye Color',
                              style:
                              KFontStyle.kTextStyle18Black,
                            ),
                          )),
                      //Body Type Tab
                      Tab(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Body Type',
                              style:
                              KFontStyle.kTextStyle18Black,
                            ),
                          )),
                      //Height Tab
                      Tab(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Height',
                              style:
                              KFontStyle.kTextStyle18Black,
                            ),
                          )),
                      //Age Range Tab
                      Tab(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Age Range',
                              style:
                              KFontStyle.kTextStyle18Black,
                            ),
                          )),
                    ],
                    contents: <Widget>[
                      //Gender Tab Content
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //Male
                              ListTile(
                                title:  Text('Male',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isMale,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isMale = value!;
                                      if(isMale == true){
                                        male = 'male';
                                        debugPrint("Male Selected $male");
                                      }
                                      else{
                                        male = '';
                                        debugPrint("Male UnSelected $male");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Female
                              ListTile(
                                title:  Text('Female',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isFemale,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isFemale = value!;
                                      if(isFemale == true){
                                        feMale = 'female';
                                        debugPrint("Female Selected");
                                      }
                                      else{
                                        feMale = '';
                                        debugPrint("Female UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              // Gender-Nonconforming
                              ListTile(
                                title:  Text('Gender-Nonconforming',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isGenderNonConforming,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isGenderNonConforming = value!;
                                      if(isGenderNonConforming == true){
                                        genderNonConforming = 'genderNonConforming';
                                        debugPrint("genderNonConforming Selected");
                                      }
                                      else{
                                        genderNonConforming = '';
                                        debugPrint("genderNonConforming UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              // Non-Binary
                              ListTile(
                                title:  Text('Non-Binary',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isNonBinary,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isNonBinary = value!;
                                      if(isNonBinary == true){
                                        nonBinary = 'nonBinary';
                                        debugPrint("nonBinary Selected");
                                      }
                                      else{
                                        nonBinary = '';
                                        debugPrint("nonBinary UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              // Trans Female
                              ListTile(
                                title:  Text('Trans Female',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isTransFemale,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isTransFemale = value!;
                                      if(isTransFemale == true){
                                        transFemale = 'transFemale';
                                        debugPrint("transFemale Selected");
                                      }
                                      else{
                                        transFemale = '';
                                        debugPrint("transFemale UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              // Trans Male
                              ListTile(
                                title:  Text('Trans Male',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isTransMale,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isTransMale = value!;
                                      if(isTransMale == true){
                                        transMale = 'transMale';
                                        debugPrint("transMale Selected");
                                      }
                                      else{
                                        transMale = '';
                                        debugPrint("transMale UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              // Trans Male
                              ListTile(
                                title:  Text('Unspecified',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isUnspecified,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isUnspecified = value!;
                                      unspecified = 'unspecified';
                                      debugPrint("unspecified Selected");
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Location Tab Content
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [

                            CSCPicker(
                              onCountryChanged: (value) {
                                setState(() {
                                  countryValue = value;
                                });
                              },
                              onStateChanged:(value) {
                                setState(() {
                                  stateValue = value!;
                                });
                              },
                              onCityChanged:(value) {
                                setState(() {
                                  cityValue = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      //Ethnicity Tab Content
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //Pakistani
                              ListTile(
                                title:  Text('Pakistani',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isPakistani,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isPakistani = value!;
                                      if(isPakistani == true){
                                        pakistani = 'pakistani';
                                        debugPrint("Pakistani Ethnicity Selected");
                                      }
                                      else{
                                        pakistani = '';
                                        debugPrint("Pakistani Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Indian
                              ListTile(
                                title:  Text('Indian',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isIndian,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isIndian = value!;
                                      if(isIndian == true){
                                        indian = 'indian';
                                        debugPrint("Indian Ethnicity Selected");
                                      }
                                      else{
                                        indian = '';
                                        debugPrint("Indian Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Bangladeshi
                              ListTile(
                                title:  Text('Bangladeshi',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isBangladeshi,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isBangladeshi = value!;
                                      if(isBangladeshi == true){
                                        bangladeshi = 'bangladeshi';
                                        debugPrint("Bangladeshi Ethnicity Selected");
                                      }
                                      else{
                                        bangladeshi = '';
                                        debugPrint("Bangladeshi Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Chinese
                              ListTile(
                                title:  Text('Chinese',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isChinese,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChinese = value!;
                                      if(isChinese == true){
                                        chinese = 'chinese';
                                        debugPrint("Chinese Ethnicity Selected");
                                      }
                                      else{
                                        chinese = '';
                                        debugPrint("Chinese Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Any Other Asian Background
                              ListTile(
                                title:  Text('Any Other Asian Background',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isAnyOtherAsian,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAnyOtherAsian = value!;
                                      if(isAnyOtherAsian == true){
                                        anyOtherAsian = 'anyOtherAsian';
                                        debugPrint("Any Other Asian Background Ethnicity Selected");
                                      }
                                      else{
                                        anyOtherAsian = '';
                                        debugPrint("Any Other Asian Background Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Caribbean
                              ListTile(
                                title:  Text('Caribbean',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isCaribbean,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCaribbean = value!;
                                      if(isCaribbean == true){
                                        caribbean = 'caribbean';
                                        debugPrint("Caribbean Ethnicity Selected");
                                      }
                                      else{
                                        caribbean = '';
                                        debugPrint("Caribbean Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //African
                              ListTile(
                                title:  Text('African',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isAfrican,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAfrican = value!;
                                      if(isAfrican == true){
                                        african = 'african';
                                        debugPrint("African Ethnicity Selected");
                                      }
                                      else{
                                        african = '';
                                        debugPrint("African Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Any Other Black
                              ListTile(
                                title:  Text('Any Other Black',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isAnyOtherBlack,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAnyOtherBlack = value!;
                                      if(isAnyOtherBlack == true){
                                        anyOtherBlack = 'anyOtherBlack';
                                        debugPrint("AnyOtherBlack Ethnicity Selected");
                                      }
                                      else{
                                        anyOtherBlack = '';
                                        debugPrint("AnyOtherBlack Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Black British
                              ListTile(
                                title:  Text('Black British',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isBlackBritish,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isBlackBritish = value!;
                                      if(isBlackBritish == true){
                                        blackBritish = 'blackBritish';
                                        debugPrint("Black British Ethnicity Selected");
                                      }
                                      else{
                                        blackBritish = '';
                                        debugPrint("Black British Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Caribbean Background
                              ListTile(
                                title:  Text('Caribbean Background',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isCaribbeanBackground,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCaribbeanBackground = value!;
                                      if(isCaribbeanBackground == true){
                                        caribbeanBackground = 'caribbeanBackground';
                                        debugPrint("CaribbeanBackground Ethnicity Selected");
                                      }
                                      else{
                                        caribbeanBackground = '';
                                        debugPrint("CaribbeanBackground Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //White and Black Caribbean
                              ListTile(
                                title:  Text('White and Black Caribbean',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isWhiteAndBlackCaribbean,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isWhiteAndBlackCaribbean = value!;
                                      if(isWhiteAndBlackCaribbean == true){
                                        whiteAndBlackCaribbean = 'whiteAndBlackCaribbean';
                                        debugPrint("White and Black Caribbean Ethnicity Selected");
                                      }
                                      else{
                                        whiteAndBlackCaribbean = '';
                                        debugPrint("White and Black Caribbean Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //White and Black African
                              ListTile(
                                title:  Text('White and Black African',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isWhiteAndBlackAfrican,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isWhiteAndBlackAfrican = value!;
                                      if(isWhiteAndBlackAfrican == true){
                                        whiteAndBlackAfrican = 'whiteAndBlackAfrican';
                                        debugPrint("White and Black African Ethnicity Selected");
                                      }
                                      else{
                                        whiteAndBlackAfrican = '';
                                        debugPrint("White and Black African Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //White and Asian
                              ListTile(
                                title:  Text('White and Asian',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isWhiteAndAsian,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isWhiteAndAsian = value!;
                                      if(isWhiteAndAsian == true){
                                        whiteAndAsian = 'whiteAndAsian';
                                        debugPrint("White and Asian Ethnicity Selected");
                                      }
                                      else{
                                        whiteAndAsian = '';
                                        debugPrint("White and Asian Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Any Other Mixed
                              ListTile(
                                title:  Text('Any Other Mixed',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isAnyOtherMixed,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAnyOtherMixed = value!;
                                      if(isAnyOtherMixed == true){
                                        anyOtherMixed = 'anyOtherMixed';
                                        debugPrint("Any Other Mixed Ethnicity Selected");
                                      }
                                      else{
                                        anyOtherMixed = '';
                                        debugPrint("Any Other Mixed Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Multiple Ethnic Background
                              ListTile(
                                title:  Text('Multiple Ethnic Background',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isMultipleEthnicBackground,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isMultipleEthnicBackground = value!;
                                      if(isMultipleEthnicBackground == true){
                                        multipleEthnicBackground = 'multipleEthnicBackground';
                                        debugPrint("Multiple Ethnic Background Ethnicity Selected");
                                      }
                                      else{
                                        multipleEthnicBackground = '';
                                        debugPrint("Multiple Ethnic Background Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //English
                              ListTile(
                                title:  Text('English',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isEnglish,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isEnglish = value!;
                                      if(isEnglish == true){
                                        english = 'english';
                                        debugPrint("English Ethnicity Selected");
                                      }
                                      else{
                                        english = '';
                                        debugPrint("English Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Welsh
                              ListTile(
                                title:  Text('Welsh',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isWelsh,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isWelsh = value!;
                                      if(isWelsh == true){
                                        welsh = 'welsh';
                                        debugPrint("Welsh Ethnicity Selected");
                                      }
                                      else{
                                        welsh = '';
                                        debugPrint("Welsh Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Scottish
                              ListTile(
                                title:  Text('Scottish',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isScottish,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isScottish = value!;
                                      if(isScottish == true){
                                        scottish = 'scottish';
                                        debugPrint("Scottish Ethnicity Selected");
                                      }
                                      else{
                                        scottish = '';
                                        debugPrint("Scottish Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Northern Irish
                              ListTile(
                                title:  Text('Northern Irish',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isNorthernIrish,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isNorthernIrish = value!;
                                      if(isNorthernIrish == true){
                                        northernIrish = 'northernIrish';
                                        debugPrint("Northern Irish Ethnicity Selected");
                                      }
                                      else{
                                        northernIrish = '';
                                        debugPrint("Northern Irish Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Irish
                              ListTile(
                                title:  Text('Irish',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isIrish,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isIrish = value!;
                                      if(isIrish == true){
                                        irish = 'irish';
                                        debugPrint("Irish Ethnicity Selected");
                                      }
                                      else{
                                        irish = '';
                                        debugPrint("Irish Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Gypsy
                              ListTile(
                                title:  Text('Gypsy',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isGypsy,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isGypsy = value!;
                                      if(isGypsy == true){
                                        gypsy = 'gypsy';
                                        debugPrint("Gypsy Ethnicity Selected");
                                      }
                                      else{
                                        gypsy = '';
                                        debugPrint("Gypsy Ethnicity UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Roma
                              ListTile(
                                title:  Text('Roma',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isRoma,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isRoma = value!;
                                      if(isRoma == true){
                                        roma = 'roma';
                                        debugPrint("Roma Ethnicity Selected");
                                      }
                                      else{
                                        roma = '';
                                        debugPrint("Roma Ethnicity UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Any Other White Background
                              ListTile(
                                title:  Text('Any Other White Background',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isAnyOtherWhiteBackground,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAnyOtherWhiteBackground = value!;
                                      if(isAnyOtherWhiteBackground == true){
                                        anyOtherWhiteBackground = 'anyOtherWhiteBackground';
                                        debugPrint("Any Other White Background Ethnicity Selected");
                                      }
                                      else{
                                        anyOtherWhiteBackground = '';
                                        debugPrint("Any Other White Background Ethnicity UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Filipino
                              ListTile(
                                title:  Text('Filipino',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isFilipino,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isFilipino = value!;
                                      if(isFilipino == true){
                                        filipino = 'filipino';
                                        debugPrint("Filipino Ethnicity Selected");
                                      }
                                      else{
                                        filipino = '';
                                        debugPrint("Filipino Ethnicity UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),

                              // Container(
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     boxShadow: const [
                              //       BoxShadow(
                              //         color: Colors.grey,
                              //         offset:
                              //         Offset(0.0, 3.0),
                              //         //(x,y)
                              //         blurRadius: 5.0,
                              //       ),
                              //     ],
                              //     borderRadius:
                              //     BorderRadius.circular(
                              //         14),
                              //     // border: Border.all(
                              //     //   color: Colors.grey,
                              //     // ),
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //     MainAxisAlignment
                              //         .spaceBetween,
                              //     children: [
                              //       Expanded(
                              //         child: TextField(
                              //           style: KFontStyle
                              //               .kTextStyle18Black,
                              //           textCapitalization:
                              //           TextCapitalization
                              //               .words,
                              //           controller:
                              //           ethnicityController,
                              //           decoration:
                              //           InputDecoration(
                              //             border: OutlineInputBorder(
                              //                 borderRadius:
                              //                 BorderRadius
                              //                     .circular(
                              //                     14),
                              //                 borderSide: const BorderSide(
                              //                     color: Colors
                              //                         .white)),
                              //             focusedBorder:
                              //             OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius
                              //                   .circular(
                              //                   14.0),
                              //               borderSide:
                              //               const BorderSide(
                              //                 color: Colors
                              //                     .white,
                              //               ),
                              //             ),
                              //             enabledBorder:
                              //             OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius
                              //                   .circular(
                              //                   14.0),
                              //               borderSide:
                              //               const BorderSide(
                              //                 color: Colors
                              //                     .white,
                              //               ),
                              //             ),
                              //             hintText:
                              //             "Search Ethnicity",
                              //             hintStyle: KFontStyle
                              //                 .kTextStyle18Black,
                              //             suffixIcon: Padding(
                              //               padding:
                              //               const EdgeInsets
                              //                   .only(
                              //                   left:
                              //                   20.0,
                              //                   right: 20,
                              //                   top: 10,
                              //                   bottom:
                              //                   10),
                              //               child: FittedBox(
                              //                   fit: BoxFit
                              //                       .cover,
                              //                   child:
                              //                   ImageIcon(
                              //                     const AssetImage(
                              //                       "assets/images/search.png",
                              //                     ),
                              //                     color: Color(
                              //                         KColors
                              //                             .kColorDarkGrey),
                              //                   )),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       // Image.asset("assets/images/search.png",height: 32,width: 32,),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //     child:
                              //     const Text('Ethnicity'),
                              //     padding:
                              //     const EdgeInsets.all(
                              //         20)),
                            ],
                          ),
                        ),
                      ),
                      //Hair Color Tab Content
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //Black
                              ListTile(
                                title:  Text('Black',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isBlackHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isBlackHair = value!;
                                      if(isBlackHair == true){
                                        blackHair = 'black';
                                        debugPrint("Black Hair Selected");
                                      }
                                      else{
                                        blackHair = '';
                                        debugPrint("Black Hair UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Blonde
                              ListTile(
                                title:  Text('Blonde',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isBlondeHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isBlondeHair = value!;
                                      if(isBlondeHair == true){
                                        blondeHair = 'blonde';
                                        debugPrint("Blonde Hair Selected");
                                      }
                                      else{
                                        blondeHair = '';
                                        debugPrint("Blonde Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Brown
                              ListTile(
                                title:  Text('Brown',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isBrownHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isBrownHair = value!;
                                      if(isBrownHair == true){
                                        brownHair = 'brown';
                                        debugPrint("Brown Hair Selected");
                                      }
                                      else{
                                        brownHair = '';
                                        debugPrint("Brown Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Auburn
                              ListTile(
                                title:  Text('Auburn',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isAuburnHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAuburnHair = value!;
                                      if(isAuburnHair == true){
                                        auburnHair = 'auburn';
                                        debugPrint("AuBurn Hair Selected");
                                      }
                                      else{
                                        auburnHair = '';
                                        debugPrint("AuBurn Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //ChestNut
                              ListTile(
                                title:  Text('Chestnut',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isChestNutHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChestNutHair = value!;
                                      if(isChestNutHair == true){
                                        chestNutHair = 'chestnut';
                                        debugPrint("chestNut Hair Selected");
                                      }
                                      else{
                                        chestNutHair = '';
                                        debugPrint("chestNut Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Red
                              ListTile(
                                title:  Text('Red',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isRedHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isRedHair = value!;
                                      if(isRedHair == true){
                                        redHair = 'red';
                                        debugPrint("red Hair Selected");
                                      }
                                      else{
                                        redHair = '';
                                        debugPrint("red Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Gray
                              ListTile(
                                title:  Text('Gray',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isGrayHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isGrayHair = value!;
                                      if(isGrayHair == true){
                                        grayHair = 'gray';
                                        debugPrint("gray Hair Selected");
                                      }
                                      else{
                                        grayHair = '';
                                        debugPrint("gray Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //White
                              ListTile(
                                title:  Text('White',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isWhiteHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isWhiteHair = value!;
                                      if(isWhiteHair == true){
                                        whiteHair = 'white';
                                        debugPrint("white Hair Selected");
                                      }
                                      else{
                                        whiteHair = '';
                                        debugPrint("white Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Bald
                              ListTile(
                                title:  Text('Bald',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isBaldHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isBaldHair = value!;
                                      if(isBaldHair == true){
                                        baldHair = 'bald';
                                        debugPrint("bald Hair Selected");
                                      }
                                      else{
                                        baldHair = '';
                                        debugPrint("bald Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Salt & Pepper
                              ListTile(
                                title:  Text('Salt & Pepper',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isSaltPepperHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isSaltPepperHair = value!;
                                      if(isSaltPepperHair == true){
                                        saltPepperHair = 'saltPepper';
                                        debugPrint("saltPepper Hair Selected");
                                      }
                                      else{
                                        saltPepperHair = '';
                                        debugPrint("saltPepper Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Strawberry Blond
                              ListTile(
                                title:  Text('Strawberry Blonde',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isStrawberryBlondeHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isStrawberryBlondeHair = value!;
                                      if(isStrawberryBlondeHair == true){
                                        strawberryBlondeHair = 'strawberryBlonde';
                                        debugPrint("strawberryBlondeHair Hair Selected");
                                      }
                                      else{
                                        strawberryBlondeHair = '';
                                        debugPrint("strawberryBlondeHair Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Multicolored / Dyed
                              ListTile(
                                title:  Text('Multicolored / Dyed',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isMulticoloredHair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isMulticoloredHair = value!;
                                      if(isMulticoloredHair == true){
                                        multicoloredHair = 'multicolored';
                                        debugPrint("multicoloredHair Hair Selected");
                                      }
                                      else{
                                        multicoloredHair = '';
                                        debugPrint("multicoloredHair Hair UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      //Eye Color Tab Content
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //Black
                              ListTile(
                                title:  Text('Black',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isBlackEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isBlackEye = value!;
                                      if(isBlackEye == true){
                                        blackEye = 'black';
                                        debugPrint("Black Eye Selected");
                                      }
                                      else{
                                        blackEye = '';
                                        debugPrint("Black Eye UnSelected");
                                      }

                                    });
                                  },
                                ),
                              ),
                              //Blonde
                              ListTile(
                                title:  Text('Blonde',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isBlondeEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isBlondeEye = value!;
                                      if(isBlondeEye == true){
                                        blondeEye = 'blonde';
                                        debugPrint("Blonde Eye Selected");
                                      }
                                      else{
                                        blondeEye = '';
                                        debugPrint("Blonde Eye UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Brown
                              ListTile(
                                title:  Text('Brown',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isBrownEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isBrownEye = value!;
                                      if(isBrownEye == true){
                                        brownEye = 'brown';
                                        debugPrint("Brown Eye Selected");
                                      }
                                      else{
                                        brownEye = '';
                                        debugPrint("Brown Eye UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Auburn
                              ListTile(
                                title:  Text('Auburn',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isAuburnEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAuburnEye = value!;
                                      if(isAuburnEye == true){
                                        auburnEye = 'auburn';
                                        debugPrint("AuBurn Eye Selected");
                                      }
                                      else{
                                        auburnEye = '';
                                        debugPrint("AuBurn Eye UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //ChestNut
                              ListTile(
                                title:  Text('Chestnut',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isChestNutEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChestNutEye = value!;
                                      if(isChestNutEye == true){
                                        chestNutEye = 'chestnut';
                                        debugPrint("chestNut Eye Selected");
                                      }
                                      else{
                                        chestNutEye = '';
                                        debugPrint("chestNut Eye UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Red
                              ListTile(
                                title:  Text('Red',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isRedEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isRedEye = value!;
                                      if(isRedEye == true){
                                        redEye = 'red';
                                        debugPrint("red eye Selected");
                                      }
                                      else{
                                        redEye = '';
                                        debugPrint("red eye UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Gray
                              ListTile(
                                title:  Text('Gray',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isGrayEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isGrayEye = value!;
                                      if(isGrayEye == true){
                                        grayEye = 'gray';
                                        debugPrint("gray eye Selected");
                                      }
                                      else{
                                        grayEye = '';
                                        debugPrint("gray eye UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //White
                              ListTile(
                                title:  Text('White',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isWhiteEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isWhiteEye = value!;
                                      if(isWhiteEye == true){
                                        whiteEye = 'white';
                                        debugPrint("white eye Selected");
                                      }
                                      else{
                                        whiteEye = '';
                                        debugPrint("white eye UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Salt & Pepper
                              ListTile(
                                title:  Text('Salt & Pepper',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isSaltPepperEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isSaltPepperEye = value!;
                                      if(isSaltPepperEye == true){
                                        saltPepperEye = 'saltPepper';
                                        debugPrint("saltPepper Eye Selected");
                                      }
                                      else{
                                        saltPepperEye = '';
                                        debugPrint("saltPepper Eye UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Strawberry Blond
                              ListTile(
                                title:  Text('Strawberry Blonde',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isStrawberryBlondeEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isStrawberryBlondeEye = value!;
                                      if(isStrawberryBlondeEye == true){
                                        strawberryBlondeEye = 'strawberryBlonde';
                                        debugPrint("strawberryBlonde Eye Selected");
                                      }
                                      else{
                                        strawberryBlondeEye = '';
                                        debugPrint("strawberryBlonde eye UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Multicolored / Dyed
                              ListTile(
                                title:  Text('Multicolored / Dyed',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value:  isMulticoloredEye,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isMulticoloredEye = value!;
                                      if(isMulticoloredEye == true){
                                        multicoloredEye = 'multicolored';
                                        debugPrint("multicoloredHair eye Selected");
                                      }
                                      else{
                                        multicoloredEye = '';
                                        debugPrint("multicoloredHair eye UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Body Type Tab Content
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //Average
                              ListTile(
                                title:  Text('Average',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isAverageBody,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAverageBody = value!;
                                      if(isAverageBody == true){
                                        averageBody = 'average';
                                        debugPrint("Average Body Selected");
                                      }
                                      else{
                                        averageBody = '';
                                        debugPrint("Average Body UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Slim
                              ListTile(
                                title:  Text('Slim',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isSlimBody,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isSlimBody = value!;
                                      if(isSlimBody == true){
                                        slimBody = 'slim';
                                        debugPrint("Slim Body Selected");
                                      }
                                      else{
                                        slimBody = '';
                                        debugPrint("Slim Body UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Athletic / Toned
                              ListTile(
                                title:  Text('Athletic / Toned',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isAthleticTonedBody,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAthleticTonedBody = value!;
                                      if(isAthleticTonedBody == true){
                                        athleticTonedBody = 'athletic';
                                        debugPrint("Athletic Body Selected");
                                      }
                                      else{
                                        athleticTonedBody = '';
                                        debugPrint("Athletic Body UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Muscular
                              ListTile(
                                title:  Text('Muscular',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isMuscularBody,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isMuscularBody = value!;
                                      if(isMuscularBody == true){
                                        muscularBody = 'muscular';
                                        debugPrint("Muscular Body Selected");
                                      }
                                      else{
                                        muscularBody = '';
                                        debugPrint("Muscular Body UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Curvy
                              ListTile(
                                title:  Text('Curvy',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isCurvyBody,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCurvyBody = value!;
                                      if(isCurvyBody == true){
                                        curvyBody = 'curvy';
                                        debugPrint("Curvy Body Selected");
                                      }
                                      else{
                                        curvyBody = '';
                                        debugPrint("Curvy Body UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Heavyset / Stocky
                              ListTile(
                                title:  Text('Heavyset / Stocky',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isHeavySetBody,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isHeavySetBody = value!;
                                      if(isHeavySetBody == true){
                                        heavySetBody = 'heavyset';
                                        debugPrint("HeavySet Body Selected");
                                      }
                                      else{
                                        heavySetBody = '';
                                        debugPrint("HeavySet Body UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                              //Plus-Sized / Full-Figured
                              ListTile(
                                title:  Text('Plus-Sized / Full-Figured',style: KFontStyle.kTextStyle14Black,),
                                leading: Checkbox(
                                  value: isPlusSizedBody,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isPlusSizedBody = value!;
                                      if(isPlusSizedBody == true){
                                        plusSizedBody = 'plusSized';
                                        debugPrint("PlusSized Body Selected");
                                      }
                                      else{
                                        plusSizedBody = '';
                                        debugPrint("PlusSized Body UnSelected");
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Height
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [

                            //height slider
                            Padding(
                              padding: const EdgeInsets.all(
                                  10.0),
                              child: SfRangeSlider(
                                  activeColor: Color(KColors
                                      .kColorPrimary),
                                  inactiveColor: Color(
                                      KColors
                                          .kColorDarkGrey),
                                  trackShape:
                                  const SfTrackShape(),
                                  enableTooltip: true,
                                  showLabels: true,
                                  showTicks: true,
                                  stepSize: 1.0,
                                  min: heightMin,
                                  max: heightMax,
                                  values: heightValues,
                                  onChanged: (SfRangeValues
                                  newValues) {
                                    setState(() {
                                      heightValues =
                                          newValues;
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                      //Age
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            // Expanded(
                            //   child: TextField(
                            //     style: KFontStyle
                            //         .kTextStyle18Black,
                            //     textCapitalization:
                            //     TextCapitalization
                            //         .words,
                            //     textAlign: TextAlign.center,
                            //     controller:
                            //     bodyTypeController,
                            //     decoration: InputDecoration(
                            //       border: OutlineInputBorder(
                            //           borderRadius:
                            //           BorderRadius
                            //               .circular(14),
                            //           borderSide:
                            //           const BorderSide(
                            //               color: Colors
                            //                   .white)),
                            //       focusedBorder:
                            //       OutlineInputBorder(
                            //         borderRadius:
                            //         BorderRadius
                            //             .circular(14.0),
                            //         borderSide:
                            //         const BorderSide(
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //       enabledBorder:
                            //       OutlineInputBorder(
                            //         borderRadius:
                            //         BorderRadius
                            //             .circular(14.0),
                            //         borderSide:
                            //         const BorderSide(
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //       hintText: "Search By Age",
                            //       hintStyle: KFontStyle
                            //           .kTextStyle18Black,
                            //     ),
                            //   ),
                            // ),
                            //age slider
                            Padding(
                              padding: const EdgeInsets.all(
                                  10.0),
                              child: SfRangeSlider(
                                  activeColor: Color(KColors
                                      .kColorPrimary),
                                  inactiveColor: Color(
                                      KColors
                                          .kColorDarkGrey),
                                  trackShape:
                                  const SfTrackShape(),
                                  enableTooltip: true,
                                  showLabels: true,
                                  showTicks: true,
                                  stepSize: 1.0,
                                  min: ageMin,
                                  max: ageMax,
                                  values: ageValues,
                                  onChanged: (SfRangeValues
                                  newValues) {
                                    setState(() {
                                      ageValues = newValues;
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Filter Buttons
                Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 3.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      //Clear Button
                      GestureDetector(
                        onTap: () {
                          clearFilters();
                          filteredTalentData.clear();
                          // Get.back();
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(
                              10, 10, 10, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(14),
                            border: Border.all(
                              color: Color(
                                  KColors.kColorPrimary),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: 15,
                                    bottom: 15),
                                child: Text(
                                  "Clear",
                                  style: KFontStyle
                                      .kTextStyle16Blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Apply Button
                      GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   debugPrint("Filters are applied ");
                          //   debugPrint(countryValue);
                          //   debugPrint(stateValue);
                          //   debugPrint(cityValue);
                          //   // Get.back();
                          //   getFilteredTalent();
                          // });

                          Get.to(()=>FilteredViewScreen(male, feMale, genderNonConforming, nonBinary, transFemale, transMale, unspecified, blackHair, blondeHair, brownHair, auburnHair, chestNutHair, redHair, grayHair, whiteHair, baldHair, saltPepperHair, strawberryBlondeHair, multicoloredHair, blackEye, blondeEye, brownEye, auburnEye, chestNutEye, redEye, grayEye, whiteEye, saltPepperEye, strawberryBlondeEye, multicoloredEye, averageBody, slimBody, athleticTonedBody, muscularBody, curvyBody, heavySetBody, plusSizedBody, indian, pakistani, bangladeshi, chinese, anyOtherAsian, caribbean, african, anyOtherBlack, blackBritish, caribbeanBackground, whiteAndBlackCaribbean, whiteAndBlackAfrican, whiteAndAsian, anyOtherMixed, multipleEthnicBackground, english, welsh, scottish, northernIrish, irish, gypsy, roma, anyOtherWhiteBackground, filipino, countryValue, stateValue, heightValues, ageValues));
                          // Get.back();

                          // Navigator.pop(context);

                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(
                              10, 10, 10, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(14),
                            border: Border.all(
                              color: Color(
                                  KColors.kColorPrimary),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: 15,
                                    bottom: 15),
                                child: Text(
                                  "Apply",
                                  style: KFontStyle
                                      .kTextStyle16Blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Image.asset("assets/images/search.png",height: 32,width: 32,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // body: Container(
      //   margin: const EdgeInsets.only(top:20,right: 20,left: 20),
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: Column(
      //     children: [
      //
      //       (filteredTalentData.isNotEmpty)? Expanded(
      //         child: ListView.builder(
      //           reverse: false,
      //           keyboardDismissBehavior:
      //           ScrollViewKeyboardDismissBehavior.onDrag,
      //           itemCount: filteredTalentData.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             return ModelItem(userId: filteredTalentData.elementAt(index).userId,
      //                 firstName: filteredTalentData.elementAt(index).firstName,
      //                 lastName: filteredTalentData.elementAt(index).lastName,
      //                 email: filteredTalentData.elementAt(index).email,
      //                 profilePicture: filteredTalentData.elementAt(index).profilePicture,
      //                 dateOfBirth: filteredTalentData.elementAt(index).dateOfBirth,
      //                 gender: filteredTalentData.elementAt(index).gender,
      //                 county: filteredTalentData.elementAt(index).county,
      //                 state: filteredTalentData.elementAt(index).state,
      //                 city: filteredTalentData.elementAt(index).city,
      //                 postalCode: filteredTalentData.elementAt(index).postalCode,
      //                 drivingLicense: filteredTalentData.elementAt(index).drivingLicense,
      //                 idCard: filteredTalentData.elementAt(index).idCard,
      //                 passport: filteredTalentData.elementAt(index).passport,
      //                 otherId: filteredTalentData.elementAt(index).otherId,
      //                 country: filteredTalentData.elementAt(index).country,
      //                 hairColor: filteredTalentData.elementAt(index).hairColor,
      //                 eyeColor: filteredTalentData.elementAt(index).eyeColor,
      //                 buildType: filteredTalentData.elementAt(index).buildType,
      //                 heightCm: filteredTalentData.elementAt(index).heightCm,
      //                 heightFeet: filteredTalentData.elementAt(index).heightFeet,
      //                 waistCm: filteredTalentData.elementAt(index).waistCm,
      //                 waistInches: filteredTalentData.elementAt(index).waistInches,
      //                 weightKg: filteredTalentData.elementAt(index).weightKg,
      //                 weightPound: filteredTalentData.elementAt(index).weightPound,
      //                 wearSizeCm: filteredTalentData.elementAt(index).wearSizeCm,
      //                 wearSizeInches: filteredTalentData.elementAt(index).wearSizeInches,
      //                 chestCm: filteredTalentData.elementAt(index).chestCm,
      //                 chestInches: filteredTalentData.elementAt(index).chestInches,
      //                 hipCm: filteredTalentData.elementAt(index).hipCm,
      //                 hipInches: filteredTalentData.elementAt(index).hipInches,
      //                 inseamCm: filteredTalentData.elementAt(index).inseamCm,
      //                 inseamInches: filteredTalentData.elementAt(index).inseamInches,
      //                 shoesCm: filteredTalentData.elementAt(index).shoesCm,
      //                 shoesInches: filteredTalentData.elementAt(index).shoesInches,
      //                 scarPicture: filteredTalentData.elementAt(index).scarPicture,
      //                 tattooPicture: filteredTalentData.elementAt(index).tattooPicture,
      //                 isDrivingLicense: filteredTalentData.elementAt(index).isDrivingLicense,
      //                 isIdCard: filteredTalentData.elementAt(index).isIdCard,
      //                 isPassport: filteredTalentData.elementAt(index).isPassport,
      //                 isOtherId: filteredTalentData.elementAt(index).isOtherId,
      //                 isScar: filteredTalentData.elementAt(index).isScar,
      //                 isTattoo: filteredTalentData.elementAt(index).isTattoo,
      //                 languages: filteredTalentData.elementAt(index).languages,
      //                 sports: filteredTalentData.elementAt(index).sports,
      //                 hobbies: filteredTalentData.elementAt(index).hobbies,
      //                 talent: filteredTalentData.elementAt(index).talent,
      //                 portfolioImageLink: filteredTalentData.elementAt(index).portfolioImageLink,
      //                 portfolioVideoLink: filteredTalentData.elementAt(index).portfolioVideoLink,
      //                 polaroidImageLink: filteredTalentData.elementAt(index).polaroidImageLink,
      //                 indexNumber: index);
      //           },
      //         ),
      //       ):Center(child: Text("No Model",style: KFontStyle.kTextStyle24Black,)),
      //     ],
      //   ),
      // ),
    );
  }
}
