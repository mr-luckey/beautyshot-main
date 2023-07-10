import 'package:beautyshot/Views/talent_screens/gender_screen.dart';
import 'package:beautyshot/Views/talent_screens/identity_screen.dart';
import 'package:beautyshot/components/rounded_text_field.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

late String county ;
late String state ;
late String city ;
late String postalCode ;
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController countyController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  onForwardPress()async{
    SharedPreferences prefs = await _prefs;
    county = countyController.text.toString();
    state = stateController.text.toString();
    city = cityController.text.toString();
    postalCode = postalCodeController.text.toString();

    prefs.setString('county', county);
    prefs.setString('state', state);
    prefs.setString('city', city);
    prefs.setString('postalCode', postalCode);

    Get.to(()=>const IdentityScreen());
  }


setInitialValues() async{
  SharedPreferences prefs = await _prefs;

  if(prefs.getString('county') != null){
    countyController.text = prefs.getString('county')!;
  }
  if(prefs.getString('state') != null) {
    stateController.text = prefs.getString('state')!;
  }
  if(prefs.getString('city') != null) {
    cityController.text = prefs.getString('city')!;
  }
  if(prefs.getString('postalCode') != null) {
    postalCodeController.text = prefs.getString('postalCode')!;
  }
}
void persistLastRoute(String routeName) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(Strings.lastRouteKey, routeName);
}

@override
  void initState() {
    super.initState();
    setInitialValues();
    persistLastRoute('/talentAddress');
  }
Future<bool> _willPopCallback() async {
  Get.to(()=>const GenderScreen());
  return false;
  // return true if the route to be popped
}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Top Row
                TopRow(5, 1),
                //Body
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text Create Account
                     TitleText(Strings.address),
                      //SizedBox
                     const SizedBox(height: 30,),
                      //County
                     RoundedTextField(controller:countyController, title:Strings.county),
                      //State
                     RoundedTextField(controller:stateController,title:Strings.state),
                      //City
                     RoundedTextField(controller:cityController, title:Strings.city),
                      //Postal Code
                      RoundedTextField(controller:postalCodeController,title: Strings.postalCode),
                      //SizedBox
                      const SizedBox(height: 20,),
                      //Back and Forward Button
                      // BackForwardButton(onForwardPress),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>const GenderScreen());
                            },
                            child: Container(
                              height: 56,
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                color: Color(KColors.kColorWhite),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Color(KColors.kColorPrimary),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40.0,right: 40,top: 20,bottom: 20),
                                child: Center(child: Text(Strings.back,style: KFontStyle.kTextStyle14Blue,)),
                              ),
                            ),
                          ),
                          //Forward Button
                          GestureDetector(
                            onTap: onForwardPress,
                            child: const Icon(Icons.navigate_next_rounded,size: 52,),
                          ),
                        ],)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
