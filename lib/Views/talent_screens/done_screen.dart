import 'dart:async';

import 'package:beautyshot/Views/talent_screens/country_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String modelFirstName= '';

  setInitialValues() async{
    SharedPreferences prefs = await _prefs;
    if(prefs.getString('firstName') != null) {
      modelFirstName = prefs.getString('firstName')!;
    }
    startTime();
  }

  @override
  void initState() {
    super.initState();
    setInitialValues();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, callback);
  }

  Future callback() async{
    Get.off(()=> const CountryScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Center(child: Text("Yei,you are ready",style: KFontStyle.kTextStyle24Black, )),
          const SizedBox(height: 5,),
          Center(child: Text("to Work!",style: KFontStyle.kTextStyle24Black, )),
            const SizedBox(height: 20,),
            Image.asset(KImages.check,height: 100,width: 100,),
        ],),
      ),
    );
  }
}
