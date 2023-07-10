import 'dart:async';
import 'package:beautyshot/Views/talent_screens/wear_size_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';


class BuildTypeScreen extends StatefulWidget {
  const BuildTypeScreen( {Key? key}) : super(key: key);

  @override
  State<BuildTypeScreen> createState() => _BuildTypeScreenState();
}

class _BuildTypeScreenState extends State<BuildTypeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController buildTypeController = TextEditingController();
  String buildType = BuildType.muscular.toString().split('.').last;
  BuildType bTYpe = BuildType.muscular ;
  String? massageText;
  bool isVisible = false;
  bool isOffStage = true;

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

  setVisibility(){
    setState(() {
      isVisible = true;
      isOffStage = false;
    });
  }

  onForwardPress()async{

    if(buildType.isEmpty){
      // print("show error message");

      Fluttertoast.showToast(
          msg: "Please Enter build type",
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
      prefs.setString('buildType', buildType);
      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const WearSizeScreen(),duration: const Duration(milliseconds: 500)));
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
              // TopRow(7, 13),
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
                                child: Text("What is your build type?",
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
                        delay: const Duration(milliseconds: 500),
                        child: Column(children: [
                          ///Average
                         RadioListTile(
                              title: const Text('Average'),
                              value: BuildType.average,
                              groupValue: bTYpe,
                              onChanged: (BuildType? value) {
                                setState(() {
                                  bTYpe = value!;
                                  buildType = value.toString().split('.').last;
                                });
                              },
                            ),
                          ///Slim
                          RadioListTile(
                              title: const Text('Slim'),
                              value: BuildType.slim,
                              groupValue: bTYpe,
                              onChanged: (BuildType? value) {
                                setState(() {
                                  bTYpe = value!;
                                  buildType = value.toString().split('.').last;
                                });
                              },
                            ),
                          ///Athletic
                          RadioListTile(
                              title: const Text('Athletic'),
                              value: BuildType.athletic,
                              groupValue: bTYpe,
                              onChanged: (BuildType? value) {
                                setState(() {
                                  bTYpe = value!;
                                  buildType = value.toString().split('.').last;
                                });
                              },
                            ),
                          ///Muscular
                          RadioListTile(
                              title: const Text('Muscular'),
                              value: BuildType.muscular,
                              groupValue: bTYpe,
                              onChanged: (BuildType? value) {
                                setState(() {
                                  bTYpe = value!;
                                  buildType = value.toString().split('.').last;
                                });
                              },
                            ),
                          ///Curvy
                          RadioListTile(
                              title: const Text('Curvy'),
                              value: BuildType.curvy,
                              groupValue: bTYpe,
                              onChanged: (BuildType? value) {
                                setState(() {
                                  bTYpe = value!;
                                  buildType = value.toString().split('.').last;
                                });
                              },
                            ),
                          ///Heavyset / Stocky
                          RadioListTile(
                              title: const Text('Heavyset / Stocky'),
                              value: BuildType.heavyset,
                              groupValue: bTYpe,
                              onChanged: (BuildType? value) {
                                setState(() {
                                  bTYpe = value!;
                                  buildType = value.toString().split('.').last;
                                });
                              },
                            ),
                          ///Plus-Sized / Full-Figured
                          RadioListTile(
                              title: const Text('Plus-Sized / Full-Figured'),
                              value: BuildType.plusSized,
                              groupValue: bTYpe,
                              onChanged: (BuildType? value) {
                                setState(() {
                                  bTYpe = value!;
                                  buildType = value.toString().split('.').last;
                                });
                              },
                            ),
                          // ForwardButton(onForwardPress),
                          Buttons.forwardButton(onForwardPress),
                        ],),
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
