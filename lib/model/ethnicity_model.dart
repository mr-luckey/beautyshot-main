
class EthnicityModel{

  List ethnicity;
  EthnicityModel(
      this.ethnicity,
      );

  Map<String, dynamic> toMap() {
    return {
      'ethnicity': ethnicity,
    };
  }
  factory EthnicityModel.fromMap(Map<String, dynamic> map) {
    return EthnicityModel(
      map['ethnicity'] as List,
    );
  }
}