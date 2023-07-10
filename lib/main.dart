
import 'package:beautyshot/Views/client_talent_screen.dart';
import 'package:beautyshot/Views/splash_screen.dart';
import 'package:beautyshot/Views/talent_screens/address_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:beautyshot/Views/talent_screens/build_type_screen.dart';
import 'package:beautyshot/Views/talent_screens/chest_screen.dart';
import 'package:beautyshot/Views/talent_screens/country_screen.dart';
import 'package:beautyshot/Views/talent_screens/date_of_birth_screen.dart';
import 'package:beautyshot/Views/talent_screens/done_screen.dart';
import 'package:beautyshot/Views/talent_screens/eye_color_screen.dart';
import 'package:beautyshot/Views/talent_screens/gender_screen.dart';
import 'package:beautyshot/Views/talent_screens/hair_color_screen.dart';
import 'package:beautyshot/Views/talent_screens/height_screen.dart';
import 'package:beautyshot/Views/talent_screens/hip_screen.dart';
import 'package:beautyshot/Views/talent_screens/hobbies_screen.dart';
import 'package:beautyshot/Views/talent_screens/identity_screen.dart';
import 'package:beautyshot/Views/talent_screens/inseam_screen.dart';
import 'package:beautyshot/Views/talent_screens/language_screen.dart';
import 'package:beautyshot/Views/talent_screens/polaroids_screen.dart';
import 'package:beautyshot/Views/talent_screens/portfolio_screen.dart';
import 'package:beautyshot/Views/talent_screens/profile_picture_screen.dart';
import 'package:beautyshot/Views/talent_screens/scars_screen.dart';
import 'package:beautyshot/Views/talent_screens/shoe_screen.dart';
import 'package:beautyshot/Views/talent_screens/sports_screen.dart';
import 'package:beautyshot/Views/talent_screens/talent_login_screen.dart';
import 'package:beautyshot/Views/talent_screens/talent_screen.dart';
import 'package:beautyshot/Views/talent_screens/talent_signup_screen.dart';
import 'package:beautyshot/Views/talent_screens/tattoos_screen.dart';
import 'package:beautyshot/Views/talent_screens/wear_size_screen.dart';
import 'package:beautyshot/Views/talent_screens/weight_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:firebase_core/firebase_core.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Views/talent_screens/terms_and_conditions_screen.dart';
import 'Views/talent_screens/waist_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? lastRoute;
  if(preferences.getString(Strings.lastRouteKey) == null){
    lastRoute = '/';
  }
   else{
     lastRoute = preferences.getString(Strings.lastRouteKey);
  }
  runApp( MyApp(lastRoute!));
}

class MyApp extends StatelessWidget {
  final String lastRoute;

  const MyApp(this.lastRoute, {Key? key}) : super(key: key); // const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, widget) => ResponsiveBreakpoints.builder(
          // BouncingScrollWrapper.builder(context, widget!),
          // maxWidth: 1200,
          // minWidth: 480,
          // defaultScale: true,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          child: Container(color: const Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.grey),
      title: 'Beauty Shot',
      // theme: ThemeData(fontFamily: 'NewYork', primarySwatch: Colors.blue,),
      initialRoute: lastRoute,
      routes: {
        '/':(context)=> const SplashScreen(),
        '/clientTalentScreen':(context)=>const ClientTalentScreen(),
        '/talentSignup':(context)=>const TalentSignUpScreen(),
        '/talentLogin':(context)=>const TalentLoginScreen(),
        '/talentProfilePictureScreen':(context)=>const ProfilePictureScreen(),
        '/talentDateOfBirth':(context)=>const DateOfBirthScreen(),
        '/talentGender':(context)=>const GenderScreen(),
        '/talentAddress':(context)=>const AddressScreen(),
        '/talentIdentity':(context)=>const IdentityScreen(),
        '/termsAndConditions':(context)=>const TermsAndConditions(),
        '/doneScreen':(context)=>const DoneScreen(),
        '/countryScreen':(context)=>const CountryScreen(),
        '/hairColorScreen':(context)=>const HairColorScreen(),
        '/eyeColorScreen':(context)=>const EyeColorScreen(),
        '/heightScreen':(context)=>const HeightScreen(),
        '/waistScreen':(context)=>const WaistScreen(),
        '/weightScreen':(context)=>const WeightScreen(),
        '/buildTypeScreen':(context)=>const BuildTypeScreen(),
        '/wearSizeScreen':(context)=>const WearSizeScreen(),
        '/chestScreen':(context)=>const ChestScreen(),
        '/hipScreen':(context)=>const HipScreen(),
        '/inseamScreen':(context)=>const InseamScreen(),
        '/shoeScreen':(context)=>const ShoeScreen(),
        '/languageScreen':(context)=>const LanguageScreen(),
        '/sportsScreen':(context)=>const SportsScreen(),
        '/hobbiesScreen':(context)=>const HobbiesScreen(),
        '/talentScreen':(context)=>const TalentScreen(),
        '/portfolioScreen':(context)=>const PortfolioScreen(),
        '/polaroidScreen':(context)=>const PolaroidsScreen(),
        '/scarsScreen':(context)=>const ScarsScreen(),
        '/tattooScreen':(context)=>const TattoosScreen(),
      },
      // home: const SplashScreen(),
    );
  }
}

