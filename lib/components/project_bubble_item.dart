import 'package:beautyshot/Views/client_screens/bulk_models_list.dart';
import 'package:beautyshot/Views/client_screens/client_project_folder_screen.dart';
import 'package:beautyshot/Views/client_screens/project_detail_screen.dart';
import 'package:beautyshot/controller/project_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants.dart';

class ProjectBubbleItem extends StatelessWidget {

  final String projectId;
  final String projectName;
  final String projectBudget;
  final String projectLocation;
  final String projectLatitude;
  final String projectLongitude;
  final String projectTillDate;
  final String projectFromDate;
  final String projectCreatedBy;
  final List<String> modelId;
  final List firstOption;
  final List secondOption;
  final String option;

  ProjectBubbleItem({Key? key,
    required this.projectId,
    required this.projectName,
    required this.projectBudget,
    required this.projectLocation,
    required this.projectLatitude,
    required this.projectLongitude,
    required this.projectTillDate,
    required this.projectFromDate,
    required this.projectCreatedBy,
    required this.modelId,
    required this.firstOption,
    required this.secondOption,
    required this.option,
  }) : super(key: key);
  final projectController = Get.put(ProjectController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        if(option == "firstOption"){
          projectController.addFirstOption(projectId, modelId);
          Get.to(()=>BulkModelsList());
          debugPrint("$modelId added to first option");
        }
        else if(option == "secondOption"){
          projectController.addSecondOption(projectId, modelId);
          Get.to(()=>BulkModelsList());
          debugPrint("$modelId added to second option");
        }
      },

      child: Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all( 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Text(projectName,style: KFontStyle.kTextStyle16BlackRegular,textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}