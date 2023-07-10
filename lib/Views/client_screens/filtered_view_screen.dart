import 'package:beautyshot/components/model_Item.dart';
import 'package:beautyshot/model/talent_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilteredViewScreen extends StatefulWidget {

  final String male, feMale,genderNonConforming,nonBinary,transFemale,transMale,unspecified,blackHair,blondeHair,brownHair
  ,auburnHair,chestNutHair,redHair,grayHair,whiteHair,baldHair,saltPepperHair,strawberryBlondeHair,multicoloredHair,
      blackEye,blondeEye,brownEye,auburnEye,chestNutEye,redEye,grayEye,whiteEye,saltPepperEye,strawberryBlondeEye,multicoloredEye,
      averageBody,slimBody,athleticTonedBody,muscularBody,curvyBody,heavySetBody,plusSizedBody,indian,pakistani,bangladeshi,
      chinese,anyOtherAsian,caribbean,african,anyOtherBlack,blackBritish,caribbeanBackground,whiteAndBlackCaribbean,whiteAndBlackAfrican,
      whiteAndAsian,anyOtherMixed,multipleEthnicBackground,english,welsh,scottish,northernIrish,irish,gypsy,roma,anyOtherWhiteBackground,
      filipino,countryValue,stateValue;
  SfRangeValues heightValues, ageValues;


  FilteredViewScreen(
      this.male,
      this.feMale,
      this.genderNonConforming,
      this.nonBinary,
      this.transFemale,
      this.transMale,
      this.unspecified,
      this.blackHair,
      this.blondeHair,
      this.brownHair,
      this.auburnHair,
      this.chestNutHair,
      this.redHair,
      this.grayHair,
      this.whiteHair,
      this.baldHair,
      this.saltPepperHair,
      this.strawberryBlondeHair,
      this.multicoloredHair,
      this.blackEye,
      this.blondeEye,
      this.brownEye,
      this.auburnEye,
      this.chestNutEye,
      this.redEye,
      this.grayEye,
      this.whiteEye,
      this.saltPepperEye,
      this.strawberryBlondeEye,
      this.multicoloredEye,
      this.averageBody,
      this.slimBody,
      this.athleticTonedBody,
      this.muscularBody,
      this.curvyBody,
      this.heavySetBody,
      this.plusSizedBody,
      this.indian,
      this.pakistani,
      this.bangladeshi,
      this.chinese,
      this.anyOtherAsian,
      this.caribbean,
      this.african,
      this.anyOtherBlack,
      this.blackBritish,
      this.caribbeanBackground,
      this.whiteAndBlackCaribbean,
      this.whiteAndBlackAfrican,
      this.whiteAndAsian,
      this.anyOtherMixed,
      this.multipleEthnicBackground,
      this.english,
      this.welsh,
      this.scottish,
      this.northernIrish,
      this.irish,
      this.gypsy,
      this.roma,
      this.anyOtherWhiteBackground,
      this.filipino,
      this.countryValue,
      this.stateValue,
      this.heightValues,
      this.ageValues, {Key? key}) : super(key: key);

  @override
  State<FilteredViewScreen> createState() => _FilteredViewScreenState();
}

class _FilteredViewScreenState extends State<FilteredViewScreen> {

  List<TalentModel> talentData = <TalentModel>[];
  List<TalentModel> filteredTalentData = <TalentModel>[];

  String countryValue = '';
  String cityValue = '';
  String stateValue = '';
  SfRangeValues heightValues = const SfRangeValues(4, 6);
  SfRangeValues ageValues = const SfRangeValues(20, 40);
  bool isDidChangeRunningOnce = true;
  List <String> GenderList = [];
  List <String> HairColorList = [];
  List <String> EyeColorList = [];

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
      // getAllTalent();
      getAllTalent();
      getFilteredTalent();
      isDidChangeRunningOnce = false;
    }
  }


  @override
  void initState() {
    super.initState();
    male = widget.male;
    feMale = widget.feMale;
    genderNonConforming = widget.genderNonConforming;
    nonBinary = widget.nonBinary;
    transFemale = widget.transFemale;
    transMale = widget.transMale;
    unspecified = widget.unspecified;
    blackHair = widget.blackHair;
    blondeHair = widget.blondeHair;
    brownHair = widget.brownHair;
    auburnHair = widget.auburnHair;
    chestNutHair = widget.chestNutHair;
    redHair = widget.redHair;
    grayHair = widget.grayHair;
    whiteHair = widget.whiteHair;
    baldHair = widget.baldHair;
    saltPepperHair = widget.saltPepperHair;
    strawberryBlondeHair = widget.strawberryBlondeHair;
    multicoloredHair = widget.multicoloredHair;

    blackEye = widget.blackEye;
    blondeEye = widget.blondeEye;
    brownEye = widget.brownEye;
    auburnEye =widget.auburnEye;
    chestNutEye = widget.chestNutEye;
    redEye = widget.redEye;
    grayEye = widget.grayEye;
    whiteEye = widget.whiteEye;
    saltPepperEye = widget.saltPepperEye;
    strawberryBlondeEye = widget.strawberryBlondeEye;
    multicoloredEye = widget.multicoloredEye;

    averageBody = widget.averageBody;
    slimBody = widget.slimBody;
    athleticTonedBody = widget.athleticTonedBody;
    muscularBody = widget.muscularBody;
    curvyBody = widget.curvyBody;
    heavySetBody = widget.heavySetBody;
    plusSizedBody = widget.plusSizedBody;

    indian = widget.indian;
    pakistani = widget.pakistani;
    bangladeshi = widget.bangladeshi;
    chinese = widget.chinese;
    anyOtherAsian = widget.anyOtherAsian;
    caribbean = widget.caribbean;
    african = widget.african;
    anyOtherBlack = widget.anyOtherBlack;
    blackBritish = widget.blackBritish;
    caribbeanBackground = widget.caribbeanBackground;
    whiteAndBlackCaribbean = widget.whiteAndBlackCaribbean;
    whiteAndBlackAfrican = widget.whiteAndBlackAfrican;
    whiteAndAsian = widget.whiteAndAsian;
    anyOtherMixed = widget.anyOtherMixed;
    multipleEthnicBackground = widget.multipleEthnicBackground;
    english = widget.english;
    welsh =widget.welsh;
    scottish = widget.scottish;
    northernIrish = widget.northernIrish;
    irish = widget.irish;
    gypsy = widget.gypsy;
    roma = widget.roma;
    anyOtherWhiteBackground = widget.anyOtherWhiteBackground;
    filipino = widget.filipino;

     countryValue = widget.countryValue;

    stateValue = widget.stateValue;
     heightValues = widget.heightValues;
     ageValues = widget.ageValues;




  }

  ///Gender Filter parameters
  late String male ;
  String feMale = '';
  String genderNonConforming = '';
  String nonBinary = '';
  String transFemale = '';
  String transMale = '';
  String unspecified = '';

  ///Hair Color Filter parameters
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

  ///Eye Color Filter Parameters
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

  ///Body Type Filter Parameter
  String averageBody = '';
  String slimBody = '';
  String athleticTonedBody = '';
  String muscularBody = '';
  String curvyBody = '';
  String heavySetBody = '';
  String plusSizedBody = '';

  ///Ethnicity
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


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: (){
              Get.back();
            },
              child: Icon(Icons.arrow_back_ios,color: const Color(0xff4b6dfc),)),
          title: Text("Filters",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Color(0xff000000)),),
        ),
        body: Container(
          margin: const EdgeInsets.only(top:20,right: 20,left: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: getFilteredTalent(),
              builder: (context,snapshot){
            return ListView.builder(
                reverse: false,
                itemCount: filteredTalentData.length,
                itemBuilder: (BuildContext context, int index){
                  return ModelItem(userId: filteredTalentData.elementAt(index).userId,
                      firstName: filteredTalentData.elementAt(index).firstName,
                      lastName: filteredTalentData.elementAt(index).lastName,
                      email: filteredTalentData.elementAt(index).email,
                      profilePicture: filteredTalentData.elementAt(index).profilePicture,
                      dateOfBirth: filteredTalentData.elementAt(index).dateOfBirth,
                      gender: filteredTalentData.elementAt(index).gender,
                      county: filteredTalentData.elementAt(index).county,
                      state: filteredTalentData.elementAt(index).state,
                      city: filteredTalentData.elementAt(index).city,
                      postalCode: filteredTalentData.elementAt(index).postalCode,
                      drivingLicense: filteredTalentData.elementAt(index).drivingLicense,
                      idCard: filteredTalentData.elementAt(index).idCard,
                      passport: filteredTalentData.elementAt(index).passport,
                      otherId: filteredTalentData.elementAt(index).otherId,
                      country: filteredTalentData.elementAt(index).country,
                      hairColor: filteredTalentData.elementAt(index).hairColor,
                      eyeColor: filteredTalentData.elementAt(index).eyeColor,
                      buildType: filteredTalentData.elementAt(index).buildType,
                      heightCm: filteredTalentData.elementAt(index).heightCm,
                      heightFeet: filteredTalentData.elementAt(index).heightFeet,
                      waistCm: filteredTalentData.elementAt(index).waistCm,
                      waistInches: filteredTalentData.elementAt(index).waistInches,
                      weightKg: filteredTalentData.elementAt(index).weightKg,
                      weightPound: filteredTalentData.elementAt(index).weightPound,
                      wearSizeCm: filteredTalentData.elementAt(index).wearSizeCm,
                      wearSizeInches: filteredTalentData.elementAt(index).wearSizeInches,
                      chestCm: filteredTalentData.elementAt(index).chestCm,
                      chestInches: filteredTalentData.elementAt(index).chestInches,
                      hipCm: filteredTalentData.elementAt(index).hipCm,
                      hipInches: filteredTalentData.elementAt(index).hipInches,
                      inseamCm: filteredTalentData.elementAt(index).inseamCm,
                      inseamInches: filteredTalentData.elementAt(index).inseamInches,
                      shoesCm: filteredTalentData.elementAt(index).shoesCm,
                      shoesInches: filteredTalentData.elementAt(index).shoesInches,
                      scarPicture: filteredTalentData.elementAt(index).scarPicture,
                      tattooPicture: filteredTalentData.elementAt(index).tattooPicture,
                      isDrivingLicense: filteredTalentData.elementAt(index).isDrivingLicense,
                      isIdCard: filteredTalentData.elementAt(index).isIdCard,
                      isPassport: filteredTalentData.elementAt(index).isPassport,
                      isOtherId: filteredTalentData.elementAt(index).isOtherId,
                      isScar: filteredTalentData.elementAt(index).isScar,
                      isTattoo: filteredTalentData.elementAt(index).isTattoo,
                      languages: filteredTalentData.elementAt(index).languages,
                      sports: filteredTalentData.elementAt(index).sports,
                      hobbies: filteredTalentData.elementAt(index).hobbies,
                      talent: filteredTalentData.elementAt(index).talent,
                      portfolioImageLink: filteredTalentData.elementAt(index).portfolioImageLink,
                      portfolioVideoLink: filteredTalentData.elementAt(index).portfolioVideoLink,
                      polaroidImageLink: filteredTalentData.elementAt(index).polaroidImageLink,
                      indexNumber: index);
            });
          }),
          // child: Column(
          //   children: [
          //     (filteredTalentData.isNotEmpty)? Expanded(
          //       child: ListView.builder(
          //         reverse: false,
          //         keyboardDismissBehavior:
          //         ScrollViewKeyboardDismissBehavior.onDrag,
          //         itemCount: filteredTalentData.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return ModelItem(userId: filteredTalentData.elementAt(index).userId,
          //               firstName: filteredTalentData.elementAt(index).firstName,
          //               lastName: filteredTalentData.elementAt(index).lastName,
          //               email: filteredTalentData.elementAt(index).email,
          //               profilePicture: filteredTalentData.elementAt(index).profilePicture,
          //               dateOfBirth: filteredTalentData.elementAt(index).dateOfBirth,
          //               gender: filteredTalentData.elementAt(index).gender,
          //               county: filteredTalentData.elementAt(index).county,
          //               state: filteredTalentData.elementAt(index).state,
          //               city: filteredTalentData.elementAt(index).city,
          //               postalCode: filteredTalentData.elementAt(index).postalCode,
          //               drivingLicense: filteredTalentData.elementAt(index).drivingLicense,
          //               idCard: filteredTalentData.elementAt(index).idCard,
          //               passport: filteredTalentData.elementAt(index).passport,
          //               otherId: filteredTalentData.elementAt(index).otherId,
          //               country: filteredTalentData.elementAt(index).country,
          //               hairColor: filteredTalentData.elementAt(index).hairColor,
          //               eyeColor: filteredTalentData.elementAt(index).eyeColor,
          //               buildType: filteredTalentData.elementAt(index).buildType,
          //               heightCm: filteredTalentData.elementAt(index).heightCm,
          //               heightFeet: filteredTalentData.elementAt(index).heightFeet,
          //               waistCm: filteredTalentData.elementAt(index).waistCm,
          //               waistInches: filteredTalentData.elementAt(index).waistInches,
          //               weightKg: filteredTalentData.elementAt(index).weightKg,
          //               weightPound: filteredTalentData.elementAt(index).weightPound,
          //               wearSizeCm: filteredTalentData.elementAt(index).wearSizeCm,
          //               wearSizeInches: filteredTalentData.elementAt(index).wearSizeInches,
          //               chestCm: filteredTalentData.elementAt(index).chestCm,
          //               chestInches: filteredTalentData.elementAt(index).chestInches,
          //               hipCm: filteredTalentData.elementAt(index).hipCm,
          //               hipInches: filteredTalentData.elementAt(index).hipInches,
          //               inseamCm: filteredTalentData.elementAt(index).inseamCm,
          //               inseamInches: filteredTalentData.elementAt(index).inseamInches,
          //               shoesCm: filteredTalentData.elementAt(index).shoesCm,
          //               shoesInches: filteredTalentData.elementAt(index).shoesInches,
          //               scarPicture: filteredTalentData.elementAt(index).scarPicture,
          //               tattooPicture: filteredTalentData.elementAt(index).tattooPicture,
          //               isDrivingLicense: filteredTalentData.elementAt(index).isDrivingLicense,
          //               isIdCard: filteredTalentData.elementAt(index).isIdCard,
          //               isPassport: filteredTalentData.elementAt(index).isPassport,
          //               isOtherId: filteredTalentData.elementAt(index).isOtherId,
          //               isScar: filteredTalentData.elementAt(index).isScar,
          //               isTattoo: filteredTalentData.elementAt(index).isTattoo,
          //               languages: filteredTalentData.elementAt(index).languages,
          //               sports: filteredTalentData.elementAt(index).sports,
          //               hobbies: filteredTalentData.elementAt(index).hobbies,
          //               talent: filteredTalentData.elementAt(index).talent,
          //               portfolioImageLink: filteredTalentData.elementAt(index).portfolioImageLink,
          //               portfolioVideoLink: filteredTalentData.elementAt(index).portfolioVideoLink,
          //               polaroidImageLink: filteredTalentData.elementAt(index).polaroidImageLink,
          //               indexNumber: index);
          //         },
          //       ),
          //     ):Center(child: Text("No Model",style: KFontStyle.kTextStyle24Black,)),
          //   ],
          // ),
        ),
      ),
    );
  }
}
