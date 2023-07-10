
class HairColorModel{

  List hairColor;
  HairColorModel(
      this.hairColor,
      );

  Map<String, dynamic> toMap() {
    return {
      'hairColor': hairColor,
    };
  }
  factory HairColorModel.fromMap(Map<String, dynamic> map) {
    return HairColorModel(
      map['hairColor'] as List,
    );
  }
}