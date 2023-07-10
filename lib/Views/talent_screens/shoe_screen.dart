
import 'dart:async';
import 'package:beautyshot/Views/talent_screens/language_screen.dart';
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


class ShoeScreen extends StatefulWidget {
  const ShoeScreen( {Key? key}) : super(key: key);

  @override
  State<ShoeScreen> createState() => _ShoeScreenState();
}

class _ShoeScreenState extends State<ShoeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
   // late double shoeSize ;
  TextEditingController shoeController = TextEditingController();

  double shoesInches = 0.0;
  double shoesCm = 0.0;
  // double shoesForConversion = 0.0;

  var shoesUnit = MeasurementUnit.cm.toString().split('.').last;

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

    if(shoesCm == 0.0){
      Fluttertoast.showToast(
          msg: "Enter valid shoes size",
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

      prefs.setDouble('shoesCm', shoesCm);
      prefs.setDouble('shoesInches', shoesInches);

      debugPrint('shoesCm $shoesCm');
      debugPrint('shoesInches $shoesInches');
      // Get.to(() => const WaistScreen());
      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const LanguageScreen(),duration: const Duration(milliseconds: 500)));
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

              // TopRow(12, 8),

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
                                child: Text("What is your shoe size?",
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
                                    Strings.eu,
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
                                            shoesUnit = MeasurementUnit.cm.toString().split('.').last;
                                            // shoesCm = shoesForConversion ;
                                            // var hight = heightForConversion * 2.54 ;
                                            shoeController.text = shoesCm.toStringAsFixed(2);
                                          }
                                          else{
                                            shoesUnit = MeasurementUnit.inch.toString().split('.').last;
                                            // shoesInches = shoesForConversion / 2.54 ;
                                            shoeController.text = shoesInches.toStringAsFixed(2);
                                          }
                                        });
                                      }),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    Strings.american,
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
                                        debugPrint(shoesUnit);
                                        if(status == false){
                                          Picker(
                                              adapter: NumberPickerAdapter(data: [
                                                const NumberPickerColumn(begin: 0, end: 999,suffix: Text(" Cm")),
                                                // NumberPickerColumn(begin: 100, end: 200),
                                              ]),
                                              // delimiter: [
                                              //   PickerDelimiter(child: Container(
                                              //     width: 30.0,
                                              //     alignment: Alignment.center,
                                              //     child: Icon(Icons.more_vert),
                                              //   ))
                                              // ],
                                              hideHeader: false,
                                              title: const Center(
                                                  child: Text("Shoe Size")),
                                              onConfirm: (Picker picker, List value) {
                                                setState(() {
                                                  shoeController.text = value.toString().substring(1,value.toString().length-1);
                                                  // shoesForConversion = double.parse(value.toString().substring(1,value.toString().length-1));
                                                  shoesCm = double.parse(shoeController.text) ;
                                                  shoesInches = shoesCm / 2.54 ;
                                                });

                                              }).showModal(context);
                                        }
                                        else {
                                          Picker(
                                            adapter: NumberPickerAdapter(data: [
                                              const NumberPickerColumn(begin: 0, end: 999,suffix: Text(" Inches")),
                                              // NumberPickerColumn(begin: 100, end: 200),
                                            ]),
                                            // delimiter: [
                                            //   PickerDelimiter(child: Container(
                                            //     width: 30.0,
                                            //     alignment: Alignment.center,
                                            //     child: Icon(Icons.more_vert),
                                            //   ))
                                            // ],
                                            hideHeader: false,
                                            title: const Center(
                                                child: Text("Shoe Size")),
                                            onConfirm: (Picker picker, List value) {
                                              setState(() {
                                                shoeController.text = value.toString().substring(1,value.toString().length-1);
                                                // shoesForConversion = double.parse(value.toString().substring(1,value.toString().length-1));
                                                shoesInches = double.parse(shoeController.text) ;
                                                shoesCm = shoesInches * 2.54 ;
                                              });
                                              debugPrint(value.toString());
                                              debugPrint(picker.getSelectedValues().toString());
                                            }).showModal(context);
                                        }
                                      },
                                      child: TextField(
                                        enabled: false,
                                        controller: shoeController,
                                        onChanged: (value) {
                                          massageText = value;
                                        },
                                        decoration:  InputDecoration(
                                            contentPadding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 20.0),
                                            hintText: 'Select shoe size',
                                            suffixText: shoesUnit,
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
                      ):
                      Row(
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
