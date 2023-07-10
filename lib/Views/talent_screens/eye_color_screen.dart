import 'dart:async';

import 'package:beautyshot/Views/talent_screens/ethnicity_screen.dart';
import 'package:beautyshot/Views/talent_screens/height_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';


class EyeColorScreen extends StatefulWidget {
  const EyeColorScreen( {Key? key}) : super(key: key);

  @override
  State<EyeColorScreen> createState() => _EyeColorScreenState();
}

class _EyeColorScreenState extends State<EyeColorScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController eyeColorController = TextEditingController();

  String eyeColor =  EyeColor.black.toString().split('.').last;
  EyeColor eColor = EyeColor.black;
   String firstName = '';
  String? massageText;
  bool isVisible = false;
  bool isOffStage = true;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    setInitialValues();
    startTime();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller
          .animateTo(_controller.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.ease)
          .then((value) async {
      });
    });
    // persistLastRoute('/eyeColorScreen');
  }

  // void persistLastRoute(String routeName) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString(Strings.lastRouteKey, routeName);
  // }
  setInitialValues() async{
    SharedPreferences prefs = await _prefs;
    if(prefs.getString('firstName') != null){
      // firstName = prefs.getString('firstName')!;
      firstName = prefs.getString('firstName')!.capitalizeFirst.toString();
    }
  }
  startTime() async {
    var duration = const Duration(milliseconds: 750);
    return Timer(duration, setVisibility);
  }

  setVisibility(){
    setState(() {
      isVisible = true;
      isOffStage = false;
    });
  }


  onForwardPress()async{
    // eyeColor = eyeColorController.text.toString();

    // print("Eye Color $eyeColor");
    if(eyeColor.isEmpty){
      // print("No Eye Color Selected");

      Fluttertoast.showToast(
          msg: "Please select your eye color",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      SharedPreferences prefs = await _prefs;
      prefs.setString('eyeColor', eyeColor);
      // Get.to(()=>const HeightScreen());
      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const EthnicityScreen(),duration: const Duration(milliseconds: 500)));
    }


  }

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
              // TopRow(3, 17),

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
                                child: Text("What is your eye color?",
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

                    Offstage(
                      offstage: isOffStage,
                      child: DelayedDisplay(
                        delay: const Duration(milliseconds: 750),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height/1.4,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: _controller,
                                  child: Column(children: [
                                    ///Blonde Color
                                    RadioListTile(
                                        title: const Text('Blonde'),
                                        value: EyeColor.blonde,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Black Color
                                   RadioListTile(
                                        title: const Text('Black'),
                                        value: EyeColor.black,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Brown
                                    RadioListTile(
                                        title: const Text('Brown'),
                                        value: EyeColor.brown,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Auburn
                                    RadioListTile(
                                        title: const Text('Auburn'),
                                        value: EyeColor.auburn,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Chestnut
                                     RadioListTile(
                                        title: const Text('ChestNut'),
                                        value: EyeColor.chestnut,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Red
                                    RadioListTile(
                                        title: const Text('Red'),
                                        value: EyeColor.red,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Gray
                                    RadioListTile(
                                        title: const Text('Gray'),
                                        value: EyeColor.gray,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///White
                                    RadioListTile(
                                        title: const Text('White'),
                                        value: EyeColor.white,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Salt & Pepper
                                     RadioListTile(
                                        title: const Text('Salt & Pepper'),
                                        value: EyeColor.saltPepper,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Strawberry Blonde
                                    RadioListTile(
                                        title: const Text('Strawberry Blonde'),
                                        value: EyeColor.strawberryBlonde,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Multicolored / Dyed
                                    RadioListTile(
                                        title: const Text('Multicolored / Dyed'),
                                        value: EyeColor.multicolored,
                                        groupValue: eColor,
                                        onChanged: (EyeColor? value) {
                                          setState(() {
                                            eColor = value!;
                                            eyeColor = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    //TextField for Hair Color
                                    // Container(
                                    //   margin: const EdgeInsets.only(left: 20,right: 20,bottom: 0),
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(50),
                                    //       border: Border.all(color: Colors.grey)
                                    //   ),
                                    //   child: Row(
                                    //     crossAxisAlignment: CrossAxisAlignment.center,
                                    //     children: <Widget>[
                                    //       Expanded(
                                    //         child: TextField(
                                    //           textCapitalization: TextCapitalization.words,
                                    //           style: KFontStyle.kTextStyle16BlackRegular,
                                    //           enabled: true,
                                    //           controller: hairColorController,
                                    //           decoration: const InputDecoration(
                                    //               contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                    //               hintText: 'Type Color if not in list',
                                    //               border: InputBorder.none
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),


                                  ],),
                                ),
                              ),
                              // ForwardButton(onForwardPress)
                              Buttons.forwardButton(onForwardPress),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: isOffStage,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
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




