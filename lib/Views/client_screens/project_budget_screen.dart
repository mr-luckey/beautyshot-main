import 'package:beautyshot/Views/client_screens/project_date_screen.dart';

import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';


class ProjectBudgetScreen extends StatefulWidget {
  const ProjectBudgetScreen({Key? key}) : super(key: key);

  @override
  State<ProjectBudgetScreen> createState() => _ProjectBudgetScreenState();
}

class _ProjectBudgetScreenState extends State<ProjectBudgetScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String projectBudget;
  TextEditingController projectBudgetController = TextEditingController();

  onForwardPress()async{
    projectBudget = projectBudgetController.text.toString();
    SharedPreferences prefs = await _prefs;
    prefs.setString('projectBudget', projectBudget);
    Get.to(()=>const ProjectDateScreen());
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
              TopRow(2, 2),
              //Body
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text what is the budget of the project
                  TitleText(Strings.whatIsTheBudgetOfTheProject),
                  //SizedBox
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: TextField(
                      style:KFontStyle.kTextStyle14Black,
                      keyboardType: TextInputType.number,
                      controller: projectBudgetController,
                      autofocus: false,
                      maxLines: 1,
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        prefixText: "\$ ",
                        prefixStyle: KFontStyle.kTextStyle14Black,
                        hintText: "Type here",
                        hintStyle: KFontStyle.kTextStyle14Black,
                      ),
                    ),
                  ),
                  //SizedBox
                  const SizedBox(height: 20,),
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


