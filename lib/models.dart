// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String gender;
  String avatar;
  String domain;
  bool available;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.avatar,
    required this.domain,
    required this.available,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    gender: json["gender"]!,
    avatar: json["avatar"],
    domain: json["domain"],
    available: json["available"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "gender": genderValues.reverse[gender],
    "avatar": avatar,
    "domain": domainValues.reverse[domain],
    "available": available,
  };
}

enum Domain {
  BUSINESS_DEVELOPMENT,
  FINANCE,
  IT,
  MANAGEMENT,
  MARKETING,
  SALES,
  UI_DESIGNING
}

final domainValues = EnumValues({
  "Business Development": Domain.BUSINESS_DEVELOPMENT,
  "Finance": Domain.FINANCE,
  "IT": Domain.IT,
  "Management": Domain.MANAGEMENT,
  "Marketing": Domain.MARKETING,
  "Sales": Domain.SALES,
  "UI Designing": Domain.UI_DESIGNING
});

enum Gender {
  AGENDER,
  BIGENDER,
  FEMALE,
  GENDERFLUID,
  GENDERQUEER,
  MALE,
  NON_BINARY,
  POLYGENDER
}

final genderValues = EnumValues({
  "Agender": Gender.AGENDER,
  "Bigender": Gender.BIGENDER,
  "Female": Gender.FEMALE,
  "Genderfluid": Gender.GENDERFLUID,
  "Genderqueer": Gender.GENDERQUEER,
  "Male": Gender.MALE,
  "Non-binary": Gender.NON_BINARY,
  "Polygender": Gender.POLYGENDER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
