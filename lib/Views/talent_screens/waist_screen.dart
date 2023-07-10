import 'dart:async';
import 'package:beautyshot/Views/talent_screens/weight_screen.dart';
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


class WaistScreen extends StatefulWidget {
  const WaistScreen( {Key? key}) : super(key: key);


  @override
  State<WaistScreen> createState() => _WaistScreenState();
}

class _WaistScreenState extends State<WaistScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  MeasurementUnit wUnit = MeasurementUnit.cm ;
  var waistUnit = MeasurementUnit.cm.toString().split('.').last;

  double waistInches = 0.0;
  double waistCm = 0.0;
  // double waistForConversion = 0.0;
  TextEditingController waistController = TextEditingController();
  String? massageText;
  bool isVisible = false;
   String firstName = "";
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


  onForwardPress()async{

    if(waistCm == 0.0){

      Fluttertoast.showToast(
          msg: "Enter valid waist",
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

      prefs.setDouble('waistCm', waistCm);
      prefs.setDouble('waistInches', waistInches);
      debugPrint('waistCm $waistCm');
      debugPrint('waistInches $waistInches');

      // Get.to(() => const WaistScreen());
      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const WeightScreen(),duration: const Duration(milliseconds: 500)));
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
                                child: Text("What is your waist?",
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
                                            waistUnit = MeasurementUnit.cm.toString().split('.').last;
                                            // waistCm = waistForConversion ;
                                            // var hight = heightForConversion * 2.54 ;
                                            waistController.text = waistCm.toStringAsFixed(2);
                                          }
                                          else{
                                            waistUnit = MeasurementUnit.inch.toString().split('.').last;
                                            // waistInches = waistForConversion / 2.54 ;
                                            waistController.text = waistInches.toStringAsFixed(2);
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
                                        debugPrint(waistUnit);
                                        //If Unit is metric Cm
                                        if(status == false){
                                          Picker(
                                              adapter: NumberPickerAdapter(data: [
                                                const NumberPickerColumn(begin: 0, end: 999,suffix: Text(" Cm")),
                                                // NumberPickerColumn(begin: 100, end: 200),
                                              ]),
                                              hideHeader: false,
                                              title: const Center(
                                                  child: Text("Waist")),
                                              onConfirm: (Picker picker, List value) {
                                                setState(() {
                                                  waistController.text = value.toString().substring(1,value.toString().length-1);
                                                  waistCm = double.parse(waistController.text);
                                                  waistInches = waistCm /2.54;
                                                  // waistForConversion = double.parse(value.toString().substring(1,value.toString().length-1));
                                                  // waistCm = waistForConversion ;
                                                  // waistInches = waistForConversion / 2.54 ;
                                                });
                                              }).showModal(context);
                                        }
                                        else{
                                          Picker(
                                              adapter: NumberPickerAdapter(data: [
                                                const NumberPickerColumn(begin: 0, end: 999, suffix: Text(" Inches")),
                                                // NumberPickerColumn(begin: 100, end: 200),
                                              ]),
                                              hideHeader: false,
                                              title: const Center(
                                                  child: Text("Waist")),
                                              onConfirm: (Picker picker, List value) {
                                                setState(() {
                                                  waistController.text = value.toString().substring(1,value.toString().length-1);
                                                  waistInches = double.parse(waistController.text);
                                                  waistCm = waistInches * 2.54;
                                                  // waistForConversion = double.parse(value.toString().substring(1,value.toString().length-1));
                                                  // waistCm = waistForConversion ;
                                                  // waistInches = waistForConversion / 2.54 ;
                                                });
                                              }).showModal(context);
                                        }

                                      },
                                      child: TextField(
                                        enabled: false,
                                        controller: waistController,
                                        onChanged: (value) {
                                          massageText = value;
                                        },
                                        decoration:  InputDecoration(
                                            contentPadding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 20.0),
                                            hintText: 'Select waist',
                                            suffixText: waistUnit,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),

                                  //Send Button
                                  // TextButton(
                                  //   onPressed: () {
                                  //     addTextToList();
                                  //     dataController.clear();
                                  //   },
                                  //   child: Icon(Icons.arrow_forward_ios_rounded)
                                  // ),
                                ],
                              ),
                            ),
                            // ForwardButton(onForwardPress)
                            Buttons.forwardButton(onForwardPress),
                          ],
                        ),
                      )
                       : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 60,bottom: 60),
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

