import 'dart:async';
import 'package:beautyshot/Views/talent_screens/portfolio_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:shared_preferences/shared_preferences.dart';

class TalentScreen extends StatefulWidget {


  const TalentScreen( {Key? key}) : super(key: key);

  @override
  State<TalentScreen> createState() => _TalentScreenState();
}

class _TalentScreenState extends State<TalentScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String talent;
   List<String> talentList = [];
  TextEditingController talentController = TextEditingController();
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

  setVisibility(){
    setState(() {
      isVisible = true;
    });
  }

  onForwardPress()async{
    talent= talentController.text.toString();
    //Assigning hobbies after comma
    final split = talent.split(',');
    talentList = {
      for (int i = 0; i < split.length; i++)
        split[i].replaceAll(' ', '')
    }.toList();

      SharedPreferences prefs = await _prefs;
      prefs.setStringList('talent', talentList);
      Get.to(()=>const PortfolioScreen());

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
              // TopRow(16, 4),
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
                                child: Text("What are your talents?",
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
                      child: isVisible ?  DelayedDisplay(
                        delay: const Duration(milliseconds: 500),
                        child: Column(children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20,right: 20,bottom: 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    enabled: true,
                                    textCapitalization: TextCapitalization.words,
                                    controller: talentController,
                                    onChanged: (value) {
                                      massageText = value;
                                    },
                                    decoration: const InputDecoration(

                                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                        hintText: 'What are your talents?',
                                        border: InputBorder.none
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
                          Container(
                            margin: EdgeInsets.only(left: 20,top: 5),
                            child: Row(
                              children: [
                                Text("Separate talents with comma",style: KFontStyle.kTextStyle14Black,),
                              ],
                            ),
                          ),

                          // ForwardButton(onForwardPress)
                          Buttons.forwardButton(onForwardPress),
                        ],),
                      ):
                      Row(
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

