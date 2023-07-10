
import 'package:flutter/material.dart';

class ProjectModel{
  String projectId,projectName,projectBudget,projectLocation,projectLatitude,projectLongitude,projectTillDate,projectFromDate,projectCreatedBy;
  List firstOption, secondOption,confirmed,pending;
  ProjectModel(
      this.projectId,
      this.projectName,
      this.projectBudget,
      this.projectLocation,
      this.projectLatitude,
      this.projectLongitude,
      this.projectTillDate,
      this.projectFromDate,
      this.projectCreatedBy,
      this.firstOption,
      this.secondOption,
      this.confirmed,
      this.pending,
      );

  Map<String, dynamic> toMap() {
    return {
      'projectId': projectId,
      'projectName': projectName,
      'projectBudget': projectBudget,
      'projectLocation': projectLocation,
      'projectLatitude': projectLatitude,
      'projectLongitude': projectLongitude,
      'projectTillDate': projectTillDate,
      'projectFromDate': projectFromDate,
      'projectCreatedBy': projectCreatedBy,
      'firstOption': firstOption,
      'secondOption': secondOption,
      'confirmed': confirmed,
      'pending': pending,
    };
  }
  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      map['projectId'] as String,
      map['projectName'] as String,
      map['projectBudget'] as String,
      map['projectLocation'] as String,
      map['projectLatitude'] as String,
      map['projectLongitude'] as String,
      map['projectTillDate'] as String,
      map['projectFromDate'] as String,
      map['projectCreatedBy'] as String,
      map['firstOption'] as List,
      map['secondOption'] as List,
      map['confirmed'] as List,
      map['pending'] as List,

    );
  }
}