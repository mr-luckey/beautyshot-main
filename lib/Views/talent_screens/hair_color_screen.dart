import 'dart:async';

import 'package:beautyshot/Views/talent_screens/eye_color_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';


class HairColorScreen extends StatefulWidget {

  const HairColorScreen( {Key? key}) : super(key: key);
  @override
  State<HairColorScreen> createState() => _HairColorScreenState();
}

class _HairColorScreenState extends State<HairColorScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
   String hairColor = HairColor.blonde.toString().split('.').last;
  HairColor hColor = HairColor.blonde ;
   String firstName = "";
  bool isVisible = false;
  bool isOffStage = true;
  TextEditingController hairColorController = TextEditingController();
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
    // persistLastRoute('/hairColorScreen');
  }
  // void persistLastRoute(String routeName) async {
    //   SharedPreferences preferences = await SharedPreferences.getInstance();
    //   preferences.setString(Strings.lastRouteKey, routeName);
    // }
  setInitialValues() async{
    SharedPreferences prefs = await _prefs;
    prefs.getString('firstName');
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


    if(hairColorController.text.isNotEmpty){
      SharedPreferences prefs = await _prefs;
      prefs.setString('hairColor', hairColorController.text.toString());
      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const EyeColorScreen(),duration: const Duration(milliseconds: 500)));
    }
    else{
      SharedPreferences prefs = await _prefs;
      prefs.setString('hairColor', hairColor);
      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const EyeColorScreen(),duration: const Duration(milliseconds: 500)));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: Text("What is your hair color?",
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
                                     title: Text('Blonde'),
                                     value: HairColor.blonde,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///Black Color
                                    RadioListTile(
                                     title: const Text('Black'),
                                     value: HairColor.black,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///Brown
                                   RadioListTile(
                                     title: const Text('Brown'),
                                     value: HairColor.brown,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///Auburn
                                   RadioListTile(
                                     title: const Text('Auburn'),
                                     value: HairColor.auburn,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///Chestnut
                                  RadioListTile(
                                     title: const Text('ChestNut'),
                                     value: HairColor.chestnut,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///Red
                                   RadioListTile(
                                     title: const Text('Red'),
                                     value: HairColor.red,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///Gray
                                    RadioListTile(
                                     title: const Text('Gray'),
                                     value: HairColor.gray,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///White
                                 RadioListTile(
                                     title: const Text('White'),
                                     value: HairColor.white,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///Bald
                                  RadioListTile(
                                     title: const Text('Bald'),
                                     value: HairColor.bald,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///Salt & Pepper
                                 RadioListTile(
                                     title: const Text('Salt & Pepper'),
                                     value: HairColor.saltPepper,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///Strawberry Blonde
                                RadioListTile(
                                     title: const Text('Strawberry Blonde'),
                                     value: HairColor.strawberryBlonde,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
                                       });
                                     },
                                   ),
                                 ///Multicolored / Dyed
                                RadioListTile(
                                     title: const Text('Multicolored / Dyed'),
                                     value: HairColor.multicolored,
                                     groupValue: hColor,
                                     onChanged: (HairColor? value) {
                                       setState(() {
                                         hColor = value!;
                                         hairColor = value.toString().split('.').last;
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
                           // ForwardButton(onForwardPress),
                           Buttons.forwardButton(onForwardPress),
                         ],
                       ),
                     ),
                   ),
                 ),
                  ],
                ),
              ),
              Visibility(
                visible: isOffStage,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,top: 30,bottom: 30),
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
      ),
    );
  }
}



