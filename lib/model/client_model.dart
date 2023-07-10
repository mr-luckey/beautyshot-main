
class ClientModel{
  String clientId,companyName,companyPhone,companyEmail,dunsNumber,taxId,address,userType;
  List ignoreList;

  ClientModel.name(
      this.clientId,
      this.companyName,
      this.companyPhone,
      this.companyEmail,
      this.dunsNumber,
      this.taxId,
      this.address,
      this.userType,
      this.ignoreList,
      );

  Map<String, dynamic> toMap() {
    return {
      'projectId': clientId,
      'projectName': companyName,
      'projectBudget': companyPhone,
      'projectLocation': companyEmail,
      'projectLatitude': dunsNumber,
      'projectLongitude': taxId,
      'projectTillDate': address,
      'projectFromDate': userType,
      'ignoreList': ignoreList,
    };
  }
  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel.name(
      map['projectId'] as String,
      map['projectName'] as String,
      map['projectBudget'] as String,
      map['projectLocation'] as String,
      map['projectLatitude'] as String,
      map['projectLongitude'] as String,
      map['projectTillDate'] as String,
      map['projectFromDate'] as String,
      map['ignoreList'] as List,
    );
  }
}