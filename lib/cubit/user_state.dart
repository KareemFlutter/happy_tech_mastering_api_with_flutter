import 'package:happy_tech_mastering_api_with_flutter/models/profile_model.dart';

class UserState {}

//! Sign In
final class UserInitial extends UserState {}

final class SignInSuccessState extends UserState {}

final class SignInLoadingState extends UserState {}

final class SignInFailureState extends UserState {
  final String errorMessage;

  SignInFailureState({required this.errorMessage});
}

//! Sign Up
final class SignUpSuccessState extends UserState {
  final String message;

  SignUpSuccessState({required this.message});
}

final class SignUpLoadingState extends UserState {}

final class SignUpFailureState extends UserState {
  final String errorMessage;

  SignUpFailureState({required this.errorMessage});
}

class UploadProfilePicture extends UserState {}

//! getUserData
class GetUserDataSuccessState extends UserState {
  final UserModel userModel;

  GetUserDataSuccessState({required this.userModel});
}

class GetUserDataFailureState extends UserState {
  final String message;

  GetUserDataFailureState({required this.message});
}

class GetUserDataLoadingState extends UserState {}
