import 'dart:convert';

UserModel treasureModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String treasureModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.accessToken,
    required this.phone,
    required this.userId,
  });

  String accessToken;
  String phone;
  String userId;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json["access_token"] ?? '',
        phone: json["phone"] ?? '',
        userId: json["user_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "phone": phone,
        "user_id": userId,
      };
}
