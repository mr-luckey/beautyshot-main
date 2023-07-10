import 'dart:async';
import 'package:beautyshot/Views/talent_screens/waist_screen.dart';
import 'package:beautyshot/components/buttons.dart';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen( {Key? key}) : super(key: key);

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  MeasurementUnit hUnit = MeasurementUnit.cm ;
  var heightUnit = MeasurementUnit.cm.toString().split('.').last;

   // double height = 0.0;
   // double heightForConversion = 0.0;
   double heightFeet = 0.0;
   double heightCm = 0.0;

   String firstName = "";

  TextEditingController heightController = TextEditingController();

  String? massageText;
  bool isVisible = false;


  @override
  void initState() {
    super.initState();
    setInitialValues();
    startTime();

  }
  setInitialValues() async{
    SharedPreferences prefs = await _prefs;
    prefs.getString('firstName');
    if(prefs.getString('firstName') != null){
      // firstName = prefs.getString('firstName')!;
      firstName = prefs.getString('firstName')!.capitalizeFirst.toString();
    }
  }
  startTime() async {
    var duration = const Duration(milliseconds: 500);
    return Timer(duration, setVisibility);
  }


  setVisibility() {
    setState(() {
      isVisible = true;
    });
  }


  onForwardPress() async {
    if(heightCm == 0.0){

      Fluttertoast.showToast(
          msg: "Enter valid height",
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
     debugPrint("Height Cm $heightCm");
     debugPrint("Height Feet $heightFeet");
      prefs.setDouble('heightCm', heightCm);
      prefs.setDouble('heightFeet', heightFeet);
      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const WaistScreen(),duration: const Duration(milliseconds: 500)));
    }
  }

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Top Row
              // TopRow(4, 16),
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
                                child: Text("What is your height?",
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
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: isVisible ? DelayedDisplay(
                        delay: const Duration(milliseconds: 500),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0,bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    Strings.metric,
                                    style: KFontStyle.kTextStyle14Black,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  FlutterSwitch(
                                      value: status,
                                      activeColor: Color(KColors.kColorPrimary),
                                      inactiveColor: Color(KColors.kColorWhite),
                                      inactiveToggleColor: Color(KColors.kColorPrimary),
                                      activeToggleColor: Color(KColors.kColorWhite),
                                      inactiveSwitchBorder: Border.all(
                                        color: Color(KColors.kColorPrimary),
                                        width: 1.0,
                                      ),
                                      width: 50.0,
                                      height: 25.0,
                                      onToggle: (val) {
                                        setState(() {
                                          status = val;
                                          if(!val){
                                            heightUnit = MeasurementUnit.cm.toString().split('.').last;
                                            // heightCm = heightForConversion ;
                                            // heightCm  = heightFeet * 30.48;
                                            heightController.text = heightCm.toStringAsFixed(2);

                                            debugPrint("Height Cm $heightCm");
                                          }
                                          else{
                                            heightUnit = MeasurementUnit.feet.toString().split('.').last;

                                            // heightFeet = heightForConversion * 0.39 ;
                                            // heightFeet = heightCm / 30.48 ;
                                            heightController.text = heightFeet.toStringAsFixed(2);

                                            debugPrint("Height Feet $heightFeet");
                                          }
                                        });
                                      }),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    Strings.imperial,
                                    style: KFontStyle.kTextStyle14Black,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        //If cm is selected
                                        if(status == false){
                                          Picker(
                                              adapter: NumberPickerAdapter(data: [
                                                const NumberPickerColumn(begin: 0, end: 999,suffix: Text(" Cm")),
                                                // const NumberPickerColumn(begin: 0, end: 999),
                                              ]),
                                              // delimiter: [
                                              //   PickerDelimiter(child: Container(
                                              //     width: 10.0,
                                              //     alignment: Alignment.center,
                                              //     child: Icon(Icons.more_vert),
                                              //   ))
                                              // ],
                                              hideHeader: false,
                                              title: const Center(
                                                  child: Text("Height")),
                                              onConfirm: (Picker picker, List value) {
                                                setState(() {
                                                  heightController.text = value.toString().substring(1,value.toString().length-1) ;
                                                  // heightForConversion = double.parse(value.toString().substring(1,value.toString().length-1));
                                                  heightCm = double.parse(heightController.text) ;
                                                  heightFeet = heightCm / 30.48 ;
                                                });
                                              }).showModal(context);
                                        }
                                        //If feet is selected
                                        else{
                                          Picker(
                                              adapter: NumberPickerAdapter(data: [
                                                 const NumberPickerColumn(begin: 0, end: 15,suffix: Text(" Feet")),
                                                const NumberPickerColumn(begin: 0, end: 12,suffix: Text(" Inches")),
                                              ]),
                                              delimiter: [
                                                PickerDelimiter(child: Container(
                                                  width: 10.0,
                                                  alignment: Alignment.center,
                                                  child: Icon(Icons.more_vert),
                                                ))
                                              ],
                                              hideHeader: false,
                                              title: const Center(
                                                  child: Text("Height")),
                                              onConfirm: (Picker picker, List value) {
                                                setState(() {
                                                  // heightController.text = value.toString() ;
                                                  // heightForConversion = double.parse(value.toString().substring(1,value.toString().length-1));
                                                  // heightCm = heightForConversion ;
                                                  // heightFeet = heightCm / 30.48 ;

                                                  final split = value.toString().split(',');
                                                  debugPrint(split[0].substring(1)+"."+split[1].substring(1,2));
                                                  heightController.text = split[0].substring(1)+"."+split[1].substring(1,2);
                                                  heightFeet = double.parse(heightController.text.toString());
                                                  heightCm = heightFeet * 30.48;

                                                    // for (int i = 0; i < split.length; i++) {
                                                    //   // split[i].replaceAll(' ', '');
                                                    //   debugPrint(split[i]);
                                                    //
                                                    // }

                                                  // debugPrint(heightFeet.toString());
                                                });
                                              }).showModal(context);
                                        }

                                      },
                                      child: TextField(
                                        enabled: false,
                                        controller: heightController,
                                        onChanged: (value) {
                                          massageText = value;
                                        },
                                        decoration:  InputDecoration(
                                            contentPadding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 20.0),
                                            hintText: 'Select height',
                                            suffixText: heightUnit,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ForwardButton(onForwardPress)
                            Buttons.forwardButton(onForwardPress),
                          ],
                        ),
                      ): Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 50,bottom: 50),
                            child: LoadingAnimationWidget.waveDots(
                              color: Colors.black,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

