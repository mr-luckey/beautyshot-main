import 'package:beautyshot/Views/client_screens/project_budget_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';

class ProjectNameScreen extends StatefulWidget {
  const ProjectNameScreen({Key? key}) : super(key: key);

  @override
  State<ProjectNameScreen> createState() => _ProjectNameScreenState();
}

class _ProjectNameScreenState extends State<ProjectNameScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String projectName;
  TextEditingController projectNameController = TextEditingController();

  onForwardPress()async{
    projectName = projectNameController.text.toString();
    SharedPreferences prefs = await _prefs;
    prefs.setString('projectName', projectName);
    Get.to(()=>const ProjectBudgetScreen());
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
              TopRow(1, 3),
              //Body
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text type the name of project
                  TitleText(Strings.typeTheNameOfProject),
                  //SizedBox
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: TextField(
                      style:  KFontStyle.kTextStyle16BlackRegular ,
                      textCapitalization: TextCapitalization.words,
                      controller: projectNameController,
                      autofocus: false,
                      maxLines: 1,
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: "Type here",
                        hintStyle: KFontStyle.kTextStyle16BlackRegular,
                      ),
                    ),
                  ),
                  //SizedBox
                  SizedBox(height: 20,),
                  //Forward Button
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


