import 'package:flutter/material.dart';

class KFontStyle {
  static var kTextStyle24Black = const TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'NewYork');
  static var kTextStyle26Black = const TextStyle(
      fontSize: 26,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle14Black = const TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle18Black = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle16BlackRegular = const TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: 'NewYork',
      letterSpacing: 1.0);
  static var kTextStyle16White = const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle24White = const TextStyle(
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'NewYork');
  static var kTextStyle32White = const TextStyle(
      fontSize: 32,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle32WhiteNormal = const TextStyle(
      fontSize: 32,
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'NewYork');
  static var kTextStyle18White = const TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle14White = const TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle14Grey = const TextStyle(
      fontSize: 14,
      color: Color(0xff7b7b7b),
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle14Blue = const TextStyle(
      fontSize: 14,
      color: Color(0xff4B6DFC),
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle16Blue = const TextStyle(
      fontSize: 16,
      color: Color(0xff4B6DFC),
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle18Blue = const TextStyle(
      fontSize: 18,
      color: Color(0xff4B6DFC),
      fontWeight: FontWeight.w600,
      fontFamily: 'NewYork');
  static var kTextStyle12White = const TextStyle(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'NewYork');
  static var kTextStyle12Black = const TextStyle(
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'NewYork');
  static var kTextStyle10Black = const TextStyle(
      fontSize: 10,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'NewYork');

  ///SF Pro Regular 5
  static var sFProRegular5 = const TextStyle(
      color: Color(0xff242424),
      fontWeight: FontWeight.w400,
      fontFamily: "SFPro",
      fontStyle: FontStyle.normal,
      fontSize: 5.0);

  ///New York Semi bold 8
  static var newYorkSemiBold8 = const TextStyle(
      color: Color(0xff000000),
      fontWeight: FontWeight.w600,
      fontFamily: "NewYork",
      fontStyle: FontStyle.normal,
      fontSize: 8.0);

  ///New York Semi bold 10
  static var newYorkSemiBold10 = const TextStyle(
      color: Color(0xff656565),
      fontWeight: FontWeight.w600,
      fontFamily: "NewYork",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  ///New York Semi bold 22
  static var newYorkSemiBold22 = const TextStyle(
      color: Color(0xff000000),
      fontWeight: FontWeight.w600,
      fontFamily: "NewYork",
      fontStyle: FontStyle.normal,
      fontSize: 22.0);

  ///New York Bold 53
  static var newYorkBold53 = const TextStyle(
      color: Color(0xff000000),
      fontWeight: FontWeight.w700,
      fontFamily: "NewYork",
      fontStyle: FontStyle.normal,
      fontSize: 53.0);

  ///New York Regular 11
  static var newYorkRegular11 = const TextStyle(
      color: Color(0xff000000),
      fontWeight: FontWeight.w400,
      fontFamily: "NewYork",
      fontStyle: FontStyle.normal,
      fontSize: 11.0);

  ///New York Extra large 33
  static var newYorkExtraLarge33 = const TextStyle(
      color: Color(0xffffffff),
      fontWeight: FontWeight.w700,
      fontFamily: "NewYork",
      fontStyle: FontStyle.normal,
      fontSize: 33.0);
}

class KColors {
  //COLORS
  static var kColorPrimary = 0xff4B6DFC;
  static var kColorGrey = 0xff7b7b7b;
  static var kColorLightGrey = 0xffDEDBDB;
  static var kColorDarkGrey = 0xff433E3E;
  static var kColorWhite = 0xffffffff;
  static var kColorTransparent = 0x0000ffff;
}

class Strings {
  static const client = 'Client';
  static const talent = 'Talent';
  static const model = 'Model';
  static const project = 'Project';
  static const login = 'Login';
  static const signup = 'SignUp';
  static const email = 'Email';
  static const password = 'Password';
  static const confirmPassword = 'Confirm Password';
  static const firstName = 'First Name';
  static const lastName = 'Last Name';
  static const createAccount = 'Create Account';
  static const profilePicture = 'Profile Picture';
  static const chooseFromGallery = 'Choose From Gallery';
  static const chooseFromCalendar = 'Choose From Calendar';
  static const takeFromCamera = 'Take From Camera';
  static const back = 'back';
  static const dateOfBirth = 'Date of Birth';

  //Gender Parameters
  static const male = 'Male';
  static const female = 'Female';
  static const genderNonConforming = 'Gender-NonConforming';
  static const nonBinary = 'Non-Binary';
  static const transFemale = 'TransFemale';
  static const transMale = 'TransMale';
  static const unspecified = 'Unspecified';
  static const other = 'Other';
  static const gender = 'Gender';

  //Address Parameters
  static const address = 'Address';
  static const county = 'County';
  static const state = 'State';
  static const city = 'City';
  static const postalCode = 'Postal Code';
  static const identity = 'Identity';
  static const drivingLicense = 'Driving License';
  static const idCard = 'ID Card';
  static const passport = 'Passport';
  static const metric = 'Metric';
  static const imperial = 'Imperial';
  static const eu = 'EU';
  static const american = 'American';
  static const termsAndConditions = 'Terms & Conditions';
  static const whereAreYouFrom = 'Where are you from?';
  static const whatIsYourHairColor = 'What is your hair color?';
  static const whatIsYourEyeColor = 'What is your eye color?';
  static const whatIsYourHeight = 'What is your height?';
  static const whatIsYourWaist = 'What is your waist?';
  static const whatIsYourWeight = 'What is your weight?';
  static const whatIsYourBuildType = 'What is your build type?';
  static const whatSizeDoYouWear = 'What size do you wear?';
  static const whatLanguagesDoYouSpeak = 'What languages do you speak?';
  static const whatSportsDoYouPlay = 'What sports do you play?';
  static const whatAreYourHobbies = 'What are your hobbies?';
  static const whatAreYourTalents = 'What are your talents?';
  static const doYouHaveAnyScars = 'Do you have any scars?';
  static const doYouHaveAnyTattoos = 'Do you have any Tattoos?';
  static const chest = 'Chest';
  static const hips = 'Hips';
  static const inseam = 'Inseam';
  static const shoe = 'Shoe';
  static const portfolio = 'Portfolio';
  static const polaroids = 'Polaroids';
  static const videos = 'Videos';
  static const uploadVideo = 'Upload video';
  static const help = 'Help';
  static const attachPicture = 'Attach Picture';
  static const no = 'No';
  static const yes = 'Yes';
  static const jobProposals = 'Job Proposals';
  static const availability = 'Availability';
  static const chat = 'Chat';
  static const pendingOffers = 'Pending Offers';
  static const settings = 'Settings';
  static const editProfile = 'Edit Profile';
  static const archiveProjects = 'Archive Projects';
  static const deleteAccount = 'Delete Account';
  static const logout = 'Logout';
  static const createClientAccount = 'Create Client Account';
  static const clientName = 'Client Name';
  static const clientPhoneNumber = 'Client Phone Number';
  static const companyEmail = 'Client Email';
  static const dunsNumber = 'DUNS Number';
  static const taxId = 'Tax ID';
  static const home = 'Home';
  static const projectFolder = 'Project Folder';
  static const lookingFor = 'Looking For';
  static const createProjectFolder = 'Create Project Folder';
  static const typeTheNameOfProject = 'Type the name of project';
  static const whatIsTheBudgetOfTheProject =
      'What is the budget of the project?';
  static const whenDoYouNeedTheTalent = 'When do you need the talent?';
  static const whereDoYouNeedTheTalent = 'Where do you need the talent?';
  static const fromDate = 'From Date';
  static const tillDate = 'Till Date';
  static const chooseLocationOnMap = 'Choose Location on Map';
  static const lastRouteKey = 'last_route';
  static const bookNow = 'Book Now';
  static const sendOffer = 'Send Offer';
  static const send = 'Send';
  static const firstOption = '1st';
  static const secondOption = '2nd';
  static const ignore = 'Ignore';
  static const accept = 'Accept';
  static const kContinue = 'Continue';
  static const camera = 'Camera';
  static const gallery = 'Gallery';
  static const addNewSection = 'Add new section';
  static const kBack = 'Back';
  static const renameProject = 'Rename Project';
  static const editDates = 'Edit Dates';
  static const editBudget = 'Edit Budget';
  static const deleteProject = 'Delete Project';
}

class KImages {
  static var logo = "assets/images/logo.png";
  static var backward = "assets/images/backward.png";
  static var forward = "assets/images/forward.png";
  static var email = "assets/images/email.png";
  static var password = "assets/images/password.png";
  static var check = "assets/images/check.png";
}

enum HairColor {
  blonde,
  black,
  brown,
  auburn,
  chestnut,
  red,
  gray,
  white,
  bald,
  saltPepper,
  strawberryBlonde,
  multicolored
}

enum EyeColor {
  blonde,
  black,
  brown,
  auburn,
  chestnut,
  red,
  gray,
  white,
  bald,
  saltPepper,
  strawberryBlonde,
  multicolored
}

enum MeasurementUnit { cm, inch, feet, kg, pound }

enum BuildType { average, slim, athletic, muscular, curvy, heavyset, plusSized }

enum Sports { cricket, football, basketball, badminton, squash }

enum Gender { male, female, other }

enum BloodType {
  aPositive,
  aNegative,
  bPositive,
  bNegative,
  abPositive,
  abNegative,
  oPositive,
  oNegative
}

enum Ethnicity{asian,african,american,korean,pakistani,indian,chinese}
