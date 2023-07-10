import 'package:beautyshot/Views/client_screens/project_location_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectDateScreen extends StatefulWidget {
  const ProjectDateScreen({Key? key}) : super(key: key);

  @override
  State<ProjectDateScreen> createState() => _ProjectDateScreenState();
}

class _ProjectDateScreenState extends State<ProjectDateScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String projectFromDate = "";
  String projectTillDate = "";

  TextEditingController fromDateController = TextEditingController();
  TextEditingController tillDateController = TextEditingController();

  onForwardPress()async{

    SharedPreferences prefs = await _prefs;
    if(projectFromDate == "" || projectTillDate == ""){

      Fluttertoast.showToast(
          msg: "Please select date first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      prefs.setString('projectFromDate', projectFromDate);
      prefs.setString('projectTillDate', projectTillDate);
      Get.to(()=>const ProjectLocationScreen());
    }

  }
  chooseFromDate(){
    // DatePicker.showDateTimePicker(context,
    //     showTitleActions: true,
    //
    //     minTime: DateTime(1950, 1, 1),
    //     maxTime: DateTime.now(), onChanged: (date) {
    //       print('change $date');
    //     }, onConfirm: (date) {
    //       // final DateFormat formatter = DateFormat.yMEd().add_jms().format(DateTime.now());
    //       setState(() {
    //         projectFromDate = DateFormat.yMEd().add_jms().format(date);
    //         fromDateController.text = projectFromDate;
    //       });
    //       print('confirm $date');
    //     }, currentTime: DateTime.now(), locale: LocaleType.en);
    DatePicker.showDatePicker(context,

        showTitleActions: true,
        minTime: DateTime(1950, 1, 1),
        maxTime: DateTime(2099,1,1), onChanged: (date) {
          // print('change $date');
        }, onConfirm: (date) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          setState(() {
            projectFromDate = formatter.format(date);
            fromDateController.text = projectFromDate;

          });
          // print('confirm $date');
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
  chooseTillDate(){
    // DatePicker.showDateTimePicker(context,
    //     showTitleActions: true,
    //     minTime: DateTime(1950, 1, 1),
    //     maxTime: DateTime.now(), onChanged: (date) {
    //       print('change $date');
    //     }, onConfirm: (date) {
    //       // final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
    //       setState(() {
    //         projectTillDate = DateFormat.yMEd().add_jms().format(date);
    //         tillDateController.text = projectTillDate;
    //       });
    //       print('confirm $date');
    //     }, currentTime: DateTime.now(), locale: LocaleType.en);
    DatePicker.showDatePicker(context,

        showTitleActions: true,
        minTime: DateTime(1950, 1, 1),
        maxTime: DateTime(2099,1,1), onChanged: (date) {
          // print('change $date');
        }, onConfirm: (date) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          setState(() {
            projectTillDate = formatter.format(date);
            tillDateController.text = projectTillDate;

          });
          // print('confirm $date');
        }, currentTime: DateTime.now(), locale: LocaleType.en);
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
              // Top Row
              TopRow(3, 1),
              //Body
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title when do you need the talent
                  TitleText(Strings.whenDoYouNeedTheTalent),

                  //Choose from date
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      chooseFromDate();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: TextField(
                        style:  KFontStyle.kTextStyle16BlackRegular ,
                        enabled: false,
                        controller: fromDateController,
                        autofocus: false,
                        maxLines: 1,
                        decoration: InputDecoration(
                          // border: InputBorder.none,
                          hintText: Strings.fromDate,
                          hintStyle: KFontStyle.kTextStyle16BlackRegular,
                        ),
                      ),
                    ),
                  ),
                  //Choose from date
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      chooseTillDate();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: TextField(
                        style:  KFontStyle.kTextStyle16BlackRegular ,
                        enabled: false,
                        controller: tillDateController,
                        autofocus: false,
                        maxLines: 1,
                        decoration: InputDecoration(
                          // border: InputBorder.none,
                          hintText: Strings.tillDate,
                          hintStyle: KFontStyle.kTextStyle16BlackRegular,
                        ),
                      ),
                    ),
                  ),
                  //SizedBox
                  const SizedBox(height: 30,),
                  // Back and Forward Button
                  // BackForwardButton(onForwardPress),
                  Buttons.backForwardButton(onForwardPress),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
