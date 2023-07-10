import 'package:beautyshot/Views/talent_screens/gender_screen.dart';
import 'package:beautyshot/Views/talent_screens/profile_picture_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateOfBirthScreen extends StatefulWidget {
  const DateOfBirthScreen({Key? key}) : super(key: key);

  @override
  State<DateOfBirthScreen> createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
   String dateOfBirth = "";
   bool calendarIconVisibility = false;

  onForwardPress()async{
    Get.to(()=>const GenderScreen());
    SharedPreferences prefs = await _prefs;
    prefs.setString('dateOfBirth', dateOfBirth);
  }
  chooseFromCalendar(){
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1950, 1, 1),
        maxTime: DateTime.now(), onChanged: (date) {
          // print('change $date');
        }, onConfirm: (date) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
      setState(() {
        dateOfBirth = formatter.format(date);
        if(dateOfBirth.isNotEmpty){
          calendarIconVisibility = true;
        }
        else{
          calendarIconVisibility = false;
        }

      });
          // print('confirm $date');
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
  void persistLastRoute(String routeName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString(Strings.lastRouteKey, routeName);
    });
  }
  setInitialValues() async{
    SharedPreferences prefs = await _prefs;

    setState(() {
      if(prefs.getString('dateOfBirth') != null){
        dateOfBirth = prefs.getString('dateOfBirth')!;
      }
      else{
        dateOfBirth = "";
      }

      if(dateOfBirth.isNotEmpty){
        calendarIconVisibility = true;
      }
      else{
        calendarIconVisibility = false;
      }
    });



  }
  @override
  void initState() {
    super.initState();
    setInitialValues();
    persistLastRoute('/talentDateOfBirth');

  }
  Future<bool> _willPopCallback() async {
    Get.to(()=>const ProfilePictureScreen());
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
                // Top Row
               TopRow(3, 5),
                //Body
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Title Text
                     TitleText(Strings.dateOfBirth),
                      //SizedBox
                      const SizedBox(height: 30,),
                      //Choose from Calendar
                      GestureDetector(
                        onTap: chooseFromCalendar,
                          // child: PlainWhiteButton(dateOfBirth != ""?dateOfBirth:Strings.chooseFromCalendar)),
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 3.0), //(x,y)
                                  blurRadius: 5.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50),
                              // border: Border.all(
                              //   color: Colors.grey,
                              // ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(dateOfBirth != ""?dateOfBirth:Strings.chooseFromCalendar,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Visibility(
                                  visible: calendarIconVisibility,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      //SizedBox
                      const SizedBox(height: 30,),
                      // Back and Forward Button
                      // BackForwardButton(onForwardPress),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>const ProfilePictureScreen());
                            },
                            child: Container(
                              height: 56,
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                color: Color(KColors.kColorWhite),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Color(KColors.kColorPrimary),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40.0,right: 40,top: 20,bottom: 20),
                                child: Center(child: Text(Strings.back,style: KFontStyle.kTextStyle14Blue,)),
                              ),
                            ),
                          ),
                          //Forward Button
                          GestureDetector(
                            onTap: onForwardPress,
                            child: const Icon(Icons.navigate_next_rounded,size: 52,),
                          ),
                        ],)
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
