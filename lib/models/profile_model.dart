import 'package:happy_tech_mastering_api_with_flutter/core/api/end_ponits.dart';

class UserModel {
  final String name;
  final String profilePic;
  final String email;
  final String phone;
  final Map<String, dynamic> location;

  UserModel({
    required this.name,
    required this.profilePic,
    required this.email,
    required this.phone,
    required this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['user'][ApiKeys.name],
      profilePic: json['user'][ApiKeys.profilePic],
      email: json['user'][ApiKeys.email],
      phone: json['user'][ApiKeys.phone],
      location: json['user'][ApiKeys.location],
    );
  }
}
