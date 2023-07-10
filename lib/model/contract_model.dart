
class ContractModel{
  String amount,clientId,contractId,jobTitle,modelPdf,notes,pdfLink,projectId,projectName,status;
  List modelIds;


  ContractModel.name(
      this.amount,
      this.clientId,
      this.contractId,
      this.jobTitle,
      this.modelPdf,
      this.notes,
      this.pdfLink,
      this.projectId,
      this.projectName,
      this.status,
      this.modelIds);

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'clientId': clientId,
      'contractId': contractId,
      'jobTitle': jobTitle,
      'modelPdf': modelPdf,
      'notes': notes,
      'pdfLink': pdfLink,
      'projectId': projectId,
      'projectName': projectName,
      'status': status,
      'modelIds': modelIds,
    };
  }
  factory ContractModel.fromMap(Map<String, dynamic> map) {
    return ContractModel.name(
      map['amount'] as String,
      map['clientId'] as String,
      map['contractId'] as String,
      map['jobTitle'] as String,
      map['modelPdf'] as String,
      map['notes'] as String,
      map['pdfLink'] as String,
      map['projectId'] as String,
      map['projectName'] as String,
      map['status'] as String,
      map['ignoreList'] as List,
    );
  }
}