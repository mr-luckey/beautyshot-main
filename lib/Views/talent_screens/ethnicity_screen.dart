import 'dart:async';

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


class EthnicityScreen extends StatefulWidget {
  const EthnicityScreen( {Key? key}) : super(key: key);

  @override
  State<EthnicityScreen> createState() => _EthnicityScreenState();
}

class _EthnicityScreenState extends State<EthnicityScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController eyeColorController = TextEditingController();

  String ethnicity =  Ethnicity.asian.toString().split('.').last;
  Ethnicity eEthnicity = Ethnicity.asian;
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
    if(ethnicity.isEmpty){
      // print("No Eye Color Selected");

      Fluttertoast.showToast(
          msg: "Please select your ethnicity",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      SharedPreferences prefs = await _prefs;
      prefs.setString('ethnicity', ethnicity);
      // Get.to(()=>const HeightScreen());
      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const HeightScreen(),duration: const Duration(milliseconds: 500)));
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
                                child: Text("What is your ethnicity?",
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
                                    ///Asian
                                    RadioListTile(
                                        title: const Text('Asian'),
                                        value: Ethnicity.asian,
                                        groupValue: eEthnicity,
                                        onChanged: (Ethnicity? value) {
                                          setState(() {
                                            eEthnicity = value!;
                                            ethnicity = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///African
                                    RadioListTile(
                                        title: const Text('African'),
                                        value: Ethnicity.african,
                                        groupValue: eEthnicity,
                                        onChanged: (Ethnicity? value) {
                                          setState(() {
                                            eEthnicity = value!;
                                            ethnicity = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///American
                                    RadioListTile(
                                        title: const Text('American'),
                                        value: Ethnicity.american,
                                        groupValue: eEthnicity,
                                        onChanged: (Ethnicity? value) {
                                          setState(() {
                                            eEthnicity = value!;
                                            ethnicity = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Chinese
                                    RadioListTile(
                                        title: const Text('Chinese'),
                                        value: Ethnicity.chinese,
                                        groupValue: eEthnicity,
                                        onChanged: (Ethnicity? value) {
                                          setState(() {
                                            eEthnicity = value!;
                                            ethnicity = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Indian
                                    RadioListTile(
                                        title: const Text('Indian'),
                                        value: Ethnicity.indian,
                                        groupValue: eEthnicity,
                                        onChanged: (Ethnicity? value) {
                                          setState(() {
                                            eEthnicity = value!;
                                            ethnicity = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Korean
                                    RadioListTile(
                                        title: const Text('Korean'),
                                        value: Ethnicity.korean,
                                        groupValue: eEthnicity,
                                        onChanged: (Ethnicity? value) {
                                          setState(() {
                                            eEthnicity = value!;
                                            ethnicity = value.toString().split('.').last;
                                          });
                                        },
                                      ),
                                    ///Pakistani
                                    RadioListTile(
                                        title: const Text('Pakistani'),
                                        value: Ethnicity.pakistani,
                                        groupValue: eEthnicity,
                                        onChanged: (Ethnicity? value) {
                                          setState(() {
                                            eEthnicity = value!;
                                            ethnicity = value.toString().split('.').last;
                                          });
                                        },
                                      ),
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




