import 'package:beautyshot/Views/client_screens/project_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class ClientProjectItem extends StatelessWidget {

  final String projectId;
  final String projectName;
  final String projectBudget;
  final String projectLocation;
  final String projectLatitude;
  final String projectLongitude;
  final String projectTillDate;
  final String projectFromDate;
  final String projectCreatedBy;
  final List firstOption;
  final List secondOption;

  const ClientProjectItem({Key? key,
    required this.projectId,
    required this.projectName,
    required this.projectBudget,
    required this.projectLocation,
    required this.projectLatitude,
    required this.projectLongitude,
    required this.projectTillDate,
    required this.projectFromDate,
    required this.projectCreatedBy,
    required this.firstOption,
    required this.secondOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>ProjectDetailScreen(projectId: projectId, projectName: projectName, projectBudget: projectBudget, projectLocation: projectLocation, projectLatitude: projectLatitude, projectLongitude: projectLongitude, projectTillDate: projectTillDate, projectFromDate: projectFromDate, projectCreatedBy: projectCreatedBy,firstOption: [firstOption],secondOption: [secondOption],));
      },
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
              child: Text(projectName,style: KFontStyle.kTextStyle16BlackRegular,),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.navigate_next_rounded,size: 32,color: Color(KColors.kColorPrimary),),
            ),
          ],
        ),
      ),
    );
  }
}