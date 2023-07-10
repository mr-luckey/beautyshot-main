import 'dart:async';
import 'package:beautyshot/Views/talent_screens/hair_color_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:delayed_display/delayed_display.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen( {Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String country;
  String? massageText;
   String firstName = "";
  bool isVisible = false;
  TextEditingController countryController = TextEditingController();


  @override
  void initState() {
    super.initState();
    setInitialValues();
    startTime();
    persistLastRoute('/countryScreen');

  }
  startTime() async {
    var duration = const Duration(milliseconds: 500);
    return Timer(duration, setVisibility);
  }

  setVisibility(){
    setState(() {
      isVisible = true;
    });
  }

  onForwardPress()async{
  country = countryController.text.toString();

  if(country.isEmpty){
    // print("show error message");
    Fluttertoast.showToast(
        msg: "Please select your country",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  else{
    SharedPreferences prefs = await _prefs;
    prefs.setString('country', country);
    Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const HairColorScreen(),duration: const Duration(milliseconds: 500)));
    // Get.to(()=>const HairColorScreen());
  }
}
  void persistLastRoute(String routeName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Strings.lastRouteKey, routeName);
  }
  setInitialValues() async{
    SharedPreferences prefs = await _prefs;
    prefs.getString('firstName');
    if(prefs.getString('firstName') != null){
      firstName = prefs.getString('firstName')!.capitalizeFirst.toString();
    }

    if(prefs.getString('country') != null) {
      countryController.text = prefs.getString('country')!;
    }else{
      country = "";
    }

  }
  Future<bool> _willPopCallback() async {
    SystemNavigator.pop();
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

              // TopRow(1, 19),

                //Body
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 250),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Material(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                  // bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),
                                elevation: 5.0,
                                color:Colors.white,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  child: Text("Hi $firstName",
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Material(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                  // bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),
                                elevation: 5.0,
                                color:Colors.white,
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  child: Text("Where are you from?",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,),

                      AnimatedSwitcher(duration: const Duration(milliseconds: 500),
                      child: isVisible?DelayedDisplay(
                        delay: const Duration(milliseconds: 500),
                        child: Column(children: [
                          Container(
                            // margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      showCountryPicker(
                                        context: context,
                                        showPhoneCode: false, // optional. Shows phone code before the country name.
                                        onSelect: (Country country) {
                                          setState(() {
                                            countryController.text = country.name.toString();
                                          });
                                          // print('Select country: ${country.displayName}');
                                        },
                                      );
                                    },
                                    child: TextField(
                                      enabled: false,
                                      controller: countryController,
                                      onChanged: (value) {
                                        massageText = value;
                                      },
                                      decoration: const InputDecoration(

                                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                          hintText: 'Where are you from',
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ForwardButton(onForwardPress)
                          Buttons.forwardButton(onForwardPress),
                        ],),
                      ):Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 30,bottom: 30),
                            child: LoadingAnimationWidget.waveDots(
                              color: Colors.black,
                              size: 50,
                            ),
                          ),
                        ],
                      ),),
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

